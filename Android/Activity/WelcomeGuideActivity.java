package com.wowo.wowo.Activity;

import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v4.view.ViewPager;
import android.view.LayoutInflater;
import android.view.View;
import android.view.animation.AlphaAnimation;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.LinearLayout;

import com.wowo.wowo.Adapter.ViewPagerAdatper;
import com. wowo.wowo.Base.BaseActivity;
import com. wowo.wowo.R;
import com. wowo.wowo.Utils.DepthPageTransformer;
import com.wowo.wowo.Utils.SharedPreferencesManager;

import java.util.ArrayList;
import java.util.List;


/**
 * author: ZhangXiaoWei
 * email : cherno@126.com
 * blog  : http://www.jianshu.com/users/0f532bf88454/latest_articles
 * time  : 2018/1/30 0030
 * desc  :
 */
public class WelcomeGuideActivity extends BaseActivity {
    private ViewPager mVp;
    private LinearLayout mLL;
    private List<View> mViewList;
    private ImageView mLight_dots;
    private int mDistance;
    private ImageView mOne_dot;
    private ImageView mTwo_dot;
    private ImageView mThree_dot;
    private Button mBtn_next;
    private AlphaAnimation alphaAnimation;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_welcome_guide);
        findView();
        init();
        moveDots();
        mVp.setPageTransformer(true, new DepthPageTransformer());
        mVp.setOnClickListener(this);
        mBtn_next.setVisibility(View.VISIBLE);
    }

    private void moveDots() {
//        mLight_dots.getViewTreeObserver().addOnGlobalLayoutListener(new ViewTreeObserver.OnGlobalLayoutListener() {
//            @Override
//            public void onGlobalLayout() {
//                //获得两个圆点之间的距离
//                mDistance = mLL.getChildAt(1).getLeft() - mLL.getChildAt(0).getLeft();
//                mLight_dots.getViewTreeObserver()
//                        .removeGlobalOnLayoutListener(this);
//            }
//        });
        mVp.addOnPageChangeListener(new ViewPager.OnPageChangeListener() {
            @Override
            public void onPageScrolled(int position, float positionOffset, int positionOffsetPixels) {
                //页面滚动时小白点移动的距离，并通过setLayoutParams(params)不断更新其位置
//                float leftMargin = mDistance * (position + positionOffset);
//                RelativeLayout.LayoutParams params = (RelativeLayout.LayoutParams) mLight_dots.getLayoutParams();
//                params.leftMargin = (int) leftMargin;
//                mLight_dots.setLayoutParams(params);
//                if(position==2){
//                    mBtn_next.setVisibility(View.VISIBLE);
//                }
//                if(position!=2&&mBtn_next.getVisibility()==View.VISIBLE){
//                    mBtn_next.setVisibility(View.GONE);
//                }
            }

            @Override
            public void onPageSelected(int position) {
                //页面跳转时，设置小圆点的margin
//                float leftMargin = mDistance * position;
//                RelativeLayout.LayoutParams params = (RelativeLayout.LayoutParams) mLight_dots.getLayoutParams();
//                params.leftMargin = (int) leftMargin;
//                mLight_dots.setLayoutParams(params);
//                alphaAnimation = new AlphaAnimation(0.0f, 1.0f);
//                alphaAnimation.setDuration(2000);    //深浅动画持续时间
//                alphaAnimation.setFillAfter(true);   //动画结束时保持结束的画面
                if (position == 4) {
                    mBtn_next.setVisibility(View.VISIBLE);
//                    mBtn_next.setAlpha(1.0f);
//                    mBtn_next.setAnimation(alphaAnimation);
//                    alphaAnimation.start();
                }
                if (position != 4 && mBtn_next.getVisibility() == View.VISIBLE) {
                    mBtn_next.setVisibility(View.GONE);
//                    mBtn_next.setAlpha(0.0f);
//                    alphaAnimation.cancel();
                }
            }

            @Override
            public void onPageScrollStateChanged(int state) {

            }
        });
    }


    private void init() {
        mViewList = new ArrayList<View>();
        LayoutInflater lf = getLayoutInflater().from(this);
        View view1 = lf.inflate(R.layout.guide_indicator1, null);
//        View view2 = lf.inflate(R.layout.guide_indicator2, null);
//        View view3 = lf.inflate(R.layout.guide_indicator3, null);
//        View view4 = lf.inflate(R.layout.guide_indicator4, null);
//        View view5 = lf.inflate(R.layout.guide_indicator5, null);
        mViewList.add(view1);
//        mViewList.add(view2);
//        mViewList.add(view3);
//        mViewList.add(view4);
//        mViewList.add(view5);
        mVp.setAdapter(new ViewPagerAdatper(mViewList));
    }

    private void findView() {
        mVp = findView(R.id.guide_viewpager);
//        mLL = findView(R.id.guide_ll);
//        mLight_dots = findView(R.id.guide_iv_light_dots);
        mBtn_next = findView(R.id.guide_btn_next);
    }

    @Override
    public void widgetClick(View v) {
        switch (v.getId()) {
            case R.id.guide_btn_next:
                openActivity(LoginActivity.class);
                SharedPreferencesManager.getInstance().putBooleanData(this, "firstopen", "FIRST", false);
                finish();
                break;
            case R.id.guide_viewpager:
                openActivity(LoginActivity.class);
                SharedPreferencesManager.getInstance().putBooleanData(this, "firstopen", "FIRST", false);
                finish();
                break;
        }
    }
}
