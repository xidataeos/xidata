package com.wowo.wowo.Activity;

import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.View;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.TextView;

import com.wowo.wowo.Adapter.GroupMemberRcAdapter;
import com.wowo.wowo.Adapter.RedpackListRcAdapter;
import com.wowo.wowo.Base.BaseActivity;
import com.wowo.wowo.Model.FriendInfoModel;
import com.wowo.wowo.Model.RedPackDetailsModel;
import com.wowo.wowo.Model.RedPackSingleModel;
import com.wowo.wowo.Model.UserModel;
import com.wowo.wowo.R;
import com.wowo.wowo.Utils.GlideUtils;
import com.wowo.wowo.Utils.SharedPreferencesManager;
import com.wowo.wowo.Views.CircleImageView.CircleImageView;
import com.wowo.wowo.Views.Dialog.DeleteDialog;
import com.wowo.wowo.rxjava.BaseResponse;
import com.wowo.wowo.rxjava.ProgressSubscriber;
import com.wowo.wowo.rxjava.RetrofitAPIManager;
import com.wowo.wowo.rxjava.SubscriberOnNextListener;

import java.util.ArrayList;
import java.util.List;

import io.rong.imkit.RongIM;

public class RedpackageDetailsActivity extends BaseActivity{
    private Bundle bundle;
    private TextView mTvTitle,mTvAction,mTvName,mTvTip,mTvAsset,mTvDetail;
    private CircleImageView mCiHead;
    private UserModel userModel;
    private RecyclerView mRclist;
    RedPackDetailsModel.RedMultiDetail model;
    RedPackDetailsModel.RedMultiRecv  Recvmodel;
    private List<RedPackDetailsModel.ListBean> listmodel;
    SubscriberOnNextListener listener;
    SubscriberOnNextListener  singlistener;
    RedpackListRcAdapter mAdapter;
    String  redId ; // 对方的ID
    String type;
    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_redpackagedeatails);
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
        mTvTitle.setText("红包详情");
        mTvAction.setText("红包记录");
        redId = bundle.getString("id");
        type = bundle.getString("type");

        listener = new SubscriberOnNextListener<BaseResponse<RedPackDetailsModel>>(){ //通过ID获取群资料
            @Override
            public void onNext(BaseResponse<RedPackDetailsModel> baseResponse){
                model = baseResponse.data.getRedMultiDetail();
                Recvmodel =  baseResponse.data.getRedMultiRecv();
                if (Recvmodel!=null){
                    mTvAsset.setText(Recvmodel.getAsset()+"");
                }
                GlideUtils.loadImageView(RedpackageDetailsActivity.this,model.getPhoto(),mCiHead);
                mTvName.setText(model.getName().toString());
                mTvTip.setText(model.getTip().toString());
                mTvDetail.setText( "剩余"+ model.getRemain() +"/" +model.getSize()+" , "+model.getBalance()+"/"+model.getAsset()+"个" );
                listmodel.clear();
                listmodel.addAll(baseResponse.data.getList());
                mRclist.setLayoutManager(new LinearLayoutManager(RedpackageDetailsActivity.this, LinearLayoutManager.VERTICAL, false));
                mAdapter = new RedpackListRcAdapter(RedpackageDetailsActivity.this,listmodel ,userModel.getUserId());
                mRclist.setAdapter(mAdapter);
                mAdapter.notifyDataSetChanged();
            }
        };
        singlistener = new SubscriberOnNextListener<BaseResponse<RedPackSingleModel>>(){ //通过ID获取群资料
            @Override
            public void onNext(BaseResponse<RedPackSingleModel> baseResponse){
                RedPackSingleModel model = baseResponse.data;
                GlideUtils.loadImageView(RedpackageDetailsActivity.this,model.getFromPhoto(),mCiHead);
                mTvName.setText(model.getFromName().toString());
                mTvTip.setText(model.getTip().toString());
                mTvAsset.setText(model.getAsset()+"");
                mTvDetail.setText("");
            }
        };
        if (type.equals("private")){
            RetrofitAPIManager.getInstance().getRedSingle(new ProgressSubscriber<BaseResponse<RedPackSingleModel>>(singlistener,RedpackageDetailsActivity.this,0),redId);
        }else{
            RetrofitAPIManager.getInstance().getRedmulti(new ProgressSubscriber<BaseResponse<RedPackDetailsModel>>(listener,RedpackageDetailsActivity.this,0),redId,userModel.getUserId());
        }
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
            case R.id.title_layout_tv_action://红包记录
                Bundle bundle = new Bundle();
                bundle.putString("id",userModel.getUserId());
//                bundle.putString("type",type);
               openActivity(RedpackageRecordActivity.class,bundle);
                break;
        }
    }

}
