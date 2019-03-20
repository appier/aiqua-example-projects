package com.appier.aiqua.demoapp;

import android.accounts.AccountManager;
import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.text.Editable;
import android.text.TextWatcher;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.CompoundButton;
import android.widget.EditText;
import com.appier.aiqua.utils.LocalStorageManager;

import com.crashlytics.android.Crashlytics;
import com.google.firebase.FirebaseApp;
import com.quantumgraph.sdk.QG;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import io.fabric.sdk.android.Fabric;

// Note: bug tracking tool library


public class LoginActivity extends AppCompatActivity {

    private static final String TAG = LoginActivity.class.getName();
    private static final int ACCOUNT_PICKER_CODE = 100;
    private QG qg;
    private EditText nameEdit;
    private EditText emailText;
    private EditText companyEdit;
    private CheckBox agreeCheck;
    private Button loginBtn;


    private void enableLoginBtn() {

        String name = nameEdit.getText().toString();
        String email = emailText.getText().toString();
        String company = companyEdit.getText().toString();
        Boolean agree = agreeCheck.isChecked();

        boolean enabled = name.length() > 0 && email.length() > 0 && company.length() > 0 && agree;
        if (!isEmailValid(email)) { enabled = false; }

        loginBtn.setEnabled(enabled);
        loginBtn.setAlpha(enabled ? (float)1.0 : (float)0.5);

        emailText.setError(null);
    }


    private void initialize(String name, String email, String company) {
        if (name != null && email != null && company != null) {

            // AIQUA logging user profiles
            qg = QG.getInstance(getApplicationContext());
            qg.setCustomUserParameter("name", name);
            qg.setCustomUserParameter("work_email", email);
            qg.setCustomUserParameter("company", company);
            qg.setEmail(email);
        }
    }
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        Fabric.with(this, new Crashlytics());
        FirebaseApp.initializeApp(this);
        setContentView(R.layout.activity_login);

        this.nameEdit = this.findViewById(R.id.name_edit);
        this.emailText = this.findViewById(R.id.email_text);
        this.companyEdit = this.findViewById(R.id.company_edit);
        this.agreeCheck = this.findViewById(R.id.agree_check);
        this.loginBtn = this.findViewById(R.id.login_btn);

        final TextWatcher editWatcher = new TextWatcher() {
            @Override
            public void afterTextChanged(Editable editable) {
                enableLoginBtn();
            }

            // nothing to do in the following functions
            @Override public void beforeTextChanged(CharSequence charSequence, int i, int i1, int i2) {}
            @Override public void onTextChanged(CharSequence charSequence, int i, int i1, int i2) {}
        };

        this.nameEdit.addTextChangedListener(editWatcher);
        this.emailText.addTextChangedListener(editWatcher);
        this.companyEdit.addTextChangedListener(editWatcher);
        this.agreeCheck.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
                enableLoginBtn();
            }
        });

        this.loginBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if(!view.isEnabled()) return;

                String name = nameEdit.getText().toString().trim();
                String email= emailText.getText().toString().trim();
                String company = companyEdit.getText().toString().trim();
                if(!isEmailValid(email)) {
                    emailText.setError(getString(R.string.error_invalid_email));
                    return;
                }
                // save user information in local
                LocalStorageManager.setUserName(LoginActivity.this, name);
                LocalStorageManager.setUserEmail(LoginActivity.this, email);
                LocalStorageManager.setUserCompany(LoginActivity.this, company);
                gotoNextPage();
            }
        });
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        if(requestCode == ACCOUNT_PICKER_CODE && resultCode == RESULT_OK) {
            String accountName = data.getStringExtra(AccountManager.KEY_ACCOUNT_NAME);
            Log.i(TAG, String.format("User chooses accountName: '%s'", accountName));
            emailText.setText(accountName);
        }
    }

    @Override
    protected void onStart() {
        super.onStart();
        // Check if user has been logged in.
        String name = LocalStorageManager.getUserName(this);
        String email = LocalStorageManager.getUserEmail(this);
        String company = LocalStorageManager.getUserCompany(this);
        String country = LocalStorageManager.getCountry(this);
        if (name != null && email != null &&country != null) {
            Log.i(TAG, String.format("User login, name: '%s', email: '%s', country: '%s'",
                    name,
                    email,
                    country));
            initialize(name, email, company);
            gotoNextPage();
        }
    }

    /**
     * Switch Home Activity and destroy current page so that when user clicks
     * goback_button, Demo App would not show this page again.
     */
    private void gotoNextPage() {
        // goto next page
        Intent intent = new Intent(LoginActivity.this, HomeActivity.class);
        startActivity(intent);
        overridePendingTransition(R.anim.page_enter, 0);

        // destroy this activity
        finish();
    }

    /**
     * Check if it is a valid email address
     */
    private boolean isEmailValid(String email) {

        if (null==email || "".equals(email)) return false;
//        Pattern p = Pattern.compile("\\w+@(\\w+.)+[a-z]{2,3}");   //simple pattern
        Pattern p =  Pattern.compile("\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*"); //complex pattern
        Matcher m = p.matcher(email);
        return m.matches();
    }
}
