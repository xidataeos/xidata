package com.wowo.wowo.Activity;

import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.TextView;

import com.wowo.wowo.Adapter.ConferenceListAdapter;
import com.wowo.wowo.Base.BaseActivity;
import com.wowo.wowo.Model.ConferenceDetailsModel;
import com.wowo.wowo.Model.ConferenceListModel;
import com.wowo.wowo.Model.GroupInfoModel;
import com.wowo.wowo.Model.UserModel;
import com.wowo.wowo.R;
import com.wowo.wowo.Utils.GlideUtils;
import com.wowo.wowo.Utils.HmacSHA256Utils;
import com.wowo.wowo.Utils.SharedPreferencesManager;
import com.wowo.wowo.Views.Dialog.DeleteDialog;
import com.wowo.wowo.rxjava.BaseResponse;
import com.wowo.wowo.rxjava.ProgressSubscriber;
import com.wowo.wowo.rxjava.RetrofitAPIManager;
import com.wowo.wowo.rxjava.SubscriberOnNextListener;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.rong.imkit.RongIM;

/**
 *   会议详情
 */
public class ConferenceDetailsActivity extends BaseActivity{
    private Bundle bundle;
    private TextView mTvTitle,mTvAction,mTvContitle,mTvConName,mTvConWatchNum,mTvConApplyNum,mTvConTime,mTvConAddress,mTvConPrice,mTvContent,mTvGame,mTvGroup,mTvApply;
    private ImageView mIvPic;
    private ConferenceDetailsModel model;
    UserModel userModel;
    String mId;
    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_conferencedeatails);
        findViews();
        init();
        initListener();
    }
    public void findViews() {
        mTvTitle = findView(R.id.title_layout_tv_title);
        mTvAction = findView(R.id.title_layout_tv_action);
        mIvPic  = findView(R.id.conference_iv_pic);
        mTvContitle = findView(R.id.con_tv_title);
        mTvConName = findView(R.id.con_tv_username);
        mTvConWatchNum = findView(R.id.con_tv_watchnum);
        mTvConApplyNum = findView(R.id.con_tv_applynum);
        mTvConTime = findView(R.id.con_tv_time);
        mTvConAddress = findView(R.id.con_tv_address);
        mTvConPrice = findView(R.id.con_tv_price);
        mTvContent = findView(R.id.con_tv_content);
        mTvGame = findView(R.id.con_tv_game);
        mTvGame.setVisibility(View.GONE);//玩彩蛋功能 去掉
        mTvGroup = findView(R.id.con_tv_group);
        mTvApply = findView(R.id.con_tv_apply);
    }
    private void init() {
        bundle = getIntent().getExtras();
        userModel = SharedPreferencesManager.getInstance().getUserData(this);
        mTvTitle.setText("会议详情");
        mTvAction.setBackground(getResources().getDrawable(R.mipmap.fenxiang));
        SubscriberOnNextListener mlistener = new SubscriberOnNextListener<BaseResponse<ConferenceDetailsModel>>(){
            @Override
            public void onNext(BaseResponse<ConferenceDetailsModel> baseResponse) {
                model=baseResponse.data;
                if (model != null) {
                    mId  = model.getMId()+"";
                    GlideUtils.loadImageView(ConferenceDetailsActivity.this,model.getmImg(),mIvPic);
                    mTvContitle.setText(model.getMName());
                    mTvConName.setText("主办方： " + model.getUserName());
                    mTvConWatchNum.setText("浏览数： " + model.getMPageview());
                    mTvConApplyNum.setText("已报名： " + model.getMApplicantcount() + "/" + model.getMUplimit());
                    mTvConTime.setText(model.getMStarttime() + "--" + model.getMStoptime());
                    mTvConAddress.setText(model.getMAddress());
                    mTvConPrice.setText(model.getMPrice());
                    mTvContent.setText(model.getMDesc());
                }
            }
        };
        Map<String, String> map = new HashMap<>();
        map.put("mId",bundle.getInt("mId")+"");
        map.put("key",userModel.getToken());
        map.put("uuQieKeNaoId",userModel.getUserId());
        map.put("token", HmacSHA256Utils.digest("token",map));
        RetrofitAPIManager.getInstance().getConferenceDetails(new ProgressSubscriber<BaseResponse<ConferenceDetailsModel>>(mlistener,this,0),bundle.getInt("mId"),map);
    }
    private void initListener() {
        mTvAction.setOnClickListener(this);
        mIvPic.setOnClickListener(this);
        mTvConAddress.setOnClickListener(this);
        mTvApply.setOnClickListener(this);
        mTvGame.setOnClickListener(this);
        mTvGroup.setOnClickListener(this);
    }
    @Override
    public void widgetClick(View v) {
        switch (v.getId()){
            case R.id.con_tv_address:
                String address = "address=" + mTvConAddress.getText().toString();
                /**调用百度地图Web页面
                 * address=LocaltionAddress&src=YourAppName
                 */
                String uristr = "http://api.map.baidu.com/geocoder?" + address
                        + "&output=html&src=yhc";
                Uri uri = Uri.parse(uristr);
                Intent intent = new Intent(Intent.ACTION_VIEW, uri);
                startActivity(intent);

                break;
            case R.id.con_tv_game://玩彩蛋
                bundle.putString("mId",mId);
                bundle.putString("uId",userModel.getUserId());
                openActivity(PlayEggsActivity.class,bundle);
                break;
            case R.id.con_tv_group://社群
                SubscriberOnNextListener  listener = new SubscriberOnNextListener<BaseResponse<GroupInfoModel>>() { //通过ID获取群资料
                    @Override
                    public void onNext(BaseResponse<GroupInfoModel> baseResponse) {
                        GroupInfoModel groupInfoModel = baseResponse.data;
                        if (groupInfoModel.getIsCrewMember().equals("0")) {//不是成员  申请加群
                            SubscriberOnNextListener applistener = new SubscriberOnNextListener<BaseResponse<GroupInfoModel>>() {
                                @Override
                                public void onNext(BaseResponse<GroupInfoModel> baseResponse) {
                                    showToast("加群成功");
                                    RongIM.getInstance().startGroupChat(ConferenceDetailsActivity.this,model.getCrewCid(),model.getcName());
                                }
                            };
                            RetrofitAPIManager.getInstance().getCrewReply2(new ProgressSubscriber<BaseResponse<GroupInfoModel>>(applistener,ConferenceDetailsActivity.this,0),
                                    model.getCrewCid(),userModel.getUserId(),userModel.getName());
                        } else { //直接跳转到群聊天
                            RongIM.getInstance().startGroupChat(ConferenceDetailsActivity.this,model.getCrewCid(),model.getcName());
                        }
                    }
                };
                RetrofitAPIManager.getInstance().getCrewS(new ProgressSubscriber<BaseResponse<GroupInfoModel>>(listener,ConferenceDetailsActivity.this,0),model.getCrewCid(),userModel.getUserId());
                model.getCrewCid(); //群ID
                model.getcName();//群名
                break;
            case R.id.con_tv_apply://去现场
                bundle.putString("mId",mId);
                bundle.putString("uId",userModel.getUserId());
                openActivity(ApplyActivity.class,bundle);
                break;
            case R.id.title_layout_tv_action://分享

                break;
        }
    }
    private void showDeleteDialog() {
        DeleteDialog.Builder dialog = new DeleteDialog.Builder(this);
        dialog.create("删除好友","确定删除该好友和相关数据").show();
        dialog.setOnSureClickListener(new DeleteDialog.Builder.OnSureClickListener() {
            @Override
            public void onClick() {

            }
        });
    }

}
