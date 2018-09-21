package com.wowo.wowo.Activity;

import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.util.Log;
import android.view.View;
import android.widget.TextView;

import com.wowo.wowo.Adapter.MessageRemindAdapter;
import com.wowo.wowo.Adapter.MyEggsAdapter;
import com.wowo.wowo.Base.BaseActivity;
import com.wowo.wowo.Bean.ByUserBean;
import com.wowo.wowo.Model.UserModel;
import com.wowo.wowo.R;
import com.wowo.wowo.Utils.SharedPreferencesManager;
import com.wowo.wowo.rxjava.BaseResponse;
import com.wowo.wowo.rxjava.ProgressSubscriber;
import com.wowo.wowo.rxjava.RetrofitAPIManager;
import com.wowo.wowo.rxjava.SubscriberOnNextListener;

import java.util.List;

/**
 * 消息提醒
 */
public class MessageRemindActivity extends BaseActivity implements MessageRemindAdapter.itemClick{
    private TextView mTvTitle;
    private RecyclerView remind_recycler;
    private UserModel model;

    private MessageRemindAdapter adapter;
    private List<ByUserBean> bean;
    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_message_remind);
        findview();
        init();
    }

    private void findview() {
        mTvTitle = findView(R.id.title_layout_tv_title);
        remind_recycler = findView(R.id.remind_recycler);
        remind_recycler.setLayoutManager(new LinearLayoutManager(this, LinearLayoutManager.VERTICAL, false));

    }

    private void init() {
        mTvTitle.setText("消息提醒");
        model = SharedPreferencesManager.getInstance().getUserData(this);
        //获取我的钱包信息
        SubscriberOnNextListener listener = new SubscriberOnNextListener<BaseResponse<List<ByUserBean>>>() {
            @Override
            public void onNext(BaseResponse<List<ByUserBean>> baseResponse) {
                bean = baseResponse.data;
                if (bean.size() == 0){
                    return;
                }
                initData();
            }
        };
        RetrofitAPIManager.getInstance().meetingByUser(new ProgressSubscriber<BaseResponse<List<ByUserBean>>>(listener, MessageRemindActivity.this, 0), model.getUserId());

    }
    public void initData() {
        adapter = new MessageRemindAdapter(MessageRemindActivity.this);
        adapter.setData(bean);
        adapter.setItemClick(this);
        remind_recycler.setAdapter(adapter);
    }
    @Override
    public void widgetClick(View v) {

    }
    private Bundle bundle;
    @Override
    public void setOnclick(int mId) {
        bundle = new Bundle();
        bundle.putInt("mId",mId);
        openActivity(ConferenceDetailsActivity.class, bundle);
    }
}
