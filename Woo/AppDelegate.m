//
//  AppDelegate.m
//  Woo
//
//  Created by 风外杏林香 on 2018/7/25.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import "AppDelegate.h"
#import "WooTabBarViewController.h"
#import "WooLoginViewController.h"
#import "RedMessage.h"
#import "TransferMessage.h"
#define LOG_EXPIRE_TIME -7 * 24 * 60 * 60

//融云测试key
#define RONGCLOUD_IM_APPKEY @"qd46yzrfqivaf" // online key
#define RONGCLOUD_IM_Secret @"WHCC4Ij50w"

#define tokentext @"354BvizvpbNVvJ9PYTOs5M7pvnIrYGVl2B3xFphwrKavq0N/fywAgBoJx5xA2pta04tqbASrbP4M6ZtENYayAA=="
//#define roclouduserid  @"002108"
//
//#define tokentext @"1wrz1v5aJS3HI2Prj2sTzX3drir+Ka+2zJtycD1Egw1ukCu9XziWYpeAOEDbsxsnmGSSruHJLhOv12YnNvcmeQ=="
//#define rocuserid  @"002109"
@interface AppDelegate ()

@end


@implementation AppDelegate
-(void)UpdateselfList:(NSNotification *)noti
{
    [self insertAndSaveFriendandgroup];
    [self insertGroup];
}
//缓存好友信息和群组信息
-(void)insertAndSaveFriendandgroup
{
    NSLog(@"%@",RCLOUD_ID);
        NSMutableDictionary *parametDic = [NSMutableDictionary dictionaryWithCapacity:9];
        [parametDic setObject:RCLOUD_ID forKey:@"uid"];
        [UserRequestToo shareInstance].rquesturl=getfriendlistRequrl;
        [UserRequestToo shareInstance].params=parametDic;
        [[UserRequestToo shareInstance] statrrequestgetwith:MHAsiNetWorkGET successBlock:^(id returnData) {
            if (returnData[@"success"]) {
                if ([returnData[@"status"] isEqualToString:@"200"]) {
                    NSArray *list=returnData[@"data"];
                    NSMutableArray *datalist=[[NSMutableArray alloc] init];
                    //顺序遍历
                    [list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        NSDictionary *dic=(NSDictionary *)obj;
                        RCDUserInfo *model=[[RCDUserInfo alloc] init];
                        model.displayName=dic[@"nickname"];
                        model.portraitUri=dic[@"photo"];
                        model.status=@"20";
                        model.userId=dic[@"uid"];
                        model.name=dic[@"name"];
                        model.qrcode=@"niaho";
                        model.pub=dic[@"pub"];
                        model.signature=dic[@"brief"];
                        model.sex=[NSString stringWithFormat:@"%@",dic[@"sex"]];
                        [datalist addObject:model];
                    }];
                    
                    if (datalist.count!=0) {
                        [[RCDataBaseManager shareInstance] clearFriendsData];
                        [[RCDataBaseManager shareInstance] insertFriendListToDB:datalist complete:^(BOOL result) {
                            
                        }];
                    }
                    else{
                        [[RCDataBaseManager shareInstance] clearFriendsData];
                    }
                }
              
            }
            else{
                
            }
        } failureBlock:^(NSError *error) {
            
            
        }];
}
-(void)insertGroup
{
    NSMutableDictionary *parametDic = [NSMutableDictionary dictionaryWithCapacity:9];
    [parametDic setObject:RCLOUD_ID forKey:@"userId"];
    [UserRequestToo shareInstance].rquesturl=MGroupsListRequrl;
    [UserRequestToo shareInstance].params=parametDic;
    [[UserRequestToo shareInstance] statrrequestgetwith:MHAsiNetWorkGET successBlock:^(id returnData) {
        
        if (returnData[@"success"]) {
            if ([returnData[@"status"] isEqualToString:@"200"]) {
                NSArray *list=returnData[@"data"];
                NSMutableArray *datalist=[[NSMutableArray alloc] init];
                //顺序遍历
                [list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    NSDictionary *dic=(NSDictionary *)obj;
                    RCDGroupInfo *model=[[RCDGroupInfo alloc] init];
                    model.introduce=dic[@"brief"];
                    model.portraitUri=dic[@"photo"];
                    model.groupId=dic[@"cid"];
                    model.groupName=dic[@"name"];
                    model.creatorId=dic[@"uid"];
                     model.creatorTime=dic[@"createTime"];
                    model.number=[NSString stringWithFormat:@"%@",dic[@"num"]];
                    model.qrcode=dic[@"qrcode"];
                    model.pub= [NSString stringWithFormat:@"%@",dic[@"pub"]];
                    [datalist addObject:model];
                }];
                if (datalist.count!=0) {
                     [[RCDataBaseManager shareInstance] clearGroupsData];
                    [[RCDataBaseManager shareInstance] insertGroupsToDB:datalist complete:^(BOOL result) {
                        
                    }];
                }
                else{
                     [[RCDataBaseManager shareInstance] clearGroupsData];
                }
            }
        }
        else{
            
        }
    } failureBlock:^(NSError *error) {
        
    }];

}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.allowRotation = 0;
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    NSString *str = [NSString stringWithFormat:@"%@", [UserDefaults objectForKey:@"isLogin"]];
    ZKLog(@"str -- %@", str);
    if ([UserDefaults objectForKey:@"userId"]) {
        [self initrongcloud];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self insertAndSaveFriendandgroup];
            [self insertGroup];
        });
        self.window.rootViewController = [WooTabBarViewController new];
    } else {
        self.window.rootViewController = [WooLoginViewController new];
    }
    [self setupNavBar];
    //初始化分享组件
    [ShareObject installPlatForm];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(dismissLogin:) name:@"remove" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(UpdateselfList:) name:UPDATE_GROUP_FRIEND object:nil];

    UIFont *font = [UIFont systemFontOfSize:17.f];
    NSDictionary *textAttributes = @{NSFontAttributeName : font, NSForegroundColorAttributeName : [UIColor whiteColor]};
    [[UINavigationBar appearance] setTitleTextAttributes:textAttributes];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setBarTintColor:NaviBackgroundColor];
    [UINavigationBar appearance].translucent = NO;
    //[self redirectNSlogToDocumentFolder];
    /**
     * 推送处理1
     */
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        //注册推送, 用于iOS8以及iOS8之后的系统
        UIUserNotificationSettings *settings = [UIUserNotificationSettings
                                                settingsForTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert)
                                                categories:nil];
        [application registerUserNotificationSettings:settings];
    } else {
        //注册推送，用于iOS8之前的系统
        UIRemoteNotificationType myTypes =
        UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound;
        [application registerForRemoteNotificationTypes:myTypes];
    }
    /**
     * 统计推送打开率1
     */
    [[RCIMClient sharedRCIMClient] recordLaunchOptionsEvent:launchOptions];
    /**
     * 获取融云推送服务扩展字段1
     */
    NSDictionary *pushServiceData = [[RCIMClient sharedRCIMClient] getPushExtraFromLaunchOptions:launchOptions];
    if (pushServiceData) {
        NSLog(@"该启动事件包含来自融云的推送服务");
        for (id key in [pushServiceData allKeys]) {
            NSLog(@"%@", pushServiceData[key]);
        }
    } else {
        NSLog(@"该启动事件不包含来自融云的推送服务");
    }
    // 注册自定义测试消息
    [[RCIM sharedRCIM] registerMessageType:[RedMessage class]];
    [[RCIM sharedRCIM] registerMessageType:[TransferMessage class]];
    //设置会话列表头像和会话页面头像
    [[RCIM sharedRCIM] setConnectionStatusDelegate:self];
    [RCIM sharedRCIM].globalConversationPortraitSize = CGSizeMake(46, 46);
    //开启发送已读回执
    [RCIM sharedRCIM].enabledReadReceiptConversationTypeList =
    @[ @(ConversationType_PRIVATE), @(ConversationType_DISCUSSION), @(ConversationType_GROUP) ];
    //开启消息@功能（只支持群聊和讨论组, App需要实现群成员数据源groupMemberDataSource）
    [RCIM sharedRCIM].enableMessageMentioned = YES;
    
    //开启消息撤回功能
    [RCIM sharedRCIM].enableMessageRecall = YES;

    [self initNotificationCenter];
    //缓存好友列表和群组信息
    return YES;
}
#pragma mark -- 允许某个页面横屏
- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    if (_allowRotation == 1) {
        return UIInterfaceOrientationMaskAllButUpsideDown;//这个可以根据自己的需求设置旋转方向
    }
    else
    {
        return (UIInterfaceOrientationMaskPortrait);
    }
}


-(void)initNotificationCenter
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceiveMessageNotification:)
                                                 name:RCKitDispatchMessageNotification
                                               object:nil];
}

- (void)didReceiveMessageNotification:(NSNotification *)notification {
    NSNumber *left = [notification.userInfo objectForKey:@"left"];
    if ([RCIMClient sharedRCIMClient].sdkRunningMode == RCSDKRunningMode_Background && 0 == left.integerValue) {
        int unreadMsgCount = [[RCIMClient sharedRCIMClient] getUnreadCount:@[
                                                                             @(ConversationType_PRIVATE), @(ConversationType_DISCUSSION), @(ConversationType_APPSERVICE),
                                                                             @(ConversationType_PUBLICSERVICE), @(ConversationType_GROUP)
                                                                             ]];
        dispatch_async(dispatch_get_main_queue(),^{
            [UIApplication sharedApplication].applicationIconBadgeNumber = unreadMsgCount;
        });
    }
}
//初始化融云组建
-(void)initrongcloud
{
    BOOL debugMode = NO;
#if RCDPrivateCloudManualMode
    debugMode = YES;
#endif
    // debugMode是为了动态切换导航server地址和文件server地址，公有云用户可以忽略
    if (debugMode) {
        //初始化融云SDK
        // debug模式初始化sdk
        [[RCIM sharedRCIM] initWithAppKey:RONGCLOUD_IM_APPKEY];
        //设置导航server和文件server地址
        
    } else {
        //非debug模式初始化sdk
        [[RCIM sharedRCIM] initWithAppKey:RONGCLOUD_IM_APPKEY];
    }
    
    //调用自己的借口获取令牌token
    //暂时没接口调用
    
    [[RCIM sharedRCIM] connectWithToken:[UserDefaults objectForKey:@"rcToken"]     success:^(NSString *userId) {
       [RCIMClient sharedRCIMClient].currentUserInfo.userId=userId;
    } error:^(RCConnectErrorCode status) {
   
    } tokenIncorrect:^{
        //token过期或者不正确。
        //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
        //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
        NSLog(@"token错误");
    }];
}
- (void)dismissLogin:(NSNotification *)noti
{
    [self initrongcloud];
 dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self insertAndSaveFriendandgroup];
        [self insertGroup];
    });
    self.window.rootViewController = [WooTabBarViewController new];
}

- (void)setupNavBar
{
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    UINavigationBar *bar = [UINavigationBar appearance];
//    CGFloat rgb = 0.1;
//    bar.barTintColor = [UIColor colorWithRed:rgb green:rgb blue:rgb alpha:0.9];
    bar.barTintColor = [UIColor whiteColor];
    bar.tintColor = [UIColor whiteColor];
    bar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor blackColor]};
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    RCConnectionStatus status = [[RCIMClient sharedRCIMClient] getConnectionStatus];
    if (status != ConnectionStatus_SignUp) {
        int unreadMsgCount = [[RCIMClient sharedRCIMClient] getUnreadCount:@[
                                                                             @(ConversationType_PRIVATE), @(ConversationType_DISCUSSION), @(ConversationType_APPSERVICE),
                                                                             @(ConversationType_PUBLICSERVICE), @(ConversationType_GROUP)
                                                                             ]];
        application.applicationIconBadgeNumber = unreadMsgCount;
    }
}

/**
 * 推送处理3
 */
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSString *token = [[[[deviceToken description] stringByReplacingOccurrencesOfString:@"<" withString:@""]
                        stringByReplacingOccurrencesOfString:@">"
                        withString:@""] stringByReplacingOccurrencesOfString:@" "
                       withString:@""];
    
    [[RCIMClient sharedRCIMClient] setDeviceToken:token];
}
/**
 * 推送处理2
 */
//注册用户通知设置
- (void)application:(UIApplication *)application
didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    // register to receive notifications
    [application registerForRemoteNotifications];
}
- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
#if TARGET_IPHONE_SIMULATOR
    // 模拟器不能使用远程推送
#else
    // 请检查App的APNs的权限设置，更多内容可以参考文档
    // http://www.rongcloud.cn/docs/ios_push.html。
    ZKLog(@"获取DeviceToken失败！！！");
    ZKLog(@"ERROR：%@", error);
#endif
}
- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}
/**
 * 推送处理4
 * userInfo内容请参考官网文档
 */
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    /**
     * 统计推送打开率2
     */
    [[RCIMClient sharedRCIMClient] recordRemoteNotificationEvent:userInfo];
    /**
     * 获取融云推送服务扩展字段2
     */
    NSDictionary *pushServiceData = [[RCIMClient sharedRCIMClient] getPushExtraFromRemoteNotification:userInfo];
    if (pushServiceData) {
        NSLog(@"该远程推送包含来自融云的推送服务");
        for (id key in [pushServiceData allKeys]) {
            NSLog(@"key = %@, value = %@", key, pushServiceData[key]);
        }
    } else {
        NSLog(@"该远程推送不包含来自融云的推送服务");
    }
}
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    /**
     * 统计推送打开率3
     */
    [[RCIMClient sharedRCIMClient] recordLocalNotificationEvent:notification];
    
    //  //震动
    //  AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    //  AudioServicesPlaySystemSound(1007);
}
- (void)redirectNSlogToDocumentFolder {
    NSLog(@"Log重定向到本地，如果您需要控制台Log，注释掉重定向逻辑即可。");
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    
    [self removeExpireLogFiles:documentDirectory];
    
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"MMddHHmmss"];
    NSString *formattedDate = [dateformatter stringFromDate:currentDate];
    
    NSString *fileName = [NSString stringWithFormat:@"rc%@.log", formattedDate];
    NSString *logFilePath = [documentDirectory stringByAppendingPathComponent:fileName];
    
    freopen([logFilePath cStringUsingEncoding:NSASCIIStringEncoding], "a+", stdout);
    freopen([logFilePath cStringUsingEncoding:NSASCIIStringEncoding], "a+", stderr);
}

- (void)removeExpireLogFiles:(NSString *)logPath {
    //删除超过时间的log文件
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *fileList = [[NSArray alloc] initWithArray:[fileManager contentsOfDirectoryAtPath:logPath error:nil]];
    NSDate *currentDate = [NSDate date];
    NSDate *expireDate = [NSDate dateWithTimeIntervalSinceNow:LOG_EXPIRE_TIME];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *fileComp = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit |
    NSMinuteCalendarUnit | NSSecondCalendarUnit;
    fileComp = [calendar components:unitFlags fromDate:currentDate];
    for (NSString *fileName in fileList) {
        // rcMMddHHmmss.log length is 16
        if (fileName.length != 16) {
            continue;
        }
        if (![[fileName substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"rc"]) {
            continue;
        }
        int month = [[fileName substringWithRange:NSMakeRange(2, 2)] intValue];
        int date = [[fileName substringWithRange:NSMakeRange(4, 2)] intValue];
        if (month > 0) {
            [fileComp setMonth:month];
        } else {
            continue;
        }
        if (date > 0) {
            [fileComp setDay:date];
        } else {
            continue;
        }
        NSDate *fileDate = [calendar dateFromComponents:fileComp];
        
        if ([fileDate compare:currentDate] == NSOrderedDescending ||
            [fileDate compare:expireDate] == NSOrderedAscending) {
            [fileManager removeItemAtPath:[logPath stringByAppendingPathComponent:fileName] error:nil];
        }
    }
}
- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
