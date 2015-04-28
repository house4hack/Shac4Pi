package za.co.house4hack.shac4pi.services

import android.app.IntentService
import android.content.Intent
import android.util.Log
import org.jivesoftware.smack.Chat
import org.jivesoftware.smack.ChatManager
import org.jivesoftware.smack.ConnectionConfiguration
import org.jivesoftware.smack.MessageListener
import org.jivesoftware.smack.Roster
import org.jivesoftware.smack.XMPPConnection
import org.jivesoftware.smack.XMPPException
import org.jivesoftware.smack.packet.Message
import org.jivesoftware.smack.packet.Presence

import static extension za.co.house4hack.shac4pi.utils.Dependencies.*

/**
 * Intent service to send a command to the server over XMPP
 */
class SendCommandService extends IntentService {
    public static val String EXTRA_COMMAND = "command"
    
    new() {
        super("send_command")
    }
    
    override protected onHandleIntent(Intent intent) {
        var command = intent.getStringExtra(EXTRA_COMMAND)
        Log.d("xmpp", "Sending command " + command)
        
        // see http://developer.samsung.com/technical-doc/view.do
        // connect
        var connConfig = new ConnectionConfiguration(settings.serverHost, 
            Integer.parseInt(settings.serverPort), 
            settings.serverResource
        );
        var XMPPConnection connection = new XMPPConnection(connConfig);
        connection.connect();
        if (!connection.connected) {
            Log.d("xmpp", "Unable to connect to " + settings.serverHost + " " + settings.serverPort) 
        }

        // login
        connection.login(settings.account, settings.password)
        if (!connection.authenticated) {
            Log.d("xmpp", "Unable to authenticate with " + settings.account)
        }
        
        // Create a new presence. Pass in false to indicate we're unavailable.
        var Presence presence = new Presence(Presence.Type.available);
        presence.setStatus("I’m available");
        connection.sendPacket(presence);

        var Roster roster = connection.getRoster();
        if (!roster.contains(settings.serverAccount)) {
            // add it
            Log.d("xmpp", "Shac4Pi not a friend, adding")
            roster.createEntry(settings.serverAccount, "Please give me access", #[ "one", "two" ]);
        }
        
        var ChatManager chatmanager = connection.getChatManager();
        var Chat newChat = chatmanager.createChat(settings.serverAccount, new MessageListener() {
            override void processMessage(Chat chat, Message message) {
                Log.d("xmpp", "Received message: " + message);
            }
        });
        
        try {
            newChat.sendMessage(command);
        } catch (XMPPException e) {
            Log.e("xmpp", "Error sending message", e)
            return;
        }
        
        Log.d("xmpp", "All done, disconnecting")
        connection.disconnect();        
    }
    
}