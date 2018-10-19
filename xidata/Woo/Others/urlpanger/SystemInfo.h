//
//  SystemInfo.h
//  SummaryHoperun
//
//  Created by 程long on 14-7-30.
//  Copyright (c) 2014年 chenglong. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Reachability.h"


FOUNDATION_EXTERN NSString *const kSystemNetworkChangedNotification;

@interface SystemInfo : NSObject
{
    
    Reachability            *internetReach_;
}

//静态绑定属性
@property (nonatomic, retain, readonly) NSString * appId;//应用标识
@property (nonatomic, retain, readonly) NSString * appVersion;//应用版本
@property (nonatomic, retain, readonly) NSString * deviceId;//设备唯一标识符
@property (nonatomic, retain, readonly) NSString * deviceType;//设备类型
@property (nonatomic, retain, readonly) NSString * OSVersion;//设备操作系统版本

+ (SystemInfo *)shareSystemInfo;

//当前网络状态
- (NetworkStatus)currentNetworkStatus;

@end
