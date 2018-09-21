package com.wowo.wowo.Activity;

import android.os.Bundle;
import android.support.annotation.Nullable;
import android.view.View;
import android.widget.TextView;

import com.wowo.wowo.Base.BaseActivity;
import com.wowo.wowo.R;


public class UAgreementActivity extends BaseActivity{
    private TextView mTvTitle;
    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_uagreement);
        findView();
        init();
    }

    private void init() {
        mTvTitle.setText("xidata服务协议");
    }


    private void findView() {
        mTvTitle = findView(R.id.title_layout_tv_title);
    }

    @Override
    public void widgetClick(View v) {

    }
}
