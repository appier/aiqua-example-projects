package com.appier.aiqua.demoapp;

import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;

import com.appier.aiqua.view.DefaultActionBarView;
import com.quantumgraph.sdk.NotificationIntentProcessor;
import com.quantumgraph.sdk.NotificationJobIntentService;
import com.quantumgraph.sdk.QG;

import org.json.JSONException;
import org.json.JSONObject;

public class ProactiveExperiencesActivity extends CheckLoginActivity
{

    private DefaultActionBarView viewActionBar;
    private Button gotoProductCategoryPageBtn;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        this.setContentView(R.layout.activity_proactive_experiences);
        this.viewActionBar = this.findViewById(R.id.view_action_bar);
        this.gotoProductCategoryPageBtn = this.findViewById(R.id.btn_goto_product_list);

        // setup page title
        this.viewActionBar.setTitle(this.getResources().getString(R.string.text_proactive_experiences_title));

        this.gotoProductCategoryPageBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                gotoProductCategoryPage();
            }
        });
    }

    private void gotoProductCategoryPage() {
        // goto next page
        Intent intent = new Intent(ProactiveExperiencesActivity.this, ProductCategoryActivity.class);
        startActivity(intent);
        overridePendingTransition(R.anim.page_enter, 0);

        // destroy this page
        finish();
    }
}
