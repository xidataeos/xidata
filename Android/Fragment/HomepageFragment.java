package com.wowo.wowo.Fragment;

import android.os.Bundle;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentTransaction;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.wowo.wowo.Base.BaseFragment;
import com.wowo.wowo.Model.UserModel;
import com.wowo.wowo.R;
import com.wowo.wowo.Utils.SharedPreferencesManager;

import java.util.ArrayList;

//import com.wowo.wowo.rxjava.BaseResponse;
//import com.wowo.wowo.rxjava.ProgressSubscriber;
//import com.wowo.wowo.rxjava.RetrofitAPIManager;
//import com.wowo.wowo.rxjava.SubscriberOnNextListener;



public class HomepageFragment extends BaseFragment implements View.OnClickListener {
    private TextView mTvConference,mTvEducation;
    private UserModel model;
    private int fragmentType = 0;
    private Bundle bundle;

    ConferenceFragment mConference;
    EducationFragment mEducation;
    @Override
    protected void instanceRootView(LayoutInflater inflater) {
        mRootView = inflater.inflate(R.layout.fragment_home, null);
    }

    @Override
    protected void findViews() {
        mTvConference = findView(R.id.fragment_home_tv_conference);
        mTvEducation = findView(R.id.fragment_home_tv_education);
    }

    @Override
    protected void initListener() {
        mTvConference.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                fragmentType = 0;
                showFragment(fragmentType);
            }
        });

        mTvEducation.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                fragmentType = 1;
                showFragment(fragmentType);
            }
        });
    }

    @Override
    protected void init(Bundle savedInstanceState) {
        model = SharedPreferencesManager.getInstance().getUserData(getActivity());
        bundle = new Bundle();
        bundle.putString("userId", model.getUserId());
        bundle.putString("type", "0");
        initData();
    }

    private void initData() {
        mConference = new ConferenceFragment();
        mEducation = new EducationFragment();
        showFragment(fragmentType);

    }

    @Override
    public void onResume() {
        super.onResume();
        initData();
    }
    private void showFragment(int fragmentType) {
        FragmentManager fm = getFragmentManager();
        FragmentTransaction transaction = fm.beginTransaction();
        switch (fragmentType) {
            case 0:
                mTvConference.setSelected(true);
                mTvEducation.setSelected(false);
                transaction.replace(R.id.fragment_fl, mConference);
                break;
            case 1:
                mTvConference.setSelected(false);
                mTvEducation.setSelected(true);
                transaction.replace(R.id.fragment_fl, mEducation);
                break;
        }
        transaction.commitAllowingStateLoss();
    }

    @Override
    public void onClick(View v) {

    }
}
