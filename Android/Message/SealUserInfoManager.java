package com.wowo.wowo.Message;

import android.content.Context;
import android.content.SharedPreferences;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.os.Handler;
import android.os.HandlerThread;
import android.os.Looper;
import android.text.TextUtils;

import com.wowo.wowo.Message.db.BlackListDao;
import com.wowo.wowo.Message.db.DBManager;
import com.wowo.wowo.Message.db.FriendDao;
import com.wowo.wowo.Message.db.GroupMemberDao;
import com.wowo.wowo.Message.db.Groups;
import com.wowo.wowo.Message.db.GroupsDao;

import java.util.LinkedHashMap;
import java.util.List;

import io.rong.common.RLog;
import io.rong.imkit.RongIM;
import io.rong.imlib.model.Group;
import io.rong.imlib.model.UserInfo;


/**
 * 第一次login时从app server获取数据,之后数据库读,数据的更新使用IMKit里的通知类消息
 * 因为存在app server获取数据失败的情况,代码里有很多这种异常情况的判断处理并重新从app server获取数据
 * 1.add...类接口为插入或更新数据库
 * 2.get...类接口为读取数据库
 * 3.delete...类接口为删除数据库数据
 * 4.sync...为同步接口,因为存在去掉sync相同名称的异步接口,有些同步类接口不带sync
 * 5.fetch...,pull...类接口都是从app server获取数据并存数据库,不同的只是返回值不一样,此类接口全部为private
 */
public class SealUserInfoManager{

    private final static String TAG = "SealUserInfoManager";
    private static final int GET_TOKEN = 800;

    /**
     * 用户信息全部未同步
     */
    private static final int NONE = 0;//00000
    /**
     * 好友信息同步成功
     */
    private static final int FRIEND = 1;//00001
    /**
     * 群组信息同步成功
     */
    private static final int GROUPS = 2;//00010
    /**
     * 群成员信息部分同步成功,n个群组n次访问网络,存在部分同步的情况
     */
    private static final int PARTGROUPMEMBERS = 4;//00100
    /**
     * 群成员信息同步成功
     */
    private static final int GROUPMEMBERS = 8;//01000
    /**
     * 黑名单信息同步成功
     */
    private static final int BLACKLIST = 16;//10000
    /**
     * 用户信息全部同步成功
     */
    private static final int ALL = 27;//11011

    private static SealUserInfoManager sInstance;
    private final Context mContext;
    private DBManager mDBManager;
    private Handler mWorkHandler;
    private HandlerThread mWorkThread;
    static Handler mHandler;
    private SharedPreferences sp;
    private List<Groups> mGroupsList;//同步群组成员信息时需要这个数据
    private int mGetAllUserInfoState;
    private boolean doingGetAllUserInfo = false;
    private FriendDao mFriendDao;
    private GroupsDao mGroupsDao;
    private GroupMemberDao mGroupMemberDao;
    private BlackListDao mBlackListDao;
    private LinkedHashMap<String, UserInfo> mUserInfoCache;
    private LinkedHashMap<String, Group> mGroupCache;

    public static SealUserInfoManager getInstance() {
        return sInstance;
    }

    public SealUserInfoManager(Context context) {
        mContext = context;
        sp = context.getSharedPreferences("config", Context.MODE_PRIVATE);
        mHandler = new Handler(Looper.getMainLooper());
        mGroupsList = null;
    }

    public static void init(Context context) {
        RLog.d(TAG, "SealUserInfoManager init");
        sInstance = new SealUserInfoManager(context);
    }

    /**
     * 修改数据库的存贮路径为.../appkey/userID/,
     * 必须确保userID存在后才能初始化DBManager
     */
    public void openDB() {
        RLog.d(TAG, "SealUserInfoManager openDB");
        if (mDBManager == null || !mDBManager.isInitialized()) {
            mDBManager = DBManager.init(mContext);
            mWorkThread = new HandlerThread("sealUserInfoManager");
            mWorkThread.start();
            mWorkHandler = new Handler(mWorkThread.getLooper());
            mUserInfoCache = new LinkedHashMap<>();
            setUserInfoEngineListener();
        }
        mGetAllUserInfoState = sp.getInt("getAllUserInfoState", 0);
        RLog.d(TAG, "SealUserInfoManager mGetAllUserInfoState = " + mGetAllUserInfoState);
    }

    public void closeDB() {
        RLog.d(TAG, "SealUserInfoManager closeDB");
        if (mDBManager != null) {
            mDBManager.uninit();
            mDBManager = null;
            mFriendDao = null;
            mGroupsDao = null;
            mGroupMemberDao = null;
            mBlackListDao = null;
        }
        if (mWorkThread != null) {
            mWorkThread.quit();
            mWorkThread = null;
            mWorkHandler = null;
        }
        if (mUserInfoCache != null) {
            mUserInfoCache.clear();
            mUserInfoCache = null;
        }
        mGroupsList = null;
    }

    /**
     * kit中提供用户信息的用户信息提供者
     * 1.读缓存
     * 2.读好友数据库
     * 3.读群组成员数据库
     * 4.网络获取
     */
    public void getUserInfo(final String userId) {
        if (TextUtils.isEmpty(userId)) {
            return;
        }
        if (mUserInfoCache != null) {
            UserInfo userInfo = mUserInfoCache.get(userId);
            if (userInfo != null) {
                RongIM.getInstance().refreshUserInfoCache(userInfo);
                return;
            }
        }
//        mWorkHandler.post(new Runnable() {
//            @Override
//            public void run() {
////                UserInfo userInfo;
////                Friend friend = getFriendByID(userId);
////                if (friend != null) {
////                    String name = friend.getName();
////                    if (friend.isExitsDisplayName()) {
////                        name = friend.getDisplayName();
////                    }
////                    userInfo = new UserInfo(friend.getUserId(), name, friend.getPortraitUri());
////                    NLog.d(TAG, "SealUserInfoManager getUserInfo from Friend db " + userId + " "
////                            + userInfo.getName() + " " + userInfo.getPortraitUri());
////                    RongIM.getInstance().refreshUserInfoCache(userInfo);
////                    return;
////                }
////                List<GroupMember> groupMemberList = getGroupMembersWithUserId(userId);
////                if (groupMemberList != null && groupMemberList.size() > 0) {
////                    GroupMember groupMember = groupMemberList.get(0);
////                    userInfo = new UserInfo(groupMember.getUserId(), groupMember.getName(),
////                            groupMember.getPortraitUri());
////                    NLog.d(TAG, "SealUserInfoManager getUserInfo from GroupMember db " + userId + " "
////                            + userInfo.getName() + " " + userInfo.getPortraitUri());
////                    RongIM.getInstance().refreshUserInfoCache(userInfo);
////                    return;
////                }
////                UserInfoEngine.getInstance(mContext).startEngine(userId);
//            }
//        });
    }

    public void getGroupInfo(final String groupsId) {
        if (TextUtils.isEmpty(groupsId)) {
            return;
        }
        if (mGroupCache != null) {
            Group group = mGroupCache.get(groupsId);
            if (group != null) {
                RongIM.getInstance().refreshGroupInfoCache(group);
                return;
            }
        }
//        mWorkHandler.post(new Runnable() {
//            @Override
//            public void run() {
//                Group groupInfo;
//                Groups group = getGroupsByID(groupsId);
//                if (group != null) {
//                    groupInfo = new Group(groupsId, group.getName(), Uri.parse(group.getPortraitUri()));
//                    RongIM.getInstance().refreshGroupInfoCache(groupInfo);
//                    NLog.d(TAG, "SealUserInfoManager getGroupInfo from db " + groupsId + " "
//                            + groupInfo.getName() + " " + groupInfo.getPortraitUri());
//                    return;
//                }
//                GroupInfoEngine.getInstance(mContext).startEngine(groupsId);
//            }
//        });
    }

    /**
     * 需要 rongcloud connect 成功后设置的 listener
     */
    public void setUserInfoEngineListener() {
//        UserInfoEngine.getInstance(mContext).setListener(new UserInfoEngine.UserInfoListener() {
//            @Override
//            public void onResult(UserInfo info) {
//                if (info != null && RongIM.getInstance() != null) {
//                    if (TextUtils.isEmpty(info.getPortraitUri() == null ? null : info.getPortraitUri().toString())) {
//                        info.setPortraitUri(Uri.parse(RongGenerate.generateDefaultAvatar(info.getName(), info.getUserId())));
//                    }
//                    NLog.d(TAG, "SealUserInfoManager getUserInfo from network " + info.getUserId() + " " + info.getName() + " " + info.getPortraitUri());
//                    RongIM.getInstance().refreshUserInfoCache(info);
//                }
//            }
//        });
//        GroupInfoEngine.getInstance(mContext).setmListener(new GroupInfoEngine.GroupInfoListeners() {
//            @Override
//            public void onResult(Group info) {
//                if (info != null && RongIM.getInstance() != null) {
//                    NLog.d(TAG, "SealUserInfoManager getGroupInfo from network " + info.getId() + " " + info.getName() + " " + info.getPortraitUri());
//                    if (TextUtils.isEmpty(info.getPortraitUri() == null ? null : info.getPortraitUri().toString())) {
//                        info.setPortraitUri(Uri.parse(RongGenerate.generateDefaultAvatar(info.getName(), info.getId())));
//                    }
//                    RongIM.getInstance().refreshGroupInfoCache(info);
//                }
//            }
//        });
    }

//    /**
//     * 第一次登录时同步好友,群组,群组成员,黑名单数据
//     */
//    public void getAllUserInfo() {
//        if (!isNetworkConnected())
//            return;
//        if (hasGetAllUserInfo())
//            return;
//        mWorkHandler.post(new Runnable() {
//            @Override
//            public void run() {
//                try {
//                    doingGetAllUserInfo = true;
//                    //在获取用户信息时无论哪一个步骤出错,都不继续往下执行,因为网络出错,很可能再次的网络访问还是有问题
//                    if (needGetAllUserInfo()) {
//                        if (!fetchFriends()) {
//                            setGetAllUserInfoDone();
//                            return;
//                        }
//                        //必须取得群组信息成功时才有必要获取群组成员信息
//                        if (fetchGroups()) {
//                            if (!fetchGroupMembers()) {
//                                setGetAllUserInfoDone();
//                                return;
//                            }
//                        } else {
//                            setGetAllUserInfoDone();
//                            return;
//                        }
//                        fetchBlackList();
//                    } else {
//                        if (!hasGetFriends()) {
//                            if (!fetchFriends()) {
//                                setGetAllUserInfoDone();
//                                return;
//                            }
//                        }
//                        if (!hasGetGroups()) {
//                            if (!fetchGroups()) {
//                                setGetAllUserInfoDone();
//                                return;
//                            }
//                            if (!hasGetAllGroupMembers()) {
//                                if (!fetchGroupMembers()) {
//                                    setGetAllUserInfoDone();
//                                    return;
//                                }
//                            }
//                        }
//                        //部分群组信息同步的情况,此时需要特殊处理,但是目前暂未处理
//                        //// TODO: 16/9/20
//                        if (!hasGetAllGroupMembers()) {
//                            if (hasGetPartGroupMembers()) {
//                                syncDeleteGroupMembers();
//                            }
//                            if (mGroupsList == null) {
//                                mGroupsList = getGroups();
//                            }
//                            fetchGroupMembers();
//                        }
//                        if (!hasGetBlackList()) {
//                            fetchBlackList();
//                        }
//                    }
//                } catch (HttpException e) {
//                    e.printStackTrace();
//                    RLog.d(TAG, "fetchUserInfo occurs HttpException e=" + e.toString() + "mGetAllUserInfoState=" + mGetAllUserInfoState);
//                } catch (Exception e) {
//                    e.printStackTrace();
//                    RLog.d(TAG, "fetchUserInfo occurs Exception e=" + e.toString() + "mGetAllUserInfoState=" + mGetAllUserInfoState);
//                }
//                setGetAllUserInfoDone();
//            }
//        });
//    }

    private void setGetAllUserInfoDone() {
        RLog.d(TAG, "SealUserInfoManager setGetAllUserInfoDone = " + mGetAllUserInfoState);
        doingGetAllUserInfo = false;
        sp.edit().putInt("getAllUserInfoState", mGetAllUserInfoState).apply();
    }

    /**
     * 清除所有用户数据
     * 注意这是个同步函数,目前用到的也是同步场景
     */
    public void deleteAllUserInfo() {
        if (mFriendDao != null) {
            mFriendDao.deleteAll();
        }
        if (mGroupsDao != null) {
            mGroupsDao.deleteAll();
        }
        if (mGroupMemberDao != null) {
            mGroupMemberDao.deleteAll();
        }
        if (mBlackListDao != null) {
            mBlackListDao.deleteAll();
        }
    }






    /**
     * 泛型类，主要用于 API 中功能的回调处理。
     *
     * @param <T> 声明一个泛型 T。
     */
    public static abstract class ResultCallback<T> {

        public static class Result<T> {
            public T t;
        }

        public ResultCallback() {

        }

        /**
         * 成功时回调。
         *
         * @param t 已声明的类型。
         */
        public abstract void onSuccess(T t);

        /**
         * 错误时回调。
         *
         * @param errString 错误提示
         */
        public abstract void onError(String errString);


        public void onFail(final String errString) {
            mHandler.post(new Runnable() {
                @Override
                public void run() {
                    onError(errString);
                }
            });
        }

        public void onCallback(final T t) {
            mHandler.post(new Runnable() {
                @Override
                public void run() {
                    onSuccess(t);
                }
            });
        }
    }


    private boolean needGetAllUserInfo() {
        return mGetAllUserInfoState == NONE;
    }

    private boolean hasGetAllUserInfo() {
        return mGetAllUserInfoState == ALL;
    }

    private boolean hasGetFriends() {
        return (mGetAllUserInfoState & FRIEND) != 0;
    }

    private boolean hasGetGroups() {
        return (mGetAllUserInfoState & GROUPS) != 0;
    }

    private boolean hasGetAllGroupMembers() {
        return ((mGetAllUserInfoState & GROUPMEMBERS) != 0)
                && ((mGetAllUserInfoState & PARTGROUPMEMBERS) == 0);
    }

    private boolean hasGetPartGroupMembers() {
        return ((mGetAllUserInfoState & GROUPMEMBERS) == 0)
                && ((mGetAllUserInfoState & PARTGROUPMEMBERS) != 0);
    }

    private boolean hasGetBlackList() {
        return (mGetAllUserInfoState & BLACKLIST) != 0;
    }

    private void setGetAllUserInfoWithPartGroupMembersState() {
        mGetAllUserInfoState &= ~GROUPMEMBERS;
        mGetAllUserInfoState |= PARTGROUPMEMBERS;
    }

    private void setGetAllUserInfoWtihAllGroupMembersState() {
        mGetAllUserInfoState &= ~PARTGROUPMEMBERS;
        mGetAllUserInfoState |= GROUPMEMBERS;
    }

    private void onCallBackFail(ResultCallback<?> callback) {
        if (callback != null) {
            callback.onFail(null);
        }
    }

    private boolean isNetworkConnected() {
        ConnectivityManager cm = (ConnectivityManager) mContext.getSystemService(Context.CONNECTIVITY_SERVICE);
        NetworkInfo ni = cm.getActiveNetworkInfo();
        return ni != null && ni.isConnectedOrConnecting();
    }

//    /**
//     * app中获取用户头像的接口,此前这部分调用分散在app显示头像的每处代码中,整理写一个方法使app代码更整洁
//     * 这个方法不涉及读数据库,头像空时直接生成默认头像
//     */
//    public String getPortraitUri(UserInfo userInfo) {
//        if (userInfo != null) {
//            if (userInfo.getPortraitUri() != null) {
//                if (TextUtils.isEmpty(userInfo.getPortraitUri().toString())) {
//                    if (userInfo.getName() != null) {
//                        return RongGenerate.generateDefaultAvatar(userInfo);
//                    } else {
//                        return null;
//                    }
//                } else {
//                    return userInfo.getPortraitUri().toString();
//                }
//            } else {
//                if (userInfo.getName() != null) {
//                    return RongGenerate.generateDefaultAvatar(userInfo);
//                } else {
//                    return null;
//                }
//            }
//
//        }
//        return null;
//    }
//
//    public String getPortraitUri(UserInfoBean bean) {
//        if (bean != null) {
//            if (bean.getPortraitUri() != null) {
//                if (TextUtils.isEmpty(bean.getPortraitUri().toString())) {
//                    if (bean.getName() != null) {
//                        return RongGenerate.generateDefaultAvatar(bean.getName(), bean.getUserId());
//                    } else {
//                        return null;
//                    }
//                } else {
//                    return bean.getPortraitUri().toString();
//                }
//            } else {
//                if (bean.getName() != null) {
//                    return RongGenerate.generateDefaultAvatar(bean.getName(), bean.getUserId());
//                } else {
//                    return null;
//                }
//            }
//
//        }
//        return null;
//    }
//
//    public String getPortraitUri(GetGroupInfoResponse groupInfoResponse) {
//        if (groupInfoResponse.getResult() != null) {
//            Groups groups = new Groups(groupInfoResponse.getResult().getId(),
//                    groupInfoResponse.getResult().getName(),
//                    groupInfoResponse.getResult().getPortraitUri());
//            return getPortraitUri(groups);
//        }
//        return null;
//    }
//
//    /**
//     * 获取用户头像,头像为空时会生成默认的头像,此默认头像可能已经存在数据库中,不重新生成
//     * 先从缓存读,再从数据库读
//     */
//    private String getPortrait(Friend friend) {
//        if (friend != null) {
//            if (friend.getPortraitUri() == null || TextUtils.isEmpty(friend.getPortraitUri().toString())) {
//                if (TextUtils.isEmpty(friend.getUserId())) {
//                    return null;
//                } else {
//                    UserInfo userInfo = mUserInfoCache.get(friend.getUserId());
//                    if (userInfo != null) {
//                        if (userInfo.getPortraitUri() != null && !TextUtils.isEmpty(userInfo.getPortraitUri().toString())) {
//                            return userInfo.getPortraitUri().toString();
//                        } else {
//                            mUserInfoCache.remove(friend.getUserId());
//                        }
//                    }
//                    List<GroupMember> groupMemberList = getGroupMembersWithUserId(friend.getUserId());
//                    if (groupMemberList != null && groupMemberList.size() > 0) {
//                        GroupMember groupMember = groupMemberList.get(0);
//                        if (groupMember.getPortraitUri() != null && !TextUtils.isEmpty(groupMember.getPortraitUri().toString()))
//                            return groupMember.getPortraitUri().toString();
//                    }
//                    String portrait = RongGenerate.generateDefaultAvatar(friend.getName(), friend.getUserId());
//                    //缓存信息kit会使用,备注名存在时需要缓存displayName
//                    String name = friend.getName();
//                    if (friend.isExitsDisplayName()) {
//                        name = friend.getDisplayName();
//                    }
//                    userInfo = new UserInfo(friend.getUserId(), name, Uri.parse(portrait));
//                    mUserInfoCache.put(friend.getUserId(), userInfo);
//                    return portrait;
//                }
//            } else {
//                return friend.getPortraitUri().toString();
//            }
//        }
//        return null;
//    }

//    private Uri getPortrait(GroupMember groupMember) {
//        if (groupMember != null) {
//            if (groupMember.getPortraitUri() == null || TextUtils.isEmpty(groupMember.getPortraitUri().toString())) {
//                if (TextUtils.isEmpty(groupMember.getUserId())) {
//                    return null;
//                } else {
//                    UserInfo userInfo = mUserInfoCache.get(groupMember.getUserId());
//                    if (userInfo != null) {
//                        if (userInfo.getPortraitUri() != null && !TextUtils.isEmpty(userInfo.getPortraitUri().toString())) {
//                            return userInfo.getPortraitUri();
//                        } else {
//                            mUserInfoCache.remove(groupMember.getUserId());
//                        }
//                    }
//                    Friend friend = getFriendByID(groupMember.getUserId());
//                    if (friend != null) {
//                        if (friend.getPortraitUri() != null && !TextUtils.isEmpty(friend.getPortraitUri().toString())) {
//                            return friend.getPortraitUri();
//                        }
//                    }
//                    List<GroupMember> groupMemberList = getGroupMembersWithUserId(groupMember.getUserId());
//                    if (groupMemberList != null && groupMemberList.size() > 0) {
//                        GroupMember member = groupMemberList.get(0);
//                        if (member.getPortraitUri() != null && !TextUtils.isEmpty(member.getPortraitUri().toString())) {
//                            return member.getPortraitUri();
//                        }
//                    }
//                    String portrait = RongGenerate.generateDefaultAvatar(groupMember.getName(), groupMember.getUserId());
//                    if (!TextUtils.isEmpty(portrait)) {
//                        userInfo = new UserInfo(groupMember.getUserId(), groupMember.getName(), Uri.parse(portrait));
//                        mUserInfoCache.put(groupMember.getUserId(), userInfo);
//                        return Uri.parse(portrait);
//                    } else {
//                        return null;
//                    }
//                }
//            } else {
//                return groupMember.getPortraitUri();
//            }
//        }
//        return null;
//    }
}
