package com.wowo.wowo.Base;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.text.TextUtils;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import com.wowo.wowo.R;
import com.wowo.wowo.Views.SweetAlert.SweetAlertDialog;


public abstract class BaseFragment extends Fragment {
    /**
     * 当前上下文环境
     */
    protected Activity mActivity;

    /**
     * 缓存Fragment view
     */
    protected View mRootView;
    // 弹出的对话框
    protected SweetAlertDialog pDialog;

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        mActivity = getActivity();

        if (mRootView == null) {
            instanceRootView(inflater);
            findViews();
            init(savedInstanceState);
            initListener();
        }
        /**
         * 缓存的rootView需要判断是否已经被加过parent，如果有parent需要从parent删除，
         * 要不然会发生这个rootview已经有parent的错误。
         */
        ViewGroup parent = (ViewGroup) mRootView.getParent();
        if (parent != null) {
            parent.removeView(mRootView);
        }


        return mRootView;
    }

    /**
     * @Description 初始化视图布局
     */
    protected abstract void instanceRootView(LayoutInflater inflater);

    /**
     * @Description 通过findViewById()获取各个子视图，并做相应的设置
     */
    protected abstract void findViews();

    /**
     * @Description 初始化监听事件
     */
    protected abstract void initListener();

    /**
     * @Description 初始化数据
     */
    protected abstract void init(Bundle savedInstanceState);

    /**
     * 减少每次都要强制转换类型的麻烦
     * @param id
     * @param <T>
     * @return
     */
    protected <T extends View> T findView(int id) {
        return (T) mRootView.findViewById(id);
    }

    /**
     * 当无参数需要传递时，可调用单参的该函数
     * @param pClass
     */
    protected void openActivity(Class<?> pClass) {
        openActivity(pClass, null);
    }

    /**
     * 当无参数需要传递,但有返回结果，可向Bundle传递null
     * @param pClass
     * @param requestCode
     */
    protected void openActivity(Class<?> pClass,int requestCode) {
        openActivity(pClass, null,requestCode);
    }

    /**
     * 传递不带返回值的意图
     * @param pClass
     * @param pBundle
     */
    protected void openActivity(Class<?> pClass, Bundle pBundle) {
        Intent intent = new Intent(getActivity(), pClass);
        if (pBundle != null) {
            intent.putExtras(pBundle);
        }
        startActivity(intent);
    }

    /**
     * 传递带有返回值的activity，简化了意图的代码
     * @param pClass
     * @param pBundle
     * @param requestCode
     */
    protected void openActivity(Class<?> pClass, Bundle pBundle,int requestCode) {
        Intent intent = new Intent(getActivity(), pClass);
        if (pBundle != null) {
            intent.putExtras(pBundle);
        }
        startActivityForResult(intent, requestCode);
    }
    public void showLoading() {

        if(null!=pDialog){
            if(pDialog.isShowing()){
                pDialog.dismiss();
            }
        }else{
            pDialog=new SweetAlertDialog(mActivity);
        }
        pDialog.changeAlertType(SweetAlertDialog.PROGRESS_TYPE);

        pDialog.setTitleText(getString(R.string.loading_string));
        pDialog.show();
    }


    public void showLoading(String msg) {
        if (null != pDialog) {
            if (pDialog.isShowing()) {
                pDialog.dismiss();
            }
        } else {
            pDialog = new SweetAlertDialog(mActivity);
        }
        pDialog.changeAlertType(SweetAlertDialog.PROGRESS_TYPE);
        pDialog.setTitleText(TextUtils.isEmpty(msg) ? getString(R.string.loading_string) : msg);

        pDialog.show();
    }

    public void closeLoading() {
        if(null!=pDialog){
            pDialog.dismiss();
        }
    }
    @Override
    public void onResume() {
        super.onResume();
    }

    @Override
    public void onPause() {
        super.onPause();
    }

    @Override
    public void onDestroy() {
        super.onDestroy();
    }
}
