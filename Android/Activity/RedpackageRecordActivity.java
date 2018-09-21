package com.wowo.wowo.Activity;

import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.View;
import android.widget.TextView;

import com.wowo.wowo.Adapter.RedpackListRcAdapter;
import com.wowo.wowo.Base.BaseActivity;
import com.wowo.wowo.Model.RedPackDetailsModel;
import com.wowo.wowo.Model.RedPackSingleModel;
import com.wowo.wowo.Model.UserModel;
import com.wowo.wowo.R;
import com.wowo.wowo.Utils.GlideUtils;
import com.wowo.wowo.Utils.SharedPreferencesManager;
import com.wowo.wowo.Views.CircleImageView.CircleImageView;
import com.wowo.wowo.rxjava.BaseResponse;
import com.wowo.wowo.rxjava.ProgressSubscriber;
import com.wowo.wowo.rxjava.RetrofitAPIManager;
import com.wowo.wowo.rxjava.SubscriberOnNextListener;

import java.util.ArrayList;
import java.util.List;

/**
 * 红包记录
 * */
public class RedpackageRecordActivity extends BaseActivity{
    private Bundle bundle;
    private TextView mTvTitle,mTvAction,mTvName,mTvTip,mTvAsset,mTvDetail;
    private CircleImageView mCiHead;
    private UserModel userModel;
    private RecyclerView mRclist;
    RedPackDetailsModel.RedMultiDetail model;
    RedPackDetailsModel.RedMultiRecv  Recvmodel;
    private List<RedPackDetailsModel.ListBean> listmodel;
    SubscriberOnNextListener listener;
    RedpackListRcAdapter mAdapter;
    String  redId ; // 对方的ID
    String type;
    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_redpackagerecord);
        findViews();
        init();
        initListener();
    }
    public void findViews() {
        mCiHead= findView(R.id.red_ci_head);
        mTvTitle = findView(R.id.title_layout_tv_title);
        mTvAction = findView(R.id.title_layout_tv_action);
        mTvName = findView(R.id.red_tv_name);
        mTvTip = findView(R.id.red_tv_tip);
        mTvAsset= findView(R.id.red_tv_asset);
        mTvDetail = findView(R.id.red_tv_redMultiDetail);
        mRclist  = findView(R.id.red_rc_detail);
    }
    private void init() {
        listmodel = new ArrayList<>();
        userModel = SharedPreferencesManager.getInstance().getUserData(this);
        bundle = getIntent().getExtras();
        mTvTitle.setText("发出的红包");
        mTvAction.setText("");
        redId = bundle.getString("id");
        GlideUtils.loadImageView(RedpackageRecordActivity.this,userModel.getPhoto(),mCiHead);
        mTvName.setText(userModel.getName()+"收到的红包");
        mTvAsset.setText("总数");
//        listener = new SubscriberOnNextListener<BaseResponse<RedPackSingleModel>>(){ //通过ID获取群资料
//            @Override
//            public void onNext(BaseResponse<RedPackSingleModel> baseResponse){
//                RedPackSingleModel model = baseResponse.data;
//
//                mTvName.setText(model.getFromName().toString());
//                mTvTip.setText(model.getTip().toString());
//                mTvAsset.setText(model.getAsset()+"");
//                mTvDetail.setText("");
//            }
//        };
//        RetrofitAPIManager.getInstance().getRedSingle(new ProgressSubscriber<BaseResponse<RedPackSingleModel>>(listener,RedpackageRecordActivity.this,0),redId);
    }
    private void initListener() {
        mTvAction.setOnClickListener(this);
    }

    @Override
    protected void onResume() {
        super.onResume();
    }

    @Override
    public void widgetClick(View v) {
        switch (v.getId()){
            case R.id.title_layout_tv_action:// …

                break;
        }
    }

}
