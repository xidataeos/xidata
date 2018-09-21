package com.wowo.wowo.Activity;

import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.TextView;

import com.wowo.wowo.Base.BaseActivity;
import com.wowo.wowo.Bean.InviteCodeBean;
import com.wowo.wowo.R;
import com.wowo.wowo.Utils.CommonUtils;
import com.wowo.wowo.Views.Dialog.BottomDialog;
import com.wowo.wowo.rxjava.BaseResponse;
import com.wowo.wowo.rxjava.ProgressSubscriber;
import com.wowo.wowo.rxjava.RetrofitAPIManager;
import com.wowo.wowo.rxjava.SubscriberOnNextListener;

import java.util.List;

/*
*我的邀请码
 */
public class InviteCodeActivity extends BaseActivity{
    private Button invite_invitation;
    private ImageView personal_return;
    private TextView activity_invitationCode;
    private ImageView invite_the_first,invite_the_second,invite_the_third,invite_the_fourth,invite_the_fifth;

    private String invitationCode;//邀请码
    private String userId;
    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_invite_code);
        Intent intent = getIntent();
        invitationCode = intent.getStringExtra("invitationCode").replaceAll(".{1}(?!$)", "$0 ");
        userId = intent.getStringExtra("userId");
        invite_invitation = findViewById(R.id.invite_invitation);
        personal_return = findViewById(R.id.personal_return);
        invite_the_first = findViewById(R.id.invite_the_first);
        invite_the_second = findViewById(R.id.invite_the_second);
        invite_the_third = findViewById(R.id.invite_the_third);
        invite_the_fourth = findViewById(R.id.invite_the_fourth);
        invite_the_fifth = findViewById(R.id.invite_the_fifth);
        activity_invitationCode = findViewById(R.id.activity_invitationCode);
        activity_invitationCode.setText(invitationCode);
        init();
        initData();
    }
    private List<InviteCodeBean> bean;
    private void initData() {
        //获取用户信息
        SubscriberOnNextListener listener = new SubscriberOnNextListener<BaseResponse<List<InviteCodeBean>>>() {
            @Override
            public void onNext(BaseResponse<List<InviteCodeBean>> baseResponse) {
                bean = baseResponse.data;
                if (CommonUtils.isVariableList(bean)){
                    return;
                }
                for (int i = 0; i < bean.size(); i++) {
                    Log.e("TAG","*******>"+i);
                    if (i == 0){
                        CommonUtils.setImagerView(InviteCodeActivity.this,bean.get(i).getPhoto(),invite_the_first);
                    }else if (i == 1){
                        CommonUtils.setImagerView(InviteCodeActivity.this,bean.get(i).getPhoto(),invite_the_second);
                    }else if (i == 2){
                        CommonUtils.setImagerView(InviteCodeActivity.this,bean.get(i).getPhoto(),invite_the_third);
                    }else if (i == 3){
                        CommonUtils.setImagerView(InviteCodeActivity.this,bean.get(i).getPhoto(),invite_the_fourth);
                    }else if (i == 4){
                        CommonUtils.setImagerView(InviteCodeActivity.this,bean.get(i).getPhoto(),invite_the_fifth);
                    }
                }
            }
        };
        RetrofitAPIManager.getInstance().InviteCode(new ProgressSubscriber<BaseResponse<List<InviteCodeBean>>>(listener, this, 0), userId);
    }



    private void init() {
        invite_invitation.setOnClickListener(this);
        personal_return.setOnClickListener(this);
    }

    @Override
    public void widgetClick(View v) {
        switch (v.getId()){
            case R.id.invite_invitation:
                showShareDialog();
                break;
            case R.id.personal_return:
                finish();
                break;
        }
    }
    private void showShareDialog() {
        BottomDialog.Builder dialog = new BottomDialog.Builder(this);
        dialog.create("0","x").show();
    }
}
