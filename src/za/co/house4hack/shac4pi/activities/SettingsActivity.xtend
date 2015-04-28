package za.co.house4hack.shac4pi.activities

import android.preference.PreferenceActivity
import android.os.Bundle
import za.co.house4hack.shac4pi.R

class SettingsActivity extends PreferenceActivity {
    
    override protected onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState)
        addPreferencesFromResource(R.xml.settings)
    }
    
}