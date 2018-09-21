package com.wowo.wowo.Activity;

import android.net.Uri;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentTransaction;
import android.view.View;
import android.widget.TextView;

import com.wowo.wowo.Adapter.ConversationListAdapterEx;
import com.wowo.wowo.Base.BaseActivity;
import com.wowo.wowo.Message.SealUserInfoManager;
import com.wowo.wowo.Message.db.Groups;
import com.wowo.wowo.Model.GroupInfoModel;
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
import io.rong.imlib.model.Conversation;
import io.rong.imlib.model.Group;
import io.rong.imlib.model.UserInfo;

public class GroupMessageActivity extends BaseActivity{
    private Bundle bundle;
    private TextView mTvTitle,mTvNewGroup,mTvGlist;
    private io.rong.imkit.fragment.ConversationListFragment mConversationListFragment = null;
    private Conversation.ConversationType[] mConversationsTypes = null;
    UserModel userModel;
    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_groupmessage);
        findViews();
        init();
        initListener();
    }
    public void findViews() {
        mTvTitle = findView(R.id.title_layout_tv_title);
        mTvNewGroup= findView(R.id.group_tv_new);
        mTvGlist= findView(R.id.group_tv_list);
        FragmentTransaction transaction = getSupportFragmentManager().beginTransaction();
        transaction.add(R.id.rong_content, initConversationList());
        transaction.commit();
    }
    private void init() {
        userModel = SharedPreferencesManager.getInstance().getUserData(this);
        bundle = getIntent().getExtras();
        mTvTitle.setText("我的群组");
        RongIM.getInstance().refreshUserInfoCache(new UserInfo(userModel.getUserId(), userModel.getName(), Uri.parse(userModel.getPhoto())));
        RongIM.getInstance().setGroupInfoProvider(new RongIM.GroupInfoProvider() {
            @Override
            public Group getGroupInfo(final String groupId) {
                SubscriberOnNextListener listener = new SubscriberOnNextListener<BaseResponse<GroupInfoModel>>() {
                    @Override
                    public void onNext(BaseResponse<GroupInfoModel> baseResponse) {
                        GroupInfoModel gModel = baseResponse.data;
                        RongIM.getInstance().refreshGroupInfoCache(new Group(groupId, gModel.getName(), Uri.parse(gModel.getUrlPhoto())));
                    }
                };
                RetrofitAPIManager.getInstance().getCrewS(new ProgressSubscriber<BaseResponse<GroupInfoModel>>(listener,GroupMessageActivity.this,0),groupId,userModel.getUserId());
                return null;
            }

        }, true);
    }
    private void initListener() {
        mTvNewGroup.setOnClickListener(this);
        mTvGlist.setOnClickListener(this);
    }
    @Override
    public void widgetClick(View v) {
        switch (v.getId()){
            case R.id.group_tv_new://新建群组
                bundle.putInt("isshow",1);
                openActivity(FriendListActivity.class,bundle);
//                openActivity(NewGroupActivity.class, bundle);
                break;
            case R.id.group_tv_list:
                bundle.putString("name", "");
                openActivity(GroupListActivity.class, bundle);
                break;
        }
    }
    private Fragment initConversationList() {
        if (mConversationListFragment == null) {
            ConversationListFragment listFragment = new ConversationListFragment();
            listFragment.setAdapter(new ConversationListAdapterEx(RongContext.getInstance()));
            Uri uri;
            uri = Uri.parse("rong://" + getApplicationInfo().packageName).buildUpon()
                    .appendPath("conversationlist")
//                    .appendQueryParameter(Conversation.ConversationType.PRIVATE.getName(), "false") //设置私聊会话是否聚合显示
                    .appendQueryParameter(Conversation.ConversationType.GROUP.getName(), "false")//群组
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

}
