package com.wowo.wowo.Activity;

import android.net.Uri;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentTransaction;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.util.Log;
import android.view.View;
import android.widget.TextView;

import com.wowo.wowo.Adapter.ConversationListAdapterEx;
import com.wowo.wowo.Adapter.SysMessageRcAdapter;
import com.wowo.wowo.Adapter.SysteamListAdapterEx;
import com.wowo.wowo.Base.BaseActivity;
import com.wowo.wowo.Message.AgreedFriendRequestMessage;
import com.wowo.wowo.Model.UserModel;
import com.wowo.wowo.R;
import com.wowo.wowo.Utils.SharedPreferencesManager;

import java.util.List;

import io.rong.imkit.RongContext;
import io.rong.imkit.RongIM;
import io.rong.imkit.fragment.ConversationListFragment;
import io.rong.imkit.widget.provider.SystemConversationProvider;
import io.rong.imlib.RongIMClient;
import io.rong.imlib.model.Conversation;
import io.rong.imlib.model.Message;
import io.rong.imlib.model.MessageContent;
import io.rong.imlib.model.UserInfo;
import io.rong.message.ContactNotificationMessage;
import io.rong.message.TextMessage;

public class SysMessageActivity extends BaseActivity{
    private Bundle bundle;
    private TextView mTvTitle,mTvNewGroup,mTvGlist;
    private ConversationListFragment mConversationListFragment = null;
    private Conversation.ConversationType[] mConversationsTypes = null;
    private RecyclerView mRcSysmessage;
    SysMessageRcAdapter mAdapter;
    UserModel userModel;
    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState){
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_system_msg);
        findViews();
        init();
        initListener();
    }

    public void findViews() {
        mTvTitle = findView(R.id.title_layout_tv_title);
        mTvNewGroup= findView(R.id.group_tv_new);
        mTvNewGroup.setVisibility(View.GONE);
        mTvGlist= findView(R.id.group_tv_list);
        mTvGlist.setVisibility(View.GONE);
        mRcSysmessage = findView(R.id.msg_rc_sys);
    }
    private void init() {
        bundle = getIntent().getExtras();
        List<Conversation>  mList = RongIMClient.getInstance().getConversationList(Conversation.ConversationType.SYSTEM);
        if (mList!=null){
            userModel = SharedPreferencesManager.getInstance().getUserData(this);
            mRcSysmessage.setLayoutManager(new LinearLayoutManager(SysMessageActivity.this, LinearLayoutManager.VERTICAL, false));
            mAdapter = new SysMessageRcAdapter(SysMessageActivity.this,mList,userModel.getUserId());
            mRcSysmessage.setAdapter(mAdapter);
        }
        mTvTitle.setText("消息");
    }
    private void initListener() {
        mTvNewGroup.setOnClickListener(this);
        mTvGlist.setOnClickListener(this);
    }
    @Override
    public void widgetClick(View v) {
        switch (v.getId()){
        }
    }
}


