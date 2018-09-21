package com.wowo.wowo.Activity;

import android.os.Bundle;
import android.support.annotation.Nullable;
import android.view.View;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.TextView;

import com.wowo.wowo.Base.BaseActivity;
import com.wowo.wowo.Message.SealAppContext;
import com.wowo.wowo.Message.db.Friend;
import com.wowo.wowo.Model.FriendInfoModel;
import com.wowo.wowo.Model.GroupInfoModel;
import com.wowo.wowo.Model.UserModel;
import com.wowo.wowo.R;
import com.wowo.wowo.Utils.GlideUtils;
import com.wowo.wowo.Utils.SharedPreferencesManager;
import com.wowo.wowo.Views.CircleImageView.CircleImageView;
import com.wowo.wowo.Views.Dialog.BottomDialog;
import com.wowo.wowo.Views.Dialog.DeleteDialog;
import com.wowo.wowo.rxjava.BaseResponse;
import com.wowo.wowo.rxjava.ProgressSubscriber;
import com.wowo.wowo.rxjava.RetrofitAPIManager;
import com.wowo.wowo.rxjava.SubscriberOnNextListener;

import io.rong.imkit.RongIM;

public class FriendsDetailsActivity extends BaseActivity{
    private Bundle bundle;
    private TextView mTvTitle,mTvAction,mTvBrief,mTvName,mTvNickName;
    private ImageView mIvSex;
    private Button mBtRemake,mBtDeleFriend;
    private CircleImageView mCiHead;
    private UserModel userModel;
    FriendInfoModel model;
    SubscriberOnNextListener listener;
    String  fid ; // 对方的ID
    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_frienddeatails);
        findViews();
        init();
        initListener();
    }
    public void findViews() {
        mCiHead= findView(R.id.fr_ci_head);
        mTvTitle = findView(R.id.title_layout_tv_title);
        mTvAction = findView(R.id.title_layout_tv_action);
        mBtRemake= findView(R.id.frdet_bt_remake);
        mBtDeleFriend= findView(R.id.frdet_bt_delete);
        mTvName= findView(R.id.fd_tv_nickname);
        mTvNickName= findView(R.id.fd_tv_remake);
        mIvSex = findView(R.id.fr_iv_sex);
        mTvBrief= findView(R.id.ft_tv_brief);
    }
    private void init() {

        userModel = SharedPreferencesManager.getInstance().getUserData(this);
        bundle = getIntent().getExtras();
        mTvTitle.setText("用户详情");
        fid = bundle.getString("uid");
        listener = new SubscriberOnNextListener<BaseResponse<FriendInfoModel>>(){ //通过ID获取群资料
            @Override
            public void onNext(BaseResponse<FriendInfoModel> baseResponse){
                model = baseResponse.data;
                if (model.getIsFriend().equals("0")){//不是好友
                    mBtRemake.setText("发消息");
                    mBtDeleFriend.setText("添加好友");
                    mBtDeleFriend.setTextColor(getResources().getColor(R.color.main_color));
                }
                GlideUtils.loadImageView(FriendsDetailsActivity.this,model.getPhoto(),mCiHead);
                mTvBrief.setText(model.getBrief().toString());
                mTvName.setText(model.getName().toString());
                mTvNickName.setText(model.getNickname());
                if (model.getSex().equals("1")){ //男的
                    mIvSex.setImageDrawable(getResources().getDrawable(R.mipmap.boy));
                }else{
                    mIvSex.setImageDrawable(getResources().getDrawable(R.mipmap.girl));
                }
            }
        };

    }
    private void initListener() {
        mBtRemake.setOnClickListener(this);
        mBtDeleFriend.setOnClickListener(this);
    }

    @Override
    protected void onResume() {
        super.onResume();
        RetrofitAPIManager.getInstance().getFriendInfo(new ProgressSubscriber<BaseResponse<FriendInfoModel>>(listener,FriendsDetailsActivity.this,0),userModel.getUserId(),fid);
    }

    @Override
    public void widgetClick(View v) {
        switch (v.getId()){
            case R.id.frdet_bt_remake:
                if (model.getIsFriend().equals("0")){//不是好友 发起会话
                    RongIM.getInstance().startPrivateChat(this,fid,model.getName().toString());
                }else{
                    bundle.putString("mid",userModel.getUserId());
                    bundle.putString("fid",fid);
                    bundle.putString("nickname",mTvNickName.getText().toString());
                    openActivity(RemarkEditActivity.class,bundle);
                }
                break;
            case R.id.frdet_bt_delete:
                if (model.getIsFriend().equals("0")) {//不是好友 添加好友
                    SubscriberOnNextListener listener = new SubscriberOnNextListener<BaseResponse<String>>(){ //添加好友
                        @Override
                        public void onNext(BaseResponse<String> baseResponse){
                            showToast("成功发出好友请求");
                        }
                    };
                    RetrofitAPIManager.getInstance().getFriendInvite(new ProgressSubscriber<BaseResponse<String>>(listener,FriendsDetailsActivity.this,0),userModel.getUserId(),fid,userModel.getName());
                }else{
                    showDeleteDialog();
                }

                break;
        }
    }
    private void showDeleteDialog() {
        DeleteDialog.Builder dialog = new DeleteDialog.Builder(this);
        dialog.create("删除好友","确定删除该好友和相关数据").show();
        dialog.setOnSureClickListener(new DeleteDialog.Builder.OnSureClickListener() {
            @Override
            public void onClick() {
                SubscriberOnNextListener listener = new SubscriberOnNextListener<BaseResponse<String>>(){ //删除好友
                    @Override
                    public void onNext(BaseResponse<String> baseResponse){
                        finish();
                    }
                };
                RetrofitAPIManager.getInstance().getFriendDel(new ProgressSubscriber<BaseResponse<String>>(listener,FriendsDetailsActivity.this,0),userModel.getUserId(),fid);
            }
        });
    }

}
