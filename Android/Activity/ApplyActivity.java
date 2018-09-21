package com.wowo.wowo.Activity;

import android.os.Bundle;
import android.support.annotation.Nullable;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.TextView;

import com.wowo.wowo.Base.BaseActivity;
import com.wowo.wowo.Model.ApplyModel;
import com.wowo.wowo.Model.UserModel;
import com.wowo.wowo.R;
import com.wowo.wowo.Utils.CheckUtils;
import com.wowo.wowo.Utils.LogUtil;
import com.wowo.wowo.Utils.SharedPreferencesManager;
import com.wowo.wowo.Views.Dialog.BottomDialog;
import com.wowo.wowo.rxjava.BaseResponse;
import com.wowo.wowo.rxjava.ProgressSubscriber;
import com.wowo.wowo.rxjava.RetrofitAPIManager;
import com.wowo.wowo.rxjava.SubscriberOnNextListener;

/*
*我的邀请码
 */
public class ApplyActivity extends BaseActivity{
    private Button mBtAaaply;
    private TextView mTvTitile;
    private Bundle bundle;
    private EditText mEtName,mEtPhone,mEtCorporation,mEtdept ,mEtposition;
    UserModel userModel;
    SubscriberOnNextListener listener;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_apply);

        init();
    }

    private void init() {
        userModel = SharedPreferencesManager.getInstance().getUserData(this);
        bundle = getIntent().getExtras();
        mTvTitile = findView(R.id.title_layout_tv_title);
        mTvTitile.setText("填写报名表单");
        mEtName= findView(R.id.apply_tv_name);
        mEtPhone= findView(R.id.apply_tv_phone);
        mEtCorporation= findView(R.id.apply_tv_cor);
        mEtdept= findView(R.id.apply_tv_dep);
        mEtposition= findView(R.id.apply_tv_pos);
        mBtAaaply= findView(R.id.apply_bt_apply);
        mBtAaaply.setOnClickListener(this);
        mEtPhone.setText(userModel.getTel().toString());
        listener = new SubscriberOnNextListener<BaseResponse<ApplyModel>>() {
            @Override
            public void onNext(BaseResponse<ApplyModel> baseResponse) {
                ApplyModel model = baseResponse.data;
                if (model!=null){
                    mEtName.setText(model.getApplyName().toString());
                    mEtPhone.setText(model.getPhone().toString());
                    mEtCorporation.setText(model.getCorporation().toString());
                    mEtdept.setText(model.getDept().toString());
                    mEtposition.setText(model.getPosition().toString());
                    if (model.getState()!=0){
                        mBtAaaply.setOnClickListener(null);
                    }
                    if (model.getState()==1){
                        mBtAaaply.setText("待审核");
                    }else if (model.getState()==2){
                        mBtAaaply.setText("审核通过");
                    }else if (model.getState()==3){
                        mBtAaaply.setText("审核失败");
                    }
                }
            }
        };
    }

    @Override
    protected void onResume() {
        super.onResume();
        RetrofitAPIManager.getInstance().getgetApply(new ProgressSubscriber<BaseResponse<ApplyModel>>(listener,ApplyActivity.this,0)
                ,bundle.get("uId").toString(),bundle.get("mId").toString());
    }

    @Override
    public void widgetClick(View v) {
        switch (v.getId()){
            case R.id.apply_bt_apply://提交報名
                SubscriberOnNextListener mlistener = new SubscriberOnNextListener<BaseResponse<String>>() {
                    @Override
                    public void onNext(BaseResponse<String> baseResponse) {
                        showToast("报名成功");
                        finish();
                    }
                };
                if (mEtPhone.getText().toString() == null || mEtPhone.getText().toString().isEmpty()) {
                    showToast("手机号码不能为空");
                    return;
                } else if (!CheckUtils.isMobile(mEtPhone.getText().toString())) {
                    showToast("手机号码格式不正确");
                    return;
                }
                if (mEtName.getText().toString().isEmpty()||mEtName.getText().toString()==null){
                    showToast("请填写姓名");
                    return;
                }
                RetrofitAPIManager.getInstance().getInsertApply(new ProgressSubscriber<BaseResponse<String>>(mlistener,ApplyActivity.this,0)
                        ,mEtName.getText().toString(),mEtPhone.getText().toString(),mEtCorporation.getText().toString(),mEtdept.getText().toString()
                        ,mEtposition.getText().toString(),bundle.get("uId").toString(),bundle.get("mId").toString());
                break;
        }
    }
}
