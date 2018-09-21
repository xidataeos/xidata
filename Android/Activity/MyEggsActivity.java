package com.wowo.wowo.Activity;

import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.View;
import android.widget.TextView;

import com.wowo.wowo.Adapter.MyEggsAdapter;
import com.wowo.wowo.Base.BaseActivity;
import com.wowo.wowo.Bean.AccountBean;
import com.wowo.wowo.Bean.PersonalBean;
import com.wowo.wowo.Bean.TradeListBean;
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
 * 我的彩蛋
 */
public class MyEggsActivity extends BaseActivity {
    private TextView mTvTitle;
    private TextView eggs_detail;//账单明细
    private TextView eggs_participate;//正在参与
    private TextView eggs_prize;//已开奖
    private RecyclerView eggs_recycler;
    private TextView eggs_balance;//总资产


    private UserModel model;
    private AccountBean bean;//用户信息实体类
    private TradeListBean tradeListBean;//账单明细实体类
    private MyEggsAdapter adapter;
    private List<Integer> list = new ArrayList<>();
    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_my_eggs);
        findViews();
        init();
    }
    public void findViews() {
        mTvTitle = findView(R.id.title_layout_tv_title);
        eggs_detail = findView(R.id.eggs_detail);
        eggs_participate = findView(R.id.eggs_participate);
        eggs_prize = findView(R.id.eggs_prize);
        eggs_recycler = findView(R.id.eggs_recycler);
        eggs_balance = findView(R.id.eggs_balance);
        eggs_recycler.setLayoutManager(new LinearLayoutManager(this, LinearLayoutManager.VERTICAL, false));
    }
    private void init() {
        mTvTitle.setText("我的彩蛋");
        eggs_detail.setOnClickListener(this);
        eggs_participate.setOnClickListener(this);
        eggs_prize.setOnClickListener(this);
        model = SharedPreferencesManager.getInstance().getUserData(MyEggsActivity.this);

        //获取我的钱包信息
        SubscriberOnNextListener listener = new SubscriberOnNextListener<BaseResponse<AccountBean>>() {
            @Override
            public void onNext(BaseResponse<AccountBean> baseResponse) {
                bean = baseResponse.data;
                eggs_balance.setText(bean.getBalance()+"");
            }
        };
        RetrofitAPIManager.getInstance().account(new ProgressSubscriber<BaseResponse<AccountBean>>(listener, MyEggsActivity.this, 0), model.getUserId());

        //获取交易记录
        SubscriberOnNextListener listener2 = new SubscriberOnNextListener<BaseResponse<TradeListBean>>() {
            @Override
            public void onNext(BaseResponse<TradeListBean> baseResponse) {
                tradeListBean = baseResponse.data;
            }
        };
        RetrofitAPIManager.getInstance().tradeList(new ProgressSubscriber<BaseResponse<TradeListBean>>(listener2, MyEggsActivity.this, 0), model.getUserId(),"1","10");


        list.add(1);
        list.add(1);
        list.add(1);
        list.add(1);
        list.add(1);
        adapter = new MyEggsAdapter(this);
        adapter.setData(list);
        eggs_recycler.setAdapter(adapter);
    }
    @Override
    public void widgetClick(View v) {
        switch (v.getId()){
            case R.id.eggs_detail://我的账单
                initViewColor(0);
                list.clear();
                list.add(1);
                list.add(1);
                list.add(1);
                list.add(1);
                list.add(1);
                adapter.setData(list);
                adapter.notifyDataSetChanged();
                break;
            case R.id.eggs_participate://正在参与
                initViewColor(1);
                list.clear();
                list.add(2);
                list.add(2);
                list.add(2);
                list.add(2);
                list.add(2);
                adapter.setData(list);
                adapter.notifyDataSetChanged();
                break;
            case R.id.eggs_prize://已开奖
                initViewColor(2);
                list.clear();
                list.add(3);
                list.add(3);
                list.add(3);
                list.add(3);
                list.add(3);
                adapter.setData(list);
                adapter.notifyDataSetChanged();
                break;
        }
    }

    /**
     * 初始化按钮颜色
     */
    private void initViewColor(int type){
        switch (type){
            case 0:
                eggs_detail.setTextColor(getResources().getColor(R.color.color_ffffff));
                eggs_participate.setTextColor(getResources().getColor(R.color.gray_light));
                eggs_prize.setTextColor(getResources().getColor(R.color.gray_light));

                eggs_detail.setBackgroundResource(R.drawable.backround_bt_maincolor);
                eggs_participate.setBackgroundResource(0);
                eggs_prize.setBackgroundResource(0);
                break;
            case 1:
                eggs_detail.setTextColor(getResources().getColor(R.color.gray_light));
                eggs_participate.setTextColor(getResources().getColor(R.color.color_ffffff));
                eggs_prize.setTextColor(getResources().getColor(R.color.gray_light));

                eggs_detail.setBackgroundResource(0);
                eggs_participate.setBackgroundResource(R.drawable.backround_bt_maincolor);
                eggs_prize.setBackgroundResource(0);
                break;
            case 2:
                eggs_detail.setTextColor(getResources().getColor(R.color.gray_light));
                eggs_participate.setTextColor(getResources().getColor(R.color.gray_light));
                eggs_prize.setTextColor(getResources().getColor(R.color.color_ffffff));

                eggs_detail.setBackgroundResource(0);
                eggs_participate.setBackgroundResource(0);
                eggs_prize.setBackgroundResource(R.drawable.backround_bt_maincolor);
                break;
        }
    }
    @Override
    public void onPointerCaptureChanged(boolean hasCapture) {

    }
}
