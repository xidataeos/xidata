package com.wowo.wowo.Activity;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.view.View;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

import com.wowo.wowo.Bean.UpdateUserInfoBean;
import com.wowo.wowo.Model.UserModel;
import com.wowo.wowo.R;
import com.wowo.wowo.Utils.LogUtil;
import com.wowo.wowo.Utils.SharedPreferencesManager;
import com.wowo.wowo.rxjava.BaseResponse;
import com.wowo.wowo.rxjava.ProgressSubscriber;
import com.wowo.wowo.rxjava.RetrofitAPIManager;
import com.wowo.wowo.rxjava.SubscriberOnNextListener;

import okhttp3.MultipartBody;

public class NicknameUpdateActivity extends Activity implements View.OnClickListener{
    TextView mTvTitle,nickname_save;//保存
    EditText nickname_edittext;
    private UserModel model;
    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_nickname);
        model = SharedPreferencesManager.getInstance().getUserData(this);
        nickname_save = findViewById(R.id.title_layout_tv_action);
        nickname_edittext = findViewById(R.id.nickname_edittext);
        mTvTitle = findViewById(R.id.title_layout_tv_title);
        mTvTitle.setText("修改昵称");
        nickname_save.setText("保存");
        nickname_save.setOnClickListener(this);
        Intent intent = getIntent();
        String name = intent.getStringExtra("name");
        if (!name.isEmpty()){
            nickname_edittext.setText(name);
        }
    }

    @Override
    public void onClick(View view) {
        switch (view.getId()){
            case R.id.title_layout_tv_action:
                if (nickname_edittext.getText().toString().isEmpty()){
                    Toast.makeText(this,"请输入新的昵称", Toast.LENGTH_SHORT).show();
                    return;
                }
               SubscriberOnNextListener listener = new SubscriberOnNextListener<BaseResponse<UpdateUserInfoBean>>() {
                    @Override
                    public void onNext(BaseResponse<UpdateUserInfoBean> baseResponse) {
                        LogUtil.e("TAG","修改成功");
                        finish();
                    }
                };
                RetrofitAPIManager.getInstance().getUpdateUserInfo2(new ProgressSubscriber<BaseResponse<UpdateUserInfoBean>>(listener, this, 0), model.getUserId(),nickname_edittext.getText().toString(),"","","");
                break;
        }
    }
}
