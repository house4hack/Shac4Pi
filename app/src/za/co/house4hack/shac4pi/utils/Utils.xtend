package za.co.house4hack.shac4pi.utils

import android.content.Context
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.graphics.BitmapFactory.Options
import android.graphics.Rect
import android.util.Log
import java.io.InputStream

import static extension org.xtendroid.utils.AlertUtils.*

class Utils {
   
   /**
    * Load an image and downsample it to the screen dimensions
    */
   def static Bitmap loadImage(Context context, InputStream is, int widthDp) {
      // get image dimensions
      var options=new Options();
      options.inJustDecodeBounds = true;
      BitmapFactory.decodeStream(is, new Rect(0, 0, 0, 0), options);
      var orgHeight = options.outHeight
      var orgWidth = options.outWidth
      Log.d("bmp", "width = " + orgWidth)

      // calculate downsampling      
      var requiredWidth = widthDp * context.getResources().getDisplayMetrics().density;
      Log.d("bmp", "requiredwidth = " + requiredWidth)
      var sampleSize = Math.round(orgWidth / requiredWidth)
      if (sampleSize % 2 == 1) sampleSize += 1
      if (sampleSize < 1) sampleSize = 1     
      
      Log.d("bmp", "downsample = " + sampleSize)
      
      options.inPreferredConfig = Bitmap.Config.RGB_565
      options.inJustDecodeBounds = false
      
      BitmapFactory.decodeStream(is, new Rect(0,0,0,0), options)
   }
   
   def public static (Exception)=>void onError(Context context) {
      return [err| 
         context.toast(err.class.simpleName + " " + err.message)
      ]
   }
}