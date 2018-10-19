//
//  SendRedpocketWooViewController.h
//  Woo
//
//  Created by 王起锋 on 2018/8/24.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import "WooBaseViewController.h"
@protocol SendRedpocketDelegate <NSObject>
- (void)sendRedmessage:(NSString *)redSize leavemessage:(NSString *)leavemessage;
- (void)GroupsendRedmessage:(NSString *)redSize redcount:(NSString *)redcount leavemessage:(NSString *)leavemessage;
@end
@interface SendRedpocketWooViewController : WooBaseViewController
@property(nonatomic,weak)id<SendRedpocketDelegate>delegate;
@property(nonatomic,assign)RCConversationType convertype;
@property(nonatomic,copy)NSString *selfcount;
@end
