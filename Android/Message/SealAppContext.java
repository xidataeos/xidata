package com.wowo.wowo.Message;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.support.v4.content.LocalBroadcastManager;
import android.util.Log;
import android.view.View;

import com.lljjcoder.style.citylist.Toast.ToastUtils;
import com.wowo.wowo.Activity.FriendsDetailsActivity;
import com.wowo.wowo.Activity.HomePageActivity;
import com.wowo.wowo.Activity.LoginActivity;
import com.wowo.wowo.Base.BaseActivity;
import com.wowo.wowo.Model.UserModel;
import com.wowo.wowo.Utils.LogUtil;
import com.wowo.wowo.Utils.SharedPreferencesManager;
import com.wowo.wowo.Views.Dialog.ToastDialog;
import com.wowo.wowo.Views.Dialog.WarningDialog;

import java.util.ArrayList;
import java.util.List;

import io.rong.imkit.DefaultExtensionModule;
import io.rong.imkit.IExtensionModule;
import io.rong.imkit.RongExtensionManager;
import io.rong.imkit.RongIM;
import io.rong.imkit.model.GroupUserInfo;
import io.rong.imkit.model.UIConversation;
import io.rong.imlib.RongIMClient;
import io.rong.imlib.model.Conversation;
import io.rong.imlib.model.Group;
import io.rong.imlib.model.Message;
import io.rong.imlib.model.UserInfo;


public class SealAppContext implements RongIM.ConversationListBehaviorListener,
        RongIMClient.OnReceiveMessageListener,
        RongIM.GroupInfoProvider,
        RongIM.GroupUserInfoProvider,
        RongIM.LocationProvider,
        RongIMClient.ConnectionStatusListener,
        RongIM.ConversationBehaviorListener,
        RongIM.IGroupMembersProvider {
    private static final int CLICK_CONVERSATION_USER_PORTRAIT = 1;


    private final static String TAG = "SealAppContext";
    public static final String UPDATE_FRIEND = "update_friend";
    public static final String UPDATE_RED_DOT = "update_red_dot";
    public static final String UPDATE_GROUP_NAME = "update_group_name";
    public static final String UPDATE_GROUP_MEMBER = "update_group_member";
    public static final String GROUP_DISMISS = "group_dismiss";

    private Context mContext;

    private static SealAppContext mRongCloudInstance;

    private RongIM.LocationProvider.LocationCallback mLastLocationCallback;

    private static ArrayList<Activity> mActivities;

    private Bundle bundle;

    private UserModel userModel;
    public SealAppContext(Context mContext) {
        this.mContext = mContext;
        initListener();
        mActivities = new ArrayList<>();
    }

    /**
     * 初始化 RongCloud.
     *
     * @param context 上下文。
     */
    public static void init(Context context) {

        if (mRongCloudInstance == null) {
            synchronized (SealAppContext.class) {

                if (mRongCloudInstance == null) {
                    mRongCloudInstance = new SealAppContext(context);
                }
            }
        }

    }
    /**
     * 获取RongCloud 实例。
     *
     * @return RongCloud。
     */
    public static SealAppContext getInstance() {
        return mRongCloudInstance;
    }

    public Context getContext() {
        return mContext;
    }
    /**
     * init 后就能设置的监听
     */
    private void initListener() {
        RongIM.setConversationBehaviorListener(this);//设置会话界面操作的监听器。
        RongIM.setConversationListBehaviorListener(this);
        RongIM.setConnectionStatusListener(this);
        RongIM.setGroupInfoProvider(this, true);
        RongIM.setLocationProvider(this);//设置地理位置提供者,不用位置的同学可以注掉此行代码
        setInputProvider();
//        setUserInfoEngineListener();//移到SealUserInfoManager
        setReadReceiptConversationType();
        RongIM.getInstance().enableNewComingMessageIcon(true);
        RongIM.getInstance().enableUnreadMessageIcon(true);
        RongIM.getInstance().setGroupMembersProvider(this);
        RongIM.setGroupUserInfoProvider(this, true);//seal
    }
    private void setReadReceiptConversationType() {
        Conversation.ConversationType[] types = new Conversation.ConversationType[]{
                Conversation.ConversationType.PRIVATE,
                Conversation.ConversationType.GROUP,
                Conversation.ConversationType.SYSTEM,
                Conversation.ConversationType.DISCUSSION
        };
        RongIM.getInstance().setReadReceiptConversationTypeList(types);
    }
    private void setInputProvider() {
        RongIM.setOnReceiveMessageListener(this);
        List<IExtensionModule> moduleList = RongExtensionManager.getInstance().getExtensionModules();
        IExtensionModule defaultModule = null;
        if (moduleList != null) {
            for (IExtensionModule module : moduleList) {
                if (module instanceof DefaultExtensionModule) {
                    defaultModule = module;
                    break;
                }
            }
            if (defaultModule != null) {
                RongExtensionManager.getInstance().unregisterExtensionModule(defaultModule);
                RongExtensionManager.getInstance().registerExtensionModule(new SealExtensionModule());
            }
        }
    }

    @Override
    public boolean onUserPortraitClick(Context context, Conversation.ConversationType conversationType, UserInfo userInfo) {
        bundle = new Bundle();
        userModel = SharedPreferencesManager.getInstance().getUserData(getContext());
        bundle.putString("uid", userInfo.getUserId()+"");
       if (conversationType.getName().equals("private")&&!userInfo.getUserId().equals(userModel.getUserId())) { //点自己头像不处理
           ((BaseActivity) context).openActivity(FriendsDetailsActivity.class, bundle);
       }
        return true;
    }

    @Override
    public boolean onUserPortraitLongClick(Context context, Conversation.ConversationType conversationType, UserInfo userInfo) {
        return false;
    }

    @Override
    public boolean onMessageClick(Context context, View view, Message message) {
        //点击消息处理事件， message.getContent() 获得消息内容
//        if (message.getContent() instanceof UserTextMsgMessage) { //用户的审核消息
//            UserTextMsgMessage userTextMsgMessage = (UserTextMsgMessage) message.getContent();
//            intent = new Intent();
//            openActivity(intent, BaiDuLocationDetailActivity.class);
//        }
        return false;
    }

    @Override
    public boolean onMessageLinkClick(Context context, String s) {
        return false;
    }

    @Override
    public boolean onMessageLongClick(Context context, View view, Message message) {
        return false;
    }

    @Override
    public boolean onConversationPortraitClick(Context context, Conversation.ConversationType conversationType, String s) {
        bundle = new Bundle();
        bundle.putString("uid", s);
        if (conversationType.getName().equals("private")){
            ((BaseActivity)context).openActivity(FriendsDetailsActivity.class,bundle);
        }else{
//            bundle.putString("CrewId",);
//            ((BaseActivity)context).openActivity(GroupDetailsActivity.class,bundle);
        }
        return true;
    }

    @Override
    public boolean onConversationPortraitLongClick(Context context, Conversation.ConversationType conversationType, String s) {
        return false;
    }

    @Override
    public boolean onConversationLongClick(Context context, View view, UIConversation uiConversation) {
        return false;
    }

    @Override
    public boolean onConversationClick(Context context, View view, UIConversation uiConversation) {
        //消息item点击
       // uiConversation.
        return false;
    }

    @Override
    public Group getGroupInfo(String s) {
        return null;
    }

    @Override
    public GroupUserInfo getGroupUserInfo(String s, String s1) {
        return null;
    }

    @Override
    public void getGroupMembers(String s, RongIM.IGroupMemberCallback iGroupMemberCallback) {
            LogUtil.e("TAG","红包:"+s);
        /**
         * 进入我的钱包页面
         * @param activity :从哪个activity的跳转
         */
        //JrmfClient.intentWallet(Activity activity);
    }

    @Override
    public void onStartLocation(Context context, LocationCallback locationCallback) {

    }

    @Override
    public void onChanged(ConnectionStatus connectionStatus) {
        switch (connectionStatus){
            case CONNECTED://连接成功。
                break;
            case DISCONNECTED://断开连接。
                break;
            case CONNECTING://连接中。
                break;
            case NETWORK_UNAVAILABLE://网络不可用。
                break;
            case KICKED_OFFLINE_BY_OTHER_CLIENT://用户账户在其他设备登录，本机会被踢掉线
                ToastUtils.showShortToast(mContext,"用户账户在其他设备登录");
//                ToastDialog.Builder dialog = new ToastDialog.Builder(mContext);
//                    dialog.create("用户账户在其他设备登录").show();
//                    dialog.setOnSureClickListener(new ToastDialog.Builder.OnSureClickListener() {
//                        @Override
//                        public void onClick() {
//                            ((BaseActivity)mContext).openActivity(LoginActivity.class);
//                            LocalBroadcastManager.getInstance(mContext).sendBroadcast(new Intent().setAction("unregister.account"));
//                            SharedPreferencesManager.getInstance().out(mContext,SharedPreferencesManager.SP_FILE_USER);
//                            System.exit(0);
//                        }
//                    });
                break;
    }
    }

    @Override
    public boolean onReceived(Message message, int i) {
        return false;
    }
    public void pushActivity(Activity activity) {
        mActivities.add(activity);
    }
    public void popAllActivity() {
        try {
            if (HomePageActivity.mViewPager != null) {
                HomePageActivity.mViewPager.setCurrentItem(2);
            }
            for (Activity activity : mActivities) {
                if (activity != null) {
                    activity.finish();
                }
            }
            mActivities.clear();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    public void popActivity(Activity activity) {
        if (mActivities.contains(activity)) {
            activity.finish();
            mActivities.remove(activity);
        }
    }
}
