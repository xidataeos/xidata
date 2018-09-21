//
//  ChatmangerObject.h
//  Woo
//
//  Created by 王起锋 on 2018/8/10.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import "baseobject.h"

@interface ChatmangerObject : baseobject
+ (id)ShareManger;
-(void)cgreatGroupwith:(NSMutableArray *)list fromview:(WooBaseViewController *)fromcontroller;
-(void)addsomegroup:(NSMutableArray *)list fromcontroller:(WooBaseViewController *)fromcontroller Groupid:(NSString *)Groupid;
-(void)gotoChatViewtargetid:(NSString *)targetid convertitle:(NSString *)convertitle conversationModelType:(RCConversationType)conversationModelType fromview:(WooBaseViewController *)fromeview;
//发起申请添加好友
-(void)addfriend:(NSString *)fid frome:(WooBaseViewController *)frome;
//发起申请添加群组
-(void)sendJionGroup:(NSString *)groupId frome:(WooBaseViewController *)frome;
@end
