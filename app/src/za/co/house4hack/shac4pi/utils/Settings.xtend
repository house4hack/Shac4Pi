package za.co.house4hack.shac4pi.utils

import org.xtendroid.annotations.AndroidPreference

@AndroidPreference class Settings {
    String serverHost = "talk.google.com"
    String serverPort = "5222"
    String serverResource = "gmail.com"
    String serverAccount = "serveraccount@gmail.com"
    
    String account = "unknown@gmail.com"
    String password = "password"
}