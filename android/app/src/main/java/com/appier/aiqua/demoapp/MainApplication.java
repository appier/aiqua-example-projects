package com.appier.aiqua.demoapp;

import android.app.Application;

import com.quantumgraph.sdk.QG;

public class MainApplication extends Application {
    @Override
    public void onCreate() {
        super.onCreate();

        // [AIQUA] SDK initialization
        QG.initializeSdk(this, "<YOUR APP ID>");
    }
}
