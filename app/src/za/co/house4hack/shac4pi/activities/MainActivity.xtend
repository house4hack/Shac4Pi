package za.co.house4hack.shac4pi.activities

import android.support.v4.app.Fragment
import android.view.View
import org.xtendroid.app.AndroidActivity
import org.xtendroid.app.OnCreate
import za.co.house4hack.shac4pi.R
import za.co.house4hack.shac4pi.fragments.MainFragment
import za.co.house4hack.shac4pi.fragments.NavigationDrawerFragment
import android.content.Intent

// Main activity
@AndroidActivity(R.layout.activity_main) class MainActivity extends BaseActivity {
    MyActionBarDrawerToggle actionBarDrawerToggle

    @OnCreate
    def init() {
        setupToolbar()
        setupDrawerLayout()
        addFragment("main")
    }

    def addFragment(String tag) {
        if ("settings".equals(tag)) {
            // start settings activity
            var i = new Intent(this, SettingsActivity)
            startActivity(i)
            return
        }
        
        // create a new fragment each time. Change this to cache fragments as necessary.
        var Fragment fragm = switch (tag) {
            default: new MainFragment()
        }

        supportFragmentManager.beginTransaction
            .replace(R.id.container, fragm, tag)
            .commit();
    }

    def setupDrawerLayout() {
        supportFragmentManager.beginTransaction
            .replace(R.id.left_drawer, new NavigationDrawerFragment(), "drawer")
            .commit();

        actionBarDrawerToggle = new MyActionBarDrawerToggle(this, drawerLayout, toolbar)
        drawerLayout.drawerListener = actionBarDrawerToggle;

        // This following line actually reveals the hamburger
        drawerLayout.post [
            actionBarDrawerToggle.syncState()
        ];
    }

    def setupToolbar() {
        setSupportActionBar(toolbar)
        val actionBar = supportActionBar
        actionBar.displayHomeAsUpEnabled = true
    }

    // Item in the navigation drawer was clicked
    def void onNavItemClicked(View v) {
    	drawerLayout.closeDrawer(leftDrawer)
    	addFragment(v.tag as String)
    }
}