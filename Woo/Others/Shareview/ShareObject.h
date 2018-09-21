//
//  ShareObject.h
//  Woo
//
//  Created by 王起锋 on 2018/8/9.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import "baseobject.h"
#import <ShareSDK/ShareSDK.h>
// 回调地址
#define Share_TwitterRedirectUri @"http://www.ipanda.com"
#define Share_RedirectUrl        @"http://www.ipanda.com/"
#define Share_SinaRedirectUrl    @"http://www.ipanda.com"
// shareSDK Key （更换bundleID后要去ShareSDK官网重新创建个key）
#define ShareSdk_AppKey @"2783d0d9572fc"

#define ShareObject_SinaWeiboAppKey @"725697741"
#define ShareObject_SinaWeiboAppSecrect @"a525af32e29def84e55446eeeba4a900"

#define ShareObject_WeChatAppId @"wxc97585d42099d55f"
#define ShareObject_WeChatAppSecrect @"d7152c855cc50cedf114d0f109aaa481"

#define ShareObject_QQAppId @"1107792806"
#define ShareObject_QQAppKey @"KEYu0ONpxRUz5u2inRe"

#define ShareObject_FacebookApiKey @"741373995963007"
#define ShareObject_FacebookAppSecrect @"d6aa3aa1e07c49eee9bf5816183f7de6"

#define ShareObject_TwitterConsumerKey @"RIQqDbSgFKPtlGS1XdbovXa9C"
#define ShareObject_TwitterConsumerSecret @"odkduPCTjULRgMCmTJyRRV1edCxeigqtZbz7g0HpaTBOV0Syv8"

#define ShareObject_ShortUrl @"http://api.t.sina.com.cn/short_url/shorten.json"
//#define ShareObject_ShortUrl @"dwz.cn/create.php"

#define ShareObject_TwitterHost @"https://twitter.com"
#define ShareObject_FacebookHost @"https://www.facebook.com"


enum{
    share_facebook = 100,
    share_twitter,
    share_sinaWeibo,
    share_weChat,
    share_timeline,
    share_QQFriend,
    share_Qzone,
    share_weburl
};

typedef int SharePlatfrom;

typedef void (^ShareCompletionBlock)(SSDKResponseState state);
@interface ShareObject : baseobject
@property(nonatomic,copy)NSString *shareUrl;
@property(nonatomic,copy)NSString *shretext;
@property(nonatomic,copy)NSString *shareImageUrl;
@property(nonatomic,copy)NSString *shareTitle;
/**
 *  初始化(安装)各个平台,要在AppDelegate里面的启动方法中首先调用
 */
+ (void)installPlatForm;

/**
 *  1.创建分享单例
 *
 *  @return 分享类
 */
+ (id)defaultShare;

/**
 *  2.添加分享内容
 *
 *  @param shareImageUrl 要分享的图片Url
 *  @param shareText     分享文字
 *  @param shareTitle    分享Title
 */
- (void)addShareImageUrl:(NSString *)shareImageUrl
               shareText:(NSString *)shareText
              shareTitle:(NSString *)shareTitle
                shareUrl:(NSString *)shareUrl
             shareCompletionBlcok:(ShareCompletionBlock)completionBlock;
- (void)shareToPlatfrom:(SharePlatfrom)platform fromecontroller:(WooBaseViewController *)fromecontroller ContentType:(SSDKContentType)ContentType;

@end
