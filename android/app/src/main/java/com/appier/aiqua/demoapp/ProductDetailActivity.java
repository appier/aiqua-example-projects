package com.appier.aiqua.demoapp;

import android.graphics.Paint;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.ImageButton;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

import com.appier.aiqua.utils.LocalCache;
import com.appier.aiqua.view.DefaultActionBarView;
import com.quantumgraph.sdk.QG;

import org.json.JSONException;
import org.json.JSONObject;

public class ProductDetailActivity extends CheckLoginActivity {

    private final static String TAG = ProductDetailActivity.class.getName();

    private DefaultActionBarView actionBarView;
    private ImageView productImg;
    private TextView productNameText;
    private TextView productDescText;
    private TextView productRatingText;
    private TextView productRatingCountText;
    private TextView productCurPriceText;
    private TextView productPrePriceText;
    private TextView productDiscountText;
    private ImageButton productWishlistBtn;
    private ImageButton productShoppingCartBtn;

    private boolean selectedWishlistBtn = false;
    private boolean selectedShoppingCartBtn = false;


    private void logQG(String eventName,
                       String name,
                       String price,
                       String rating,
                       String category,
                       String imageUrl,
                       String deepLink
    ) {
        try {

            // [AIQUA] Logging events
            QG.getInstance(this).logEvent(
                    eventName,
                    new JSONObject()
                            .put("product_name", name)
                            .put("product_price", price)
                            .put("product_rating", rating)
                            .put("product_category", category)
                            .put("product_image_url", imageUrl)
                            .put("product_deeplink", deepLink)
            );
        } catch (JSONException e) {

        }

    }


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        final String productCategory = this.getIntent().getStringExtra("productCategory");
        final String productName = this.getIntent().getStringExtra("productName");
        int productOrder = this.getIntent().getIntExtra("productOrder", 0);

        Log.i(TAG, "Initialize ProductDetail Page with category : " + productCategory +
                ", name : " + productName + ", order : " + productOrder);

        this.setContentView(R.layout.activity_product_detail);
        this.actionBarView = this.findViewById(R.id.view_action_bar);
        this.productImg = this.findViewById(R.id.img_product);
        this.productNameText = this.findViewById(R.id.text_product_name);
        this.productDescText = this.findViewById(R.id.text_product_description);
        this.productRatingText = this.findViewById(R.id.text_product_rating);
        this.productRatingCountText = this.findViewById(R.id.text_product_rating_count);
        this.productCurPriceText = this.findViewById(R.id.text_product_current_price);
        this.productPrePriceText = this.findViewById(R.id.text_product_previous_price);
        this.productDiscountText = this.findViewById(R.id.text_product_discount);
        this.productWishlistBtn = this.findViewById(R.id.btn_wishlist);
        this.productShoppingCartBtn = this.findViewById(R.id.btn_shopping_cart);

        // set page title
        this.actionBarView.setTitle(productName);

        final String productItemKey = String.format("%s_%s", productCategory, productOrder);

        Log.i(TAG, "ProductDetailItemKey : " + productItemKey);
        Integer[] productResources = LocalCache.getLocalCacheInstance().getProductItemsMap().get(productItemKey); // get detail string-array and image resource id

        int productDetailResId = productResources[0];
        int productImgResId = productResources[1];
        String[] detail = this.getResources().getStringArray(productDetailResId);

        // set product image
        this.productImg.setImageResource(productImgResId);

        // set product detail information
        // FIXME: It's supposed to be improve, not hard code here.
        final String name = detail[0];
        final String desc = detail[1];
        final String rating = detail[2];
        final String rateCounting = detail[3];
        final String curPrice = detail[4];
        final String prePrice = detail[5];
        final String discount = detail[6];
        final String imageUrl = detail[7];
        final String deepLink = "aiqua://product?productName=" + productName + "&productOrder=" + productOrder + "&productCategory=" + productCategory;
        logQG("product_viewed",
                name,
                curPrice,
                rating,
                productCategory,
                imageUrl,
                deepLink);
        this.productNameText.setText(name);
        this.productDescText.setText(desc);
        this.productRatingText.setText(rating);
        this.productRatingCountText.setText(rateCounting);
        this.productCurPriceText.setText(curPrice);
        this.productPrePriceText.setText(prePrice);
        this.productDiscountText.setText(discount);

        // To keep prePriceText strike-through
        this.productPrePriceText.setPaintFlags(this.productPrePriceText.getPaintFlags() | Paint.STRIKE_THRU_TEXT_FLAG);

        this.productWishlistBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                selectedWishlistBtn = !selectedWishlistBtn;
                if (selectedWishlistBtn) {
                    // show toast
                    Toast.makeText(
                            ProductDetailActivity.this,
                            ProductDetailActivity.this.getResources().getString(R.string.text_added_to_favorite),
                            Toast.LENGTH_SHORT).show();
                    logQG("product_added_to_wishlist",
                            name,
                            curPrice,
                            rating,
                            productCategory,
                            imageUrl,
                            deepLink);
                }

                // change icon
                productWishlistBtn.setImageResource(
                        selectedWishlistBtn ? R.mipmap.ic_wishlist_selected : R.mipmap.ic_wishlist_normal
                );
            }
        });


        this.productShoppingCartBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                selectedShoppingCartBtn = !selectedShoppingCartBtn;
                if (selectedShoppingCartBtn) {
                    logQG("product_added_to_cart",
                            name,
                            curPrice,
                            rating,
                            productCategory,
                            imageUrl,
                            deepLink);
                    // TODO: integrate AIQUA SDK here
                    // show toast
                    Toast.makeText(
                            ProductDetailActivity.this,
                            ProductDetailActivity.this.getResources().getString(R.string.text_added_to_cart),
                            Toast.LENGTH_SHORT).show();
                }

                // change icon
                productShoppingCartBtn.setImageResource(
                        selectedShoppingCartBtn ? R.mipmap.ic_cart_selected : R.mipmap.ic_cart_normal
                );

            }
        });
    }
}
