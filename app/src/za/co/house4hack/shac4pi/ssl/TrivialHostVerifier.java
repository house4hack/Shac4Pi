package za.co.house4hack.shac4pi.ssl;

import javax.net.ssl.HostnameVerifier;
import javax.net.ssl.SSLSession;

import android.util.Log;

public class TrivialHostVerifier implements HostnameVerifier {

	@Override
	public boolean verify(String host, SSLSession session) {
		Log.d("host", host);
		return true;
	}

}
