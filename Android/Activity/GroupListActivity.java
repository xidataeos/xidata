package com.wowo.wowo.Activity;

import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.View;
import android.widget.EditText;
import android.widget.TextView;

import com.wowo.wowo.Adapter.GroupListRcAdapter;
import com.wowo.wowo.Base.BaseActivity;
import com.wowo.wowo.Model.FriendListModel;
import com.wowo.wowo.Model.GroupListModel;
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

public class GroupListActivity extends BaseActivity{
    private Bundle bundle;
    private TextView mTvTitle,mTvAction,mTvCancel,mTvListTitle;
    private RecyclerView mRcGrList;
    private EditText mEtSearch;
    GroupListRcAdapter  mAdapter ;
    private List<GroupListModel> mListData;
    private List<GroupListModel> SearDataList;
    private UserModel userModel;
    SubscriberOnNextListener listener;
    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_friendlist);
        findViews();
        init();
        initListener();
    }
    public void findViews() {
        mTvTitle = findView(R.id.title_layout_tv_title);
        mTvAction = findView(R.id.title_layout_tv_action);
        mTvCancel = findView(R.id.flist_tv_cancel);
        mRcGrList = findView(R.id.friend_rc_list);
        mTvListTitle = findView(R.id.list_tv_title);
        mEtSearch = findView(R.id.title_layout_search_search_et);
        mTvListTitle.setText("群组列表");
    }

    @Override
    protected void onResume() {
        super.onResume();
        Map<String, String> map = new HashMap<>();
        map.put("userId",userModel.getUserId());
        map.put("key", SharedPreferencesManager.getInstance().getUserData(this).getToken());
        map.put("uuQieKeNaoId",SharedPreferencesManager.getInstance().getUserData(this).getUserId());
        LogUtil.e("Logmap",map.toString());
        map.put("token", HmacSHA256Utils.digest("token",map));
        RetrofitAPIManager.getInstance().getCrewList(new ProgressSubscriber<BaseResponse<List<GroupListModel>>>(listener,GroupListActivity.this,0),userModel.getUserId(),map);
    }

    private void init() {
        userModel = SharedPreferencesManager.getInstance().getUserData(this);
        bundle = getIntent().getExtras();
        mTvTitle.setText("");
        mListData = new ArrayList<>();
        SearDataList= new ArrayList<>();
        listener = new SubscriberOnNextListener<BaseResponse<List<GroupListModel>>>(){
            @Override
            public void onNext(BaseResponse<List<GroupListModel>> baseResponse) {
                mListData.clear();
                mListData.addAll(baseResponse.data);
                SearDataList.addAll(baseResponse.data);
                mRcGrList.setLayoutManager(new LinearLayoutManager(GroupListActivity.this, LinearLayoutManager.VERTICAL, false));
                mAdapter = new GroupListRcAdapter(GroupListActivity.this,mListData,0);
                mRcGrList.setAdapter(mAdapter);
                mAdapter.notifyDataSetChanged();
            }
        };
    }
    private void initListener() {
        mTvCancel.setOnClickListener(this);
        mEtSearch.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence s, int start, int count, int after) {
            }
            @Override
            public void onTextChanged(CharSequence s, int start, int before, int count) {
                show(s.toString());
            }
            @Override
            public void afterTextChanged(Editable s) {
            }
        });
    }
    @Override
    public void widgetClick(View v) {
        switch (v.getId()){
            case R.id.flist_tv_cancel://取消
                    mEtSearch.setText("");
                break;
        }
    }
    private void show(String str) {
        str = str.toUpperCase();
        mListData.clear();
        for (int i = 0; i < SearDataList.size(); i++) {
            GroupListModel bean = SearDataList.get(i);
            if (bean.getName().toString().indexOf(str) > -1||bean.getUid().toString().indexOf(str) > -1) {
                mListData.add(bean);
            }
        }
        mAdapter.notifyDataSetChanged();
    }

}
