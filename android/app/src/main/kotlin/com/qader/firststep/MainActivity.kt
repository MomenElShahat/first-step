package com.qader.firststep

import android.content.Intent
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    companion object {
        var userToken: String? = null // Store token here
    }

    override fun configureFlutterEngine(flutterEngine: io.flutter.embedding.engine.FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(
                flutterEngine.dartExecutor.binaryMessenger,
                "com.qader.firststep/native"
        ).setMethodCallHandler { call, result ->
            if (call.method == "setAuthToken") {
                userToken = call.argument<String>("token")
                result.success(null)
            }
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        val intent = Intent(this, OfflineService::class.java)
        userToken?.let { token ->
            intent.putExtra("auth_token", token)
        }
        startService(intent)
    }
}
