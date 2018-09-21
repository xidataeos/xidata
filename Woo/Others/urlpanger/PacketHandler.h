//
//  PacketHander.h
//  Five_D_walletApp
//
//  Created by apple on 16/3/24.
//  Copyright © 2016年 wqf. All rights reserved.
//

#import <Foundation/Foundation.h>
/*获取短信验证码接口*/
FOUNDATION_EXPORT           NSString *const getMessageurl;

//crew/hotCrew
/*热门社群接口*/
FOUNDATION_EXPORT           NSString *const getHotgroupsRequrl;

/*看点页数据接口*/
FOUNDATION_EXPORT           NSString *const getWatcRequrl;
/*看点的第二页详情数据接口*/
FOUNDATION_EXPORT           NSString *const getWatcdetailRequrl;

/*获取好友列表接口*/
FOUNDATION_EXPORT           NSString *const getfriendlistRequrl;
/*发起好友验证*/
FOUNDATION_EXPORT           NSString *const invitefriendlistRequrl;

/*通过好友验证*/
FOUNDATION_EXPORT           NSString *const addfriendlistRequrl;

/*获取好友关系*/
FOUNDATION_EXPORT           NSString *const getfriendRelationshipRequrl;

/*删除好友关系*/
FOUNDATION_EXPORT           NSString *const deletefriendRelationshipRequrl;

/*修改好友备注好友关系*/
FOUNDATION_EXPORT           NSString *const nickFnameRequrl;

/*创建群组*/
FOUNDATION_EXPORT           NSString *const CreatGroupRequrl;

/*创建群组并邀请好友入群*/
FOUNDATION_EXPORT           NSString *const CreatGroupandInvateRequrl;

/*邀请好友入群*/
FOUNDATION_EXPORT           NSString *const GroupInvateFriendsRequrl;

/*入群通过验证*/
FOUNDATION_EXPORT           NSString *const PassGroupInvateRequrl;

/*发送加群请求*/
FOUNDATION_EXPORT           NSString *const SendJoinGroupRequrl;

/*用户所有加入群组列表*/
FOUNDATION_EXPORT           NSString *const MGroupsListRequrl;

/*群组 的成员列表*/
FOUNDATION_EXPORT           NSString *const GroupsMembersRequrl;

/*用户退出群或者被踢出群组*/
FOUNDATION_EXPORT           NSString *const DeleteGroupsMembersRequrl;

/*解散群组*/
FOUNDATION_EXPORT           NSString *const DeletesomeGroup;

/*根据群号查找群组*/
FOUNDATION_EXPORT           NSString *const SearchSomeGroup;

/*修改群组信息*/
FOUNDATION_EXPORT           NSString *const Modifythegroup;


/*注册页验证码发送*/
FOUNDATION_EXPORT           NSString *const RegistTelCode;

/*手机新用户注册*/
FOUNDATION_EXPORT           NSString *const RegistNewUser;

/*手机用户登录*/
FOUNDATION_EXPORT           NSString *const LoginUrl;

/*首页会议列表分页*/
FOUNDATION_EXPORT           NSString *const HomeMeetingUrl;

/*根据会议ID获取会议详情页*/
FOUNDATION_EXPORT           NSString *const HomeMeetingDetailUrl;

/*根据用户ID和会议ID获取报名信息*/
FOUNDATION_EXPORT           NSString *const HomeMeetingDetailRegist;

/*会议轮播图列表*/
FOUNDATION_EXPORT           NSString *const HomeMeetingCycUrl;

/*首页教育列表分页*/
FOUNDATION_EXPORT           NSString *const EducateListUrl;

/*根据教育ID获取教育详情页*/
FOUNDATION_EXPORT           NSString *const EducateDetailUrl;

/*教育详情推荐列表*/
FOUNDATION_EXPORT           NSString *const EducateRecommendUrl;

/*用户信息*/
FOUNDATION_EXPORT           NSString *const UserUrl;

/*修改用户信息*/
FOUNDATION_EXPORT           NSString *const ModifyUrl;



/*红包转账*/
FOUNDATION_EXPORT           NSString *const transferRequesturl;
/*发单人红包*/
FOUNDATION_EXPORT           NSString *const sendSingleredRequesturl;
/*接受单人红包*/
FOUNDATION_EXPORT           NSString *const receiveSingleredRequesturl;

/*发群红包*/
FOUNDATION_EXPORT           NSString *const sendGroupredRequesturl;

/*领取群红包*/
FOUNDATION_EXPORT           NSString *const ReceiveGroupredRequesturl;

/*获取群红包信息*/
FOUNDATION_EXPORT           NSString *const SeeGroupredRequesturl;

/*查看单人红包*/
FOUNDATION_EXPORT           NSString *const ReceivesingleredRequesturl;

@interface PacketHandler : NSObject

@end
