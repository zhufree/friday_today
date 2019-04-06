package info.zhufree.friday_today

import android.os.Bundle

import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import android.annotation.TargetApi;
import android.app.WallpaperManager;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.Build;
import java.io.File;
import java.io.IOException;


class MainActivity : FlutterActivity() {
    private val CHANNEL = "info.zhufree.friday_today/wallpaper"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this)
        MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
                object : MethodCallHandler {
                    override fun onMethodCall(methodCall: MethodCall, result: Result) {
                        if (methodCall.method.equals("setWallpaper")) {
                            val setWallpaperResult = setWallpaper(methodCall.arguments as String)
                            //int setWallpaper = getBatteryLevel();

                            if (setWallpaperResult == 0) {
                                result.success(setWallpaperResult)
                            } else {
                                result.error("UNAVAILABLE", "", null)
                            }
                        }
                    }
                }
        )
    }

    @TargetApi(Build.VERSION_CODES.ECLAIR)
    private fun setWallpaper(path: String): Int {
        var result = 1
        val imgFile = File(path)
        // set bitmap to wallpaper
        val bitmap = BitmapFactory.decodeFile(imgFile.getAbsolutePath())
        var wm: WallpaperManager? = null
        wm = WallpaperManager.getInstance(this)
        try {
            wm?.setBitmap(bitmap)
            result = 0
        } catch (e: IOException) {
            result = 1
        }

        return result
    }
}

