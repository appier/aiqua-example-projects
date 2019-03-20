package com.appier.aiqua.utils;

import android.content.Context;
import android.content.SharedPreferences;

public class LocalStorageManager {

    private static final String USER_PROFILE_PREFERENCE = "user_profile";

    private static final String DEFAULT_STRING = null;
    private static final String KEY_USER_NAME = "user_name";
    private static final String KEY_USER_EMAIL = "user_email";
    private static final String KEY_USER_COMPANY = "user_company";
    private static final String KEY_COUNTRY = "country";

    private static SharedPreferences preferences = null;

    public static SharedPreferences getInstances(Context ctx) {
        if (preferences == null) {
            preferences = ctx.getSharedPreferences(USER_PROFILE_PREFERENCE, Context.MODE_PRIVATE);
        }
        return preferences;
    }

    public static boolean setUserName(Context ctx, String name) {
        return getInstances(ctx).edit().putString(KEY_USER_NAME, name).commit();
    }

    public static boolean setUserEmail(Context ctx, String email) {
        return getInstances(ctx).edit().putString(KEY_USER_EMAIL, email).commit();
    }

    public static boolean setUserCompany(Context ctx, String company) {
        return getInstances(ctx).edit().putString(KEY_USER_COMPANY, company).commit();
    }

    public static boolean setCountry(Context ctx, String country) {
        return getInstances(ctx).edit().putString(KEY_COUNTRY, country).commit();
    }

    public static String getUserName(Context ctx) {
        return getInstances(ctx).getString(KEY_USER_NAME, DEFAULT_STRING);
    }

    public static String getUserEmail(Context ctx) {
        return getInstances(ctx).getString(KEY_USER_EMAIL, DEFAULT_STRING);
    }

    public static String getUserCompany(Context ctx) {
        return getInstances(ctx).getString(KEY_USER_COMPANY, DEFAULT_STRING);
    }

    public static String getCountry(Context ctx) {
        return getInstances(ctx).getString(KEY_COUNTRY, DEFAULT_STRING);
    }

    public static void clearAll(Context ctx) {
        getInstances(ctx).edit().clear().commit();
    }
}
