package za.co.house4hack.shac4pi.activities

import android.view.View
import org.xtendroid.app.AndroidActivity
import org.xtendroid.app.OnCreate
import za.co.house4hack.shac4pi.R
import za.co.house4hack.shac4pi.fragments.NavigationDrawerFragment

// Main activity
@AndroidActivity(R.layout.activity_main) class MainActivity extends BaseActivity {
    MyActionBarDrawerToggle actionBarDrawerToggle

    @OnCreate
    def init() {
        setupToolbar()
        setupDrawerLayout()
    }

    def addFragment(int position) {
        // create a new fragment each time. Change this to cache fragments as necessary.
        var frag = switch (position) {
//         case 0: new FragmentOne()
//         case 1: new FragmentTwo()
//         default: new FragmentOne()
        }

        supportFragmentManager.beginTransaction
            .replace(R.id.container, frag, String.valueOf(position))
            .commit();
    }

    def setupDrawerLayout() {
        supportFragmentManager.beginTransaction
            .replace(R.id.left_drawer, new NavigationDrawerFragment, "drawer")
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
    }
}