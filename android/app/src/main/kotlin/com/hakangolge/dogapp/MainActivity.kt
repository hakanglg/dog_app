package com.hakangolge.dogapp
import io.flutter.embedding.android.FlutterActivity
import android.os.Build
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.hakangolge.dogapp/os_version"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
                call, result ->
            if (call.method == "getOSVersion") {
                result.success("Android " + Build.VERSION.RELEASE)
            } else {
                result.notImplemented()
            }
        }
    }
}
