//
//  PublicFunction.h
//  zjcmcc
//
//  Created by 周中广 on 14/9/22.
//  Copyright (c) 2014年 sjyyt. All rights reserved.
//

/*此类中放置一些--APP通用的函数*/

//设备尺寸高度
#define DeviceScreenHeight            [[UIScreen mainScreen] bounds].size.height
//实际可操作页面尺寸
#define AvailableSecreenHeight        (DeviceScreenHeight - PCTopBarHeight)

//是否ios7运⾏行环境
#ifndef isIOS7Later

#define isIOS7Later [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0
#endif

//topBar 的高度，如果是ios7编译并且ios7运行高度为64.0f
#define PCTopBarHeight   (isIOS7Later ? 64.0f:44)

#define SCREEN_WIDTH                        [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT                       [UIScreen mainScreen].bounds.size.height
#define SHOWALERT(messageString)    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:messageString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];[alert show];

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UIAlertView+Block.h"

@interface PublicFunction : NSObject
typedef NS_ENUM(NSUInteger,CreatGroupType) {
    CREAT_GROUP = 1,
    ADD_FRIEND = 2,
} ;
//判断设备系统版本是否为IOS7之后版本
+ (BOOL)isIOS7OrLater;

//获取设备UUID
+ (NSString *)getUUIDOfDevice;

//获取客户端版本号
+ (NSString *)versionNumberOfAPP;

//保存配置信息
+(BOOL)saveConfig:(id)value forKey:(NSString*) key;
//保存配置信息(today)
+ (BOOL)saveTodayConfig:(id)value forKey:(NSString*) key;

//读取配置信息
+(id)getConfigWithKey:(NSString*) key;
//读取配置信息(today)
+ (id) getTodayConfigWithKey:(NSString*) key;


//删除配置信息
+(void) removeConfigWithKey:(NSString*) key;
//移除配置信息(today)
+ (void) removeTodayConfigWithKey:(NSString*) key;


//判断字符串是否为空
+(BOOL) isEmpty:(NSString*) value;

//是否为3G网络
+ (BOOL) IsEnable3G;
// 是否wifi
+ (BOOL)IsEnableWIFI;

// 弹出系统警告框
+ (UIAlertView *)showAlert:(NSString *)title message:(NSString *)msg;

//JSON数据解析
+ (NSDictionary *)dicFromJSONWithData:(NSData*)data;

//从app跳转到safari
+(void)openUrl:(NSString *)strUrl;

//时间相关
//根据时间戳时间获取格式化的时间
+ (NSString*)getDateStringByFormateString:(NSString*)formateString date:(NSString*)dateString;

+(NSString*)randomStr:(NSInteger)length;

+(NSString *)cryptAES128WithMD5KEY:(NSString*)secret withKey:(NSString*)key;

+(NSString *)decryptAES128WithMD5KEY:(NSString*)secret withKey:(NSString*)key;

//md5 32位 加密 （小写）
+ (NSString *)md5:(NSString *)str;

//SHA1加密
+ (NSString *)getSha1String:(NSString *)srcString;


+(void)setIsUser4g:(BOOL)aisUser4g;

+(BOOL)isUser4g;

+(NSString *)changeFlowUnit:(NSInteger)flowData isInteger:(BOOL)flag;




+(NSString *)getFlowProductLevel:(NSDictionary*)cellData isRecommend:(BOOL)isRecommend;
+(NSInteger)getFlowSize:(NSDictionary*)cellData isRecommend:(BOOL)isRecommend;

+(NSInteger)getFlowProductId:(NSDictionary*)cellData isRecommend:(BOOL)isRecommend;
+(NSString *)getFlowProductDesc:(NSDictionary*)cellData isRecommend:(BOOL)isRecommend;

+(NSString *)getFlowProductName:(NSDictionary*)cellData isRecommend:(BOOL)isRecommend;
+(NSString *)getFlowMarketId:(NSDictionary*)cellData isRecommend:(BOOL)isRecommend;

+ (NSString *)getDateWithStringFormat:(NSString *)format;
+(NSString *)getFlowProductFee:(NSDictionary*)cellData;

//获取汉字的16进制Unicode码，防止汉字乱码
+ (NSString*)chineseToHex:(NSString *)chineseString;

//根据字体和尺寸计算出完全展示text时label的尺寸大小
+ (CGRect)textLabel:(UILabel*)label constrainedToSize:(CGSize)size;
+ (void)textLabel:(UILabel*)label;

+ (NSString *)getSecureNumTime:(NSString *)strOfStartTime endOfTime:(NSString*) strofEndTime;
+ (NSString *)getSecureNumTime2:(NSString *)strOfStartTime;
+ (NSString *)changeDisplayTime:(NSString *)strOfTime;
+ (NSString*)changeSecureNumTime:(NSString *)strOfTime;

// 获取当前日期
+ (NSDate *)getDate;

//创建新的通知
+ (void)addObserver:(id)obj notificationName:(NSString *)name selector:(SEL)sel object:(id)object;

+ (void)setHasSecureNum:(BOOL)aisUser4g;

+ (BOOL)hasSecureNum;
+(void)saveSpEnterClicked:(NSInteger)mid;
+(BOOL)hasSpEnterClicked:(NSInteger)mid;

+(BOOL)hasDiscoverData;
+(NSDictionary*)getDiscoverData;


//获得设备型号
+ (NSString *)getCurrentDeviceModel;
//获取设备系统版本号
+ (NSString *)getVersionNumberOfDeviceSystem;
//获得设备的系统名称和具体版本号
+ (NSString *)getIosSystemNameAndNumber;


//设置圆角
+ (void) setViewCorner:(UIView*)view radius:(CGFloat)radius color:(CGColorRef)color;

//字符串分割
//参数1：keyStr    关键key的字符串
//参数2：inputStr  需要分割的原始字符串
//参数3：cutStr    按照该字符串进行分割
//例如：   a=12&b=34&c=56   要获得a的值，
//则：     a为keyStr       a=12&b=34&c=56为inputStr         &为cutStr
+(NSString *) ToCutStrAboutKeyStr:(NSString *)keyStr inputStr:(NSString *)inputStr cutStr:(NSString *)cutStr;

//颜色转换 IOS中十六进制的颜色转换为UIColor
+ (UIColor *) colorWithHexString: (NSString *)color;

//将URL转为image
+(UIImage *)withURLChangeImage:(NSString *)url;
+(UIImageView *)getimageviewwithimageurl:(NSString *)imageurl imagename:(NSString *)imagename fram:(CGRect)fram cornerRadius:(CGFloat)cornerRadius;
+(UILabel *)getlabelwithtexttitle:(NSString *)texttitle fram:(CGRect)fram cornerRadius:(CGFloat)cornerRadius textcolor:(UIColor *)textcolor textfont:(UIFont*)textfont backcolor:(UIColor *)backcolor textAlignment:(NSTextAlignment)textAlignment;
+(UIButton *)getbtnwithtexttitle:(NSString *)texttitle fram:(CGRect)fram cornerRadius:(CGFloat)cornerRadius textcolor:(UIColor *)textcolor textfont:(UIFont*)textfont backcolor:(UIColor *)backcolor;
+(UIView *)getheadviewfram:(CGRect)fram;
+(NSString *)JsonModel:(NSDictionary *)dictModel;
+(CGFloat)getnavi_heightwithcontroller:(UIViewController *)controller;
+(CGFloat)gettabbar_heighttwithcontroller:(UIViewController *)controller;
//判断是否登录验证userid的存在
+(BOOL)isuserloginapp;
+(UIImage *)createImageWithColor: (UIColor *) color;
+(NSAttributedString *)attributedStringWithHTMLString:(NSString *)htmlString;
//爱好只能由中文、字母组成
+ (BOOL)isValidateHobby:(NSString *)nickname;

//昵称只能由中文、字母或数字组成
+ (BOOL)isValidateNick:(NSString *)nickname;

//验证真实姓名
+ (BOOL)isValidateRealname:(NSString *)realname;

//验证账号是不是纯英文 或者 英文加数字
+ (BOOL)isValidateNickname:(NSString *)email;

//验证邮箱格式
+ (BOOL)isValidateEmail:(NSString *)email;

//验证电话格式
+ (BOOL)isValidatePhone:(NSString *)phone;

//验证身份证格式
+ (BOOL)isIdNumberValid:(NSString *)idNum;
//获取公共参数
+ (NSMutableDictionary *)getHeaderParameter;
+(UIImage *)stretchOldImegeWithGetNewImage:(UIImage *)imagename topScale:(CGFloat)topscale leftScale:(CGFloat)leftscale bottomScale:(CGFloat)bottomscale rightScale:(CGFloat)rightscale;
//汉子转拼音
+ (NSString *)transform:(NSString *)chinese;
#pragma mark 字符串转为字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
@end
