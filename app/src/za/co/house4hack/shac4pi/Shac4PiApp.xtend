package za.co.house4hack.shac4pi

import android.app.Application
import javax.net.ssl.HttpsURLConnection
import javax.net.ssl.SSLContext
import za.co.house4hack.shac4pi.ssl.TrivialHostVerifier
import za.co.house4hack.shac4pi.ssl.TrivialTrustManager

class Shac4PiApp extends Application {
    
    override onCreate() {
        super.onCreate()

        var SSLContext sslContext = SSLContext.getInstance("TLS");
        sslContext.init(null, #[ new TrivialTrustManager() ], null);
        HttpsURLConnection.setDefaultSSLSocketFactory(sslContext.socketFactory);
        HttpsURLConnection.setDefaultHostnameVerifier(new TrivialHostVerifier)        
    }
    
}