package com.wowo.wowo.Activity;

import android.content.Intent;
import android.os.Bundle;
import android.os.Parcel;
import android.support.annotation.Nullable;
import android.text.Editable;
import android.text.TextWatcher;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.wowo.wowo.Base.BaseActivity;
import com.wowo.wowo.Model.UserModel;
import com.wowo.wowo.R;
import com.wowo.wowo.Utils.CollectionPlugin;
import com.wowo.wowo.Utils.LogUtil;
import com.wowo.wowo.Utils.RedPackageMessage;
import com.wowo.wowo.Utils.SharedPreferencesManager;
import com.wowo.wowo.Views.Dialog.BottomDialog;
import com.wowo.wowo.rxjava.BaseResponse;
import com.wowo.wowo.rxjava.ProgressSubscriber;
import com.wowo.wowo.rxjava.RetrofitAPIManager;
import com.wowo.wowo.rxjava.SubscriberOnNextListener;

import io.rong.imkit.RongIM;
import io.rong.imlib.IRongCallback;
import io.rong.imlib.RongIMClient;
import io.rong.imlib.model.Conversation;
import io.rong.imlib.model.Message;

/**
* 发红包
 */
public class RedPackageSendActivity extends BaseActivity{
    private TextView mTitle,mTvNum;
    private EditText mEtnum,mEtContent,mEtPagNum;
    private Button mBtSend;
    private LinearLayout mLlIsgroup;
    String rId;
    String  from;
    Conversation.ConversationType Typeenum;
    UserModel userModel;
    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_redpage_send);
        init();
    }

    private void init() {
        userModel = SharedPreferencesManager.getInstance().getUserData(this);
        Intent intent = getIntent();
        rId= intent.getStringExtra("rId");
        from = intent.getStringExtra("from");
        Bundle bundle = intent.getExtras();
        Typeenum =(  Conversation.ConversationType )bundle.get("enum");
        LogUtil.e("Send获取的rId",rId);
        mTitle = findView(R.id.title_layout_tv_title);
        mTitle.setText("发红包");
        mTvNum = findView(R.id.red_tv_num);
        mEtnum = findView(R.id.red_et_num);
        mEtContent = findView(R.id.red_et_content);
        mBtSend= findView(R.id.red_bt_send);
        mBtSend.setOnClickListener(this);
        mLlIsgroup = findView(R.id.red_ll_isgroup);
        mEtPagNum = findView(R.id.red_et_pagnum);
        if (Typeenum.getName().equals("private")){
            mLlIsgroup.setVisibility(View.GONE);
        }else{
            mLlIsgroup.setVisibility(View.VISIBLE);
        }
        if (from.equals("Transfer")){
            mTitle.setText("转账");
            mBtSend.setText("转账");
        }

        mEtnum.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence s, int start, int count, int after) {
            }
            @Override
            public void onTextChanged(CharSequence s, int start, int before, int count) {
                mTvNum.setText(s.toString());
                if (s.length()>0&&!s.equals("0")) {
                    mBtSend.setEnabled(true);
                } else {
                    mBtSend.setEnabled(false);
                }
            }

            @Override
            public void afterTextChanged(Editable s) {

            }
        });
    }

    @Override
    public void widgetClick(View v) {
        switch (v.getId()){
            case R.id.red_bt_send:
                String tip = mEtContent.getText().toString().equals("")?mEtContent.getHint().toString():mEtContent.getText().toString();
                if (from.equals("Transfer")){ //转账
                    SubscriberOnNextListener mlistener = new SubscriberOnNextListener<BaseResponse<String>>() {
                        @Override
                        public void onNext(BaseResponse<String> baseResponse) {
                            showToast("转账");
                            finish();
                        }
                    };
                    RetrofitAPIManager.getInstance().TransferT(new ProgressSubscriber<BaseResponse<String>>(mlistener,RedPackageSendActivity.this,0),
                            userModel.getUserId(),rId,tip,mEtnum.getText().toString());
                }else { //红包
                    if (Typeenum.getName().equals("group")&&mEtPagNum.getText().toString().equals("")){
                        showToast("请填写红包个数");
                        return;
                    }else{
                        SubscriberOnNextListener mlistener = new SubscriberOnNextListener<BaseResponse<String>>() {
                            @Override
                            public void onNext(BaseResponse<String> baseResponse) {
                                showToast("发送成功");
                                finish();
                            }
                        };

                        if (Typeenum.getName().equals("private")){
                            RetrofitAPIManager.getInstance().RedSendSingle(new ProgressSubscriber<BaseResponse<String>>(mlistener,RedPackageSendActivity.this,0),
                                    userModel.getUserId(),rId,mEtnum.getText().toString(),tip );
                        }else{
                            RetrofitAPIManager.getInstance().RedsendMulti(new ProgressSubscriber<BaseResponse<String>>(mlistener,RedPackageSendActivity.this,0),
                                    userModel.getUserId(),rId,mEtPagNum.getText().toString(),mEtnum.getText().toString(),tip);
                        }
                    }
                }

//                RedPackageMessage c= new RedPackageMessage(Parcel.obtain());
//                c.setRedId("红包ID");
//                c.setMode("红包");
//                c.setAsset(mEtnum.getText().toString());
//                c.setTip(mEtContent.getText().toString().equals("")?mEtContent.getHint().toString():mEtContent.getText().toString());
//                c.setRecv("是否领取");
//                byte[] b=c.encode();
//                RedPackageMessage mes  = new RedPackageMessage(b);
//                Message message = Message.obtain(rId,Typeenum, mes);
//                RongIM.getInstance().sendMessage(message, null, null, new IRongCallback.ISendMessageCallback() {
//                    @Override
//                    public void onAttached(Message message) {
//                        LogUtil.e("TAG","发送红包消息");
//                    }
//                    @Override
//                    public void onError(Message message, RongIMClient.ErrorCode errorCode) {
//                        //发送失败的处理
//                        LogUtil.e("TAG","发送失败的处理---->"+errorCode);
//                    }
//                    @Override
//                    public void onSuccess(Message message) {
//                        //发送成功的处理
//                        LogUtil.e("TAG","发送成功");
//                    }
//                });
//                    finish();
//                break;
        }
    }
}
