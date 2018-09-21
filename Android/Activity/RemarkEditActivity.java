package com.wowo.wowo.Activity;

import android.os.Bundle;
import android.support.annotation.Nullable;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;

import com.wowo.wowo.Base.BaseActivity;
import com.wowo.wowo.Model.FriendInfoModel;
import com.wowo.wowo.Model.GroupMemberModel;
import com.wowo.wowo.R;
import com.wowo.wowo.Views.Dialog.DeleteDialog;
import com.wowo.wowo.rxjava.BaseResponse;
import com.wowo.wowo.rxjava.ProgressSubscriber;
import com.wowo.wowo.rxjava.RetrofitAPIManager;
import com.wowo.wowo.rxjava.SubscriberOnNextListener;

import java.util.List;

public class RemarkEditActivity extends BaseActivity{
    private Bundle bundle;
    private TextView mTvTitle,mTvAction;
    private EditText mEtRemark;
    String mid;
    String fid;
    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_remarkedit);
        findViews();
        init();
        initListener();
    }
    public void findViews() {
        mTvTitle = findView(R.id.title_layout_tv_title);
        mTvAction = findView(R.id.title_layout_tv_action);
        mEtRemark= findView(R.id.remark_edit_et_remark);
    }
    private void init() {
        bundle = getIntent().getExtras();
        mid = bundle.getString("mid");
        fid = bundle.getString("fid");
        mEtRemark.setText(bundle.getString("nickname"));
        mTvTitle.setText("备注编辑");
        mTvAction.setText("保存");
    }
    private void initListener() {
        mTvAction.setOnClickListener(this);
    }
    @Override
    public void widgetClick(View v) {
        switch (v.getId()){
            case R.id.title_layout_tv_action:
                SubscriberOnNextListener listener = new SubscriberOnNextListener<BaseResponse<String>>(){
                    @Override
                    public void onNext(BaseResponse<String> baseResponse) {
                        finish();
                    }
                };
        RetrofitAPIManager.getInstance().FriendNckname(new ProgressSubscriber<BaseResponse<String>>(listener,this,0),mid,fid,mEtRemark.getText().toString());
                break;
        }
    }

}
