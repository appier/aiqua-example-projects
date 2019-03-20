package com.appier.aiqua.demoapp;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.TextView;

import com.appier.aiqua.utils.LocalCache;
import com.appier.aiqua.view.DefaultActionBarView;
import com.quantumgraph.sdk.QG;

import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;

public class ProductCategoryActivity extends CheckLoginActivity
{

    private final String TAG = ProductCategoryActivity.class.getName();
    private static QG qg;
    private DefaultActionBarView viewActionBar;
    private ImageView mainCategoryImg;
    private ListView categoryListView;
    private Button getNotificationBtn;
    private TextView getNotificationDescText;

    private CategoryAdapter categoryAdapter;
    private ArrayList<CategoryItem> categories = new ArrayList<>();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        qg = QG.getInstance(this);
        this.setContentView(R.layout.activity_product_category);
        this.viewActionBar = this.findViewById(R.id.view_action_bar);
        this.mainCategoryImg = this.findViewById(R.id.img_main_category);
        this.categoryListView = this.findViewById(R.id.category_listview);
        this.getNotificationBtn = this.findViewById(R.id.btn_get_notification);
        this.getNotificationDescText = this.findViewById(R.id.text_get_notification_desc);

        // set page title
        this.viewActionBar.setTitle(this.getResources().getString(R.string.text_productL_category_title));

        // setup category listview
        this.categories = this.loadAllCategoriesFromResources();
        this.categoryAdapter = new CategoryAdapter(this, this.categories);
        this.categoryListView.setAdapter(this.categoryAdapter);
    }

    @Override
    protected void onStart() {
        super.onStart();
        // Note: if user has viewed specified category, next time when he/she comes back this page
        // The main image should be changed type to fit that specified category,
        // and show "get_notification" button in this page.
        String selectedCategory = LocalCache.getLocalCacheInstance().getSelectedCategory();
        JSONObject jsonObject = new JSONObject();
        try {
            jsonObject.put("page_name", "ecomHomeScreen_default");

        if ("Fashion" == selectedCategory) {
            jsonObject
                    .put("page_name", "ecomHomeScreen_A")
                    .put("category_name", "Fashion");
        } else if ("Shoes" == selectedCategory) {
            jsonObject
                    .put("page_name", "ecomHomeScreen_B")
                    .put("category_name", "Shoes");
        } else if ("Electronics" == selectedCategory) {
            jsonObject
                    .put("page_name", "ecomHomeScreen_C")
                    .put("category_name", "Electronics");
        } else if ("Pet Supplies" == selectedCategory) {
            jsonObject
                    .put("page_name", "ecomHomeScreen_D")
                    .put("category_name", "Pet Supplies");
        }

        // [AIQUA] Logging events
        qg.logEvent("page_viewed", jsonObject);
        } catch (JSONException e) {

        }
        setupMainImage(this.mainCategoryImg, selectedCategory);

        setupGetNotificationLayout(getNotificationDescText, getNotificationBtn, selectedCategory);
    }

    private ArrayList<CategoryItem> loadAllCategoriesFromResources() {
        ArrayList<CategoryItem> categories = new ArrayList<>();

        final String[] titles = this.getResources().getStringArray(R.array.category_title);
        final String[] descriptions = this.getResources().getStringArray(R.array.category_description);
        final int[] thumbs = {
                R.mipmap.thumbnail_fashion,
                R.mipmap.thumbnail_shoes,
                R.mipmap.thumbnail_electronics,
                R.mipmap.thumbnail_pet_supplies
        };
        for(int i = 0 ; i < titles.length ; i++ ) {
            categories.add(new CategoryItem(
                    titles[i],
                    descriptions[i],
                    thumbs[i]
            ));
        }
        return categories;
    }

    private void setupMainImage(ImageView imageView, String selectedCategory) {
        // default main image resource id
        int mainImgResId = R.mipmap.cover_category_image_default;
        if(selectedCategory != null) {
            mainImgResId = LocalCache.getLocalCacheInstance().getCategoryImgMap().get(selectedCategory);
        }
        imageView.setImageResource(mainImgResId);
    }


    private void setupGetNotificationLayout(TextView getNotificationDescText, Button getNotificationBtn, String selectedCategory) {
        if(selectedCategory == null) {
            getNotificationDescText.setVisibility(View.VISIBLE);
            getNotificationBtn.setVisibility(View.GONE);
        } else {
            getNotificationDescText.setVisibility(View.GONE);
            getNotificationBtn.setVisibility(View.VISIBLE);
            getNotificationBtn.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    Log.i(TAG, "User clicks get_notification button");

                    // [AIQUA] Logging events
                    qg.logEvent("clicked_personalizedNotification");
                }
            });
        }
    }

    class CategoryItem {
        private String title;
        private String desc;
        private int thumbResourceId;

        public CategoryItem(String title, String desc, int thumbResourceId) {
            this.title = title;
            this.desc = desc;
            this.thumbResourceId = thumbResourceId;
        }

        public String getTitle() { return this.title; }
        public String getDesc() { return this.desc; }
        public int getThumbResourceId() {return this.thumbResourceId; }
    }

    class CategoryAdapter extends ArrayAdapter<CategoryItem> {

        public CategoryAdapter(Context ctx, ArrayList<CategoryItem> categoryItems) {
            super(ctx, 0, categoryItems);
        }

        @Override
        public View getView(int position, View convertView, ViewGroup parent) {
            final CategoryItem category = this.getItem(position);

            // Note: Check if an existing view is being reused
            // Otherwise inflate the view
            if (convertView == null) {
                convertView = LayoutInflater.from(getContext()).inflate(R.layout.item_category, parent, false);
            }

            TextView titleText = convertView.findViewById(R.id.text_item_title);
            TextView descText = convertView.findViewById(R.id.text_item_description);
            ImageView thumbImg = convertView.findViewById(R.id.img_thumb_notification);
            Button viewProductsBtn = convertView.findViewById(R.id.btn_show_example_one);

            titleText.setText(category.getTitle());
            descText.setText(category.getDesc());
            thumbImg.setImageResource(category.getThumbResourceId());

            viewProductsBtn.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    gotoProductListPage(getContext(), category.getTitle());
                }
            });

            return convertView;
        }

        private void gotoProductListPage(Context ctx, String category) {
            // save selected category
            LocalCache.getLocalCacheInstance().setSelectedCategory(category);

            // goto next page
            Intent intent = new Intent(ctx, ProductListActivity.class);
            intent.putExtra("category", category);
            startActivity(intent);
            overridePendingTransition(R.anim.page_enter, 0);
        }
    }
}
