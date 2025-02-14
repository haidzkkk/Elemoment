package com.myopenai.elemoment

import io.flutter.embedding.android.FlutterActivity

import androidx.annotation.NonNull
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    
    private val FlavorChannel = "flavor"
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor, FlavorChannel).setMethodCallHandler {
            call, result ->
            result.success(BuildConfig.FLAVOR)
        }
    }
    
}
