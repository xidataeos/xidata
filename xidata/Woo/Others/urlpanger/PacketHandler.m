//
//  PacketHander.m
//  Five_D_walletApp
//
//  Created by apple on 16/3/28.
//  Copyright © 2016年 wqf. All rights reserved.
//

#import "PacketHandler.h"
//正式服务器
#define kServiceIP @"http://47.92.53.135:8080/"
//测试服务地址
//#define kServiceIP @"http://192.168.154.107:8080/"



//测试服务地址
#define kServiceIIIP @"http://192.168.154.107:8080/"

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
NSString *const RegistTelCode = @"" kServiceIP"login/tel";

/*手机新用户注册*/
NSString *const RegistNewUser = @"" kServiceIP"login/signup";

/*手机用户登录*/
NSString *const LoginUrl = @"" kServiceIP"login/signin";

/*首页会议列表分页*/
NSString *const HomeMeetingUrl = @"" kServiceIP"meeting/findMeetingPage";

/*根据会议ID获取会议详情页*/
NSString *const HomeMeetingDetailUrl = @"" kServiceIIIP"meeting/findMeeting";

/*根据用户ID和会议ID获取报名信息*/
NSString *const HomeMeetingDetailRegist = @"" kServiceIIIP"apply/getApply";

/*会议轮播图列表*/
NSString *const HomeMeetingCycUrl = @"" kServiceIP"meeting/findShuffing";

/*首页教育列表分页*/
NSString *const EducateListUrl = @"" kServiceIP"education/findEducationPage";

/*根据教育ID获取教育详情页*/
NSString *const EducateDetailUrl = @"" kServiceIP"education/findEducation";

/*教育详情推荐列表*/
NSString *const EducateRecommendUrl = @"" kServiceIP"education/EducationList";

/*用户信息*/
NSString *const UserUrl = @"" kServiceIP"user/info";

/*修改用户信息*/
NSString *const ModifyUrl = @"" kServiceIP"user/modify";

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

/*好友搜索*/
 NSString *const SearchFriendRequesturl=@"" kServiceIP"user/query";
/*社群搜索*/
 NSString *const SearchallgroupRequesturl=@"" kServiceIP"crew/query";

/*会议搜索*/
 NSString *const SearchmeetingRequesturl=@"" kServiceIP"meeting/searchMeeting";
/*教育搜索*/
 NSString *const SearchalledicationRequesturl=@"" kServiceIP"education/searchEducation";

/*看点搜索*/
 NSString *const SearchwatchRequesturl=@"" kServiceIP"news/searchNews";

/*会议报名*/
 NSString *const ApplyUrl = @"" kServiceIP"apply/insertApply";
/*游戏详情页*/
 NSString *const GamepagedetailUrl=@"" kServiceIP"game/findGameInfo";

/*玩彩蛋 操作*/
  NSString *const playGamesUrl=@"" kServiceIP"game/insertGameUser";;
/*我的报名会议*/
NSString *const myappleMeeting=@"" kServiceIP"apply/findMeetingByUser";

/*交易记录*/
 NSString *const TradeUrl = @"" kServiceIP"trade/list";

/*彩蛋 正在参与*/
NSString *const FindGameByUserInfoUrl = @"" kServiceIP"game/findGameByUserInfo";

/*已开奖*/
NSString *const GameInfoUrl = @"" kServiceIP"game/gameInfo";
//上传文件
NSString *const UpdataFileUrl = @"" kServiceIIIP"upload";

//上传图文
NSString *const UpdateGraphic = @"" kServiceIIIP"essay/insertEssay";

//全部，专辑列表
 NSString *const GetAllAlbumUrl = @"" kServiceIIIP"album/queryAlbumList";
//全部，音频或者图文列表
 NSString *const GetAllAlbumaudioUrl = @"" kServiceIIIP"essay/queryEssayList";
//付费精选，专辑
 NSString *const GetPayUrl= @"" kServiceIIIP"album/queryAlbumList";
//付费精选，图文或者音频
 NSString *const GetPayAllUrl= @"" kServiceIIIP"essay/queryEssayList";
//微版权列表
 NSString *const GetMicrocopyrightUrl= @"" kServiceIIIP"attest/findAttestList";
//电台直播列表
 NSString *const GetlivelistUrl= @"" kServiceIIIP"live/queryLiveList";
//分类专辑
 NSString *const FenLeiUrl= @"" kServiceIIIP"album/queryAlbumList";
//获取专辑详情
 NSString *const getalbumdetaiUrl= @"" kServiceIIIP"album/findAlbumInfo";
//获取专辑内容列表
 NSString *const getlbumlistUrl= @"" kServiceIIIP"essay/queryEssayList";
//获取文章详情
 NSString *const getlarticledetailsUrl= @"" kServiceIIIP"essay/findEssayInfo";
//获取已确权的内容详情
 NSString *const getMadebydetailsUrl= @"" kServiceIIIP"attest/findAttestInfo";
//个人的专辑列表
 NSString *const getownAlbumListUrl= @"" kServiceIIIP"album/queryAlbumList";
//首页标题栏列表
 NSString *const gettitleBarUrl= @"" kServiceIIIP"titleBar/findAllList";
//创建专辑
NSString *const CreatAlbumUrl=@"" kServiceIIIP"album/insertAlbum";
//获取分类列表
 NSString *const getfindClassUrl=@"" kServiceIIIP"classify/findClassifyList";

//点赞
 NSString *const TofraorUrl=@"" kServiceIIIP"likes/like";
//踩
 NSString *const TonounfraorUrl=@"" kServiceIIIP"likes/dislike";
//评论
 NSString *const TocommetnUrl=@"" kServiceIIIP"comments/add";
//收藏
 NSString *const TocollentionUrl=@"" kServiceIIIP"classify/findClassifyList";
//删除评论
 NSString *const deleCommentUrl=@"" kServiceIIIP"comments/del";
//获取评论列表
 NSString *const Getcommentlist=@"" kServiceIIIP"comments/list";
@implementation PacketHandler
@end
