package com.wowo.wowo.Activity;

import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.View;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.wowo.wowo.Adapter.FriendListRcAdapter;
import com.wowo.wowo.Adapter.FriendSearchListRcAdapter;
import com.wowo.wowo.Adapter.GroupListRcAdapter;
import com.wowo.wowo.Adapter.GroupSearchListRcAdapter;
import com.wowo.wowo.Base.BaseActivity;
import com.wowo.wowo.Model.FriendListModel;
import com.wowo.wowo.Model.GroupInfoModel;
import com.wowo.wowo.Model.GroupListModel;
import com.wowo.wowo.Model.UserModel;
import com.wowo.wowo.R;
import com.wowo.wowo.Utils.SharedPreferencesManager;
import com.wowo.wowo.rxjava.BaseResponse;
import com.wowo.wowo.rxjava.ProgressSubscriber;
import com.wowo.wowo.rxjava.RetrofitAPIManager;
import com.wowo.wowo.rxjava.SubscriberOnNextListener;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * 搜索页
**/
public class SearchActivity extends BaseActivity{
    private Bundle bundle;
    UserModel userModel;
    private TextView mTvTitle,mTvFriend,mTvGroup;
    private EditText mEtSearch;
    private ImageView mIvBack ,mIvSearch;
    private RecyclerView mSearchFrList;
    private LinearLayout mLlText;
    String  Type;
    SubscriberOnNextListener  flistener;
    FriendSearchListRcAdapter fAdapter ;
    List<UserModel> mFListData;
    SubscriberOnNextListener  glistener;
    GroupSearchListRcAdapter gAdapter ;
    List<GroupInfoModel> mGListData;
    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_searchactivity);
        findViews();
        init();
        initListener();
    }
    public void findViews() {
        mEtSearch = findView(R.id.title_layout_search_search_et);
        mIvBack = findView(R.id.iv_back);
        mIvSearch =findView(R.id.title_layout_search_iv_search);
        mSearchFrList =findView(R.id.search_rc_list);
        mLlText = findView(R.id.search_ll);
        mTvFriend = findView(R.id.search_tv_friend);
        mTvGroup= findView(R.id.search_tv_group);
    }
    private void init() {
        bundle = getIntent().getExtras();
        userModel = SharedPreferencesManager.getInstance().getUserData(this);
        mGListData  = new ArrayList<>();
        mFListData  = new ArrayList<>();
        flistener = new SubscriberOnNextListener<BaseResponse<List<UserModel>>>(){
            @Override
            public void onNext(BaseResponse<List<UserModel>> baseResponse) {
                mFListData.clear();
                mFListData.addAll(baseResponse.data);
                mSearchFrList.setLayoutManager(new LinearLayoutManager(SearchActivity.this, LinearLayoutManager.VERTICAL, false));
                fAdapter = new FriendSearchListRcAdapter(SearchActivity.this, mFListData);
                mSearchFrList.setAdapter(fAdapter);
                fAdapter.notifyDataSetChanged();
            }
        };
        glistener = new SubscriberOnNextListener<BaseResponse<List<GroupInfoModel>>>(){
            @Override
            public void onNext(BaseResponse<List<GroupInfoModel>> baseResponse) {
                mGListData.clear();
                mGListData.addAll(baseResponse.data);
                mSearchFrList.setLayoutManager(new LinearLayoutManager(SearchActivity.this, LinearLayoutManager.VERTICAL, false));
                gAdapter = new GroupSearchListRcAdapter(SearchActivity.this, mGListData);
                mSearchFrList.setAdapter(gAdapter);
                gAdapter.notifyDataSetChanged();
            }
        };
    }
    private void initListener() {
        mIvBack.setOnClickListener(this);
        mIvSearch.setOnClickListener(this);
        mTvFriend.setOnClickListener(this);
        mTvGroup.setOnClickListener(this);
    }
    @Override
    public void widgetClick(View v) {
    switch (v.getId()){
        case R.id.iv_back:
            finish();
            break;
        case R.id.search_tv_friend://搜好友
            mLlText.setVisibility(View.GONE);
            Type = "Friend";
            mEtSearch.setFocusable(true);

            break;
        case R.id.search_tv_group://搜群
            mLlText.setVisibility(View.GONE);
            Type = "Group";
            mEtSearch.setFocusable(true);
            break;
        case R.id.title_layout_search_iv_search:
            if (Type == null){
                showToast("请选择搜索内容");
                return;
            }
            String query = mEtSearch.getText().toString();
            if (Type.equals("Group")){
                RetrofitAPIManager.getInstance().getCrewquery(new ProgressSubscriber<BaseResponse<List<GroupInfoModel>>>(glistener,SearchActivity.this,0),query);
            }else if (Type.equals("Friend")){
                RetrofitAPIManager.getInstance().getUserquery(new ProgressSubscriber<BaseResponse<List<UserModel>>>(flistener,SearchActivity.this,0),query);
            }
            break;
    }
    }
}
