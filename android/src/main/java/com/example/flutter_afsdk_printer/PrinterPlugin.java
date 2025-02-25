package com.example.flutter_afsdk_printer;

import android.app.Activity;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.ServiceConnection;
import android.os.IBinder;
import android.os.RemoteException;
import androidx.annotation.NonNull;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import com.szanfu.sdk.service.IPrinterBinderService;
import com.szanfu.sdk.service.ISdkServiceManager;

public class PrinterPlugin implements FlutterPlugin, MethodCallHandler {
    private MethodChannel channel;
    private Context context;
    private IPrinterBinderService mPrinterBinderService;

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {
        channel = new MethodChannel(binding.getBinaryMessenger(), "flutter_afsdk_printer");
        channel.setMethodCallHandler(this);
        context = binding.getApplicationContext();
        bindService();
    }

    private void bindService() {
        Intent intent = new Intent();
        intent.setPackage("com.szanfu.sdk.service");
        intent.setAction("com.szanfu.sdk.service.SDK_SERVICE");
        context.bindService(intent, conn, Context.BIND_AUTO_CREATE);
    }

    private final ServiceConnection conn = new ServiceConnection() {
        @Override
        public void onServiceConnected(ComponentName name, IBinder service) {
            ISdkServiceManager sdkServiceManager = ISdkServiceManager.Stub.asInterface(service);
            try {
                mPrinterBinderService = IPrinterBinderService.Stub.asInterface(
                        sdkServiceManager.getService(ServiceID.SERVICE_ID_PRINTER)
                );
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        @Override
        public void onServiceDisconnected(ComponentName name) {
            mPrinterBinderService = null;
        }
    };

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        if (call.method.equals("printText")) {
            String text = call.argument("text");
            printText(text);
            result.success("Printed");
        } else {
            result.notImplemented();
        }
    }

    private void printText(String text) {
        if (mPrinterBinderService != null) {
            try {
                byte[] bitmapData = text.getBytes();
                mPrinterBinderService.printBitmap(0, bitmapData, 384, 100, null);
            } catch (RemoteException e) {
                e.printStackTrace();
            }
        }
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        channel.setMethodCallHandler(null);
        context.unbindService(conn);
    }
}
