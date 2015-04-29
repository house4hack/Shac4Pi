package za.co.house4hack.shac4pi.services

import android.app.Service
import android.content.Intent
import android.os.Binder
import android.os.IBinder

/**
 * Service to manage XMPP connection and messaging
 */
class XmppService extends Service {
    val IBinder mBinder = new XmppBinder(this);
    
    override onBind(Intent arg0) {
        return mBinder
    }
    
    override onCreate() {
        super.onCreate()
    }
    
    override onStartCommand(Intent intent, int flags, int startId) {
        return START_STICKY
    }

    override onDestroy() {
        super.onDestroy()
    }
    
}

/**
 * Binder for XmppService
 */
public class XmppBinder extends Binder {
    var XmppService instance
    
    new(XmppService instance) {
        this.instance = instance
    }
    
    def XmppService getService() {
      return instance;
    }
}    
