package com.appier.aiqua.demoapp;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;

import com.appier.aiqua.utils.LocalStorageManager;
import com.quantumgraph.sdk.QG;

import org.json.JSONObject;

public class HomeActivity extends CheckLoginActivity
{

    private Button contactSalesBtn;
    private Button proactiveExperiencesBtn;
    private static QG qg;

    @Override
    protected void onStart() {
        super.onStart();
        QG.logFcmId(this);
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        qg = QG.getInstance(this);
        final String email = LocalStorageManager.getUserEmail(this);
        this.setContentView(R.layout.activity_home);
        this.contactSalesBtn = this.findViewById(R.id.btn_contact_sales);
        this.proactiveExperiencesBtn = this.findViewById(R.id.btn_proactive_experiences);

        this.proactiveExperiencesBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                gotoProactiveExperiencesPage();
            }
        });


        this.contactSalesBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                try {

                    // [AIQUA] Logging events
                    qg.logEvent("contacted_sales",
                            new JSONObject().put("work_email", email));
                } catch (Exception e) {

                }
                openAppSelector();
            }
        });
    }

    private void openAppSelector() {
        String emailSubject = this.getString(R.string.email_subject);
        String emailText = this.getString(R.string.email_text);
        String receiver = this.getString(R.string.email_receiver);

        Intent sendIntent = new Intent(Intent.ACTION_SEND);
        sendIntent.setType("text/email");
        sendIntent.putExtra(Intent.EXTRA_EMAIL, new String[]{receiver});
        sendIntent.putExtra(Intent.EXTRA_SUBJECT, emailSubject);
        sendIntent.putExtra(Intent.EXTRA_TEXT, emailText);

        startActivity(Intent.createChooser(sendIntent, this.getString(R.string.send_to)));
    }

    private void gotoProactiveExperiencesPage() {
        // goto next page
        Intent intent = new Intent(HomeActivity.this, ProactiveExperiencesActivity.class);
        startActivity(intent);
        overridePendingTransition(R.anim.page_enter, 0);

    }
}
