package com.wowo.wowo.Activity;

import android.content.Intent;
import android.content.pm.PackageManager;
import android.graphics.Bitmap;
import android.net.Uri;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import android.view.View;
import android.widget.ImageView;
import android.widget.RelativeLayout;
import android.widget.TextView;
import android.widget.Toast;

import com.bumptech.glide.Glide;
import com.wowo.wowo.Bean.PersonalBean;
import com.wowo.wowo.Bean.UpdateUserInfoBean;
import com.wowo.wowo.Model.UserModel;
import com.wowo.wowo.R;
import com.wowo.wowo.Utils.LogUtil;
import com.wowo.wowo.Utils.PermissionUtils;
import com.wowo.wowo.Utils.PhotoUtils;
import com.wowo.wowo.Utils.SharedPreferencesManager;
import com.wowo.wowo.Utils.UpdatePortrait;
import com.wowo.wowo.Views.Dialog.GroupCodeDialog;
import com.wowo.wowo.Views.Dialog.QrcodePopWindow;
import com.wowo.wowo.rxjava.BaseResponse;
import com.wowo.wowo.rxjava.ProgressSubscriber;
import com.wowo.wowo.rxjava.RetrofitAPIManager;
import com.wowo.wowo.rxjava.SubscriberOnNextListener;

import io.rong.imkit.RongIM;
import io.rong.imlib.model.UserInfo;
import okhttp3.MediaType;
import okhttp3.MultipartBody;
import okhttp3.RequestBody;

/*
 *个人中心
 */
public class PersonalActivity extends AppCompatActivity implements View.OnClickListener{
    ImageView personal_portrait;
    RelativeLayout personal_nickname;
    TextView personal_nickname_tv;
    TextView mTvTitle,personal_id;
    RelativeLayout my_qr_code;//我的二维码
    private UpdatePortrait portrait;
    private PhotoUtils  pu;

    private UserModel model;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_personal);
        model = SharedPreferencesManager.getInstance().getUserData(this);
        LogUtil.e("TAG","用户ID:"+model.getUserId());
        personal_portrait = findViewById(R.id.personal_portrait);
        personal_nickname_tv = findViewById(R.id.personal_nickname_tv);
        personal_nickname = findViewById(R.id.personal_nickname);
        personal_id = findViewById(R.id.personal_id);
        my_qr_code = findViewById(R.id.my_qr_code);
        personal_portrait.setOnClickListener(this);
        personal_nickname.setOnClickListener(this);
        my_qr_code.setOnClickListener(this);
        pu = new PhotoUtils(this);
        portrait = new UpdatePortrait(this,pu);
        mTvTitle = findViewById(R.id.title_layout_tv_title);
        mTvTitle.setText("个人信息");
    }

    public static final int WRITE_EXTERNAL_STORAGE = 0x0022;//读写文件
    @Override
    public void onClick(View view) {
        switch (view.getId()){
            case R.id.personal_nickname:
                //修改昵称
                Intent intent = new Intent(this,NicknameUpdateActivity.class);
                intent.putExtra("name",personal_nickname_tv.getText().toString());
                startActivity(intent);
                break;
            case R.id.personal_portrait:
                //更换头像
                pu.show(getSupportFragmentManager(),"payDetailFragment");
                break;
            case R.id.personal_return:
                finish();
                break;
            case R.id.my_qr_code:
                //我的二维码
                boolean permiss = PermissionUtils.isStoragePermission(this,WRITE_EXTERNAL_STORAGE);
                if (permiss){
                    showCodeDialog(bean.getName(), model.getUserId() ,bean.getUrlPhoto());
                }
                break;
        }
    }
    private void showCodeDialog(String name ,String id,String photo) {
        GroupCodeDialog.Builder dialog = new GroupCodeDialog.Builder(this);
        dialog.create(name, id,photo,"0").show();
    }


    private Bitmap head;// 头像Bitmap
    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        Log.e("TAG","-----------2resultCode:"+resultCode);
        Log.e("TAG","-----------2requestCode:"+requestCode);
        if (resultCode == RESULT_OK) {
            switch (requestCode) {
                //拍照完成回调
                case PhotoUtils.CODE_CAMERA_REQUEST:
                    portrait.Camera();
                    break;
                //访问相册完成回调
                case PhotoUtils.CODE_GALLERY_REQUEST:
                    portrait.Photo(data);
                    break;
                case PhotoUtils.CODE_RESULT_REQUEST:
                    if (portrait.getCropImageUri() == null){
                        Toast.makeText(this,"更换失败3!", Toast.LENGTH_SHORT).show();
                    }
                    head = PhotoUtils.getBitmapFromUri(portrait.getCropImageUri(), this);
                    /**
                     * 上传服务器代码
                     */
                    boolean bo = PhotoUtils.setPicToView(head);// 保存在SD卡中
                    if (!bo) {
                        Toast.makeText(this,"更换失败4!", Toast.LENGTH_SHORT).show();
                        return;
                    }
                    MultipartBody.Part part;
                    RequestBody body;
                    body = RequestBody.create(MediaType.parse("image/jpg"), pu.fileUri);
                    part = MultipartBody.Part.createFormData("photoFile", pu.fileUri.getName(), body);
                    LogUtil.e("TAG","pu.fileUri:"+pu.fileUri.getName());
                    SubscriberOnNextListener listener = new SubscriberOnNextListener<BaseResponse<UpdateUserInfoBean>>() {
                        @Override
                        public void onNext(BaseResponse<UpdateUserInfoBean> baseResponse) {
                            LogUtil.e("TAG","修改成功");
                            personal_portrait.setImageBitmap(head);
                            model.setPhoto(baseResponse.data.toString());
                            SharedPreferencesManager.getInstance().putUserData(PersonalActivity.this, model);
                            RongIM.getInstance().refreshUserInfoCache(new UserInfo(model.getUserId(), model.getName(), Uri.parse(model.getPhoto())));
                        }
                    };
                    RetrofitAPIManager.getInstance().getUpdateUserInfo(new ProgressSubscriber<BaseResponse<UpdateUserInfoBean>>(listener, this, 0), model.getUserId(),"","","","",part);
                    break;
                default:
            }
        }
    }
    @Override
    protected void onResume() {
        super.onResume();
        initData();
    }
    private PersonalBean bean;
    private void initData() {
        //获取用户信息
        SubscriberOnNextListener listener = new SubscriberOnNextListener<BaseResponse<PersonalBean>>() {
            @Override
            public void onNext(BaseResponse<PersonalBean> baseResponse) {
                bean = baseResponse.data;
                personal_nickname_tv.setText(bean.getName());
                personal_id.setText(bean.getUserId());
                LogUtil.e("TAG","获取用户头像:"+bean.getUrlPhoto());
                Glide.with(PersonalActivity.this).load(bean.getUrlPhoto()).into(personal_portrait);
            }
        };
        RetrofitAPIManager.getInstance().getUserInfo(new ProgressSubscriber<BaseResponse<PersonalBean>>(listener, this, 0), model.getUserId());
    }
    @Override
    public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults);
        switch (requestCode) {
            //调用系统相机申请拍照权限回调
            case PhotoUtils.CAMERA_PERMISSIONS_REQUEST_CODE: {
                portrait.CameraCallback(grantResults);
                break;
            }
            //调用系统相册申请Sdcard权限回调
            case PhotoUtils.STORAGE_PERMISSIONS_REQUEST_CODE:
                portrait.PhotoCallback(grantResults);
                break;
            case WRITE_EXTERNAL_STORAGE:
                //读写文件权限---二维码
                if (grantResults[0] == PackageManager.PERMISSION_GRANTED) {
                    showCodeDialog(bean.getName(), model.getUserId() ,bean.getUrlPhoto());
                } else {
                    Toast.makeText(this, "读写文件：如果不允许，你将无法使用二维码功能",Toast.LENGTH_SHORT);
                }
                break;
            default:
        }
    }
}
