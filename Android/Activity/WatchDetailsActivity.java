package com.wowo.wowo.Activity;

import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.view.View;
import android.webkit.WebView;
import android.widget.ImageView;
import android.widget.TextView;

import com.wowo.wowo.Base.BaseActivity;
import com.wowo.wowo.Model.FindNewsModelDetails;
import com.wowo.wowo.R;
import com.wowo.wowo.Utils.LogUtil;
import com.wowo.wowo.Views.Dialog.BottomDialog;
import com.wowo.wowo.rxjava.BaseResponse;
import com.wowo.wowo.rxjava.ProgressSubscriber;
import com.wowo.wowo.rxjava.RetrofitAPIManager;
import com.wowo.wowo.rxjava.SubscriberOnNextListener;

/**
 * 看点详情
 */
public class WatchDetailsActivity extends BaseActivity{
    private ImageView img_return;
    private TextView details_title;
    private TextView userName;
    private TextView details_time;
    private TextView details_readnum;
    private ImageView details_share;
    private WebView details_webview;
    private int nId;
    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_watch_details);
        initView();
        Intent intent = getIntent();

        if (intent != null) {
            nId = intent.getIntExtra("nId", 0);
        }
        SubscriberOnNextListener listener = new SubscriberOnNextListener<BaseResponse<FindNewsModelDetails>>() {
            @Override
            public void onNext(BaseResponse<FindNewsModelDetails> baseResponse) {
                if (baseResponse.data.getTitle() == null){
                    details_title.setText("");
                }else {
                    details_title.setText(baseResponse.data.getTitle());
                }
                if (baseResponse.data.getUserName() == null) {
                    userName.setText("");
                }else{
                    userName.setText(baseResponse.data.getUserName());
                }
                if (baseResponse.data.getCreateTime() == null) {
                    details_time.setText("");
                }else {
                    details_time.setText(baseResponse.data.getCreateTime());
                }
                if (baseResponse.data.getReadNum() == 0) {
                    details_readnum.setText("0");
                }else {
                    details_readnum.setText(baseResponse.data.getReadNum()+"");
                }
                if (baseResponse.data.getMainBody() != null) {
                    LogUtil.e("TAG","加载html:"+baseResponse.data.getMainBody());
                    details_webview.getSettings().setDefaultTextEncodingName("UTF-8") ;
                    details_webview.loadDataWithBaseURL(null,baseResponse.data.getMainBody(),"text/html", "utf-8",null);
                }
            }
        };
        RetrofitAPIManager.getInstance().getFindNewsPageDetails(new ProgressSubscriber<BaseResponse<FindNewsModelDetails>>(listener,this,0),nId);
    }

    private void initView() {
        img_return = findView(R.id.img_return);
        details_title = findView(R.id.details_title);
        userName = findView(R.id.userName);
        details_time = findView(R.id.details_time);
        details_readnum = findView(R.id.details_readnum);
        details_webview = findView(R.id.details_webview);
        details_share = findView(R.id.details_share);
        img_return.setOnClickListener(this);
        details_share.setOnClickListener(this);
    }

    @Override
    public void widgetClick(View v) {
        switch (v.getId()){
            case R.id.details_share:
                showShareDialog();
                break;
            case R.id.img_return:
                finish();
                break;
        }
    }
    private void showShareDialog() {
        BottomDialog.Builder dialog = new BottomDialog.Builder(this);
        dialog.create("0","x").show();
    }
}
