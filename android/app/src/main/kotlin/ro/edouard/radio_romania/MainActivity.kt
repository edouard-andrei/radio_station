package ro.edouard.radio_romania

import io.flutter.plugin.common.PluginRegistry;
import io.flutter.app.FlutterApplication;
import io.flutter.plugins.GeneratedPluginRegistrant;
import com.ryanheise.audioservice.AudioServicePlugin;

class MainApplication : FlutterApplication(), PluginRegistry.PluginRegistrantCallback {
    @Override
    fun onCreate() {
        super.onCreate()
        AudioServicePlugin.setPluginRegistrantCallback(this)
    }

    @Override
    fun registerWith(registry: PluginRegistry?) {
        GeneratedPluginRegistrant.registerWith(registry)
    }
}
