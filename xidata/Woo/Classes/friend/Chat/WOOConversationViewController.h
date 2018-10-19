//
//  WOOConversationViewController.h
//  Woo
//
//  Created by 王起锋 on 2018/8/2.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import <RongIMKit/RongIMKit.h>
#import "RCDUserInfo.h"
@interface WOOConversationViewController : RCConversationViewController<RCIMUserInfoDataSource,RCIMGroupInfoDataSource>
@property(nonatomic,strong)RCDUserInfo *userinfo;
@property(nonatomic,strong)RCDGroupInfo *groupinfo;
@end
