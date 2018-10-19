//
//  ChatmangerObject.h
//  Woo
//
//  Created by 王起锋 on 2018/8/10.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import "baseobject.h"
@class HomeModel;
@interface ChatmangerObject : baseobject
+ (id)ShareManger;
-(void)cgreatGroupwith:(NSMutableArray *)list fromview:(WooBaseViewController *)fromcontroller;
-(void)addsomegroup:(NSMutableArray *)list fromcontroller:(WooBaseViewController *)fromcontroller Groupid:(NSString *)Groupid;
-(void)gotoChatViewtargetid:(NSString *)targetid convertitle:(NSString *)convertitle conversationModelType:(RCConversationType)conversationModelType fromview:(WooBaseViewController *)fromeview info:(RCDUserInfo *)info;
//发起申请添加好友
-(void)addfriend:(NSString *)fid frome:(WooBaseViewController *)frome;
//发起申请添加群组
-(void)sendJionGroup:(NSString *)groupId frome:(WooBaseViewController *)frome;
-(void)getFriendRelationship:(NSString *)fid successBlock:(MHAsiSuccessBlock)successBlock
                failureBlock:(MHAsiFailureBlock)failureBlock;
//点赞
-(void)favorSomebody:(HomeModel *)model successBlock:(MHAsiSuccessBlock)successBlock
        failureBlock:(MHAsiFailureBlock)failureBlock;
//踩
-(void)nounfavorSomebody:(HomeModel *)model successBlock:(MHAsiSuccessBlock)successBlock
        failureBlock:(MHAsiFailureBlock)failureBlock;
//评论
-(void)commentSomebody:(HomeModel *)model content:(NSString *)content successBlock:(MHAsiSuccessBlock)successBlock
        failureBlock:(MHAsiFailureBlock)failureBlock;
//收藏
-(void)CollectionSomebody:(HomeModel *)model successBlock:(MHAsiSuccessBlock)successBlock
        failureBlock:(MHAsiFailureBlock)failureBlock;
//获取专辑分类列表
-(void)getAlbumClasssuccessBlock:(MHAsiSuccessBlock)successBlock
             failureBlock:(MHAsiFailureBlock)failureBlock;
@end
