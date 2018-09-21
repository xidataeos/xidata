package com.wowo.wowo.Fragment;

import android.content.Intent;
import android.os.Bundle;
import android.support.v7.widget.GridLayoutManager;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;

import com.wowo.wowo.Activity.WatchDetailsActivity;
import com.wowo.wowo.Adapter.NewsFragmentRcAdapter;
import com.wowo.wowo.Base.BaseFragment;
import com.wowo.wowo.Model.FindNewsModel;
import com.wowo.wowo.Model.FindNewsModelDetails;
import com.wowo.wowo.R;
import com.wowo.wowo.Utils.LogUtil;
import com.wowo.wowo.rxjava.BaseResponse;
import com.wowo.wowo.rxjava.ProgressSubscriber;
import com.wowo.wowo.rxjava.RetrofitAPIManager;
import com.wowo.wowo.rxjava.SubscriberOnNextListener;

import java.util.ArrayList;
import java.util.List;


public class NewsFragment extends BaseFragment implements View.OnClickListener,NewsFragmentRcAdapter.OnClick {

    private RecyclerView recyclerView;
    private NewsFragmentRcAdapter rcAdapter;
    private List<FindNewsModel> list;
    @Override
    protected void instanceRootView(LayoutInflater inflater) {
        mRootView = inflater.inflate(R.layout.news_fragment, null);
    }

    @Override
    protected void findViews() {
        recyclerView = (RecyclerView) findView(R.id.rcv_content);
    }

    @Override
    protected void initListener() {
        list = new ArrayList<>();
        SubscriberOnNextListener listener = new SubscriberOnNextListener<BaseResponse<List<FindNewsModel>>>() {
            @Override
            public void onNext(BaseResponse<List<FindNewsModel>> baseResponse) {
                list.addAll(baseResponse.data);
                LogUtil.e("TAG","看点----1>"+list.size());
                if (list.size() == 0){
                    return;
                }
                initData();
            }
        };
        RetrofitAPIManager.getInstance().getFindNewsPage(new ProgressSubscriber<BaseResponse<List<FindNewsModel>>>(listener,getActivity(),0),1);
        initData();
    }

    @Override
    protected void init(Bundle savedInstanceState) {

    }

    private void initData() {
        LinearLayoutManager layoutManager = new LinearLayoutManager(getActivity());
        recyclerView.setLayoutManager(layoutManager);
        rcAdapter = new NewsFragmentRcAdapter(getActivity(),list);
        rcAdapter.setOnClick(this);
        recyclerView.setAdapter(rcAdapter);
    }

    @Override
    public void onResume() {
        super.onResume();
        initData();
    }

    @Override
    public void onClick(View v) {
        switch (v.getId()) {
//            case R.id.fragment_personal_rl_setting: //设置
//                openActivity(SeetingActivity.class);
//                break;
        }
    }

    @Override
    public void click(int id) {
        LogUtil.e("TAG","点击Item:"+id);
        Intent intent = new Intent(getActivity(),WatchDetailsActivity.class);
        intent.putExtra("nId",id);
        startActivity(intent);
    }
}
