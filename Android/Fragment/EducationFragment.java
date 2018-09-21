package com.wowo.wowo.Fragment;

import android.os.Bundle;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentTransaction;
import android.support.v7.widget.GridLayoutManager;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.ImageView;
import android.widget.TextView;

import com.scwang.smartrefresh.layout.SmartRefreshLayout;
import com.scwang.smartrefresh.layout.api.RefreshLayout;
import com.scwang.smartrefresh.layout.listener.OnLoadmoreListener;
import com.scwang.smartrefresh.layout.listener.OnRefreshListener;
import com.wowo.wowo.Activity.EducationDetailsActivity;
import com.wowo.wowo.Adapter.ConferenceListAdapter;
import com.wowo.wowo.Adapter.EducationRcAdapter;
import com.wowo.wowo.Adapter.FriendListRcAdapter;
import com.wowo.wowo.Adapter.GroupRcAdapter;
import com.wowo.wowo.Base.BaseFragment;
import com.wowo.wowo.Model.BannerModel;
import com.wowo.wowo.Model.ConferenceListModel;
import com.wowo.wowo.Model.EducationListModel;
import com.wowo.wowo.Model.UserModel;
import com.wowo.wowo.R;
import com.wowo.wowo.Utils.GlideUtils;
import com.wowo.wowo.Utils.HmacSHA256Utils;
import com.wowo.wowo.Utils.SharedPreferencesManager;
import com.wowo.wowo.Views.ListView.ListViewForService;
import com.wowo.wowo.Views.flashview.FlashView;
import com.wowo.wowo.rxjava.BaseResponse;
import com.wowo.wowo.rxjava.ProgressSubscriber;
import com.wowo.wowo.rxjava.RetrofitAPIManager;
import com.wowo.wowo.rxjava.SubscriberOnNextListener;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 首页 教育培训
 *
 * */

public class EducationFragment extends BaseFragment implements View.OnClickListener {
    private TextView mTvTopTitle;
    private ImageView mImTop;
    private SmartRefreshLayout mRlList;
    private RecyclerView mRcEducationList;
    private List<BannerModel> mBanners;
    private List<String> mImageViews;
    private UserModel userModel;
    private Bundle bundle;
    private List<EducationListModel> mListData;
    private EducationListModel mTopmodel;
    private EducationRcAdapter mAdapter;

    SubscriberOnNextListener mlistener;
    private int mPagesize = 10;
    private int mPageNum = 1;
    @Override
    protected void instanceRootView(LayoutInflater inflater) {
        mRootView = inflater.inflate(R.layout.fragment_education, null);
    }

    @Override
    protected void findViews() {
        mRlList = findView(R.id.education_list);
        mImTop= findView(R.id.education_iv_top);
        mTvTopTitle= findView(R.id.education_tv_top_title);
        mRcEducationList = findView(R.id.education_rl_list);
    }

    @Override
    protected void initListener() {
        mImTop.setOnClickListener(this);
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
    }

    @Override
    protected void init(Bundle savedInstanceState) {
        bundle = new Bundle();
        userModel = SharedPreferencesManager.getInstance().getUserData(getActivity());
        mListData = new ArrayList<>();
        mRlList.setEnableLoadmore(true);
        mRlList.setEnableRefresh(true);
        initData();
    }


    private void initData() {
        mlistener = new SubscriberOnNextListener<BaseResponse<List<EducationListModel>>>(){
            @Override
            public void onNext(BaseResponse<List<EducationListModel>> baseResponse) {
                if (mPageNum == 1){
                    mListData.clear();
                }
                mListData.addAll(baseResponse.data);
                for(int i = 0; i<mListData.size(); i++){
                    if (  mListData.get(i).getETop()){
                        mTopmodel = mListData.get(i);
                        mListData.remove(i);
                    }
                }
                mTvTopTitle.setText(mTopmodel.getETitle());
                GlideUtils.loadImageView(getActivity(),mTopmodel.getEImg(),mImTop);
                mRcEducationList.setLayoutManager(new GridLayoutManager(getActivity(), 2));
                mAdapter = new EducationRcAdapter(getActivity(),mListData);
                mRcEducationList.setAdapter(mAdapter);
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
        map.put("key",userModel.getToken());
        map.put("uuQieKeNaoId",userModel.getUserId());
        map.put("token", HmacSHA256Utils.digest("token",map));
        RetrofitAPIManager.getInstance().getEducationList(new ProgressSubscriber<BaseResponse<List<EducationListModel>>>(mlistener,getActivity(),0),mPageNum,map);
    }

    @Override
    public void onResume() {
        super.onResume();
    }


    @Override
    public void onClick(View v) {
        switch (v.getId()){
            case R.id.education_iv_top:
                bundle = new Bundle();
                bundle.putInt("EId", mTopmodel.getEId());
                openActivity(EducationDetailsActivity.class, bundle);
                break;
        }
    }

}
