package com.wowo.wowo.Activity;

import android.os.Bundle;
import android.support.annotation.Nullable;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import com.lljjcoder.style.citylist.Toast.ToastUtils;
import com.wowo.wowo.Base.BaseActivity;
import com.wowo.wowo.Model.GameInfoModel;
import com.wowo.wowo.Model.UserModel;
import com.wowo.wowo.R;
import com.wowo.wowo.Utils.LogUtil;
import com.wowo.wowo.Utils.SharedPreferencesManager;
import com.wowo.wowo.Views.Countdown.CountdownView;
import com.wowo.wowo.Views.Dialog.DeleteDialog;
import com.wowo.wowo.Views.Dialog.PlayEggDialog;
import com.wowo.wowo.rxjava.BaseResponse;
import com.wowo.wowo.rxjava.ProgressSubscriber;
import com.wowo.wowo.rxjava.RetrofitAPIManager;
import com.wowo.wowo.rxjava.SubscriberOnNextListener;

import io.rong.imlib.RongIMClient;
import io.rong.imlib.model.Message;
import io.rong.imlib.model.MessageContent;
import io.rong.message.TextMessage;

/**
 *   会议详情
 */
public class PlayEggsActivity extends BaseActivity implements  RongIMClient.OnReceiveMessageListener{
    private Bundle bundle;
    private TextView  mTvbonusCount,mTvnowPrice,mTvname,mTvStartTime,mTvmaxPrice,mTvCountNumber,mTvdealerGain,mTvPutCountNumber,mTvuserGain,mTvUserCountPutEgg,mTvlastUserGain;
    private CountdownView mCoutDown;
    private Button mBtPlay;
    UserModel userModel;
    GameInfoModel model;
    SubscriberOnNextListener mlistener;
    String  mId ,gameId;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_palyeggs);
        findViews();
        init();
        initListener();
    }
    public void findViews() {

    }
    public void initdata() {
        RetrofitAPIManager.getInstance().findGameInfo(new ProgressSubscriber<BaseResponse<GameInfoModel>>(mlistener,this,0),
                mId,bundle.getString("uId"));
    }
    private void init() {
        bundle = getIntent().getExtras();
        userModel = SharedPreferencesManager.getInstance().getUserData(this);
        mId =bundle.getString("mId");
        mBtPlay= findView(R.id.game_bt_play);
        mCoutDown = findView(R.id.game_countdown);
        mTvbonusCount= findView(R.id.game_tv_bonuscount);
        mTvnowPrice= findView(R.id.game_tv_nowprice);
        mTvname= findView(R.id.game_tv_name);
        mTvStartTime= findView(R.id.game_tv_starttime);
        mTvmaxPrice= findView(R.id.game_tv_maxprice);
        mTvCountNumber= findView(R.id.game_tv_countnumber);
        mTvdealerGain= findView(R.id.game_tv_dealergain);
        mTvPutCountNumber= findView(R.id.game_tv_putcountnumber);
        mTvuserGain= findView(R.id.game_tv_usergain);
        mTvUserCountPutEgg= findView(R.id.game_tv_usercountputegg);
        mTvlastUserGain= findView(R.id.game_tv_lastusergain);
        mlistener = new SubscriberOnNextListener<BaseResponse<GameInfoModel>>(){
            @Override
            public void onNext(BaseResponse<GameInfoModel> baseResponse) {
                model=baseResponse.data;
                if (model != null) {
                    gameId = model.getId()+"";
                    mCoutDown.start( mCoutDown.getTime(model.getGameStopTime()));
                    mTvbonusCount.setText(model.getBonusCount()+"");
                    mTvnowPrice.setText(model.getNowPrice()+"");
                    mTvname.setText("组织者： " + model.getName().toString());
                    mTvStartTime.setText("游戏时间：" + model.getGameStartTime().toString()+"--"+model.getGameStopTime().toString());
                    mTvmaxPrice.setText(  model.getMaxPrice()+"");
                    mTvCountNumber.setText(  model.getGameCountNumber()+"");
                    mTvdealerGain.setText(  model.getDealerGain()+"%");
                    mTvPutCountNumber.setText(  model.getGamePutCountNumber()+"");
                    mTvuserGain.setText(  model.getUserGain()+"%");
                    mTvUserCountPutEgg.setText(  model.getGameUserCountPutEgg()+"");
                    mTvlastUserGain.setText(  model.getLastUserGain()+"%");
                }else{
                    mBtPlay.setOnClickListener(null);
                }
            }
        };
    }
    private void initListener() {
    mBtPlay.setOnClickListener(this);

    }

    @Override
    protected void onResume() {
        super.onResume();
        initdata();
    }

    @Override
    public void widgetClick(View v) {
        switch (v.getId()){
            case R.id.game_bt_play:
                showPlayEggDialog();
                break;
        }
    }
    private void showPlayEggDialog() {
        PlayEggDialog.Builder dialog = new PlayEggDialog.Builder(this);
        dialog.create(model.getNowPrice()+"",userModel.getUserId(),mId).show();
        dialog.setOnSureClickListener(new PlayEggDialog.Builder.OnSureClickListener() {
            @Override
            public void onClick() {
                SubscriberOnNextListener listener = new SubscriberOnNextListener<BaseResponse<String>>(){
                    @Override
                    public void onNext(BaseResponse<String> baseResponse) {
                        ToastUtils.showShortToast(PlayEggsActivity.this,"投入成功");
                        initdata();
                    }
                };
                RetrofitAPIManager.getInstance().insertGameUser(new ProgressSubscriber<BaseResponse<String>>(listener,PlayEggsActivity.this,0),userModel.getUserId(),gameId);
            }
        });
    }

    @Override
    public boolean onReceived(Message message, int i) {
        MessageContent messageContent = message.getContent();
        if (messageContent instanceof TextMessage) {//文本消息
            TextMessage textMessage = (TextMessage) messageContent;
            if (textMessage.getContent().toString().equals("彩蛋消息")){
                initdata();
            }
            LogUtil.e("##COMMON_io.rong.push","--------&gt;onReceived-TextMessage:" +textMessage.getContent().toString());
        } else {
            LogUtil.e("##COMMON_io.rong.push","--------&gt;onReceived-其他消息，自己来判断处理");
        }
        return false;
    }
}
