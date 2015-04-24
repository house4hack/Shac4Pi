package za.co.house4hack.shac4pi.activities

import android.support.v4.widget.DrawerLayout
import android.support.v7.app.AppCompatActivity
import android.support.v7.widget.Toolbar
import org.xtendroid.annotations.AndroidView
import org.xtendroid.app.OnCreate
import za.co.house4hack.shac4pi.R

// Main activity
class MainActivity extends AppCompatActivity {
   MyActionBarDrawerToggle actionBarDrawerToggle
   @AndroidView DrawerLayout drawerLayout
   @AndroidView Toolbar toolbar

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

      supportFragmentManager
         .beginTransaction
         .replace(R.id.container, frag, String.valueOf(position))
         .commit();
   }

   def setupDrawerLayout() {

      actionBarDrawerToggle = new MyActionBarDrawerToggle(this, drawerLayout, toolbar)
      drawerLayout.drawerListener = actionBarDrawerToggle;

      // This following line actually reveals the hamburger
//      drawerLayout.post [
//         actionBarDrawerToggle.syncState()
//      ];

   }

   def setupToolbar() {
      setSupportActionBar(toolbar)
      val actionBar = supportActionBar
      actionBar.displayHomeAsUpEnabled = true
   }
}