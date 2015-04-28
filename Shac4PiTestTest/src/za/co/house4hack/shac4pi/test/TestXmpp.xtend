package za.co.house4hack.shac4pi.test

import android.test.AndroidTestCase
import android.util.Log
import java.util.Collection
import org.jivesoftware.smack.Chat
import org.jivesoftware.smack.ChatManager
import org.jivesoftware.smack.ConnectionConfiguration
import org.jivesoftware.smack.MessageListener
import org.jivesoftware.smack.PacketListener
import org.jivesoftware.smack.Roster
import org.jivesoftware.smack.RosterEntry
import org.jivesoftware.smack.XMPPConnection
import org.jivesoftware.smack.XMPPException
import org.jivesoftware.smack.filter.MessageTypeFilter
import org.jivesoftware.smack.packet.Message
import org.jivesoftware.smack.packet.Packet
import org.jivesoftware.smack.packet.Presence

import static junit.framework.Assert.*

class TestXmpp extends AndroidTestCase {
    def void testXmpp1() {

        // see http://developer.samsung.com/technical-doc/view.do

        // connect
        var connConfig = new ConnectionConfiguration("talk.google.com", 5222, "gmail.com");
        var XMPPConnection connection = new XMPPConnection(connConfig);
        connection.connect();

        assertTrue(connection.connected);

        // login
        connection.login("someone@gmail.com", "thepassword")

        assertTrue(connection.isAuthenticated);
        
        // Create a new presence. Pass in false to indicate we're unavailable.
        var Presence presence = new Presence(Presence.Type.available);
        presence.setStatus("I’m unavailable");
        connection.sendPacket(presence);

        var Roster roster = connection.getRoster();
        if (!roster.contains("serveraccount@gmail.com")) {
            // add it
            Log.d("xmpp", "Shac4Pi not a friend, adding")
            roster.createEntry("serveraccount@gmail.com", "Something", #[ "one", "two" ]);
        }
        
        var ChatManager chatmanager = connection.getChatManager();
        var Chat newChat = chatmanager.createChat("serveraccount@gmail.com", new MessageListener() {
            override void processMessage(Chat chat, Message message) {
                Log.d("xmpp", "Received message: " + message);
            }
        });
        
        try {
            newChat.sendMessage("door_open 2");
        } catch (XMPPException e) {
            assertTrue(e.message, false)
        }

        Thread.sleep(5000)
        assertTrue(connection.authenticated)
        
        connection.disconnect();        
    }
    
    def void sampleCode() {
        // connect
        var connConfig = new ConnectionConfiguration("talk.google.com", 5222, "gmail.com");
        var XMPPConnection connection = new XMPPConnection(connConfig);
        connection.connect();

        // login
        connection.login("you@gmail.com", "yourpassword")

        // Create a new presence. Pass in false to indicate we're unavailable.
        var Presence presence = new Presence(Presence.Type.unavailable);
        presence.setStatus("I’m unavailable");
        connection.sendPacket(presence);

        var Roster roster = connection.getRoster();
        // Get all rosters
        var Collection<RosterEntry> entries = roster.getEntries();
        // loop through
        for (entry : entries) {
            // example: get presence, type, mode, status
            var Presence entryPresence = roster.getPresence(entry.getUser());
            var Presence.Type userType = entryPresence.getType();
            var Presence.Mode mode = entryPresence.getMode();
            var String status = entryPresence.getStatus();
        }
        
        // get notified of status changes
        // roster.addRosterListener(...)

        // start a conversation
        //var ChatManager chatmanager = connection.getChatManager();
        //var Chat newChat = chatmanager.createChat("abc@gmail.com", new MessageListener() {
        //  ...
        //} 
        
        // Send chat msg to with msg type as (chat, normal, groupchat, headline, error)
        var msg = new Message("someone@somewhere", Message.Type.normal);
        msg.setBody("How are you?");
        connection.sendPacket(msg);
        
        // Add a packet listener to get messages sent to us
        var filter = new MessageTypeFilter(Message.Type.chat);
        connection.addPacketListener(new PacketListener() {
          override void processPacket(Packet packet) {
            var Message message = packet as Message;
            var String body = message.getBody();
            var String from = message.getFrom();
          }
        }, filter);
    }
}