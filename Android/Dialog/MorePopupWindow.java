package com.wowo.wowo.Dialog;

import android.app.Activity;
import android.graphics.Rect;
import android.graphics.drawable.ColorDrawable;
import android.os.Build;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.PopupWindow;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.wowo.wowo.R;

public class MorePopupWindow implements View.OnClickListener {

    private TextView title_sweep;
    private TextView title_create_community;
    private TextView title_add_community;
    private RelativeLayout rl_bg;
    private View rootView;
    private PopupWindow mPopWindow;
    private Activity context;
    public MorePopupWindow(Activity context){
        this.context = context;
        initView();
    }
    private MoreItme moreItme;
    public void  setMoreItme(MoreItme moreItme){
        this.moreItme = moreItme;
    }
    @Override
    public void onClick(View view) {
        switch (view.getId()){
            case R.id.title_sweep:
                moreItme.moreItemClick(0);
                break;
            case R.id.title_create_community:
                moreItme.moreItemClick(1);
                break;
            case R.id.title_add_community:
                moreItme.moreItemClick(2);
                break;
        }
    }

    public interface MoreItme{
        void moreItemClick(int position);
    }
    private void initView() {
        rootView = LayoutInflater.from(context).inflate(R.layout.more_popupwindow, null);
        title_sweep = rootView.findViewById(R.id.title_sweep);
        title_create_community = rootView.findViewById(R.id.title_create_community);
        title_add_community = rootView.findViewById(R.id.title_add_community);
        title_sweep.setOnClickListener(this);
        title_create_community.setOnClickListener(this);
        title_add_community.setOnClickListener(this);
        rl_bg = rootView.findViewById(R.id.rl_bg);
        rl_bg.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                dimiss();
            }
        });
    }
    public void showPopWindow(RelativeLayout goods_classification_popup) {
        mPopWindow = new PopupWindow(rootView, ViewGroup.LayoutParams.MATCH_PARENT,
                ViewGroup.LayoutParams.MATCH_PARENT, true);
       mPopWindow.setBackgroundDrawable(new ColorDrawable());
        // 设置好参数之后再show
        // popupWindow.showAsDropDown(mButton2);  // 默认在mButton2的左下角显示
        rootView.measure(View.MeasureSpec.UNSPECIFIED, View.MeasureSpec.UNSPECIFIED );
        /*
         *7.0 8.0显示PopupWindow偏于位置不正常
         */
        if (Build.VERSION.SDK_INT < 24) {
            int xOffset = goods_classification_popup.getWidth() / 2 - rootView.getMeasuredWidth() / 2;
            mPopWindow.showAsDropDown(goods_classification_popup,xOffset, 0);
        } else {
            // 获取控件的位置，安卓系统>7.0
            int[] location = new int[2];
            goods_classification_popup.getLocationOnScreen(location);
            int x = location[0];
            int y = location[1];
            Rect visibleFrame = new Rect();
            goods_classification_popup.getGlobalVisibleRect(visibleFrame);
            int height = goods_classification_popup.getResources().getDisplayMetrics().heightPixels - visibleFrame.bottom;
            mPopWindow.setHeight(height);
            mPopWindow.showAsDropDown(goods_classification_popup, 0, y);
        }
    }
    public void dimiss(){
        if (mPopWindow == null){
            return;
        }
        mPopWindow.dismiss();
    }
}
