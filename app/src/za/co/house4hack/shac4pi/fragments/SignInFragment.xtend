package za.co.house4hack.shac4pi.fragments

import android.app.AlertDialog
import android.os.Bundle
import android.support.v4.app.DialogFragment
import org.xtendroid.annotations.AndroidDialogFragment
import za.co.house4hack.shac4pi.R
import org.xtendroid.app.OnCreate

@AndroidDialogFragment(R.layout.fragment_signin) class SignInFragment extends DialogFragment {
    
    override onCreateDialog(Bundle instance) {
        return new AlertDialog.Builder(activity)
            .setTitle("Login")
            .setView(contentView)
            .setPositiveButton("Login", [ login ])
            .setNeutralButton("Register", [ register ])
            .setNegativeButton("Cancel", [ dismiss ])
            .create
    }
    
    @OnCreate
    def init() {
    }
    
    def login() {
        
    }
    
    def register() {
        
    }
}