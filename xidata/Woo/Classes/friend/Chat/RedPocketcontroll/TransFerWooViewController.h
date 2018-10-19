//
//  TransFerWooViewController.h
//  Woo
//
//  Created by 王起锋 on 2018/8/27.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import "WooBaseViewController.h"
@protocol TransFerDelegate <NSObject>
- (void)TransFerDelegatemessage:(NSString *)Size leavemessage:(NSString *)leavemessage;
@end
@interface TransFerWooViewController : WooBaseViewController
@property(nonatomic,strong)RCDUserInfo *userinfo;
@property(nonatomic,weak)id<TransFerDelegate> delegate;
@end
