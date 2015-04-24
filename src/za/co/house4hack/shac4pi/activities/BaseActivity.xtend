package za.co.house4hack.shac4pi.activities

import android.R
import android.support.v7.app.AppCompatActivity
import android.view.MenuItem

class BaseActivity extends AppCompatActivity {

   def public void setupActionBar(String title) {
      var actionBar = supportActionBar
      if (actionBar == null) return;
      
      actionBar.elevation = 5
      actionBar.displayHomeAsUpEnabled = true;
      actionBar.homeButtonEnabled = true;
      actionBar.title = title
   }
     
   override onOptionsItemSelected(MenuItem item) {
      if (item.itemId == R.id.home) {
         finish
      }
      
      super.onOptionsItemSelected(item)
   }
}