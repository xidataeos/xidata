package com.wowo.wowo.Activity;

import android.Manifest;
import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.graphics.Color;
import android.net.Uri;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentPagerAdapter;
import android.support.v4.view.ViewPager;
import android.text.TextUtils;
import android.util.Log;
import android.view.KeyEvent;
import android.view.View;
import android.view.WindowManager;
import android.widget.ImageView;
import android.widget.RelativeLayout;
import android.widget.TextView;
import android.widget.Toast;

//import com.wowo.wowo.Appliction.wowoAppliction;
import com.lljjcoder.style.citylist.Toast.ToastUtils;
import com.wowo.wowo.Adapter.ConversationListAdapterEx;
import com.wowo.wowo.Appliction.wowoAppliction;
import com.wowo.wowo.Base.BaseActivity;
//import com.wowo.wowo.Message.ConversationListFragment;
//import com.wowo.wowo.Message.SealAppContext;
//import com.wowo.wowo.Message.SystemOrdActivity;
//import com.wowo.wowo.Order.OrderFragment;
//import com.wowo.wowo.Personal.PersonalFragment;
import com.wowo.wowo.Dialog.MorePopupWindow;
import com.wowo.wowo.Fragment.FriendFragment;
import com.wowo.wowo.Fragment.HomepageFragment;
import com.wowo.wowo.Fragment.PersonalFragment;
import com.wowo.wowo.Fragment.NewsFragment;
import com.wowo.wowo.Message.SealAppContext;
import com.wowo.wowo.Model.FriendInfoModel;
import com.wowo.wowo.Model.GroupInfoModel;
import com.wowo.wowo.Model.PicAndNickModel;
import com.wowo.wowo.Model.RongCloudTokenModel;
import com.wowo.wowo.Model.UserModel;
import com.wowo.wowo.R;
//import com.wowo.wowo.Request.HomepageFragment;
import com.wowo.wowo.Utils.BroadcastReceiver.IListener;
import com.wowo.wowo.Utils.BroadcastReceiver.ListenerManager;
import com.wowo.wowo.Utils.Encrypt;
import com.wowo.wowo.Utils.GetResourcesUtil;
import com.wowo.wowo.Utils.LogUtil;
import com.wowo.wowo.Utils.SharedPreferencesManager;
import com.wowo.wowo.Views.NoScrollViewPager;
import com.wowo.wowo.Views.SweetAlert.SweetAlertDialog;
//import com.wowo.wowo.rxjava.BaseResponse;
//import com.wowo.wowo.rxjava.ProgressSubscriber;
//import com.wowo.wowo.rxjava.RetrofitAPIManager;
//import com.wowo.wowo.rxjava.SubscriberOnNextListener;
import com.wowo.wowo.rxjava.BaseResponse;
import com.wowo.wowo.rxjava.ProgressSubscriber;
import com.wowo.wowo.rxjava.RetrofitAPIManager;
import com.wowo.wowo.rxjava.SubscriberOnNextListener;
import com.yanzhenjie.permission.Action;
import com.yanzhenjie.permission.AndPermission;
import com.yanzhenjie.permission.Rationale;
import com.yanzhenjie.permission.RequestExecutor;
import com.yanzhenjie.permission.SettingService;

import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import io.rong.eventbus.EventBus;
import io.rong.imkit.RongIM;
import io.rong.imkit.fragment.ConversationListFragment;
import io.rong.imkit.manager.IUnReadMessageObserver;
import io.rong.imlib.RongIMClient;
import io.rong.imlib.model.Conversation;
import io.rong.imlib.model.Group;
import io.rong.imlib.model.Message;
import io.rong.imlib.model.UserInfo;
import io.rong.message.TextMessage;
import pub.devrel.easypermissions.AfterPermissionGranted;
import pub.devrel.easypermissions.EasyPermissions;

import static com.wowo.wowo.Appliction.wowoAppliction.mContext;



public class HomePageActivity extends BaseActivity implements ViewPager.OnPageChangeListener, IUnReadMessageObserver, IListener ,MorePopupWindow.MoreItme {
    private static final String TAG = HomePageActivity.class.getSimpleName();
    private TextView mTvTitle;
    private ImageView mIvSea,mIvAdd;
    private ImageView mIvHomepage, mIvMsg, mIvNews, mIvMe;
    private TextView mTvHomepage,  mTvMsg, mTvNews, mTvMe,mTvMessNum;
    private io.rong.imkit.fragment.ConversationListFragment mConversationListFragment = null;
    private Conversation.ConversationType[] mConversationsTypes = null;

    private RelativeLayout frtitle_relat;
    public static NoScrollViewPager mViewPager;
    private List<Fragment> mFragment = new ArrayList<>();
    private long mExitTime;//退出时间
    private String connectResultId;
    private String mToken;
    private int mStatus;
    private SweetAlertDialog dialog;
    private UserModel model;
    private FriendInfoModel picAndNickModel;
    private int getDataFlag = 0;
    UserModel userModel;
    private  String TOKEN ="bjpQCZXmZkLeeAxUB5UUkX3drir+Ka+2zJtycD1Egw1pjmXb6eIyLPv3R+U0OoBemTrOZLIUgwv7HJywkOEmvQ==";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        Log.e(TAG, "onCreate: ");
        setContentView(R.layout.activity_main);
        findView();
        init();
//        setAlias();//设置别名
        setRongYun();//设置融云
        Connect();//连接融云服务器
        if (isFirstOpen()) {
            setPermission();//权限申请
        }
        SealAppContext.init(this);
        changeTextViewColor();
        changeSelectedTabState(0);
        initMainViewPager();
    }

    private void init() {
        userModel = SharedPreferencesManager.getInstance().getUserData(this);
        Intent intent = getIntent();
        model = SharedPreferencesManager.getInstance().getUserData(this);
        mIvSea.setOnClickListener(this);
        mIvAdd.setOnClickListener(this);
    }

    private void setPermission() {
        // 申请权限。
        AndPermission.with(this)
                .permission(Manifest.permission.SYSTEM_ALERT_WINDOW)
                .rationale(mRationale)
                .onGranted(new Action() {
                    @Override
                    public void onAction(List<String> permissions) {
                        Log.e("permissions", "onGranted");
                    }
                })
                .onDenied(new Action() {
                    @Override
                    public void onAction(List<String> permissions) {
                        Log.e("permissions", "onDenied");
                        if (AndPermission.hasAlwaysDeniedPermission(HomePageActivity.this, permissions)) {
                            // 这些权限被用户总是拒绝。
                            final SettingService settingService = AndPermission.permissionSetting(mContext);
                            dialog = new SweetAlertDialog(HomePageActivity.this);
                            dialog.setTitleText("权限申请");
                            dialog.setContentText("您需要开启悬浮窗权限!" + "\n" + "否则不能接收到推送!!");
                            dialog.setConfirmText("去设置");
                            dialog.setCancelText("不设置");
                            dialog.setConfirmClickListener(new SweetAlertDialog.OnSweetClickListener() {
                                @Override
                                public void onClick(SweetAlertDialog sweetAlertDialog) {
                                    // 如果用户同意去设置：
                                    settingService.execute();
                                    dialog.dismiss();
                                }
                            });
                            dialog.setCancelClickListener(new SweetAlertDialog.OnSweetClickListener() {
                                @Override
                                public void onClick(SweetAlertDialog sweetAlertDialog) {
                                    // 如果用户不同意去设置：
                                    settingService.cancel();
                                    dialog.dismiss();
                                }
                            });
                            dialog.show();
                        }
                    }
                })
                .start();

    }

    private Rationale mRationale = new Rationale() {
        @Override
        public void showRationale(Context context, List<String> permissions,
                                  RequestExecutor executor) {
            // 这里使用一个Dialog询问用户是否继续授权。
            // 如果用户继续：
            executor.execute();

            // 如果用户中断：
            executor.cancel();
        }
    };

    private void setRongYun() {
        RongIM.getInstance().refreshUserInfoCache(new UserInfo(userModel.getUserId(), userModel.getName(), Uri.parse(userModel.getPhoto())));
        RongIM.getInstance().setGroupInfoProvider(new RongIM.GroupInfoProvider() {
            @Override
            public Group getGroupInfo(final String groupId) {
                SubscriberOnNextListener listener = new SubscriberOnNextListener<BaseResponse<GroupInfoModel>>() {
                    @Override
                    public void onNext(BaseResponse<GroupInfoModel> baseResponse) {
                        GroupInfoModel gModel = baseResponse.data;
                        RongIM.getInstance().refreshGroupInfoCache(new Group(groupId, gModel.getName(), Uri.parse(gModel.getUrlPhoto())));
                    }
                };
                RetrofitAPIManager.getInstance().getCrewS(new ProgressSubscriber<BaseResponse<GroupInfoModel>>(listener,HomePageActivity.this,0),groupId,userModel.getUserId());
                return null;
            }

        }, true);
        RongIM.setUserInfoProvider(new RongIM.UserInfoProvider() {
            @Override
            public UserInfo getUserInfo(final String s) {
                SubscriberOnNextListener mListener = new SubscriberOnNextListener<BaseResponse<FriendInfoModel>>() {
                    @Override
                    public void onNext(BaseResponse<FriendInfoModel> baseResponse) {
                        picAndNickModel = baseResponse.data;
                        RongIM.getInstance().refreshUserInfoCache(new UserInfo(s, picAndNickModel.getName(), Uri.parse(picAndNickModel.getPhoto())));
                        getDataFlag = 1;
                    }
                };
                if (getDataFlag == 0) {
                    RetrofitAPIManager.getInstance().getFriendInfo(new ProgressSubscriber<BaseResponse<FriendInfoModel>>(mListener,HomePageActivity.this,0),userModel.getUserId(),s);
                }
                return null;
            }
        }, true);
    }

//    private void setAlias() {
//        JPushInterface.setAlias(this, model.getUserId(), new TagAliasCallback() {
//            @Override
//            public void gotResult(int i, String s, Set<String> set) {
//                SubscriberOnNextListener mListener = new SubscriberOnNextListener() {
//                    @Override
//                    public void onNext(Object o) {
//                    }
//                };
//                RetrofitAPIManager.getInstance().addJpush(new ProgressSubscriber
//                        <BaseResponse<String>>(mListener, HomePageActivity.this, 0), JPushInterface.getUdid(getApplicationContext()), model.getUserId(), Encrypt.base64(model.getUserId()));
//            }
//        });
//    }

    HomepageFragment homepageFragment;
    NewsFragment newsFragment;
    FriendFragment friendFragment;
    private void initMainViewPager() {
        homepageFragment = new HomepageFragment();
        newsFragment = new NewsFragment();
        frtitle_relat = findView(R.id.frtitle_relat);
        friendFragment = new FriendFragment();
        mViewPager = findView(R.id.main_viewpager);
        mFragment.add(homepageFragment);
//        mFragment.add(conversationList);
        mFragment.add(newsFragment);
        mFragment.add(friendFragment);
        mFragment.add(new PersonalFragment());

        FragmentPagerAdapter fragmentPagerAdapter = new FragmentPagerAdapter(getSupportFragmentManager()) {
            @Override
            public Fragment getItem(int position) {
                return mFragment.get(position);
            }

            @Override
            public int getCount() {
                return mFragment.size();
            }
        };
        mViewPager.setAdapter(fragmentPagerAdapter);
        mViewPager.setOffscreenPageLimit(4);
        mViewPager.setOnPageChangeListener(this);
    }


    /**
     * 判断是否第一次打开APP
     *
     * @return
     */
    private boolean isFirstOpen() {
        SharedPreferences setting = getSharedPreferences("firstopen", 0);
        Boolean user_first = setting.getBoolean("FIRST", true);
        if (user_first) {//第一次
            setting.edit().putBoolean("FIRST", false).commit();
            return true;
        } else {
            return false;
        }
    }

    private void changeSelectedTabState(int position) {
        switch (position) {
            case 0:
                mTvHomepage.setTextColor(GetResourcesUtil.getColor(this, R.color.main_color));
                mIvHomepage.setImageResource(R.mipmap.ic_home_sel);
                mTvTitle.setText("首页");
                mIvSea.setVisibility(View.VISIBLE);
                mIvAdd.setImageResource(R.mipmap.jiahao);
                break;
            case 1:
                mTvNews.setTextColor(GetResourcesUtil.getColor(this, R.color.main_color));
                mIvNews.setImageResource(R.mipmap.ic_news_sel);
                mTvTitle.setText("看点");
                mIvSea.setVisibility(View.VISIBLE);
                mIvAdd.setImageResource(R.mipmap.jiahao);
                break;
            case 2:
                mTvMsg.setTextColor(GetResourcesUtil.getColor(this, R.color.main_color));
                mIvMsg.setImageResource(R.mipmap.ic_friends_sel);
                mTvTitle.setText("朋友");
                mIvSea.setVisibility(View.GONE);
                mIvAdd.setImageResource(R.mipmap.xiaoxi);
                break;
            case 3:
                mTvMe.setTextColor(GetResourcesUtil.getColor(this, R.color.main_color));
                mIvMe.setImageResource(R.mipmap.ic_my_sel);
                mTvTitle.setText("我的");
                mIvSea.setVisibility(View.VISIBLE);
                mIvAdd.setImageResource(R.mipmap.jiahao);
                break;
        }
    }

    private void changeTextViewColor() {
        mIvHomepage.setImageResource(R.mipmap.ic_home);
        mIvMsg.setImageResource(R.mipmap.ic_friends);
        mIvNews.setImageResource(R.mipmap.ic_news);
        mIvMe.setImageResource(R.mipmap.ic_my);
        mTvHomepage.setTextColor(Color.parseColor("#929292"));
        mTvMsg.setTextColor(Color.parseColor("#929292"));
        mTvNews.setTextColor(Color.parseColor("#929292"));
        mTvMe.setTextColor(Color.parseColor("#929292"));
    }

    private void findView() {
        mTvTitle = findView(R.id.title_layout_tv_title);
        mIvSea = findView(R.id.title_layout_iv_sea);
        mIvAdd = findView(R.id.title_layout_iv_add);
        mIvHomepage = findView(R.id.tab_img_homepage);
        mIvNews = findView(R.id.tab_img_news);
        mIvMsg = findView(R.id.tab_img_msg);
        mIvMe = findView(R.id.tab_img_me);
        mTvHomepage = findView(R.id.tab_text_homepage);
        mTvNews = findView(R.id.tab_text_news);
        mTvMsg = findView(R.id.tab_text_msg);
        mTvMe = findView(R.id.tab_text_me);
        mTvMessNum = findView(R.id.home_tv_mesnum);
        mTvMessNum.setVisibility(View.GONE);
    }

    private void Connect() {
//                if (!TextUtils.isEmpty(mToken)) {
                    //连接融云服务器
                    RongIM.connect(model.getRcToken(), new RongIMClient.ConnectCallback() {
                        @Override
                        public void onTokenIncorrect() {
                        }
                        @Override
                        public void onSuccess(final String userid) {
                            Log.d("HomePageActivity", "--onSuccess" + userid);
                            connectResultId = userid;
                            RongIM.setOnReceiveMessageListener(new RongIMClient.OnReceiveMessageListener() {
                                @Override
                                public boolean onReceived(Message message, int i) {
                                    // 输出消息类型。
                                    Log.d("Receive:", message.getObjectName());
                                    // 此处输出判断是否是文字消息，并输出，其他消息同理。
                                    if (message.getContent() instanceof TextMessage) {
                                        final TextMessage textMessage = (TextMessage) message.getContent();
                                        Log.d("onReceived", "Text Message: " + textMessage.getContent());
                                    }
                                    return false;
                                }
                            });

                        }

                        @Override
                        public void onError(RongIMClient.ErrorCode errorCode) {

                        }
                    });
                }
//    }

    long firstClick = 0;
    long secondClick = 0;

    private MorePopupWindow goodsPopupWindow;
    @Override
    public void widgetClick(View v) {
        switch (v.getId()) {
            case R.id.rl_homepage://
                if (mViewPager.getCurrentItem() == 0) {
//                    EventBus.getDefault().post(newsFragment.REFRESH);
                    if (firstClick == 0) {
                        firstClick = System.currentTimeMillis();
                    } else {
                        secondClick = System.currentTimeMillis();
                    }
                    if (secondClick - firstClick > 0 && secondClick - firstClick <= 800) {
                        if (mConversationListFragment != null) {
                            mConversationListFragment.focusUnreadItem();
                        }
                        firstClick = 0;
                        secondClick = 0;
                    } else if (firstClick != 0 && secondClick != 0) {
                        firstClick = 0;
                        secondClick = 0;
                    }
                }
                mViewPager.setCurrentItem(0, false);
                break;
            case R.id.rl_news:
                mViewPager.setCurrentItem(1, false);
                break;
            case R.id.rl_msg:
                mViewPager.setCurrentItem(2, false);
//                EventBus.getDefault().post(HomepageFragment.REFRESH);
                break;
            case R.id.rl_me:
                mViewPager.setCurrentItem(3, false);
                break;
            case R.id.title_layout_iv_sea :
                openActivity(SearchActivity.class);
                break ;
            case R.id.title_layout_iv_add :
                //更多
                if (mViewPager.getCurrentItem()==2){
                    openActivity(SysMessageActivity.class);
                }else{
                    goodsPopupWindow = new MorePopupWindow(this);
                    goodsPopupWindow.setMoreItme(this);
                    goodsPopupWindow.showPopWindow(frtitle_relat);
                }
                break ;
        }
    }

    @Override
    protected void onNewIntent(Intent intent) {
        super.onNewIntent(intent);
        if (intent.getBooleanExtra("systemconversation", false)) {
            mViewPager.setCurrentItem(1, false);
        }
    }

    @Override
    public void onPageScrolled(int position, float positionOffset, int positionOffsetPixels) {

    }

    @Override
    public void onPageSelected(int position) {
        changeTextViewColor();
        changeSelectedTabState(position);
    }

    @Override
    protected void onDestroy() {
        RongIM.getInstance().removeUnReadMessageCountChangedObserver(this);
        ListenerManager.getInstance().unRegisterListener(this);//注销广播
        super.onDestroy();
    }

    @Override
    public void onPageScrollStateChanged(int state) {

    }

    @Override
    protected void onStart() {
        super.onStart();
        ListenerManager.getInstance().registerListener(this);
        RongIM.getInstance().addUnReadMessageCountChangedObserver(this, Conversation.ConversationType.PRIVATE,
                Conversation.ConversationType.GROUP, Conversation.ConversationType.SYSTEM);
    }

    @Override
    public void onCountChanged(int i) { //未读消息？？？
//        LogUtil.e("onCountChanged     " , i +"");
//        if (i>0){
//            mTvMessNum.setText(i+"");
//        }else{
//            mTvMessNum.setVisibility(View.GONE);
//        }
    }

    @Override
    public boolean onKeyDown(int keyCode, KeyEvent event) {
        if (keyCode == KeyEvent.KEYCODE_BACK
                && event.getAction() == KeyEvent.ACTION_DOWN) {
            if ((System.currentTimeMillis() - mExitTime) > 2000) {
                Toast.makeText(getApplicationContext(), "再按一次退出程序！",
                        Toast.LENGTH_SHORT).show();
                mExitTime = System.currentTimeMillis();
            } else {
                wowoAppliction.getInstance().destory();
            }
            return true;
        }
        return super.onKeyDown(keyCode, event);
    }

    @Override
    public void notifyAllActivity(String type, String value) {
        if (type != null) {
            if (type.equals("gohome")) {
                mViewPager.setCurrentItem(Integer.parseInt(value), false);
            }
        }
    }

    @Override
    public void moreItemClick(int position) {
        if (goodsPopupWindow != null){
            goodsPopupWindow.dimiss();
        }
        if (position == 0){
            cameraTask();
        }if (position==1){
            Bundle bundle = new Bundle();
            bundle.putInt("isshow",1);
            openActivity(FriendListActivity.class,bundle);
        } if (position==2){
            Bundle bundle = new Bundle();
            openActivity(SearchActivity.class,bundle);
        }else{
            goodsPopupWindow.dimiss();
        }
    }
    @AfterPermissionGranted(1)
    public void cameraTask() {
        if (hasCameraPermission()) {
            // Have permission, do the thing!
            //Toast.makeText(getActivity(), "待办事项:相机的事情", Toast.LENGTH_LONG).show();
            startActivity(new Intent(this, SecondActivity.class));
        } else {
            // Ask for one permission
            EasyPermissions.requestPermissions(
                    this,
                    getString(R.string.rationale_camera),
                    1,
                    Manifest.permission.CAMERA);
        }
    }
    private boolean hasCameraPermission() {
        return EasyPermissions.hasPermissions(this, Manifest.permission.CAMERA);
    }
    public static int requestCode;
    public static int resultCode;
    public static Intent data;

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (resultCode == RESULT_OK) {
            //new PersonalFragment().onActivityResultt(this,requestCode, resultCode, data);
            Intent mIntent = new Intent("photo");
            this.requestCode = requestCode;
            this.resultCode = resultCode;
            this.data = data;
            sendBroadcast(mIntent);
        }
    }

}
