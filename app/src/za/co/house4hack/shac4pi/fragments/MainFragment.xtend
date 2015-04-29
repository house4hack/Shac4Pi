package za.co.house4hack.shac4pi.fragments

import android.content.Intent
import org.xtendroid.annotations.AndroidFragment
import org.xtendroid.app.OnCreate
import za.co.house4hack.shac4pi.R
import za.co.house4hack.shac4pi.services.SendCommandService

@AndroidFragment(R.layout.fragment_main) class MainFragment extends BaseFragment {
    @OnCreate
    def init() {
        btnDoor.onClickListener = [
            sendCommand("door_open 1")
        ]
        
        btnGate.onClickListener = [
            sendCommand("door_open 2")
        ]
    }
    
    def sendCommand(String command) {
        var intent = new Intent(activity, SendCommandService)
        intent.putExtra(SendCommandService.EXTRA_COMMAND, command)
        activity.startService(intent)
    }
}