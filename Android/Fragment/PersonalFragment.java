package com.wowo.wowo.Fragment;

import android.app.Activity;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.pm.PackageManager;
import android.graphics.Bitmap;
import android.net.Uri;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;
import android.widget.Toast;

import com.bumptech.glide.Glide;
import com.wowo.wowo.Activity.HomePageActivity;
import com.wowo.wowo.Activity.InviteCodeActivity;
import com.wowo.wowo.Activity.MessageRemindActivity;
import com.wowo.wowo.Activity.MyEggsActivity;
import com.wowo.wowo.Activity.MyWalletActivity;
import com.wowo.wowo.Activity.PersonalActivity;
import com.wowo.wowo.Base.BaseFragment;
import com.wowo.wowo.Bean.PersonalBean;
import com.wowo.wowo.Bean.UpdateUserInfoBean;
import com.wowo.wowo.Model.UserModel;
import com.wowo.wowo.R;
import com.wowo.wowo.Utils.CommonUtils;
import com.wowo.wowo.Utils.LogUtil;
import com.wowo.wowo.Utils.PermissionUtils;
import com.wowo.wowo.Utils.PhotoUtils;
import com.wowo.wowo.Utils.SharedPreferencesManager;
import com.wowo.wowo.Utils.UpdatePortrait;
import com.wowo.wowo.Views.Dialog.ExitLoginPWindow;
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


public class PersonalFragment extends BaseFragment implements View.OnClickListener {
    private TextView my_name;
    private ImageView my_portrait;//头像
    private TextView my_invite_code;//我的邀请码
    private TextView my_qr_code;//我的二维码
    private TextView my_wallet;//我的钱包
    private Button my_exit_login;//退出登录
    private LinearLayout my_personal;
    private ExitLoginPWindow pWindow;
    private TextView my_id;//用户ID
    private ImageView my_sex_img;//性别
    private RelativeLayout my_eggs;//我的彩蛋
    private TextView my_message_remind;//消息提醒

    private UserModel model;
    private Bundle bundle;
    private UpdatePortrait portrait;
    private PhotoUtils pu;
    private PersonalBean bean;//用户信息实体类
    private HomePageActivity homePageActivity;
    private Activity mContext;
    @Override
    protected void instanceRootView(LayoutInflater inflater) {
        mRootView = inflater.inflate(R.layout.fragment_personal, null);
    }

    @Override
    protected void findViews() {
        my_name = findView(R.id.my_name);
        my_portrait = findView(R.id.my_portrait);
        my_personal = findView(R.id.my_personal);
        my_invite_code = findView(R.id.my_invite_code);
        my_invite_code.setVisibility(View.GONE);//我的邀请码
        my_qr_code = findView(R.id.my_qr_code);
        my_wallet = findView(R.id.my_wallet);
        my_wallet.setVisibility(View.GONE);//我的钱包
        my_exit_login = findView(R.id.my_exit_login);
        my_id = findView(R.id.my_id);
        my_sex_img = findView(R.id.my_sex_img);
        my_eggs = findView(R.id.my_eggs);
        my_eggs.setVisibility(View.GONE);//我的彩蛋
        my_message_remind = findView(R.id.my_message_remind);
        this.mContext = getActivity();
    }

    @Override
    protected void initListener() {
        my_portrait.setOnClickListener(this);
        my_personal.setOnClickListener(this);
        my_invite_code.setOnClickListener(this);
        my_qr_code.setOnClickListener(this);
        my_wallet.setOnClickListener(this);
        my_exit_login.setOnClickListener(this);
        my_eggs.setOnClickListener(this);
        my_message_remind.setOnClickListener(this);
        pu = new PhotoUtils(getActivity());
        portrait = new UpdatePortrait(getActivity(),pu);
    }

    @Override
    protected void init(Bundle savedInstanceState) {
        model = SharedPreferencesManager.getInstance().getUserData(getActivity());
        bundle = new Bundle();
        bundle.putString("userId", model.getUserId());
        bundle.putString("type", "0");
    }

    private void initData() {
        LogUtil.e("TAG","userID--------->"+model.getUserId());
        //获取用户信息
        SubscriberOnNextListener listener = new SubscriberOnNextListener<BaseResponse<PersonalBean>>() {
            @Override
            public void onNext(BaseResponse<PersonalBean> baseResponse) {
                bean = baseResponse.data;
                my_name.setText(bean.getName());
                my_id.setText("id:"+bean.getUserId());
                if (bean.getSex() == 0){
                    //女
                    my_sex_img.setImageResource(R.mipmap.girl);
                }else if (bean.getSex() == 1){
                    //男
                    my_sex_img.setImageResource(R.mipmap.boy);
                }
                LogUtil.e("TAG","获取用户头像:"+bean.getUrlPhoto());
                Glide.with(getActivity()).load(bean.getUrlPhoto()).into(my_portrait);
            }
        };
        RetrofitAPIManager.getInstance().getUserInfo(new ProgressSubscriber<BaseResponse<PersonalBean>>(listener, getActivity(), 0), model.getUserId());

        // 注册广播
        registerBoradcastReceiver();
    }
    public void registerBoradcastReceiver() {
        IntentFilter myIntentFilter = new IntentFilter();
        myIntentFilter.addAction("photo");
        // 注册广播
        getActivity().registerReceiver(mBroadcastReceiver, myIntentFilter);
    }
    private BroadcastReceiver mBroadcastReceiver = new BroadcastReceiver() {
        @Override
        public void onReceive(Context context, Intent intent) {
            String action = intent.getAction();
            if (action.equals("photo")) {
                onActivityResult(HomePageActivity.requestCode,HomePageActivity.resultCode,HomePageActivity.data);
            }
        }
    };
    private Bitmap head;// 头像Bitmap

    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        Log.e("TAG","-----------1resultCode:"+resultCode);
        Log.e("TAG","-----------1requestCode:"+requestCode);
        if (resultCode == mContext.RESULT_OK) {
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
                    if (portrait.getCropImageUri() == null) {
                        CommonUtils.Toastshow("更换失败3!");
                        return;
                    }
                    Log.e("TAG","---------相册选中回调1:"+portrait.getCropImageUri());
                    head = PhotoUtils.getBitmapFromUri(portrait.getCropImageUri(), mContext);
                    /**
                     * 上传服务器代码
                     */
                    boolean bo = PhotoUtils.setPicToView(head);// 保存在SD卡中
                    if (!bo) {
                        Toast.makeText(mContext, "更换失败4!", Toast.LENGTH_SHORT).show();
                        return;
                    }
                    MultipartBody.Part part;
                    RequestBody body;
                    body = RequestBody.create(MediaType.parse("image/jpg"), pu.fileUri);
                    part = MultipartBody.Part.createFormData("photoFile", pu.fileUri.getName(), body);
                    LogUtil.e("TAG", "pu.fileUri:" + pu.fileUri.getName());
                    SubscriberOnNextListener listener = new SubscriberOnNextListener<BaseResponse<UpdateUserInfoBean>>() {
                        @Override
                        public void onNext(BaseResponse<UpdateUserInfoBean> baseResponse) {
                            LogUtil.e("TAG", "修改成功");
                            //my_portrait.setImageBitmap(head);
                            initData();
                            model.setPhoto(baseResponse.data.toString());
                            SharedPreferencesManager.getInstance().putUserData(mContext, model);
                            RongIM.getInstance().refreshUserInfoCache(new UserInfo(model.getUserId(), model.getName(), Uri.parse(model.getUrlPhoto())));
                        }
                    };
                    RetrofitAPIManager.getInstance().getUpdateUserInfo(new ProgressSubscriber<BaseResponse<UpdateUserInfoBean>>(listener, mContext, 0), model.getUserId(), "", "", "", "", part);
                    break;
                default:
            }
        }
    }



    @Override
    public void onResume() {
        super.onResume();
        initData();
    }
    private QrcodePopWindow popWindow;
    @Override
    public void onClick(View view) {
        switch (view.getId()){
            case R.id.my_eggs:
                //我的彩蛋
                startActivity(new Intent(getActivity(), MyEggsActivity.class));
                break;
            case R.id.my_invite_code:
                //我的邀请码
                //showShareDialog();
                Intent intent = new Intent(getActivity(), InviteCodeActivity.class);
                intent.putExtra("invitationCode",bean.getInvitationCode());
                intent.putExtra("userId", model.getUserId());
                startActivity(intent);
                break;
            case R.id.my_qr_code:
                //我的二维码
                boolean permiss = PermissionUtils.isStoragePermission(getActivity(),WRITE_EXTERNAL_STORAGE);
                if (permiss){
                    showCodeDialog(bean.getName(), model.getUserId() ,bean.getUrlPhoto());
 //                   popWindow = new QrcodePopWindow(getActivity(),model.getUserId(),"0");
//                    popWindow.showPopWindow();
                }
                break;
            case R.id.my_wallet:
                //我的钱包
                startActivity(new Intent(getActivity(), MyWalletActivity.class));
                break;
            case R.id.my_portrait:
                //更换头像
                pu.show(getActivity().getSupportFragmentManager(),"payDetailFragment");
                break;
            case R.id.my_exit_login:
                pWindow = new ExitLoginPWindow(getActivity());
                pWindow.showPopWindow();
                break;
            case R.id.my_personal:
                //个人中心
                startActivity(new Intent(getActivity(), PersonalActivity.class));
                break;
            case R.id.my_message_remind:
                //消息提醒
                startActivity(new Intent(getActivity(), MessageRemindActivity.class));
                break;
        }
    }
    private  GroupCodeDialog.Builder dialog;
    private void showCodeDialog(String name ,String id,String photo) {
        dialog = new GroupCodeDialog.Builder(getActivity());
        dialog.create(name, id,photo,"0").show();
    }
    public static final int WRITE_EXTERNAL_STORAGE = 0x0022;//读写文件
    @Override
    public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
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
                if (grantResults[0] == PackageManager.PERMISSION_GRANTED) {
//                    popWindow = new QrcodePopWindow(getActivity(),model.getUserId(),"0");
//                    popWindow.showPopWindow();
                    showCodeDialog(bean.getName(), model.getUserId() ,bean.getUrlPhoto());
                } else {
                    Toast.makeText(getActivity(), "读写文件：如果不允许，你将无法使用二维码功能",Toast.LENGTH_SHORT);
                }
                break;
            default:
                super.onRequestPermissionsResult(requestCode, permissions, grantResults);
                break;
        }
    }

}
