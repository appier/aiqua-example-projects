package com.appier.aiqua.demoapp;

import android.content.Intent;
import android.net.Uri;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;

import com.appier.aiqua.utils.LocalCache;

public class DeepLinkResolver extends LoginActivity {
    private static final String TAG = DeepLinkResolver.class.getSimpleName();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_deep_link_resolver);
        Intent intent = getIntent();
        String action = intent.getAction();
        Uri data = intent.getData();
        Log.i(TAG, "action" + action);
        Log.i(TAG, "data" + data.toString());
        String category = data.getQueryParameter("cat");
        if (null != category && category != "") {
            Intent categoryIntent = new Intent(this, ProductListActivity.class);
            categoryIntent = categoryIntent.putExtra("category", category);
            startActivity(categoryIntent);
            finish();
        }
        String productOrder = data.getQueryParameter("productOrder");
        if (null != productOrder && productOrder != "") {
            try {
                Intent productIntent = new Intent(this, ProductDetailActivity.class)
                        .putExtra("productOrder", Integer.parseInt(productOrder))
                        .putExtra("productCategory", data.getQueryParameter("productCategory"))
                        .putExtra("productName", data.getQueryParameter("productName"));
                startActivity(productIntent);
            } catch (Exception e) {
                Log.e(TAG, "Exception" + e);
                Intent homeScreen = getPackageManager().getLaunchIntentForPackage(this.getPackageName());
                startActivity(homeScreen);
            }
            finish();
        }
    }
}
