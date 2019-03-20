package com.appier.aiqua.utils;

import com.appier.aiqua.demoapp.R;

import java.util.HashMap;
import java.util.Map;

public class LocalCache
{
    private Map<String, Integer> productTitleResMap = new HashMap<>();
    private Map<String, Integer> productDescResMap = new HashMap<>();
    private Map<String, Integer> productCurPriceResMap = new HashMap<>();
    private Map<String, Integer> productPrePriceResMap = new HashMap<>();
    private Map<String, Integer[]> productThumbResMap = new HashMap<>();
    private Map<String, Integer[]> productItemMap = new HashMap<>();

    private String selectedCategory;
    private Map<String, Integer> categoryImgMap = new HashMap<>();

    private static LocalCache instance;

    private LocalCache() {

        this.productTitleResMap.put("Fashion", R.array.product_fashion_title);
        this.productDescResMap.put("Fashion", R.array.product_fashion_description);
        this.productCurPriceResMap.put("Fashion", R.array.product_fashion_current_price);
        this.productPrePriceResMap.put("Fashion", R.array.product_fashion_previous_price);
        this.productThumbResMap.put("Fashion", new Integer[]{
                R.mipmap.thumbnail_fashion_01,
                R.mipmap.thumbnail_fashion_02,
                R.mipmap.thumbnail_fashion_03,
                R.mipmap.thumbnail_fashion_04
        });
        this.productItemMap.put("Fashion_1", new Integer[]{ R.array.product_fashion_01_detail, R.mipmap.image_product_detail_fashion_01});
        this.productItemMap.put("Fashion_2", new Integer[]{ R.array.product_fashion_02_detail, R.mipmap.image_product_detail_fashion_02});
        this.productItemMap.put("Fashion_3", new Integer[]{ R.array.product_fashion_03_detail, R.mipmap.image_product_detail_fashion_03});
        this.productItemMap.put("Fashion_4", new Integer[]{ R.array.product_fashion_04_detail, R.mipmap.image_product_detail_fashion_04});


        this.productTitleResMap.put("Shoes", R.array.product_shoes_title);
        this.productDescResMap.put("Shoes", R.array.product_shoes_description);
        this.productCurPriceResMap.put("Shoes", R.array.product_shoes_current_price);
        this.productPrePriceResMap.put("Shoes", R.array.product_shoes_previous_price);
        this.productThumbResMap.put("Shoes", new Integer[]{
                R.mipmap.thumbnail_shoes_01,
                R.mipmap.thumbnail_shoes_02,
                R.mipmap.thumbnail_shoes_03,
                R.mipmap.thumbnail_shoes_04
        });
        this.productItemMap.put("Shoes_1", new Integer[]{ R.array.product_shoes_01_detail, R.mipmap.image_product_detail_shoes_01});
        this.productItemMap.put("Shoes_2", new Integer[]{ R.array.product_shoes_02_detail, R.mipmap.image_product_detail_shoes_02});
        this.productItemMap.put("Shoes_3", new Integer[]{ R.array.product_shoes_03_detail, R.mipmap.image_product_detail_shoes_03});
        this.productItemMap.put("Shoes_4", new Integer[]{ R.array.product_shoes_04_detail, R.mipmap.image_product_detail_shoes_04});



        this.productTitleResMap.put("Electronics", R.array.product_electronics_title);
        this.productDescResMap.put("Electronics", R.array.product_electronics_description);
        this.productCurPriceResMap.put("Electronics", R.array.product_electronics_current_price);
        this.productPrePriceResMap.put("Electronics", R.array.product_electronics_previous_price);
        this.productThumbResMap.put("Electronics", new Integer[]{
                R.mipmap.thumbnail_electronics_01,
                R.mipmap.thumbnail_electronics_02,
                R.mipmap.thumbnail_electronics_03,
                R.mipmap.thumbnail_electronics_04
        });
        this.productItemMap.put("Electronics_1", new Integer[]{ R.array.product_electronics_01_detail, R.mipmap.image_product_detail_electronics_01});
        this.productItemMap.put("Electronics_2", new Integer[]{ R.array.product_electronics_02_detail, R.mipmap.image_product_detail_electronics_02});
        this.productItemMap.put("Electronics_3", new Integer[]{ R.array.product_electronics_03_detail, R.mipmap.image_product_detail_electronics_03});
        this.productItemMap.put("Electronics_4", new Integer[]{ R.array.product_electronics_04_detail, R.mipmap.image_product_detail_electronics_04});

        this.productTitleResMap.put("Pet Supplies", R.array.product_pet_supplies_title);
        this.productDescResMap.put("Pet Supplies", R.array.product_pet_supplies_description);
        this.productCurPriceResMap.put("Pet Supplies", R.array.product_pet_supplies_current_price);
        this.productPrePriceResMap.put("Pet Supplies", R.array.product_pet_supplies_previous_price);
        this.productThumbResMap.put("Pet Supplies", new Integer[]{
                R.mipmap.thumbnail_pet_supplies_01,
                R.mipmap.thumbnail_pet_supplies_02,
                R.mipmap.thumbnail_pet_supplies_03,
                R.mipmap.thumbnail_pet_supplies_04
        });
        this.productItemMap.put("Pet Supplies_1", new Integer[]{ R.array.product_pet_supplies_01_detail, R.mipmap.image_product_detail_pet_supplies_01});
        this.productItemMap.put("Pet Supplies_2", new Integer[]{ R.array.product_pet_supplies_02_detail, R.mipmap.image_product_detail_pet_supplies_02});
        this.productItemMap.put("Pet Supplies_3", new Integer[]{ R.array.product_pet_supplies_03_detail, R.mipmap.image_product_detail_pet_supplies_03});
        this.productItemMap.put("Pet Supplies_4", new Integer[]{ R.array.product_pet_supplies_04_detail, R.mipmap.image_product_detail_pet_supplies_04});


        this.categoryImgMap.put("Fashion", R.mipmap.cover_category_image_shopping);
        this.categoryImgMap.put("Shoes", R.mipmap.cover_category_image_shoes);
        this.categoryImgMap.put("Electronics", R.mipmap.cover_category_image_electronics);
        this.categoryImgMap.put("Pet Supplies", R.mipmap.cover_category_image_pet_supplies);

    }

    public static LocalCache getLocalCacheInstance() {
        if(instance == null) {
            instance = new LocalCache();
        }
        return instance;
    }

    public void setSelectedCategory(String category) { this.selectedCategory = category; }
    public String getSelectedCategory() { return this.selectedCategory; }

    public Map<String, Integer> getProductTitleResMap() { return this.productTitleResMap; }
    public Map<String, Integer> getProductDescResMap() { return this.productDescResMap; }
    public Map<String, Integer> getProductCurPriceResMap() { return this.productCurPriceResMap; }
    public Map<String, Integer> getProductPrePriceResMap() { return this.productPrePriceResMap; }
    public Map<String, Integer[]> getProductThumbResMap() { return this.productThumbResMap; }
    public Map<String, Integer[]> getProductItemsMap() { return this.productItemMap; }
    public Map<String, Integer> getCategoryImgMap() { return this.categoryImgMap; }

}
