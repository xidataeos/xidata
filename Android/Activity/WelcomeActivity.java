package com.wowo.wowo.Activity;

import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.os.Handler;
import android.util.Log;
import android.view.View;
import android.view.WindowManager;

import com. wowo.wowo.Base.BaseActivity;
import com.wowo.wowo.Model.UserModel;
import com. wowo.wowo.R;
import com. wowo.wowo.Utils.SharedPreferencesManager;



public class WelcomeActivity extends BaseActivity {
    private static final String TAG = WelcomeActivity.class.getSimpleName();
    private UserModel model;

    @Override
    protected void onCreate(Bundle savedInstanceState) {//beidong
        super.onCreate(savedInstanceState);
        getWindow().setFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN,
                WindowManager.LayoutParams.FLAG_FULLSCREEN);
        if (isFirstOpen()){//判断用户是否是第一次打开APP
            GoLogin();
//            Intent intent = new Intent(this, WelcomeGuideActivity.class);
//            startActivity(intent);
//            finish();
            return;
        }
        setContentView(R.layout.activity_welcome);
        model = SharedPreferencesManager.getInstance().getUserData(this);
        Handler handler = new Handler();
        handler.postDelayed(new Runnable() {
            @Override
            public void run() {
                Log.e(TAG, "run==========: ");
                //GoHome();//存在表明用户已注册
                if (model.getUserId().trim().isEmpty()){//判断是否存在userId
                    Log.e(TAG, "不存在表明用户未注册: ");
                    GoLogin();//不存在表明用户未注册
                }else {
                    Log.e(TAG, "存在表明用户已注册: ");//
                    GoHome();//存在表明用户已注册
                }
            }
        },2000);
    }


    @Override
    public void widgetClick(View v) {

    }
    /**
     * 判断是否第一次打开APP
     *
     * @return
     */
    private boolean isFirstOpen() {
        SharedPreferences setting = getSharedPreferences("firstopen", 0);
        Boolean user_first = setting.getBoolean("FIRST", true);
        if (user_first) {//第一次
            setting.edit().putBoolean("FIRST", false).commit();
            return true;
        } else {
            return false;
        }
    }

    @Override
    public void onClick(View v) {
        super.onClick(v);
        Log.e(TAG, "onClick: " );
    }

    private void GoHome(){
        Intent intent = new Intent(WelcomeActivity.this, HomePageActivity.class);
        startActivity(intent);
        WelcomeActivity.this.finish();
    }
    private void GoLogin() {
            Intent intent = new Intent(WelcomeActivity.this, LoginActivity.class);
            startActivity(intent);
            Log.e(TAG, "GoLogin: LoginActivity" );
            WelcomeActivity.this.finish();
    }
}
