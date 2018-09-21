package com.wowo.wowo.Activity;

import android.content.pm.ActivityInfo;
import android.media.MediaPlayer;
import android.net.Uri;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v7.widget.GridLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.View;
import android.widget.Button;
import android.widget.MediaController;
import android.widget.TextView;
import android.widget.VideoView;

import com.wowo.wowo.Adapter.EducationRcAdapter;
import com.wowo.wowo.Base.BaseActivity;
import com.wowo.wowo.Model.ConferenceDetailsModel;
import com.wowo.wowo.Model.EducationDetailsModel;
import com.wowo.wowo.Model.EducationListModel;
import com.wowo.wowo.Model.UserModel;
import com.wowo.wowo.R;
import com.wowo.wowo.Utils.GlideUtils;
import com.wowo.wowo.Utils.HmacSHA256Utils;
import com.wowo.wowo.Utils.LogUtil;
import com.wowo.wowo.Utils.SharedPreferencesManager;
import com.wowo.wowo.Views.Dialog.DeleteDialog;
import com.wowo.wowo.Views.MarqueeView.Utils;
import com.wowo.wowo.Views.VideoPlayView;
import com.wowo.wowo.rxjava.BaseResponse;
import com.wowo.wowo.rxjava.ProgressSubscriber;
import com.wowo.wowo.rxjava.RetrofitAPIManager;
import com.wowo.wowo.rxjava.SubscriberOnNextListener;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 教育详情
 * */
public class EducationDetailsActivity extends BaseActivity implements VideoPlayView.MediaPlayerImpl {
    private Bundle bundle;
    private TextView mTvTitle,mTvAction,mTvATitle,mTvPage,mTvIntro;
    private int Eid;
    private VideoView mVideo;
    EducationDetailsModel model;
    String Videourl;
    SubscriberOnNextListener mlistener;
    SubscriberOnNextListener Listlistener;
    private List<EducationListModel> mListData;
    private RecyclerView mRcEducationList;
    private EducationRcAdapter mAdapter;
    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_educationdetail);
        findViews();
        init();
        initListener();
    }
    public void findViews() {
        mTvTitle = findView(R.id.title_layout_tv_title);
        mTvAction = findView(R.id.title_layout_tv_action);
        mTvATitle = findView(R.id.edu_tv_title);
        mTvPage= findView(R.id.edu_tv_page);
        mTvIntro= findView(R.id.edu_tv_intro);
        mVideo = findView(R.id.video);
        mRcEducationList = findView(R.id.education_rl_list);
    }
    private void init() {
        bundle = getIntent().getExtras();
        mTvTitle.setText("教育详情");
        mListData = new ArrayList<>();
        mTvAction.setBackground(getResources().getDrawable(R.mipmap.fenxiang));
        mTvAction.setOnClickListener(this);
        Eid = bundle.getInt("EId");
        mlistener = new SubscriberOnNextListener<BaseResponse<EducationDetailsModel>>(){
            @Override
            public void onNext(BaseResponse<EducationDetailsModel> baseResponse) {
                model=baseResponse.data;
                if (model != null) {
                    mTvATitle.setText(model.getETitle());
                    mTvPage.setText(model.getEPageview()+"次播放");
                    mTvIntro.setText(model.getEXqIntro());
                }
                Videourl= model.getEVideolink().toString();
                //设置视频控制器
                mVideo.setMediaController(new MediaController(EducationDetailsActivity.this));
                //播放完成回调
                mVideo.setOnCompletionListener( new MyPlayerOnCompletionListener());
                //设置视频路径
//        mVideo.setVideoURI(Uri.parse(Videourl));
                mVideo.setVideoPath(Videourl);
                //开始播放视频
                mVideo.start();
            }
        };
        Listlistener = new SubscriberOnNextListener<BaseResponse<List<EducationListModel>>>(){
            @Override
            public void onNext(BaseResponse<List<EducationListModel>> baseResponse) {
                mListData.addAll(baseResponse.data);
                mRcEducationList.setLayoutManager(new GridLayoutManager(EducationDetailsActivity.this, 2));
                mAdapter = new EducationRcAdapter(EducationDetailsActivity.this,mListData,1);
                mRcEducationList.setAdapter(mAdapter);
            }
        };
    }

    @Override
    protected void onResume() {
        super.onResume();
        Map<String, String> map = new HashMap<>();
        map.put("eId",Eid+"");
        map.put("key", SharedPreferencesManager.getInstance().getUserData(this).getToken());
        map.put("uuQieKeNaoId",SharedPreferencesManager.getInstance().getUserData(this).getUserId());
        LogUtil.e("Logmap",map.toString());
        map.put("token", HmacSHA256Utils.digest("token",map));
        RetrofitAPIManager.getInstance().getEducationDeList(new ProgressSubscriber<BaseResponse<List<EducationListModel>>>(Listlistener,this,0),Eid,map);
        RetrofitAPIManager.getInstance().getEducationDetails(new ProgressSubscriber<BaseResponse<EducationDetailsModel>>(mlistener,this,0),Eid,map);
    }

    class MyPlayerOnCompletionListener implements MediaPlayer.OnCompletionListener {
        @Override
        public void onCompletion(MediaPlayer mp) {
          showToast( "播放完成了");
    }
}
    private void initListener( ) {

    }
    @Override
    public void widgetClick(View v) {
        switch (v.getId()){
            case R.id.title_layout_tv_action://分享

                break;
        }
    }

    @Override
    public void onError() {
//        closeVideo();
    }

    @Override
    public void onExpend() {
//        firstVisiblePosition = video_lv.getFirstVisiblePosition();
        // 强制横屏
        setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_LANDSCAPE);
    }

    @Override
    public void onShrik() {
        // 强制竖屏
        setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_PORTRAIT);
    }

}
