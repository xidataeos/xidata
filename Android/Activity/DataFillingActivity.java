package com.wowo.wowo.Activity;

import android.net.Uri;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.TextView;

import com.wowo.wowo.Base.BaseActivity;
import com.wowo.wowo.Bean.UpdateUserInfoBean;
import com.wowo.wowo.Model.UserModel;
import com.wowo.wowo.R;
import com.wowo.wowo.Utils.GetResourcesUtil;
import com.wowo.wowo.Utils.LogUtil;
import com.wowo.wowo.Utils.SharedPreferencesManager;
import com.wowo.wowo.rxjava.BaseResponse;
import com.wowo.wowo.rxjava.ProgressSubscriber;
import com.wowo.wowo.rxjava.RetrofitAPIManager;
import com.wowo.wowo.rxjava.SubscriberOnNextListener;

import io.rong.imkit.RongIM;
import io.rong.imlib.model.UserInfo;

public class DataFillingActivity extends BaseActivity {
    private TextView mTvBoy,mTvGirl;
    private EditText mEtName;
    private ImageView mIvBoy,mIvGirl;
    private Button mBtFinish;
    private int sex =1;
    private UserModel model;
    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_datafilling);
        findView();
        init();
        initListener();
    }

    private void findView() {
        mTvBoy = findView(R.id.data_tv_boy);
        mTvGirl= findView(R.id.data_tv_girl);
        mEtName =findView(R.id.data_et_name);
        mIvBoy=findView(R.id.data_iv_boy);
        mIvGirl = findView(R.id.data_iv_girl);
        mBtFinish = findView(R.id.data_btn_regits);
    }
    private void init() {
        model = SharedPreferencesManager.getInstance().getUserData(this);
    }
    private void initListener() {
        mIvBoy.setOnClickListener(this);
        mIvGirl.setOnClickListener(this);
        mBtFinish.setOnClickListener(this);
        mEtName.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence s, int start, int count, int after) {
                if (after>0) {
                    mBtFinish.setEnabled(true);
                    mBtFinish.setTextColor(getResources().getColor(R.color.white));
                } else {
                    mBtFinish.setEnabled(false);
                    mBtFinish.setTextColor(getResources().getColor(R.color.login_btn_gray));
                }
            }

            @Override
            public void onTextChanged(CharSequence s, int start, int before, int count) {

            }

            @Override
            public void afterTextChanged(Editable s) {

            }
        });

    }
    @Override
    public void widgetClick(View v) {
    switch (v.getId()){
        case R.id.data_iv_boy:
            mTvBoy.setTextColor(GetResourcesUtil.getColor(this, R.color.main_color));
            mTvGirl.setTextColor(GetResourcesUtil.getColor(this, R.color.gray_light));
            sex = 1;
            break;
        case R.id. data_iv_girl:
            mTvGirl.setTextColor(GetResourcesUtil.getColor(this, R.color.main_color));
            mTvBoy.setTextColor(GetResourcesUtil.getColor(this, R.color.gray_light));
            sex = 0;
            break;
        case R.id.data_btn_regits:
            model.setSex(sex+"");
            model.setName(mEtName.getText().toString());
            SharedPreferencesManager.getInstance().putUserData(DataFillingActivity.this, model);
            RongIM.getInstance().refreshUserInfoCache(new UserInfo(model.getUserId(),model.getName().toString(), Uri.parse(model.getPhoto().toString())));
            SubscriberOnNextListener listener = new SubscriberOnNextListener<BaseResponse<UpdateUserInfoBean>>() {
                @Override
                public void onNext(BaseResponse<UpdateUserInfoBean> baseResponse) {
                    LogUtil.e("TAG","设置成功");
                    finish();
                }
            };
            RetrofitAPIManager.getInstance().getUpdateUserInfo2(new ProgressSubscriber<BaseResponse<UpdateUserInfoBean>>(listener, this, 0), model.getUserId(),mEtName.getText().toString(),sex+"","","");
            openActivity(HomePageActivity.class);
            break;
    }
    }
}
