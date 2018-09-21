//
//  PacketHander.m
//  Five_D_walletApp
//
//  Created by apple on 16/3/28.
//  Copyright © 2016年 wqf. All rights reserved.
//

#import "PacketHandler.h"
//测试服务地址
#define kServiceIP @"http://192.168.154.107:8080/"



//测试服务地址
#define kServiceIIIP @"http://47.92.53.135:8080/"

//#define kServiceIP @"http://192.168.154.104:8080/"

//获取短信验证码接口
 NSString *const getMessageurl = @"" kServiceIP"common/verifycode";
#pragma mark - 首页接口

/*热门社群接口*/
 NSString *const getHotgroupsRequrl=@"" kServiceIP"crew/hotCrew";

/*看点的首页数据接口*/
 NSString *const getWatcRequrl =@"" kServiceIP"news/findNewsList";

/*看点的第二页详情数据接口*/
 NSString *const getWatcdetailRequrl =@"" kServiceIP"news/findNewsInfo";

/*获取好友列表接口*/
 NSString *const getfriendlistRequrl =@"" kServiceIP"friend/list";
/*发起好友验证*/
NSString *const invitefriendlistRequrl=@"" kServiceIP"friend/invite";
/*通过好友验证*/
NSString *const addfriendlistRequrl=@"" kServiceIP"friend/add";

/*获取好友关系有返回好友关系字段*/
NSString *const getfriendRelationshipRequrl=@"" kServiceIP"friend/friendInfo";

/*删除好友关系*/
NSString *const deletefriendRelationshipRequrl=@"" kServiceIP"friend/del";

/*修改好友备注好友关系*/
 NSString *const nickFnameRequrl=@"" kServiceIP"friend/nickname";

/*创建群组*/
 NSString *const CreatGroupRequrl=@"" kServiceIP"crew/create";

/*创建群组并邀请好友入群*/
 NSString *const CreatGroupandInvateRequrl=@"" kServiceIP"crew/create/add";

/*邀请好友入群*/
 NSString *const GroupInvateFriendsRequrl=@"" kServiceIP"crew/invite";

/*入群通过验证*/
 NSString *const PassGroupInvateRequrl=@"" kServiceIP"crew/join";

/*发送加群请求*/
 NSString *const SendJoinGroupRequrl=@"" kServiceIP"crew/reply";

/*用户所有加入群组列表*/
 NSString *const MGroupsListRequrl=@"" kServiceIP"crew/crewList";

/*群组 的成员列表*/
 NSString *const GroupsMembersRequrl=@"" kServiceIP"crew/memberList";

/*用户退出群或者被踢出群组*/
 NSString *const DeleteGroupsMembersRequrl=@"" kServiceIP"crew/remove";

/*解散群组*/
 NSString *const DeletesomeGroup=@"" kServiceIP"crew/del";

/*根据群号查找群组*/
 NSString *const SearchSomeGroup=@"" kServiceIP"crew/s";

/*修改群组信息*/
 NSString *const Modifythegroup=@"" kServiceIP"crew/modify";


/*注册页验证码发送*/
NSString *const RegistTelCode = @"" kServiceIIIP"login/tel";

/*手机新用户注册*/
NSString *const RegistNewUser = @"" kServiceIIIP"login/signup";

/*手机用户登录*/
NSString *const LoginUrl = @"" kServiceIIIP"login/signin";

/*首页会议列表分页*/
NSString *const HomeMeetingUrl = @"" kServiceIIIP"meeting/findMeetingPage";

/*根据会议ID获取会议详情页*/
NSString *const HomeMeetingDetailUrl = @"" kServiceIIIP"meeting/findMeeting";

/*根据用户ID和会议ID获取报名信息*/
NSString *const HomeMeetingDetailRegist = @"" kServiceIIIP"apply/getApply";

/*会议轮播图列表*/
NSString *const HomeMeetingCycUrl = @"" kServiceIIIP"meeting/findShuffing";

/*首页教育列表分页*/
NSString *const EducateListUrl = @"" kServiceIIIP"education/findEducationPage";

/*根据教育ID获取教育详情页*/
NSString *const EducateDetailUrl = @"" kServiceIIIP"education/findEducation";

/*教育详情推荐列表*/
NSString *const EducateRecommendUrl = @"" kServiceIIIP"education/EducationList";

/*用户信息*/
NSString *const UserUrl = @"" kServiceIIIP"user";

/*修改用户信息*/
NSString *const ModifyUrl = @"" kServiceIIIP"user/modify";

/*红包转账*/
 NSString *const transferRequesturl=@"" kServiceIP"transfer/t";

/*发单人红包*/
 NSString *const sendSingleredRequesturl=@"" kServiceIP"red/sendSingle";

/*接受单人红包*/
 NSString *const receiveSingleredRequesturl=@"" kServiceIP"red/recvSingle";


/*发群红包*/
 NSString *const sendGroupredRequesturl=@"" kServiceIP"red/sendMulti";

/*领取群红包*/
 NSString *const ReceiveGroupredRequesturl=@"" kServiceIP"red/recvMulti";

/*获取群红包信息*/
 NSString *const SeeGroupredRequesturl=@"" kServiceIP"red/multi";

/*查看单人红包*/
 NSString *const ReceivesingleredRequesturl=@"" kServiceIP"red/single";


@implementation PacketHandler
@end
