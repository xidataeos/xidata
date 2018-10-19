//
//  SystemInfo.h
//  SummaryHoperun
//
//  Created by 程long on 14-7-30.
//  Copyright (c) 2014年 chenglong. All rights reserved.
//

#import "SystemInfo.h"

#import <objc/runtime.h>
#import "UIApplication+Common.h"


static SystemInfo *systemInfo = nil;

NSString *const kSystemNetworkChangedNotification = @"kNetworkReachabilityChangedNotification";

@interface SystemInfo ()
{
    Class     _originalClass; //用于检测代理有效性
}

@end


@implementation SystemInfo

@synthesize appId;
@synthesize appVersion;
@synthesize deviceId;
@synthesize deviceType;
@synthesize OSVersion;


- (NSString *)appId
{
    if (!appId)
    {
        appId = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleIdentifierKey];
    }
    
    return appId;
}

- (NSString *)appVersion
{
    if (!appVersion)
    {
        appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];
    }
    
    return appVersion;
}


- (NSString *)deviceId
{
    if (!deviceId)
    {
        CFUUIDRef unique = CFUUIDCreate(kCFAllocatorDefault);
        
        NSString *result = (NSString *)CFBridgingRelease(CFUUIDCreateString(kCFAllocatorDefault, unique));
        
        CFRelease(unique);

        deviceId = result;
    }
    
    return deviceId;
}


- (NSString *)deviceType
{
    if (!deviceType)
    {
        deviceType = [[UIDevice currentDevice] model];
    }
    
    return deviceType;
}


- (NSString *)OSVersion
{
    if (!OSVersion)
    {
        OSVersion = [[UIDevice currentDevice] systemVersion];
    }
    
    return OSVersion;
}


+ (SystemInfo *)shareSystemInfo
{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        systemInfo = [SystemInfo new];
        
    });
    
    return systemInfo;
}


- (id)init
{
    self = [super init];
    
    if (self)
    {
        
        [self registerNetWorkMonitor];
    }
    
    return self;
}

- (void)registerNetWorkMonitor
{
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(reachabilityChanged:) name: kReachabilityChangedNotification object: nil];
    internetReach_ = [Reachability reachabilityForInternetConnection];
    
	[internetReach_ startNotifier];
	[self updateInterfaceWithReachability: internetReach_];
}


- (void)updateInterfaceWithReachability: (Reachability*) curReach
{
    NetworkStatus netStatus = [curReach currentReachabilityStatus];
    
    switch (netStatus)
    {
        case NotReachable:
        {
//            网络连接失败,请查看网络是否连接正常！
        [[UIApplication sharedApplication] showcurrentNetworkStatusStr:@"网络连接失败,请查看网络是否连接正常"];
            break;
        }
            
        case ReachableViaWWAN:
        {
            break;
        }
        case ReachableViaWiFi:
        {
            break;
        }
    }
}


//Called by Reachability whenever status changes.
- (void)reachabilityChanged: (NSNotification* )note
{
	Reachability* curReach = [note object];
	NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
	[self updateInterfaceWithReachability: curReach];
}


- (NetworkStatus)currentNetworkStatus
{
    NetworkStatus netStatus = [internetReach_ currentReachabilityStatus];
    
    return netStatus;
}

@end
