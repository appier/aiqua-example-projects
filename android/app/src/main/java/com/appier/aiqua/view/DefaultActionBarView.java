package com.appier.aiqua.view;

import android.app.Activity;
import android.content.Context;
import android.util.AttributeSet;
import android.util.Log;
import android.util.TypedValue;
import android.view.View;
import android.widget.ImageButton;
import android.widget.RelativeLayout;
import android.widget.TextView;
import android.widget.Toast;

import com.appier.aiqua.utils.LocalStorageManager;
import com.appier.aiqua.demoapp.R;

public class DefaultActionBarView extends RelativeLayout {

    private TextView titleText;

    private final String TAG = "DefaultActionBarView";
    private final static int TITLE_TEXT_ID = 100;

    public DefaultActionBarView(Context context) {
        super(context);
        initView(context);
    }

    public DefaultActionBarView(Context context, AttributeSet attrs) {
        super(context, attrs);
        initView(context);
    }

    public DefaultActionBarView(Context context, AttributeSet attrs, int defStyleAttr) {
        super(context, attrs, defStyleAttr);
        initView(context);
    }

    private void initView(final Context ctx) {
        // 1. initialize background
        this.setBackground(ctx.getResources().getDrawable(R.drawable.bg_default_action_bar));


        // 2. initialize title text object
        this.titleText = new TextView(ctx);
        this.titleText.setId(TITLE_TEXT_ID);
        RelativeLayout.LayoutParams titleParams = new RelativeLayout.LayoutParams(
                LayoutParams.WRAP_CONTENT,
                LayoutParams.WRAP_CONTENT
        );
        titleParams.addRule(RelativeLayout.CENTER_IN_PARENT);
        this.titleText.setLayoutParams(titleParams);

        this.titleText.setTextColor(ctx.getResources().getColor(R.color.colorDefaultActionBarTitle));
        this.titleText.setTextSize(
                TypedValue.COMPLEX_UNIT_PX,
                ctx.getResources().getDimensionPixelSize(R.dimen.text_default_action_bar_title_size));
        this.addView(this.titleText);


        // 3. initialize goback button
        ImageButton gobackBtn = new ImageButton(ctx);
        RelativeLayout.LayoutParams btnParams = new RelativeLayout.LayoutParams(
                LayoutParams.WRAP_CONTENT,
                ctx.getResources().getDimensionPixelSize(R.dimen.btn_goback_height)
        );
        btnParams.addRule(RelativeLayout.ALIGN_PARENT_LEFT);
        btnParams.addRule(RelativeLayout.CENTER_VERTICAL);

        int btnLeftMargin = ctx.getResources().getDimensionPixelSize(R.dimen.btn_goback_left_margin);
        int btnTopMargin = ctx.getResources().getDimensionPixelSize(R.dimen.btn_goback_top_down_margin);
        int btnBottomMargin = ctx.getResources().getDimensionPixelSize(R.dimen.btn_goback_top_down_margin);
        btnParams.setMargins(btnLeftMargin, btnTopMargin, 0, btnBottomMargin);
        gobackBtn.setLayoutParams(btnParams);

        gobackBtn.setOnClickListener(new OnClickListener() {
            @Override
            public void onClick(View view) {
                // XXX: hack here, context may not be Activity
                ((Activity)ctx).onBackPressed();
            }
        });

        gobackBtn.setImageDrawable(ctx.getResources().getDrawable(R.mipmap.icon_back));
        gobackBtn.setBackground(null);
        this.addView(gobackBtn);

        // XXX: hack for debug, developers can clear shared-preferences here
        this.titleText.setOnLongClickListener(new OnLongClickListener() {
            @Override
            public boolean onLongClick(View view) {
                Log.w(TAG, "Clear all personal data from shared preferences");
                LocalStorageManager.clearAll(ctx);

                Toast.makeText(
                        ctx,
                        ctx.getString(R.string.clear_all_sp_data),
                        Toast.LENGTH_SHORT).show();
                return true;
            }
        });
    }

    public void setTitle(String title) {
        this.titleText.setText(title.toUpperCase());
    }

    public String getTitle() {
        return this.titleText.getText().toString();
    }
}
