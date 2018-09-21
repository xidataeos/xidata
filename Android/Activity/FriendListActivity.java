package com.wowo.wowo.Activity;

import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v7.widget.GridLayoutManager;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.View;
import android.widget.EditText;
import android.widget.TextView;

import com.lljjcoder.style.citylist.Toast.ToastUtils;
import com.wowo.wowo.Adapter.FriendListRcAdapter;
import com.wowo.wowo.Adapter.GroupListRcAdapter;
import com.wowo.wowo.Adapter.GroupRcAdapter;
import com.wowo.wowo.Base.BaseActivity;
import com.wowo.wowo.Model.FriendListModel;
import com.wowo.wowo.Model.GroupInfoModel;
import com.wowo.wowo.Model.GroupListModel;
import com.wowo.wowo.Model.UserModel;
import com.wowo.wowo.R;
import com.wowo.wowo.Utils.SharedPreferencesManager;
import com.wowo.wowo.Views.Dialog.BottomDialog;
import com.wowo.wowo.rxjava.BaseResponse;
import com.wowo.wowo.rxjava.ProgressSubscriber;
import com.wowo.wowo.rxjava.RetrofitAPIManager;
import com.wowo.wowo.rxjava.SubscriberOnNextListener;

import java.util.ArrayList;
import java.util.List;

public class FriendListActivity extends BaseActivity{
    private Bundle bundle;
    private TextView mTvTitle,mTvAction,mTvCancel;
    private RecyclerView mRcFrList;
    private EditText mEtSearch;
    FriendListRcAdapter  mAdapter ;
    List<FriendListModel> mListData;
    List<FriendListModel> SearDataList;
    SubscriberOnNextListener listener;
    private UserModel userModel;
    int isshowbox = 0;
    String CrewId ;
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
        mRcFrList = findView(R.id.friend_rc_list);
        mEtSearch = findView(R.id.title_layout_search_search_et);
    }
    private void init() {
        userModel = SharedPreferencesManager.getInstance().getUserData(this);
        bundle = getIntent().getExtras();
        if (bundle!=null){
            isshowbox = bundle.getInt("isshow");
            CrewId= bundle.getString("crewId");
            mTvAction.setText("完成");
        }
        mTvTitle.setText("");
        SearDataList= new ArrayList<>();
        mListData = new ArrayList<>();
        listener = new SubscriberOnNextListener<BaseResponse<List<FriendListModel>>>(){
            @Override
            public void onNext(BaseResponse<List<FriendListModel>> baseResponse) {
                mListData.clear();
                mListData.addAll(baseResponse.data);
                SearDataList.addAll(baseResponse.data);
                mRcFrList.setLayoutManager(new LinearLayoutManager(FriendListActivity.this, LinearLayoutManager.VERTICAL, false));
                mAdapter = new FriendListRcAdapter(FriendListActivity.this,mListData,isshowbox);
                mRcFrList.setAdapter(mAdapter);
                mAdapter.notifyDataSetChanged();
            }
        };

    }

    @Override
    protected void onResume() {
        super.onResume();
        RetrofitAPIManager.getInstance().getFriendList(new ProgressSubscriber<BaseResponse<List<FriendListModel>>>(listener,FriendListActivity.this,0),userModel.getUserId());
    }

    private void initListener() {
        mTvAction.setOnClickListener(this);
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
    String ids ="" ;
    String uids;
    @Override
    public void widgetClick(View v) {
        switch (v.getId()){
            case R.id.title_layout_tv_action://完成
                for(int i = 0; i<mListData.size(); i++){
                    if (mListData.get(i).isIscheck()==true){
                        ids+=mListData.get(i).getUid()+",";
                    }
                }
                if (!ids.equals(",")){
                    uids = ids.substring(0,ids.length() - 1);
                    SubscriberOnNextListener inlistener = new SubscriberOnNextListener<BaseResponse<String>>(){ //通过ID获取群资料
                        @Override
                        public void onNext(BaseResponse<String> baseResponse){
                            finish();
                        }
                    };
                    SubscriberOnNextListener addlistener = new SubscriberOnNextListener<BaseResponse<GroupInfoModel>>(){ //通过ID获取群资料
                        @Override
                        public void onNext(BaseResponse<GroupInfoModel> baseResponse){
                            finish();
                        }
                    };
                    if (CrewId==null){ //邀請好友 拉群
                        RetrofitAPIManager.getInstance().getCrewcrewAdd(new ProgressSubscriber<BaseResponse<GroupInfoModel>>(addlistener,FriendListActivity.this,0),userModel.getUserId().toString(),
                                userModel.getName().toString()+"的群聊",uids,"1","");
                    }
                    else{//邀請好友
                        RetrofitAPIManager.getInstance().getCrewInvite(new ProgressSubscriber<BaseResponse<String>>(inlistener,FriendListActivity.this,0),CrewId,uids);
                    }

                    ids = "";
                }else{
                    showToast("请选择好友");
                }
                break;
            case R.id.flist_tv_cancel://取消
                for (int i = 0 ;i<mListData.size();i++){
                    mListData.get(i).setIscheck(false);
                }
                mAdapter.notifyDataSetChanged();
                break;
        }
    }
    private void show(String str) {
        str = str.toUpperCase();
        mListData.clear();
        for (int i = 0; i < SearDataList.size(); i++) {
            FriendListModel bean = SearDataList.get(i);
            if (bean.getName().toString().indexOf(str) > -1
                    || bean.getNickname().toString().indexOf(str) > -1||bean.getUid().toString().indexOf(str) > -1) {
                mListData.add(bean);
            }
        }
        mAdapter.notifyDataSetChanged();
    }

}
