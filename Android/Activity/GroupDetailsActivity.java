package com.wowo.wowo.Activity;

import android.content.pm.PackageManager;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.text.Editable;
import android.text.TextWatcher;
import android.util.Log;
import android.view.View;
import android.widget.CheckBox;
import android.widget.CompoundButton;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.widget.Toast;

import com.wowo.wowo.Adapter.GroupListRcAdapter;
import com.wowo.wowo.Adapter.GroupMemberRcAdapter;
import com.wowo.wowo.Base.BaseActivity;
import com.wowo.wowo.Model.DataModel;
import com.wowo.wowo.Model.FriendListModel;
import com.wowo.wowo.Model.GroupInfoModel;
import com.wowo.wowo.Model.GroupMemberModel;
import com.wowo.wowo.Model.UserModel;
import com.wowo.wowo.R;
import com.wowo.wowo.Utils.GlideUtils;
import com.wowo.wowo.Utils.HmacSHA256Utils;
import com.wowo.wowo.Utils.LogUtil;
import com.wowo.wowo.Utils.PermissionUtils;
import com.wowo.wowo.Utils.SharedPreferencesManager;
import com.wowo.wowo.Views.CircleImageView.CircleImageView;
import com.wowo.wowo.Views.Dialog.DeleteDialog;
import com.wowo.wowo.Views.Dialog.GroupCodeDialog;
import com.wowo.wowo.rxjava.BaseResponse;
import com.wowo.wowo.rxjava.ProgressSubscriber;
import com.wowo.wowo.rxjava.RetrofitAPIManager;
import com.wowo.wowo.rxjava.SubscriberOnNextListener;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.rong.imkit.RongIM;
import io.rong.imlib.RongIMClient;
import io.rong.imlib.model.Conversation;

public class GroupDetailsActivity extends BaseActivity{
    private LinearLayout mLlGroupOwner,mLlShield,mLlMember;
    private Bundle bundle;
    private TextView mTvTitle,mTvCode,mTvExit,mTvCrName,mTvCrNum,mTvCrBrief,mTvInFriend,mTvSetInfo,mTvCrDel;
     private RecyclerView mRcMemList;
     private EditText mEtSearch;
     private CircleImageView mIvHead;
    private CheckBox mCbShield;
    private List<GroupMemberModel> mListData;
    private List<GroupMemberModel> SearDataList;
    GroupInfoModel groupInfoModel;
    GroupMemberRcAdapter mAdapter;
    String CrewId;
    String Qrcode;
    String Uid;
    String Ispub;
    UserModel userModel;
    SubscriberOnNextListener listener;
    SubscriberOnNextListener listlistener;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_groupdeatails);
        findViews();
        init();
        initListener();
    }
    public void findViews() {
        mTvTitle = findView(R.id.title_layout_tv_title);
        mTvCode=findView(R.id.group_tv_code);
        mTvExit=findView(R.id.group_tv_exit);
        mTvCrName = findView(R.id.crew_tv_name);
        mTvCrNum = findView(R.id.crew_tv_num);
        mTvCrBrief = findView(R.id.crew_tv_brief);
        mRcMemList = findView(R.id.group_rc_members);
//        mRcMemList. setNestedScrollingEnabled(false);
        mLlShield= findView(R.id.group_ll_shield);
        mLlGroupOwner= findView(R.id.group_ll_groupowner);
        mTvInFriend= findView(R.id.group_tv_infriend);
        mTvSetInfo= findView(R.id.group_tv_setinfo);
        mTvCrDel= findView(R.id.group_tv_groupdel);
        mCbShield= findView(R.id.group_cb_shield);
        mIvHead = findView(R.id.group_ci_head);
        mLlMember = findView(R.id.group_ll_members);
        mEtSearch = findView(R.id.title_layout_search_search_et);
    }
    private void init() {
        userModel = SharedPreferencesManager.getInstance().getUserData(this);
        mListData = new ArrayList<>();
        SearDataList = new ArrayList<>();
        bundle = getIntent().getExtras();
        mTvTitle.setText("社群详情");
        CrewId = bundle.getString("cid");
        Qrcode= bundle.getString("qrcode");
        Uid = bundle.getString("uid");
       listlistener = new SubscriberOnNextListener<BaseResponse<List<GroupMemberModel>>>(){
            @Override
            public void onNext(BaseResponse<List<GroupMemberModel>> baseResponse) {
                mListData.clear();
                mListData.addAll(baseResponse.data);
                SearDataList.addAll(baseResponse.data);
                mRcMemList.setLayoutManager(new LinearLayoutManager(GroupDetailsActivity.this, LinearLayoutManager.VERTICAL, false));
                mAdapter = new GroupMemberRcAdapter(GroupDetailsActivity.this,mListData ,userModel.getUserId());
                mRcMemList.setAdapter(mAdapter);
                mAdapter.notifyDataSetChanged();
            }
        };

        listener = new SubscriberOnNextListener<BaseResponse<GroupInfoModel>>(){ //通过ID获取群资料
            @Override
            public void onNext(BaseResponse<GroupInfoModel> baseResponse){
                groupInfoModel = baseResponse.data;
                Ispub = groupInfoModel.getPub()+"";
                GlideUtils.loadImageView(GroupDetailsActivity.this,groupInfoModel.getUrlPhoto(),mIvHead);
                mTvCrName.setText(groupInfoModel.getName().toString());
                mTvCrNum.setText("群成员数："+groupInfoModel.getNum());
                mTvCrBrief.setText(groupInfoModel.getBrief().toString());
                if (groupInfoModel.getIsCrewMember().equals("0")){//不是成员
                    mLlShield.setVisibility(View.GONE);
                    mTvExit.setText("加入群组");
                    mLlGroupOwner.setVisibility(View.GONE);
                    mLlMember.setVisibility(View.GONE);
                }else{
                    mLlMember.setVisibility(View.VISIBLE);
                     mLlShield.setVisibility(View.VISIBLE);
                       mTvExit.setText("退出社群");
          }
               if (groupInfoModel.getUid().equals(userModel.getUserId())){ //判断是不是群主
                   mTvExit.setVisibility(View.GONE);
                   mLlGroupOwner.setVisibility(View.VISIBLE);
               }else{
                   mTvExit.setVisibility(View.VISIBLE);
                   mLlGroupOwner.setVisibility(View.GONE);
               }
               if (groupInfoModel.getShield().equals("0")){//有没有屏蔽
                   mCbShield.setChecked(false);
               }else{
                   mCbShield.setChecked(true);
               }
            }
        };
    }
    private void  initdata(){
        RetrofitAPIManager.getInstance().getCrewMemberList(new ProgressSubscriber<BaseResponse<List<GroupMemberModel>>>(listlistener,GroupDetailsActivity.this,0),CrewId);

        RetrofitAPIManager.getInstance().getCrewS(new ProgressSubscriber<BaseResponse<GroupInfoModel>>(listener,GroupDetailsActivity.this,0),CrewId,userModel.getUserId());
    }
    private void initListener() {
        mTvCode.setOnClickListener(this);
        mTvExit.setOnClickListener(this);
        mTvInFriend.setOnClickListener(this);
        mTvSetInfo.setOnClickListener(this);
        mTvCrDel.setOnClickListener(this);
        mCbShield.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
                String shield;
                if (isChecked==true){
                    shield  = "1";
                }else {
                   shield = "0";
                }
                    SubscriberOnNextListener mlistener = new SubscriberOnNextListener<BaseResponse<String>>() {
                        @Override
                        public void onNext(BaseResponse<String> baseResponse) {
                        }
                    };
                RetrofitAPIManager.getInstance().getCrewshield(new ProgressSubscriber<BaseResponse<String>>(mlistener,GroupDetailsActivity.this,0),CrewId,userModel.getUserId(),shield);
                }
        });
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
    protected void onResume() {
        super.onResume();
        initdata();
    }
    public static final int WRITE_EXTERNAL_STORAGE = 0x0022;//读写文件
    @Override
    public void widgetClick(View v) {
        switch (v.getId()){
            case R.id.group_tv_code:
                boolean permiss = PermissionUtils.isStoragePermission(this,WRITE_EXTERNAL_STORAGE);
                if (permiss) {
                    showCodeDialog(bundle.getString("name"), CrewId ,groupInfoModel.getUrlPhoto());
                }
                break;
            case R.id.group_tv_exit:
                if (groupInfoModel.getIsCrewMember().equals("0")){//不是成员 加群
                    if (groupInfoModel.getPub()==0){//不是公开群
                        SubscriberOnNextListener listener = new SubscriberOnNextListener<BaseResponse<String>>() {
                            @Override
                            public void onNext(BaseResponse<String> baseResponse) {
                                showToast("已发送入群申请，等待群主审核");
                                initdata();
                            }
                        };
                        RetrofitAPIManager.getInstance().getCrewReply(new ProgressSubscriber<BaseResponse<String>>(listener,GroupDetailsActivity.this,0),
                                CrewId,userModel.getUserId(),userModel.getName());
                    }else{
                        SubscriberOnNextListener listener = new SubscriberOnNextListener<BaseResponse<GroupInfoModel>>() {
                            @Override
                            public void onNext(BaseResponse<GroupInfoModel> baseResponse) {
                                showToast("加群成功");
                                initdata();
                            }
                        };
                        RetrofitAPIManager.getInstance().getCrewReply2(new ProgressSubscriber<BaseResponse<GroupInfoModel>>(listener,GroupDetailsActivity.this,0),
                                CrewId,userModel.getUserId(),userModel.getName());
                    }
                }else{  //退群
                    showDeleteDialog(0);
                }
                break;
            case R.id.group_tv_infriend:// 邀请好友（群主）
                bundle.putInt("isshow",1);
                bundle.putString("crewId",CrewId);
                openActivity(FriendListActivity.class,bundle);
                break;

            case R.id.group_tv_setinfo://信息設置
                bundle.putString("urlphoto",groupInfoModel.getUrlPhoto());
                openActivity(NewGroupActivity.class,bundle);
                break;
            case R.id.group_tv_groupdel:
                showDeleteDialog(1);
                break;
        }
    }
    @Override
    public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
        switch (requestCode) {
            case 0x0022:
                if (grantResults[0] == PackageManager.PERMISSION_GRANTED) {
                    showCodeDialog(bundle.getString("name"), CrewId,groupInfoModel.getUrlPhoto());
                } else {
                    Toast.makeText(this, "读写文件：如果不允许，你将无法在商办帮中使用版本更新等功能",Toast.LENGTH_SHORT);
                }
                break;
            default:
                super.onRequestPermissionsResult(requestCode, permissions, grantResults);
                break;
        }
    }
    private void showDeleteDialog(int type) {
            DeleteDialog.Builder dialog = new DeleteDialog.Builder(this);
            if (type == 0){//   退出群
                dialog.create("退出社群","确定删除该社群和相关数据").show();
                dialog.setOnSureClickListener(new DeleteDialog.Builder.OnSureClickListener() {
                    @Override
                    public void onClick() {
                        SubscriberOnNextListener mlistener = new SubscriberOnNextListener<BaseResponse<String>>() {
                            @Override
                            public void onNext(BaseResponse<String> baseResponse) {
                                finish();
                            }
                        };
                        Map<String, String> map = new HashMap<>();
                        map.put("crewId",CrewId);
                        map.put("userId",userModel.getUserId());
                        map.put("key", SharedPreferencesManager.getInstance().getUserData(GroupDetailsActivity.this).getToken());
                        map.put("uuQieKeNaoId",SharedPreferencesManager.getInstance().getUserData(GroupDetailsActivity.this).getUserId());
                        LogUtil.e("Logmap",map.toString());
                        map.put("token", HmacSHA256Utils.digest("token",map));
                        RetrofitAPIManager.getInstance().CrewRemove(new ProgressSubscriber<BaseResponse<String>>(mlistener,GroupDetailsActivity.this,0),CrewId,userModel.getUserId(),map);
                    }
                });
            }else if(type == 1){ //解散群
                dialog.create("解散社群","解散此群将会清理所有成员并且丢失所有记录。确定解散此群？").show();
                dialog.setOnSureClickListener(new DeleteDialog.Builder.OnSureClickListener() {
                    @Override
                    public void onClick() {
                        SubscriberOnNextListener mlistener = new SubscriberOnNextListener<BaseResponse<String>>() {
                            @Override
                            public void onNext(BaseResponse<String> baseResponse) {
                                finish();
                            }
                        };
                        RetrofitAPIManager.getInstance().CrewDel(new ProgressSubscriber<BaseResponse<String>>(mlistener,GroupDetailsActivity.this,0),CrewId,userModel.getUserId());
                    }
                });
            }

    }
    private void showCodeDialog(String name ,String id,String photo) {
        GroupCodeDialog.Builder dialog = new GroupCodeDialog.Builder(this);
        dialog.create(name, id,photo,"1").show();
    }
    private void show(String str) {
        str = str.toUpperCase();
        mListData.clear();
        for (int i = 0; i < SearDataList.size(); i++) {
            GroupMemberModel bean = SearDataList.get(i);
            if (bean.getName().toString().indexOf(str) > -1
                    || bean.getNickname().toString().indexOf(str) > -1||bean.getUid().toString().indexOf(str) > -1) {
                mListData.add(bean);
            }
        }
        mAdapter.notifyDataSetChanged();
    }
}
