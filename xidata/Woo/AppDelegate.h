//
//  AppDelegate.h
//  Woo
//
//  Created by 风外杏林香 on 2018/7/25.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,RCIMConnectionStatusDelegate, RCIMReceiveMessageDelegate,RCIMUserInfoDataSource,RCIMGroupInfoDataSource>
@property(nonatomic,assign)NSInteger allowRotation;
@property (strong, nonatomic) UIWindow *window;


@end

