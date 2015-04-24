package za.co.house4hack.shac4pi.activities

import android.app.Activity
import android.content.Context
import android.support.v4.widget.DrawerLayout
import android.support.v7.app.ActionBarDrawerToggle
import android.support.v7.widget.Toolbar
import android.view.View
import android.support.v7.app.AppCompatActivity

class MyActionBarDrawerToggle extends ActionBarDrawerToggle {
   Context mContext
   Activity mActivity
   (View)=>void onClosed = null

   public new(AppCompatActivity activity, DrawerLayout drawerLayout, Toolbar toolbar) {
      super(activity, drawerLayout, toolbar, 0, 0)
      mContext = activity as Context
      mActivity = activity
   }

   override onDrawerClosed(View view) {
      super.onDrawerClosed(view)
      mActivity.invalidateOptionsMenu()
      if (onClosed != null) {
         onClosed.apply(view)
         onClosed = null
      }
   }

   /**
    * Write to preferences after the drawer has been opened for the first time,
    * e.g. use-case: [ShowCaseView](https://github.com/amlcurran/ShowcaseView)
    */
   override onDrawerOpened(View view) {
      super.onDrawerOpened(view)
      //mContext.settings.drawerLearned = true
   }
   
   /**
    * Set a function to run next time the drawer is closed
    */
   def public void setOnClosed((View)=>void onClosed) {
      this.onClosed = onClosed
   }
}