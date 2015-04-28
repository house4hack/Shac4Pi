package za.co.house4hack.shac4pi.fragments

import android.os.Bundle
import android.preference.PreferenceFragment
import za.co.house4hack.shac4pi.R

class SettingsFragment extends PreferenceFragment {
    
    override onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState)
        addPreferencesFromResource(R.xml.settings);
    }
    
}