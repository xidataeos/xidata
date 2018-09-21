package com.wowo.wowo.Fragment;

import android.content.Intent;
import android.os.Bundle;
import android.support.v7.widget.GridLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.TextView;

import com.wowo.wowo.Activity.FriendMessageActivity;
import com.wowo.wowo.Activity.GroupMessageActivity;
import com.wowo.wowo.Activity.SearchActivity;
import com.wowo.wowo.Adapter.GroupRcAdapter;
import com.wowo.wowo.Base.BaseFragment;
import com.wowo.wowo.Model.GroupInfoModel;
import com.wowo.wowo.Model.UserModel;
import com.wowo.wowo.R;
import com.wowo.wowo.Utils.HmacSHA256Utils;
import com.wowo.wowo.Utils.LogUtil;
import com.wowo.wowo.Utils.SharedPreferencesManager;
import com.wowo.wowo.rxjava.BaseResponse;
import com.wowo.wowo.rxjava.ProgressSubscriber;
import com.wowo.wowo.rxjava.RetrofitAPIManager;
import com.wowo.wowo.rxjava.SubscriberOnNextListener;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.rong.imkit.RongIM;
import io.rong.imkit.manager.IUnReadMessageObserver;
import io.rong.imlib.model.Conversation;

//import com.wowo.wowo.rxjava.BaseResponse;
//import com.wowo.wowo.rxjava.ProgressSubscriber;
//import com.wowo.wowo.rxjava.RetrofitAPIManager;
//import com.wowo.wowo.rxjava.SubscriberOnNextListener;


/**
 */

public class FriendFragment extends BaseFragment implements View.OnClickListener {
    private TextView mTvFriend,mtvGroup ,mtvFNum,mTvGNum;
    private RecyclerView mRecyclerView;
    private GroupRcAdapter mAdapter;
//    private SelectCountModel models;
    private UserModel usermodel;
    private Bundle bundle;
    private List<GroupInfoModel> mListData;
    private String connectResultId;
    private String mToken;
    @Override
    protected void instanceRootView(LayoutInflater inflater) {
        mRootView = inflater.inflate(R.layout.fragment_friends, null);
    }

    @Override
    protected void findViews() {
        mTvFriend =findView( R.id.friend_tv_friends);
        mtvGroup=findView(R.id.friend_tv_group);
        mRecyclerView = findView(R.id.frafriend_rc_group);
        mtvFNum=findView(R.id.friend_tv_mesnum);
        mTvGNum=findView(R.id.group_tv_mesnum);
    }

    @Override
    protected void initListener() {
        mTvFriend.setOnClickListener(this);
        mtvGroup.setOnClickListener(this);
    }

    @Override
    protected void init(Bundle savedInstanceState) {
        usermodel = SharedPreferencesManager.getInstance().getUserData(getActivity());
        mListData = new ArrayList<>();
        bundle = new Bundle();
        bundle.putString("userId", usermodel.getUserId());
        initData();

    }
    private void initData() {
        SubscriberOnNextListener listener = new SubscriberOnNextListener<BaseResponse<List<GroupInfoModel>>>(){
            @Override
            public void onNext(BaseResponse<List<GroupInfoModel>> baseResponse) {
                mListData.clear();
                mListData.addAll(baseResponse.data);
                mRecyclerView.setLayoutManager(new GridLayoutManager(getActivity(), 3));
                mAdapter = new GroupRcAdapter(getActivity(),mListData);
                mRecyclerView.setAdapter(mAdapter);
                mAdapter.notifyDataSetChanged();
            }
        };
        Map<String, String> map = new HashMap<>();
        map.put("key", SharedPreferencesManager.getInstance().getUserData(getActivity()).getToken());
        map.put("uuQieKeNaoId",SharedPreferencesManager.getInstance().getUserData(getActivity()).getUserId());
        map.put("token", HmacSHA256Utils.digest("token",map));
        RetrofitAPIManager.getInstance().getHotCrew(new ProgressSubscriber<BaseResponse<List<GroupInfoModel>>>(listener,getActivity(),0),map);

        IUnReadMessageObserver pri= new IUnReadMessageObserver() {
            @Override
            public void onCountChanged(int i) {
                if (i>0){
                    mtvFNum.setText(i+"");
                }else{
                    mtvFNum.setVisibility(View.GONE);
                }
            }
        };
        RongIM.getInstance().addUnReadMessageCountChangedObserver(pri, Conversation.ConversationType.PRIVATE);
        IUnReadMessageObserver group= new IUnReadMessageObserver() {
            @Override
            public void onCountChanged(int i) {
                if (i>0){
                    mTvGNum.setText(i+"");
                }else{
                    mTvGNum.setVisibility(View.GONE);
                }
            }
        };
        RongIM.getInstance().addUnReadMessageCountChangedObserver(group, Conversation.ConversationType.GROUP);
    }

    @Override
    public void onResume() {
        super.onResume();
        initData();
    }

    @Override
    public void onClick(View v) {
        switch (v.getId()) {
            case R.id.title_layout_iv_sea :
                bundle.putString("name", "1");
                openActivity(SearchActivity.class, bundle);
                break ;
            case R.id.title_layout_iv_add :

                break ;
            case R.id.friend_tv_friends://好友
                startActivity(new Intent(getActivity(), FriendMessageActivity.class));
//                bundle.putString("name", "1");
//                openActivity(FriendMessageActivity.class, bundle);
                break;
            case R.id.friend_tv_group:
                openActivity(GroupMessageActivity.class, bundle);
                break;

        }
    }
}
