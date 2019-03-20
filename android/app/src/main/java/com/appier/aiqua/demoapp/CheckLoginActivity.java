package com.appier.aiqua.demoapp;

import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;

import com.appier.aiqua.utils.LocalStorageManager;


public class CheckLoginActivity extends AppCompatActivity {

    private static final String TAG = "CheckLoginActivity";

    protected boolean hasLogin = false;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    }

    @Override
    protected void onStart() {
        super.onStart();

        // Check if user has been logged in.
        String name = LocalStorageManager.getUserName(this);
        String email = LocalStorageManager.getUserEmail(this);

        this.hasLogin = (name != null && email != null);
        if (this.hasLogin) {
            Log.i(TAG, String.format("User login, name: '%s', email: '%s'", name, email));
        } else {
            this.goBackToLoginPage();
        }
    }

    /**
     * Note: need to check for each page(activity). Once user haven't logged in,
     * app should destroy current page and go back to login page.
     **/
    protected void goBackToLoginPage() {
        // go back to login page
        Intent intent = new Intent(this, LoginActivity.class);
        intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TASK | Intent.FLAG_ACTIVITY_NEW_TASK);
        startActivity(intent);
        overridePendingTransition(R.anim.page_enter, 0);
        finish();
    }
}
