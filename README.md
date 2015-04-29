# Shac4Pi

Smart House Access Control for the Raspberry Pi. This project has 2 parts:

- A Raspberry Pi (any model) with relays attached to it's GPIO pins and a Python program + Web server
- An Android app to connect to the Pi over XMPP or Wifi to tell it to open certain relays

The relays of the Raspberry Pi are typically connected to gate/door/garage door remote control buttons, allowing the Android app to remotely open the gate/door/garage door.

# Hardware setup

TO BE COMPLETED

# How to compile

To compile the Android app:

- Install [Gradle v2.2.1][gradle]
- Install the [Android SDK][android_sdk] and download the ```Android 5.1.1``` platform.
- Clone this repository
- Create a file called ```local.properties``` in the project root pointing to your SDK directory, e.g. 
```
sdk.dir=/opt/android-sdk-linux/
```
- Run this in the cloned directory: ```gradle assembleDebug```. This will create the debug APK file.

# How to develop

You will need Eclipse with the Xtend plugin for development. You can use Android Studio, but the Xtend editor plugin for Android Studio is still in development.

- Set up the project for compilation as outlined in *How to compile*
- Run ```gradle generateEclipseDependencies```
- In Eclipse, *File > Import > General > Existing Projects Into Workspace*. Select the project folder and tick *Search for nested projects*. Import the displayed projects
- Wait for the initial build to complete. You are now ready to develop.

    [gradle]: https://gradle.org/downloads/
    [android_sdk]: https://developer.android.com/sdk/index.html#Other
    