package com.wowo.wowo.Activity;

import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.util.Log;
import android.view.View;
import android.widget.CheckBox;
import android.widget.CompoundButton;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import com.lljjcoder.style.citylist.Toast.ToastUtils;
import com.wowo.wowo.Base.BaseActivity;
import com.wowo.wowo.Bean.UpdateUserInfoBean;
import com.wowo.wowo.Model.BannerModel;
import com.wowo.wowo.Model.ConferenceDetailsModel;
import com.wowo.wowo.Model.UserModel;
import com.wowo.wowo.R;
import com.wowo.wowo.Utils.GlideUtils;
import com.wowo.wowo.Utils.ImageCompressionUtils;
import com.wowo.wowo.Utils.LogUtil;
import com.wowo.wowo.Utils.PhotoUtils;
import com.wowo.wowo.Utils.UpdatePortrait;
import com.wowo.wowo.Views.CircleImageView.CircleImageView;
import com.wowo.wowo.Views.Dialog.PhotoSelectDialog;
import com.wowo.wowo.rxjava.BaseResponse;
import com.wowo.wowo.rxjava.ProgressSubscriber;
import com.wowo.wowo.rxjava.RetrofitAPIManager;
import com.wowo.wowo.rxjava.SubscriberOnNextListener;
import  com.wowo.wowo.Utils.SharedPreferencesManager;

import java.io.File;
import java.util.List;

import cn.finalteam.galleryfinal.GalleryFinal;
import cn.finalteam.galleryfinal.model.PhotoInfo;
import io.rong.imkit.RongIM;
import okhttp3.MediaType;
import okhttp3.MultipartBody;
import okhttp3.RequestBody;
import rx.Subscriber;

public class NewGroupActivity extends BaseActivity{
    private final static int REQUEST_CODE_CAMERA = 0;//相机
    private final static int REQUEST_CODE_GALLERY = 1;//相册
    private int mHeadImgName;
    private CheckBox mCbPublic,mCbPrivate;
    private Bundle bundle;
    private TextView mTvTitle,mTvAction;
    private CircleImageView mCihead;
    private EditText mEtIntroduce,mEtName;
    private UserModel userModel;
    String pub = "1";
    MultipartBody.Part part = null;

    private UpdatePortrait portrait;
    private PhotoUtils pu;
    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_newgroup);
        findViews();
        init();
        initListener();
    }
    public void findViews() {
        mTvTitle = findView(R.id.title_layout_tv_title);
        mTvAction = findView(R.id.title_layout_tv_action);
        mCihead = findView(R.id.group_ic_head);
        mEtIntroduce= findView(R.id.group_et_introduce);
        mEtName= findView(R.id.group_et_name);
        mCbPublic= findView(R.id.crew_cb_pub);
        mCbPrivate= findView(R.id.crew_cb_private);
    }
    private void init() {
        pu = new PhotoUtils(this);
        portrait = new UpdatePortrait(this,pu);
        bundle = getIntent().getExtras();
        mTvTitle.setText("信息设置");
        mTvAction.setText("完成");
        userModel = SharedPreferencesManager.getInstance().getUserData(this);
        if (bundle!=null){
            GlideUtils.loadImageView(NewGroupActivity.this,bundle.get("urlphoto").toString(),mCihead);
            mEtName.setText(bundle.getString("name"));
            mEtIntroduce.setText(bundle.getString("brief"));
            if (bundle.getString("pub")!=null){
                pub = bundle.getString("pub");
            }else{
                pub = "1";
            }
            if (pub.equals("0")){
                mCbPublic.setChecked(false);
                mCbPrivate.setChecked(true);
            }else{
                mCbPublic.setChecked(true);
                mCbPrivate.setChecked(false);
            }
        }
    }
    private void initListener() {
        mTvAction.setOnClickListener(this);
        mCihead.setOnClickListener(this);
        mCbPublic.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
                if (isChecked){
                    mCbPrivate.setChecked(false);
                    pub = "1";
                }
            }
        });
        mCbPrivate.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
                if (isChecked){
                    mCbPublic.setChecked(false);
                    pub = "0";
                }
            }
        });
    }
    @Override
    public void widgetClick(View v) {
        switch (v.getId()){
            case R.id.title_layout_tv_action://完成
                final String name = mEtName.getText().toString();
                if (name == null || name.isEmpty()) {
                    showToast("请输入群名");
                    return;
                }
                SubscriberOnNextListener mlistener = new SubscriberOnNextListener<BaseResponse<String>>() {
                    @Override
                    public void onNext(BaseResponse<String> baseResponse) {
                        LogUtil.e("TAG","修改成功");
                        finish();
        }
    };
                if (part!=null){
                    RetrofitAPIManager.getInstance().crewModify(new ProgressSubscriber<BaseResponse<String>>(mlistener,NewGroupActivity.this,0),
                            mEtName.getText().toString(),bundle.getString("cid"),userModel.getUserId(),pub,mEtIntroduce.getText().toString(),part);// 修改群信息
                }else{
                    RetrofitAPIManager.getInstance().crewModify2(new ProgressSubscriber<BaseResponse<String>>(mlistener,NewGroupActivity.this,0),
                            mEtName.getText().toString(),bundle.getString("cid"),userModel.getUserId(),pub,mEtIntroduce.getText().toString());// 修改群信息
                }
//                RetrofitAPIManager.getInstance().crewcreate(new ProgressSubscriber<BaseResponse<String>>
//                        (mlistener,NewGroupActivity.this,0),userModel.getUserId()+"",mEtName.getText().toString());// 新建群
                break;
            case R.id.group_ic_head://群组头像
                //更换头像
                pu.show(getSupportFragmentManager(),"payDetailFragment");
                break;
        }
    }

    private void setImgName(){
        mHeadImgName = (int) (Math.random() * 12345678);
    }

    private Bitmap head;// 头像Bitmap
    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
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
                        return;
                    }
                    head = PhotoUtils.getBitmapFromUri(portrait.getCropImageUri(), this);
                    /** * 上传服务器代码*/
                    boolean bo = PhotoUtils.setPicToView(head);// 保存在SD卡中
                    if (!bo) {
                        Toast.makeText(this,"更换失败4!", Toast.LENGTH_SHORT).show();
                        return;
                    }
                    RequestBody body;
                    body = RequestBody.create(MediaType.parse("image/jpg"), pu.fileUri);
                    part = MultipartBody.Part.createFormData("photoFile", pu.fileUri.getName(), body);
                    LogUtil.e("TAG","pu.fileUri:"+pu.fileUri.getName());
                    mCihead.setImageBitmap(head);
                    break;
                default:
            }
        }
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
            default:
        }
    }
}
