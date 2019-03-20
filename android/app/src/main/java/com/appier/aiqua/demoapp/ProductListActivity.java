package com.appier.aiqua.demoapp;

import android.content.Context;
import android.content.Intent;
import android.graphics.Outline;
import android.graphics.Paint;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.ViewOutlineProvider;
import android.widget.ArrayAdapter;
import android.widget.GridView;
import android.widget.ImageView;
import android.widget.TextView;

import com.appier.aiqua.utils.LocalCache;
import com.appier.aiqua.view.DefaultActionBarView;
import com.quantumgraph.sdk.QG;

import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;

public class ProductListActivity extends CheckLoginActivity {

    private static final String TAG = ProductListActivity.class.getName();

    private DefaultActionBarView actionBarView;
    private GridView productGridView;

    private ArrayList<ProductItem> productItems = new ArrayList<>();


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        String category = this.getIntent().getStringExtra("category");
        Log.i(TAG, "Current category: " + category);

        this.setContentView(R.layout.activity_product_list);
        this.actionBarView = this.findViewById(R.id.view_action_bar);
        this.productGridView = this.findViewById(R.id.gridview_product);



        // FIXME: reduce activity launch time
        final int titleResource = LocalCache.getLocalCacheInstance().getProductTitleResMap().get(category);
        int descResource = LocalCache.getLocalCacheInstance().getProductDescResMap().get(category);
        int curPriceResource = LocalCache.getLocalCacheInstance().getProductCurPriceResMap().get(category);
        int prePriceResource = LocalCache.getLocalCacheInstance().getProductPrePriceResMap().get(category);

        final Integer[] productThumbs = LocalCache.getLocalCacheInstance().getProductThumbResMap().get(category);
        final String[] productTitles = this.getResources().getStringArray(titleResource);
        final String[] productDescs = this.getResources().getStringArray(descResource);
        final String[] productCurPrices = this.getResources().getStringArray(curPriceResource);
        final String[] productPrePrices = this.getResources().getStringArray(prePriceResource);
        // set page title
        this.actionBarView.setTitle(category.toUpperCase());
        JSONObject jsonObject = new JSONObject();
        try {
            jsonObject
                    .put("category_name", category)
                    .put("category_deeplink", "aiqua://product?cat="+category);

            // [AIQUA] Logging events
            QG.getInstance(this).logEvent("category_viewed", jsonObject);
        } catch (JSONException e) {

        }
        productItems.clear(); // initialize product items
        for(int i = 0 ; i < productTitles.length; i++) {
            // Note: product order starts from 1, 2, 3...
            int productOrder = i + 1;
            productItems.add(new ProductItem(
                    productOrder,
                    category,
                productTitles[i],
                productDescs[i],
                productCurPrices[i],
                productPrePrices[i],
                productThumbs[i]
            ));
        }

        ProductGridViewAdapter gridViewAdapter = new ProductGridViewAdapter(this, productItems);
        this.productGridView.setAdapter(gridViewAdapter);
    }

    class ProductItem {
        public int order;
        public String title;
        public String desc;
        public String curPrice;
        public String prePrice;
        public String category;
        public int thumbResourceId;

        public ProductItem(int order, String category, String title, String desc, String curPrice, String prePrice, int thumbResourceId) {
            this.order = order;
            this.category = category;
            this.title = title;
            this.desc = desc;
            this.curPrice = curPrice;
            this.prePrice = prePrice;
            this.thumbResourceId = thumbResourceId;
        }
    }

    class ProductGridViewAdapter extends ArrayAdapter<ProductItem> {
        public ProductGridViewAdapter(@NonNull Context context, @NonNull ArrayList<ProductItem> array) {
            super(context, 0, array);
        }

        @Override
        public View getView(int position, View convertView, ViewGroup parent) {
            final ProductItem item = getItem(position);

            if(convertView == null) {
                convertView = LayoutInflater.from(getContext()).inflate(R.layout.item_product, parent, false);
            }

            TextView titleText = convertView.findViewById(R.id.text_product_title);
            TextView descriptionText = convertView.findViewById(R.id.text_product_desc);
            TextView curPriceText = convertView.findViewById(R.id.current_price);
            TextView prePriceText = convertView.findViewById(R.id.previous_price);
            ImageView thumbImg = convertView.findViewById(R.id.img_product_thumb);

            titleText.setText(item.title);
            descriptionText.setText(item.desc);
            curPriceText.setText(item.curPrice);

            prePriceText.setText(item.prePrice);

            // To keep prePriceText strike-through
            prePriceText.setPaintFlags(prePriceText.getPaintFlags() | Paint.STRIKE_THRU_TEXT_FLAG);

            thumbImg.setImageResource(item.thumbResourceId);

            // Note: To keep image upper corners rounded
            // Ref, https://medium.com/@iamsadesh/android-ui-creating-a-layout-rounded-only-in-the-top-d60514ccab77
            thumbImg.setOutlineProvider(new ViewOutlineProvider() {
                @Override
                public void getOutline(View view, Outline outline) {
                    outline.setRoundRect(0, 0, view.getWidth(), (int)(view.getHeight() + 20F), 20F);
                }
            });
            thumbImg.setClipToOutline(true);

            convertView.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    Log.i(TAG, "User click item, category: " + item.category + ", order: " + item.order);
                    gotoProductDetailPage(item.category, item.title, item.order);
                }
            });

            return convertView;
        }

        private void gotoProductDetailPage(String productCategory, String productName, int productOrder) {
            // goto next page
            Intent intent = new Intent(this.getContext(), ProductDetailActivity.class);
            intent.putExtra("productName", productName);
            intent.putExtra("productOrder", productOrder);
            intent.putExtra("productCategory", productCategory);
            startActivity(intent);
            overridePendingTransition(R.anim.page_enter, 0);
        }
    }
}
