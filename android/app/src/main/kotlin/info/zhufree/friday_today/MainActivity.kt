package info.zhufree.friday_today

import android.os.Bundle

import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.plugin.common.MethodChannel;
import android.annotation.TargetApi;
import android.app.WallpaperManager;
import android.graphics.BitmapFactory;
import android.os.Build;
import java.io.File;
import java.io.IOException;


class MainActivity : FlutterActivity() {
    private val channel = "wallpaper"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this)
        MethodChannel(flutterView, channel).setMethodCallHandler { methodCall, result ->
            // 判断方法名
            if (methodCall.method == "setWallpaper") {
                // 设置壁纸的方法封装在setWallpaper中，methodCall.arguments as String拿到路径参数
                val setWallpaperResult = setWallpaper(methodCall.arguments as String)

                if (setWallpaperResult == 0) {
                    // 成功的回调
                    result.success(setWallpaperResult)
                } else {
                    // 失败的回调
                    result.error("UNAVAILABLE", "", null)
                }
            }
        }
    }

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

