package com.washx.demo;

import android.os.Bundle;
import android.widget.Toast;
import android.content.Context;
import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import com.crashlytics.android.Crashlytics;
import io.fabric.sdk.android.Fabric;

public class MainActivity extends FlutterActivity {
  private static final String CHANNEL = "samples.flutter.io/toast";
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    Fabric.with(this, new Crashlytics());
    GeneratedPluginRegistrant.registerWith(this);
    new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(new MethodCallHandler() {
      @Override
      public void onMethodCall(MethodCall call, MethodChannel.Result result) {
        if (call.method.equals("getToast")) {
          String message = call.argument("msg");
          Toast.makeText(MainActivity.this,message,Toast.LENGTH_SHORT).show();
        } else {
          result.notImplemented();
        }
      }
    });
  }
}
