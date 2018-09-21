package com.wowo.wowo.Activity;

import android.app.Activity;
import android.content.Intent;
import android.graphics.Bitmap;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.view.View;
import android.widget.LinearLayout;

import com.uuzuche.lib_zxing.activity.CaptureFragment;
import com.uuzuche.lib_zxing.activity.CodeUtils;
import com.wowo.wowo.Base.BaseActivity;
import com.wowo.wowo.R;
import com.wowo.wowo.Utils.CommonUtils;



/**
 * 定制化显示扫描界面
 */
public class SecondActivity extends BaseActivity {

    private CaptureFragment captureFragment;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_second);
        initMethods();
    }

    public void initMethods() {
        captureFragment = new CaptureFragment();
        // 为二维码扫描界面设置定制化界面
        CodeUtils.setFragmentArgs(captureFragment, R.layout.my_camera);
        captureFragment.setAnalyzeCallback(analyzeCallback);
        getSupportFragmentManager().beginTransaction().replace(R.id.fl_my_container, captureFragment).commit();

        initView();
    }




    public static boolean isOpen = false;

    private void initView() {
        LinearLayout linearLayout = (LinearLayout) findViewById(R.id.linear1);
        linearLayout.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (!isOpen) {
                    CodeUtils.isLightEnable(true);
                    isOpen = true;
                } else {
                    CodeUtils.isLightEnable(false);
                    isOpen = false;
                }

            }
        });
    }

    /**
     * 二维码解析回调函数
     */
    private String type = null; //二维码识别 0 个人 1群二维码
    private String Qrcode;
    private String Uid;
    CodeUtils.AnalyzeCallback analyzeCallback = new CodeUtils.AnalyzeCallback() {
        @Override
        public void onAnalyzeSuccess(Bitmap mBitmap, String result) {
              SecondActivity.this.finish();
                parameterNull(result);
              if (!result.contains("wowo")){
                  CommonUtils.Toastshow("二维码格式出错");
                  return;
              }
                String[] str = result.split(",");
                String uid = null;
                type = str[1];
                parameterNull(type);
                uid = str[2];
                parameterNull(uid);
                //群
                if (type.contains("0")){
                    Bundle bundle = new Bundle();
                    bundle.putString("uid", uid);
                    SecondActivity.this.openActivity(FriendsDetailsActivity.class, bundle);
                }else if (type.contentEquals("1")){
                    Qrcode = str[3];
                    parameterNull(Qrcode);
                    Uid = str[4];
                    parameterNull(Uid);
                    Bundle bundle = new Bundle();
                    bundle.putString("uid", Uid);
                    bundle.putString("qrcode", Qrcode);
                    bundle.putString("cid", uid);
                    SecondActivity.this.openActivity(GroupDetailsActivity.class, bundle);
                }

        }

        @Override
        public void onAnalyzeFailed() {
            Intent resultIntent = new Intent();
            Bundle bundle = new Bundle();
            bundle.putInt(CodeUtils.RESULT_TYPE, CodeUtils.RESULT_FAILED);
            bundle.putString(CodeUtils.RESULT_STRING, "");
            resultIntent.putExtras(bundle);
            SecondActivity.this.setResult(RESULT_OK, resultIntent);
            SecondActivity.this.finish();
        }
    };
    private void parameterNull(String name){
        if (name == null){
            CommonUtils.Toastshow("用户信息出错");
            return;
        }
    }
    @Override
    public void widgetClick(View v) {

    }
}
