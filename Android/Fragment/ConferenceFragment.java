package com.wowo.wowo.Fragment;

import android.os.Bundle;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentTransaction;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.TextView;

import com.scwang.smartrefresh.layout.SmartRefreshLayout;
import com.scwang.smartrefresh.layout.api.RefreshLayout;
import com.scwang.smartrefresh.layout.listener.OnLoadmoreListener;
import com.scwang.smartrefresh.layout.listener.OnRefreshListener;
import com.wowo.wowo.Activity.ConferenceDetailsActivity;
import com.wowo.wowo.Adapter.ConferenceListAdapter;
import com.wowo.wowo.Base.BaseActivity;
import com.wowo.wowo.Base.BaseFragment;
import com.wowo.wowo.Model.BannerModel;
import com.wowo.wowo.Model.ConferenceListModel;
import com.wowo.wowo.Model.UserModel;
import com.wowo.wowo.R;
import com.wowo.wowo.Utils.HmacSHA256Utils;
import com.wowo.wowo.Utils.SharedPreferencesManager;
import com.wowo.wowo.Views.ListView.ListViewForService;
import com.wowo.wowo.Views.flashview.FlashView;
import com.wowo.wowo.Views.flashview.FlashViewListener;
import com.wowo.wowo.rxjava.BaseResponse;
import com.wowo.wowo.rxjava.ProgressSubscriber;
import com.wowo.wowo.rxjava.RetrofitAPIManager;
import com.wowo.wowo.rxjava.SubscriberOnNextListener;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
* 首页  会议
*/

public class ConferenceFragment extends BaseFragment implements View.OnClickListener {
    private UserModel model;
    private FlashView mFlashView;
    private SmartRefreshLayout mRlList;
    private ListViewForService mLvConfer;
    private int fragmentType = 0;
    private Bundle bundle;
    private List<BannerModel> mBanners;
    private List<String> mImageViews;
    private List<ConferenceListModel> mListData;
    private ConferenceListAdapter mConferAdapter;
    SubscriberOnNextListener mlistener;
    private int mPagesize = 10;
    private int mPageNum = 1;
    @Override
    protected void instanceRootView(LayoutInflater inflater) {
        mRootView = inflater.inflate(R.layout.fragment_conference, null);
    }

    @Override
    protected void findViews() {
        mRlList = findView(R.id.conference_list);
        mFlashView= findView(R.id.home_list_banner);
        mLvConfer = findView(R.id.home_list_list);
    }

    @Override
    protected void initListener() {
        mRlList.setOnLoadmoreListener(new OnLoadmoreListener() {
            @Override
            public void onLoadmore(RefreshLayout refreshlayout) {
                mPageNum++;
                initData();
            }
        });
        mRlList.setOnRefreshListener(new OnRefreshListener() {
            @Override
            public void onRefresh(RefreshLayout refreshlayout) {
                mPageNum=1;
                initData();
            }
        });
        mFlashView.setOnPageClickListener(new FlashViewListener() {
            @Override
            public void onClick(int position) {
                bundle = new Bundle();
                bundle.putInt("mId",mBanners.get(position).getMId());
                openActivity(ConferenceDetailsActivity.class, bundle);
            }
        });
    }

    @Override
    protected void init(Bundle savedInstanceState) {
        model = SharedPreferencesManager.getInstance().getUserData(getActivity());
        bundle = new Bundle();
        mListData = new ArrayList<>();
        mRlList.setEnableLoadmore(true);
        mRlList.setEnableRefresh(true);
        initData();
        initBanner();
    }

    private void initData() {
        mlistener = new SubscriberOnNextListener<BaseResponse<List<ConferenceListModel>>>(){
            @Override
            public void onNext(BaseResponse<List<ConferenceListModel>> baseResponse) {
                if (mPageNum == 1){
                    mListData.clear();
                }
                mListData.addAll(baseResponse.data);
                mConferAdapter = new ConferenceListAdapter(getActivity(),mListData);
                mLvConfer.setAdapter(mConferAdapter);
                mConferAdapter.notifyDataSetChanged();
                if (!(mListData.size() > 0)) {
                    mRlList.setLoadmoreFinished(true);
                } else {
                    mRlList.setLoadmoreFinished(false);
                }
                mRlList.finishLoadmore();
                mRlList.finishRefresh();
            }
        };
        Map<String, String> map = new HashMap<>();
        map.put("pageNum",mPageNum+"");
        map.put("key",model.getToken());
        map.put("uuQieKeNaoId",model.getUserId());
        map.put("token", HmacSHA256Utils.digest("token",map));
        RetrofitAPIManager.getInstance().getConferenceList(new ProgressSubscriber<BaseResponse<List<ConferenceListModel>>>(mlistener,getActivity(),0),mPageNum,map);
    }

    @Override
    public void onResume() {
        super.onResume();
    }


    @Override
    public void onClick(View v) {

    }


    private void initBanner() {
        mImageViews = new ArrayList<>();
        mBanners = new ArrayList<>();
        SubscriberOnNextListener listener = new SubscriberOnNextListener<BaseResponse<List<BannerModel>>>() {
            @Override
            public void onNext(BaseResponse<List<BannerModel>> baseResponse) {
                if (mBanners.size()>0){
                    mBanners.clear();
                }
                mBanners.addAll(baseResponse.data);
                for (int i = 0;i<mBanners.size();i++){
                    mImageViews.add(mBanners.get(i).getMImg());
                }
                mFlashView.setImageUris(mImageViews);
            }
        };
        Map<String, String> map = new HashMap<>();
        map.put("key",model.getToken());
        map.put("uuQieKeNaoId",model.getUserId());
        map.put("token", HmacSHA256Utils.digest("token",map));
        RetrofitAPIManager.getInstance().getBanner(new ProgressSubscriber<BaseResponse<List<BannerModel>>>(listener,getActivity(),0),map);
    }
}
