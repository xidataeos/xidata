//
//  ShareObject.m
//  Woo
//
//  Created by 王起锋 on 2018/8/9.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import "ShareObject.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDK/ShareSDK+Base.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import <ShareSDKExtension/ShareSDK+Extension.h>
#import "WXApi.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import "WeiboSDK.h"

#import "ShareConnectionStatus.h"

#import <Photos/Photos.h>
#import <AssetsLibrary/AssetsLibrary.h>
//#import <FBSDKMessengerShareKit/FBSDKMessengerShareKit.h>

@interface ShareObject ()
{
    BOOL canShare;
    NSString *_shareText;
    NSString *_shareTitle;
    NSString *_shareImageUrl;
    NSString *_shareUrl;
    ShareCompletionBlock _shareBlock;
}
@end

@implementation ShareObject
#pragma mark - 创建单例
+ (id)defaultShare {
    static dispatch_once_t once;
    static ShareObject *_share;
    dispatch_once(&once, ^ {
        _share = [[ShareObject alloc] init];
    });
    return _share;
}
#pragma mark - 配置分享类
+ (void)installPlatForm {
    [ShareSDK registerActivePlatforms:@[@(SSDKPlatformTypeSinaWeibo),
                                        @(SSDKPlatformTypeWechat),
                                        @(SSDKPlatformTypeFacebook),
                                        @(SSDKPlatformTypeTwitter),
                                        @(SSDKPlatformTypeQQ),
                                        @(SSDKPlatformTypeCopy)]
                             onImport:^(SSDKPlatformType platformType) {
                                 switch (platformType) {
                                     case SSDKPlatformTypeWechat:
                                         [ShareSDKConnector connectWeChat:[WXApi class] delegate:self];
                                         break;
                                         
                                     case SSDKPlatformTypeQQ:
                                         [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                                         break;
                                     case SSDKPlatformTypeSinaWeibo:
                                         [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                                         break;
                                     case SSDKPlatformTypeFacebookMessenger:
                                         
//                                         [ShareSDKConnector connectFacebookMessenger:[FBSDKMessengerSharer class]];
                                         break;
                                     default:
                                         break;
                                 }
                                 
                             } onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
                                 switch (platformType)
                                 {
                                     case SSDKPlatformTypeSinaWeibo:
                                         //设置新浪微博应用信息
                                         [appInfo SSDKSetupSinaWeiboByAppKey:ShareObject_SinaWeiboAppKey
                                                                   appSecret:ShareObject_SinaWeiboAppSecrect
                                                                 redirectUri:Share_SinaRedirectUrl
                                                                    authType:SSDKAuthTypeSSO];
                                         break;
                                         
                                     case SSDKPlatformTypeWechat:
                                         //设置微信应用信息， 微信做登录时需要向微信开发平台购买权限
                                         [appInfo SSDKSetupWeChatByAppId:ShareObject_WeChatAppId
                                                               appSecret:ShareObject_WeChatAppSecrect];
                                         
                                         [WXApi registerApp:ShareObject_WeChatAppId];
                                         break;
                                         
                                     case SSDKPlatformTypeQQ:
                                         // 设置QQ应用信息
                                         [appInfo SSDKSetupQQByAppId:ShareObject_QQAppId
                                                              appKey:ShareObject_QQAppKey
                                                            authType:SSDKAuthTypeBoth];
                                         break;
                                         
                                     case SSDKPlatformTypeFacebook:
                                         //设置Facebook应用信息
                                         [appInfo SSDKSetupFacebookByApiKey:ShareObject_FacebookApiKey
                                                                  appSecret:ShareObject_FacebookAppSecrect
                                                                   authType:SSDKAuthTypeSSO];
                                         
                                         break;
                                         
                                     case SSDKPlatformTypeTwitter:
                                         //设置Twitter应用信息
                                         [appInfo SSDKSetupTwitterByConsumerKey:ShareObject_TwitterConsumerKey
                                                                 consumerSecret:ShareObject_TwitterConsumerSecret
                                                                    redirectUri:Share_TwitterRedirectUri];
                                         
                                         break;
                                     default:
                                         break;
                                 }
                                 
                             }];
}

- (void)addShareImageUrl:(NSString *)shareImageUrl
               shareText:(NSString *)shareText
              shareTitle:(NSString *)shareTitle
                shareUrl:(NSString *)shareUrl
    shareCompletionBlcok:(ShareCompletionBlock)completionBlock
{
    _shareBlock = [completionBlock copy];
    _shareImageUrl = shareImageUrl;
    _shareText = shareText;
    _shareTitle = shareTitle;
    _shareUrl = shareUrl;
}
- (void)shareToPlatfrom:(SharePlatfrom)platform fromecontroller:(WooBaseViewController *)fromecontroller ContentType:(SSDKContentType)ContentType
{
    //创建分享参数
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKEnableUseClientShare];
    [shareParams SSDKSetupShareParamsByText:_shareUrl
                                     images:[NSURL URLWithString:_shareImageUrl]
                                        url:nil
                                      title:@""
                                       type:ContentType];
    
    SSDKPlatformType shareType;
    switch (platform) {
        case share_weChat:
        {
            if (![WXApi isWXAppInstalled]) {
                [fromecontroller showAlertHud:fromecontroller.view.center withStr:@"还没安装微信" offy:-100];
                return;
            }
            else{
                [shareParams SSDKSetupShareParamsByText:_shareText images:_shareImageUrl url:[NSURL URLWithString:_shareUrl] title:_shareTitle type:ContentType];
            }
             shareType = SSDKPlatformSubTypeWechatSession;
        }
            break;
        case share_timeline:
        {
            if (![WXApi isWXAppInstalled]) {
                [fromecontroller showAlertHud:fromecontroller.view.center withStr:@"还没安装微信" offy:-100];
                return;
            }
            else{
                [shareParams SSDKSetupShareParamsByText:_shareText
                                    images:_shareImageUrl
                                        url:[NSURL URLWithString:_shareUrl]
                                         title:_shareTitle
                                                  type:ContentType];
            }
             shareType = SSDKPlatformSubTypeWechatTimeline;
        }
            break;
        case share_Qzone:
        {
            if (![ShareSDK isClientInstalled:SSDKPlatformTypeQQ]) {
                [fromecontroller showAlertHud:fromecontroller.view.center withStr:@"还没安QQ" offy:-100];
                _shareBlock(SSDKResponseStateFail);
                return;
            }
            else{
                [shareParams SSDKSetupShareParamsByText:_shareText
                                                 images:_shareImageUrl
                                                    url:[NSURL URLWithString:_shareUrl]
                                                  title:_shareTitle
                                                   type:ContentType];
            }
            shareType = SSDKPlatformSubTypeQZone;
        }
            break;
        case share_QQFriend:
        {
            if (![ShareSDK isClientInstalled:SSDKPlatformTypeQQ]) {
                [fromecontroller showAlertHud:fromecontroller.view.center withStr:@"还没安QQ" offy:-100];
                _shareBlock(SSDKResponseStateFail);
                return;
            }
            else{
                [shareParams SSDKSetupShareParamsByText:_shareText
                                    images:_shareImageUrl
                                    url:[NSURL URLWithString:_shareUrl] title:_shareTitle
                            type:ContentType];
            }
            shareType = SSDKPlatformSubTypeQQFriend;
        }
        default:
            break;
    }
    [ShareSDK share:shareType
         parameters:shareParams
     onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
         
         if (state == SSDKResponseStateSuccess) {
             [fromecontroller showAlertHud:fromecontroller.view.center withStr:@"分享成功" offy:-100];
             //统计分享
             if (shareType == SSDKPlatformTypeFacebook) {
                 return ;
             }else{
             }
         }else if (state == SSDKResponseStateFail) {
              [fromecontroller showAlertHud:fromecontroller.view.center withStr:@"分享失败" offy:-100];
             if (shareType == SSDKPlatformTypeSinaWeibo) {
                 NSDictionary *userinfo = error.userInfo;
                 
                 if (userinfo) {
                     NSString *user_data = [[userinfo objectForKey:@"user_data"] objectForKey:@"error"];
                     if (user_data.length!=0) {
                         
                         
                     }
                 }
                 
             }else if (shareType == SSDKPlatformTypeFacebook) {
                 if (error.code==208) {
                     return;
                 }
                 
                 NSDictionary *userinfo = error.userInfo;
                 //                 NSLog(@"%@", userinfo);
                 if (userinfo) {
                     NSString *errorText = [[[userinfo objectForKey:@"user_data"] objectForKey:@"error"] objectForKey:@"message"];
                     if (errorText.length!=0) {
                     }
                 }
                 
             }else if (shareType == SSDKPlatformTypeCopy || shareType == SSDKPlatformSubTypeQQFriend) {
             }
             
         }else if (state == SSDKResponseStateCancel) {
             if (shareType == SSDKPlatformSubTypeQQFriend || shareType == SSDKPlatformSubTypeWechatSession) {
                 //QQ不做处理
                 return;
             }
         }
         
     }];
}
#pragma mark 截图分享和GIF分享
-(void)sharephotoimage:(UIImage *)image
                  path:(NSString *)path
              platform:(SharePlatfrom)platform
fromecontroller:(WooBaseViewController *)fromecontroller
  shareCompletionBlcok:(ShareCompletionBlock)completionBlock
{
    _shareBlock = [completionBlock copy];
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKEnableUseClientShare];
    
    UIImage *shareImage = [UIImage imageWithData:[NSData data]];
    
    [shareParams SSDKSetupShareParamsByText:_shareUrl
                                     images:[NSURL URLWithString:_shareImageUrl]
                                        url:nil
                                      title:@""
                                       type:SSDKContentTypeImage];
    SSDKPlatformType shareType;//6510073764
    switch (platform) {
            
        case share_weChat:
            
            if (![WXApi isWXAppInstalled]) {
                [fromecontroller showAlertHud:fromecontroller.view.center withStr:@"还没安装微信" offy:-100];
                return;
            }
            [shareParams SSDKSetupWeChatParamsByText:_shareText
                                               title:_shareTitle
                                                 url:[NSURL URLWithString:_shareUrl]
                                          thumbImage:_shareImageUrl
                                               image:_shareImageUrl
                                        musicFileURL:nil
                                             extInfo:nil
                                            fileData:nil
                                        emoticonData:[NSData dataWithContentsOfFile:path]
                                 sourceFileExtension:nil
                                      sourceFileData:nil
                                                type:SSDKContentTypeImage
                                  forPlatformSubType:SSDKPlatformSubTypeWechatSession];
            
            shareType = SSDKPlatformSubTypeWechatSession;
            
            break;
            
        case share_timeline:
        {
            if (![WXApi isWXAppInstalled]) {
                 [fromecontroller showAlertHud:fromecontroller.view.center withStr:@"还没安装微信" offy:-100];
                return;
            }
            [shareParams SSDKSetupWeChatParamsByText:_shareText
                                               title:_shareTitle
                                                 url:[NSURL URLWithString:_shareUrl]
                                          thumbImage:shareImage
                                               image:image
                                        musicFileURL:nil
                                             extInfo:nil
                                            fileData:nil
                                        emoticonData:[NSData dataWithContentsOfFile:path]
                                 sourceFileExtension:nil
                                      sourceFileData:nil
                                                type:SSDKContentTypeImage
                                  forPlatformSubType:SSDKPlatformSubTypeWechatTimeline];
            
            shareType = SSDKPlatformSubTypeWechatTimeline;
            
        }
            break;
            
        case share_Qzone:
        {
            //先判断是否安装客户端QQ
            if (![ShareSDK isClientInstalled:SSDKPlatformTypeQQ]) {
                 [fromecontroller showAlertHud:fromecontroller.view.center withStr:@"还没安QQ" offy:-100];
                _shareBlock(SSDKResponseStateFail);
                return;
            }
          
                [shareParams SSDKSetupQQParamsByText:_shareText title:_shareText url:nil thumbImage:shareImage image:image type:SSDKContentTypeImage forPlatformSubType:SSDKPlatformSubTypeQZone];
            shareType = SSDKPlatformSubTypeQZone;
        }
            break;
        case share_QQFriend:
        {
            //先判断是否安装客户端QQ
            if (![ShareSDK isClientInstalled:SSDKPlatformTypeQQ]) {
                [fromecontroller showAlertHud:fromecontroller.view.center withStr:@"还没安QQ" offy:-100];
                _shareBlock(SSDKResponseStateFail);
                return;
            }
                [shareParams SSDKSetupQQParamsByText:_shareText title:_shareTitle url:[NSURL URLWithString:_shareUrl] thumbImage:shareImage image:image type:SSDKContentTypeAuto forPlatformSubType:SSDKPlatformSubTypeQQFriend];
            shareType = SSDKPlatformSubTypeQQFriend;
        }
            break;
        default:
            shareType = SSDKPlatformTypeUnknown;
            break;
    }
    WEAKSELF;
    [ShareSDK share:shareType
         parameters:shareParams
     onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
         
         if (state == SSDKResponseStateSuccess) {
             //统计分享
             if (shareType == SSDKPlatformTypeFacebook) {
                 return ;
             }else{
             }
         }else if (state == SSDKResponseStateFail) {
             
             if (shareType == SSDKPlatformTypeSinaWeibo) {
                 NSDictionary *userinfo = error.userInfo;
                 
                 if (userinfo) {
                     NSString *user_data = [[userinfo objectForKey:@"user_data"] objectForKey:@"error"];
                     if (user_data.length!=0) {
                         
                         
                     }
                 }
                 
             }else if (shareType == SSDKPlatformTypeFacebook) {
                 if (error.code==208) {
                     return;
                 }
                 
                 NSDictionary *userinfo = error.userInfo;
                 //                 NSLog(@"%@", userinfo);
                 if (userinfo) {
                     NSString *errorText = [[[userinfo objectForKey:@"user_data"] objectForKey:@"error"] objectForKey:@"message"];
                     if (errorText.length!=0) {
                     }
                 }
                 
             }else if (shareType == SSDKPlatformTypeCopy || shareType == SSDKPlatformSubTypeQQFriend) {
             }
             
         }else if (state == SSDKResponseStateCancel) {
             if (shareType == SSDKPlatformSubTypeQQFriend || shareType == SSDKPlatformSubTypeWechatSession) {
                 //QQ不做处理
                 return;
             }
         }
         if (shareType == SSDKPlatformTypeTwitter) {
         }
     }];
    
}
@end
