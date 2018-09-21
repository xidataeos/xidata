package com.wowo.wowo.Activity;

import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentTransaction;
import android.view.View;
import android.widget.TextView;

import com.wowo.wowo.Adapter.ConversationListAdapterEx;
import com.wowo.wowo.Base.BaseActivity;
import com.wowo.wowo.Model.FriendInfoModel;
import com.wowo.wowo.Model.UserModel;
import com.wowo.wowo.R;
import com.wowo.wowo.Utils.SharedPreferencesManager;
import com.wowo.wowo.Views.Dialog.BottomDialog;
import com.wowo.wowo.rxjava.BaseResponse;
import com.wowo.wowo.rxjava.ProgressSubscriber;
import com.wowo.wowo.rxjava.RetrofitAPIManager;
import com.wowo.wowo.rxjava.SubscriberOnNextListener;

import io.rong.imkit.RongContext;
import io.rong.imkit.RongIM;
import io.rong.imkit.fragment.ConversationListFragment;
import io.rong.imkit.manager.IUnReadMessageObserver;
import io.rong.imlib.model.Conversation;
import io.rong.imlib.model.UserInfo;

public class FriendMessageActivity extends BaseActivity {
    private Bundle bundle;
    private TextView mTvTitle,mTvInviten,mTvFlist;
    private ConversationListFragment mConversationListFragment = null;
    private Conversation.ConversationType[] mConversationsTypes = null;
    UserModel userModel;
    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_friendmessage);
        findViews();
        init();
        initListener();
    }
    public void findViews() {
        mTvTitle = findView(R.id.title_layout_tv_title);
        mTvInviten= findView(R.id.friend_tv_inviten);
        mTvFlist= findView(R.id.friend_tv_friendlist);
        FragmentTransaction transaction = getSupportFragmentManager().beginTransaction();
        transaction.add(R.id.rong_content, initConversationList());
        transaction.commit();
    }
    private Fragment initConversationList() {
        if (mConversationListFragment == null) {
            ConversationListFragment listFragment = new ConversationListFragment();
            listFragment.setAdapter(new ConversationListAdapterEx(RongContext.getInstance()));
            Uri uri;
            uri = Uri.parse("rong://" + getApplicationInfo().packageName).buildUpon()
                    .appendPath("conversationlist")
                    .appendQueryParameter(Conversation.ConversationType.PRIVATE.getName(), "false") //设置私聊会话是否聚合显示
//                    .appendQueryParameter(Conversation.ConversationType.GROUP.getName(), "false")//群组
                    .appendQueryParameter(Conversation.ConversationType.PUBLIC_SERVICE.getName(), "false")//公共服务号
                    .appendQueryParameter(Conversation.ConversationType.APP_PUBLIC_SERVICE.getName(), "false")//订阅号
//                    .appendQueryParameter(Conversation.ConversationType.SYSTEM.getName(), "true")//系统
                    .build();
            mConversationsTypes = new Conversation.ConversationType[]{Conversation.ConversationType.PRIVATE,
                    Conversation.ConversationType.GROUP,
                    Conversation.ConversationType.PUBLIC_SERVICE,
                    Conversation.ConversationType.APP_PUBLIC_SERVICE,
                    Conversation.ConversationType.SYSTEM
            };

            listFragment.setUri(uri);
            mConversationListFragment = listFragment;
            return listFragment;
        } else {
            return mConversationListFragment;
        }
    }
    private FriendInfoModel picAndNickModel;
    private int getDataFlag = 0;
    private void init() {
        userModel = SharedPreferencesManager.getInstance().getUserData(this);
        bundle = getIntent().getExtras();
        mTvTitle.setText("好友");
        RongIM.getInstance().refreshUserInfoCache(new UserInfo(userModel.getUserId(), userModel.getName(), Uri.parse(userModel.getPhoto())));
        RongIM.setUserInfoProvider(new RongIM.UserInfoProvider() {
            @Override
            public UserInfo getUserInfo(final String s) {
                SubscriberOnNextListener mListener = new SubscriberOnNextListener<BaseResponse<FriendInfoModel>>() {
                    @Override
                    public void onNext(BaseResponse<FriendInfoModel> baseResponse) {
                        picAndNickModel = baseResponse.data;
                        RongIM.getInstance().refreshUserInfoCache(new UserInfo(s, picAndNickModel.getName(), Uri.parse(picAndNickModel.getPhoto())));
                        getDataFlag = 1;
                    }
                };
                if (getDataFlag == 0) {
                    RetrofitAPIManager.getInstance().getFriendInfo(new ProgressSubscriber<BaseResponse<FriendInfoModel>>(mListener,FriendMessageActivity.this,0),userModel.getUserId(),s);
                }
                return null;
            }
        }, true);
    }
    private void initListener() {
        mTvInviten.setOnClickListener(this);
        mTvFlist.setOnClickListener(this);
    }
    @Override
    public void widgetClick(View v) {
        switch (v.getId()){
            case R.id.friend_tv_inviten:
                showShareDialog();
                break;
            case R.id.friend_tv_friendlist:
                startActivity(new Intent(this, FriendListActivity.class));
                break;
        }
    }

    private void showShareDialog() {
        BottomDialog.Builder dialog = new BottomDialog.Builder(this);
        dialog.create("0","x").show();
    }

}
