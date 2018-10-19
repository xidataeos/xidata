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

/*好友搜索*/
FOUNDATION_EXPORT           NSString *const SearchFriendRequesturl;
/*社群搜索*/
FOUNDATION_EXPORT           NSString *const SearchallgroupRequesturl;

/*会议搜索*/
FOUNDATION_EXPORT           NSString *const SearchmeetingRequesturl;
/*教育搜索*/
FOUNDATION_EXPORT           NSString *const SearchalledicationRequesturl;

/*看点搜索*/
FOUNDATION_EXPORT           NSString *const SearchwatchRequesturl;

/*会议报名*/
FOUNDATION_EXPORT           NSString *const ApplyUrl;

/*游戏详情页*/
FOUNDATION_EXPORT           NSString *const GamepagedetailUrl;

/*玩彩蛋 操作*/
FOUNDATION_EXPORT           NSString *const playGamesUrl;
FOUNDATION_EXPORT           NSString *const myappleMeeting;
/*交易记录*/
FOUNDATION_EXPORT           NSString *const TradeUrl;

/*彩蛋 正在参与*/
FOUNDATION_EXPORT           NSString *const FindGameByUserInfoUrl;
//上传文件
FOUNDATION_EXPORT           NSString *const UpdataFileUrl;
//上传图文
FOUNDATION_EXPORT           NSString *const UpdateGraphic;

/*已开奖*/
FOUNDATION_EXPORT           NSString *const GameInfoUrl;

//全部，专辑列表
FOUNDATION_EXPORT           NSString *const GetAllAlbumUrl;
//全部，音频或者图文列表
FOUNDATION_EXPORT           NSString *const GetAllAlbumaudioUrl;
//付费精选，专辑
FOUNDATION_EXPORT           NSString *const GetPayUrl;
//付费精选，图文或者音频
FOUNDATION_EXPORT           NSString *const GetPayAllUrl;
//微版权列表
FOUNDATION_EXPORT           NSString *const GetMicrocopyrightUrl;
//电台直播列表
FOUNDATION_EXPORT           NSString *const GetlivelistUrl;
//分类专辑
FOUNDATION_EXPORT           NSString *const FenLeiUrl;
//获取专辑详情
FOUNDATION_EXPORT           NSString *const getalbumdetaiUrl;
//获取专辑内容列表
FOUNDATION_EXPORT           NSString *const getlbumlistUrl;
//获取文章详情
FOUNDATION_EXPORT           NSString *const getlarticledetailsUrl;
//获取已确权的内容详情
FOUNDATION_EXPORT           NSString *const getMadebydetailsUrl;
//个人的专辑列表
FOUNDATION_EXPORT           NSString *const getownAlbumListUrl;
//首页标题栏列表
FOUNDATION_EXPORT           NSString *const gettitleBarUrl;
//创建专辑
FOUNDATION_EXPORT           NSString *const CreatAlbumUrl;
//获取分类列表
FOUNDATION_EXPORT           NSString *const getfindClassUrl;
//点赞
FOUNDATION_EXPORT           NSString *const TofraorUrl;
//踩
FOUNDATION_EXPORT           NSString *const TonounfraorUrl;
//评论
FOUNDATION_EXPORT           NSString *const TocommetnUrl;
//收藏
FOUNDATION_EXPORT           NSString *const TocollentionUrl;
//删除评论
FOUNDATION_EXPORT           NSString *const deleCommentUrl;
//获取评论列表
FOUNDATION_EXPORT           NSString *const Getcommentlist;
@interface PacketHandler : NSObject

@end
