//
//  PublicFunction.m
//  zjcmcc
//
//  Created by 周中广 on 14/9/22.
//  Copyright (c) 2014年 sjyyt. All rights reserved.
//

#import "PublicFunction.h"
#import "MBProgressHUD.h"
#import "Reachability.h"
#import "NSData+Encryption.h"
#include <sys/types.h>
#include <sys/sysctl.h>

#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>
#import "NSString+URLEscapes.h"
const CGFloat canvasViewSideLength = 60.0f;
static const CGFloat THeadImgLength = 60.0f;      //头像的长和宽
static const CGFloat THeadImgRatio = 5.0f;
@interface PublicFunction()
@property (nonatomic,strong) MBProgressHUD *HUD;
@end
@implementation PublicFunction

//判断设备系统版本是否为IOS7之后版本
+ (BOOL)isIOS7OrLater{
    return [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0;
}

//获取设备UUID
+ (NSString *)getUUIDOfDevice{
    return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}

//获取设备系统版本
+ (NSString*)getVersionNumberOfDeviceSystem{
    return [[UIDevice currentDevice] systemVersion];
}

+ (NSString *)getIosSystemNameAndNumber{
    NSString *systemName= [[UIDevice currentDevice] systemName];//ios
    NSString *systemNum = [[UIDevice currentDevice] systemVersion];//10.0
    return [NSString stringWithFormat:@"%@%@",systemName,systemNum];
}

//获取客户端版本号
+ (NSString *)versionNumberOfAPP{
    //    NSString * versionNumber = [NSString stringWithFormat:@"%@", [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString*)kCFBundleVersionKey]];
    NSString * versionNumber = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    return versionNumber;
}

//保存配置信息
+ (BOOL) saveConfig:(id)value forKey:(NSString*) key{
    NSUserDefaults* info = [NSUserDefaults standardUserDefaults];
    [info setObject:value forKey:key];
    return [info synchronize];
}

//保存配置信息(today)
+ (BOOL) saveTodayConfig:(id)value forKey:(NSString*) key{
        NSUserDefaults *shared = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.zhejiangcmcc.sjyyt.zjcmcc"];
        [shared setObject:value forKey:key];
        return [shared synchronize];
}
//读取配置信息
+ (id) getConfigWithKey:(NSString*) key{
    
    NSUserDefaults* info = [NSUserDefaults standardUserDefaults];
    return [info objectForKey:key];
}
//读取配置信息(today)
+ (id) getTodayConfigWithKey:(NSString*) key{
    NSUserDefaults *shared = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.zhejiangcmcc.sjyyt.zjcmcc"];
    return [shared objectForKey:key];
}

//移除配置信息
+ (void) removeConfigWithKey:(NSString*) key{
    NSUserDefaults* info = [NSUserDefaults standardUserDefaults];
    [info removeObjectForKey:key];
    [info synchronize];
}


//判断字符串是否为空
+ (BOOL) isEmpty:(NSString*) value{
    if(nil==value|| NULL==value  || [value isEqualToString:@""] ||[value isEqualToString:@"<null>"]){
        return true;
    }else{
        return false;
    }
}


// 是否wifi
+ (BOOL)IsEnableWIFI {
    return ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == ReachableViaWiFi);
}

// 弹出系统警告框
+ (UIAlertView *)showAlert:(NSString *)title message:(NSString *)msg{
    NSString *strAlertOK = @"确定";
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:msg
                                                   delegate:nil
                                          cancelButtonTitle:strAlertOK
                                          otherButtonTitles:nil];
    [alert show];
    return alert;
}

//JSON数据解析
+ (NSDictionary *)dicFromJSONWithData:(NSData*)data{
    NSDictionary* resultDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    return resultDic;
}

+(NSString*)randomStr:(NSInteger)length
{
    int NUMBER_OF_CHARS = (int)length;
    
    char data[NUMBER_OF_CHARS];
    
    for (int x=0;x<NUMBER_OF_CHARS;x++){
        data[x] = ('A' + (arc4random_uniform(26)));;
    }
    NSString *dataPoint = [[NSString alloc] initWithBytes:data length:NUMBER_OF_CHARS encoding:NSUTF8StringEncoding];
    return dataPoint;
}

+(NSString *)cryptAES128WithMD5KEY:(NSString*)secret withKey:(NSString*)key
{
    NSData *plain = [secret dataUsingEncoding:NSUTF8StringEncoding];
    NSData *cipher = [plain AES128EncryptWithMD5Key:key];
    NSString *real = [[cipher description] lowercaseString];
    NSString *reala =  [real stringByReplacingOccurrencesOfString:@"<" withString:@""];
    reala =  [reala stringByReplacingOccurrencesOfString:@">" withString:@""];
    reala =  [reala stringByReplacingOccurrencesOfString:@" " withString:@""];
    return reala;
}
+(NSString *)decryptAES128WithMD5KEY:(NSString*)secret withKey:(NSString*)key
{
    // secret = @"7B9B498C C17A5F33 651337C9 7A445F37";
    NSData *cipher = [self stringToByte:secret];
    NSData *plain = [cipher AES128DecryptWithMD5Key:key];
    NSString *real =  [[NSString alloc] initWithData:plain encoding:NSUTF8StringEncoding];
    return real;
}

+(NSData*)stringToByte:(NSString*)string
{
    NSString *hexString=[[string uppercaseString] stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([hexString length]%2!=0) {
        return nil;
    }
    Byte tempbyt[1]={0};
    NSMutableData* bytes=[NSMutableData data];
    for(int i=0;i<[hexString length];i++)
    {
        unichar hex_char1 = [hexString characterAtIndex:i]; ////两位16进制数中的第一位(高位*16)
        int int_ch1;
        if(hex_char1 >= '0' && hex_char1 <='9')
            int_ch1 = (hex_char1-48)*16;   //// 0 的Ascll - 48
        else if(hex_char1 >= 'A' && hex_char1 <='F')
            int_ch1 = (hex_char1-55)*16; //// A 的Ascll - 65
        else
            return nil;
        i++;
        
        unichar hex_char2 = [hexString characterAtIndex:i]; ///两位16进制数中的第二位(低位)
        int int_ch2;
        if(hex_char2 >= '0' && hex_char2 <='9')
            int_ch2 = (hex_char2-48); //// 0 的Ascll - 48
        else if(hex_char2 >= 'A' && hex_char2 <='F')
            int_ch2 = hex_char2-55; //// A 的Ascll - 65
        else
            return nil;
        
        tempbyt[0] = int_ch1+int_ch2;  ///将转化后的数放入Byte数组里
        [bytes appendBytes:tempbyt length:1];
    }
    return bytes;
}

+ (void)setIsUser4g:(BOOL)aisUser4g
{
    NSUserDefaults* userDefault =   [NSUserDefaults standardUserDefaults];
    [userDefault setBool:aisUser4g forKey:@"isUser4g"];
    [userDefault synchronize];
}

+ (BOOL)isUser4g
{
    NSUserDefaults* userDefault =   [NSUserDefaults standardUserDefaults];
    BOOL    ret;
    if (nil == [[NSUserDefaults standardUserDefaults] objectForKey:@"isUser4g"])
    {
        ret = NO;
    }
    else
    {
        ret   =   [userDefault boolForKey:@"isUser4g"];
    }
    return ret;
}

+(NSString *)changeFlowUnit:(NSInteger)flowData isInteger:(BOOL)flag
{
    if (flowData < 1024) {
        return [NSString stringWithFormat:@"%ld%@",(long)flowData,@"KB"];
    } else if(flowData < 1024*1024) {
        if (flag) {
            NSString * str = [[NSString alloc]initWithFormat:@"%ld%@",(long)flowData/1024,@"MB"];
            return str;
        } else {
            NSString * str = [[NSString alloc]initWithFormat:@"%.2f%@",(float)flowData/1024,@"MB"];
            return str;
        }
    }  else {
        if (flag) {
            NSString * str = [[NSString alloc]initWithFormat:@"%ld%@",(long)flowData/(1024*1024),@"GB"];
            return str;
        } else {
            NSString * str = [[NSString alloc]initWithFormat:@"%.2f%@",(float)flowData/(1024*1024),@"GB"];
            return str;
        }
    }
    return @"";
}






+(NSString *)getFlowProductLevel:(NSDictionary*)cellData isRecommend:(BOOL)isRecommend{
    NSString *fee =  [cellData objectForKey:@"fee"];
    NSInteger flowSize = [self getFlowSize:cellData isRecommend:isRecommend];
    NSString *flow  = [PublicFunction changeFlowUnit:flowSize isInteger:YES];
    return [NSString stringWithFormat:@"%@元/月%@",fee,flow];;
}

+(NSString *)getFlowProductFee:(NSDictionary*)cellData
{
    NSString *fee =  [cellData objectForKey:@"fee"];
    
    return [NSString stringWithFormat:@"%@元",fee];;
}

+(NSInteger)getFlowSize:(NSDictionary*)cellData isRecommend:(BOOL)isRecommend{
    NSInteger flowSize = 0;
    
    if(isRecommend) {
        
        flowSize = [[cellData objectForKey:@"unit"] intValue] ;
    } else {
        flowSize = [[cellData objectForKey:@"freesource"] intValue] ;
    }
    return flowSize;
}

+(NSInteger)getFlowProductId:(NSDictionary*)cellData isRecommend:(BOOL)isRecommend{
    NSInteger productId;
    
    if(isRecommend) {
        productId = [[cellData objectForKey:@"productId"] intValue] ;
    } else {
        productId =  [[cellData objectForKey:@"productshortid"] intValue];
    }
    return productId;
}
+(NSString *)getFlowProductDesc:(NSDictionary*)cellData isRecommend:(BOOL)isRecommend{
    NSString *desc;
    
    if(isRecommend) {
        desc = [[NSString alloc]initWithString:[cellData objectForKey:@"desc"]];
    } else {
        desc = [[NSString alloc]initWithString:[cellData objectForKey:@"desc1"]];
    }
    return desc;
}

+(NSString *)getFlowProductName:(NSDictionary*)cellData isRecommend:(BOOL)isRecommend{
    NSString *name;
    
    if(isRecommend) {
        name = [[NSString alloc]initWithString:[cellData objectForKey:@"productName"]];
    } else {
        name = [[NSString alloc]initWithString:[cellData objectForKey:@"productname"]];
    }
    return name;
}


+(NSString *)getFlowMarketId:(NSDictionary*)cellData isRecommend:(BOOL)isRecommend{
    NSString *mId;
    
    if(isRecommend) {
        mId = [[NSString alloc]initWithString:[cellData objectForKey:@"marketId"]];
    } else {
        mId = [[NSString alloc]initWithString:[cellData objectForKey:@"marketid"]];
    }
    return mId;
}

// 获取当前日期的字符串形式(参数是 可自定义: 如 @"yyyy-MM-dd HH:mm:ss")
+ (NSString *)getDateWithStringFormat:(NSString *)format {
    time_t now;
    time(&now);
    
    NSDate *_dateline = [NSDate dateWithTimeIntervalSince1970:now];
    NSDateFormatter *dateformat=[[NSDateFormatter alloc] init];
    [dateformat setDateFormat:format];
    NSString * new = [dateformat stringFromDate:_dateline];
    return new;
}

//根据时间戳时间获取格式化的时间
+ (NSString*)getDateStringByFormateString:(NSString*)formateString date:(NSString*)dateString{
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:[dateString floatValue]/1000];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formateString];
    NSString *strDate = [formatter stringFromDate:date];
    return strDate;
}

//从app跳转到safari
+(void)openUrl:(NSString *)strUrl{
    UIApplication *del = [UIApplication sharedApplication];
    NSURL *Url = [NSURL URLWithString:strUrl];
    [del openURL:Url];
}

//获取汉字的16进制Unicode码，防止汉字乱码
+ (NSString*)chineseToHex:(NSString *)chineseString{
    NSUInteger length = [chineseString length];
    NSMutableString *s = [NSMutableString stringWithCapacity:0];
    
    for (int i = 0;i < length; i++)
    {
        unichar _char = [chineseString characterAtIndex:i];
        NSString * str = [NSString stringWithFormat:@"%x", _char];
        if (str.length < 4) {
            NSUInteger strLength = 4-str.length;
            for (int j = 0; j < strLength; j++) {
                str = [NSString stringWithFormat:@"0%@", str];
            }
        }
        [s appendFormat:@"%@", str];
    }
    return s;
}

+ (NSString *)getSecureNumTime:(NSString *)strOfStartTime endOfTime:(NSString*) strofEndTime{
    if(!strOfStartTime || !strofEndTime) {
        return @"08:00-23:00";
    }
    NSMutableString *strOfStart = [[NSMutableString alloc] initWithString:strOfStartTime];
    [strOfStart insertString:@":" atIndex:2];
    NSMutableString *strOfEnd = [[NSMutableString alloc] initWithString:strofEndTime];
    [strOfEnd insertString:@":" atIndex:2];
    
    NSString *strOfTime;
    strOfTime = [NSString stringWithFormat:@"%@-%@",strOfStart,strOfEnd];
    return strOfTime;
    
}
+ (NSString *)getSecureNumTime2:(NSString *)strOfStartTime{
    if(!strOfStartTime) {
        return @"00:01";
    }
    NSMutableString *strOfStart = [[NSMutableString alloc] initWithString:strOfStartTime];
    [strOfStart insertString:@":" atIndex:2];
    
    return strOfStart;
    
}

+ (NSString *)changeDisplayTime:(NSString *)strOfTime
{
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    //  [inputFormatter setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease]];
    [inputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate* inputDate = [inputFormatter dateFromString:strOfTime];
    
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr1 = [dateFormatter1 stringFromDate:inputDate];
    return dateStr1;
}

//根据字体和尺寸计算出完全展示text时label的尺寸大小
+ (CGRect)textLabel:(UILabel*)label constrainedToSize:(CGSize)size{
    CGSize labelSize;
    //获取NSAttributedString字典
    NSAttributedString * attString = label.attributedText;
    
    if ([attString.string isEqualToString:@""]) {
        NSDictionary *attrDict = @{ NSFontAttributeName: [UIFont systemFontOfSize: 18]};
        label.attributedText = [[NSAttributedString alloc] initWithString: @" " attributes: attrDict];
    }
    attString = label.attributedText;
    
    NSRange range = NSMakeRange(0, attString.length);
    NSDictionary * attributes = [attString attributesAtIndex:0 effectiveRange:&range];
    if ([PublicFunction isIOS7OrLater]) {
        labelSize = [label.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attributes context:nil].size;
    }
    else {
        labelSize = [attString boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil].size;
    }
    /*
     This method returns fractional sizes (in the size component of the returned CGRect); to use a returned size to size views, you must use raise its value to the nearest higher integer using the ceil function.
     */
    labelSize.height = ceil(labelSize.height);
    labelSize.width = ceil(labelSize.width);
    
    CGRect labelFrame = label.frame;
    labelFrame.size.height = labelSize.height;
    return labelFrame;
}

+ (void)textLabel:(UILabel*)label{
    //设置自动行数与字符换行
    [label setNumberOfLines:0];
    [label setLineBreakMode:NSLineBreakByWordWrapping];
    UIFont *font = label.font;
    //设置一个行高上限
    CGSize size = CGSizeMake(320,2000);
    //计算实际frame大小，并将label的frame变成实际大小
    CGSize labelsize = [label.text sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
    CGRect rect = label.frame;
    [label setFrame:CGRectMake(rect.origin.x,rect.origin.y, rect.size.width, labelsize.height)];
}

+ (NSString*)changeSecureNumTime:(NSString *)strOfTime
{
    return  [strOfTime stringByReplacingOccurrencesOfString:@":" withString:@""];
}

// 获取当前日期
+ (NSDate *)getDate {
    time_t now;
    time(&now);
    
    NSDate *_dateline = [NSDate dateWithTimeIntervalSince1970:now];
    return _dateline;
}

+ (void)addObserver:(id)obj notificationName:(NSString *)name selector:(SEL)sel object:(id)object
{
    if (!obj || !name) {
        return;
    }
    [[NSNotificationCenter defaultCenter] removeObserver:obj name:name object:object];
    [[NSNotificationCenter defaultCenter] addObserver:obj selector:sel name:name object:object];
}



+ (void)setHasSecureNum:(BOOL)aisUser4g
{
    NSUserDefaults* userDefault =   [NSUserDefaults standardUserDefaults];
    [userDefault setBool:aisUser4g forKey:@"hasSecureNum"];
    [userDefault synchronize];
}

+ (BOOL)hasSecureNum
{
    NSUserDefaults* userDefault =   [NSUserDefaults standardUserDefaults];
    BOOL    ret;
    if (nil == [[NSUserDefaults standardUserDefaults] objectForKey:@"hasSecureNum"])
    {
        ret = NO;
    }
    else
    {
        ret   =   [userDefault boolForKey:@"hasSecureNum"];
    }
    return ret;
}

+(void)saveSpEnterClicked:(NSInteger)mid{
    NSString *key = [NSString stringWithFormat:@"%ld_clicked",(long)mid];
    [PublicFunction saveConfig:@"yes" forKey:key];
    
    //服务TABBAR中不曾显示过红点，则无需判断，直接返回
    if(![[PublicFunction getConfigWithKey:@"hasNewService"] isEqualToString:@"yes"]) {
        return;
    }
    
    //判断服务中是否还有红点，如果没有红点发出通知隐藏
    NSArray * arrayOfQuery = [[NSUserDefaults standardUserDefaults] objectForKey:@"querylist"];
    BOOL hasNewFunc = NO;
    for (NSDictionary * dic in arrayOfQuery) {
        NSInteger _m_id  = [[dic objectForKey:@"m_id"] integerValue];
        NSString *_newfunc =  [NSString stringWithFormat:@"%@",[dic objectForKey:@"newfunc"]];
        NSString *sw_type =  [NSString stringWithFormat:@"%@",[dic objectForKey:@"sw_type"]];
        
        if([_newfunc isEqualToString:@"1"] && [sw_type isEqualToString:@"1"]) {
            hasNewFunc = ![PublicFunction hasSpEnterClicked:_m_id];
            if(hasNewFunc){
                break;
            }
        }
    }
    
    if(!hasNewFunc) {
        NSArray * arrayOfHandle =  [[NSUserDefaults standardUserDefaults] objectForKey:@"handlelist"];
        for (NSDictionary * dic in arrayOfHandle) {
            NSInteger _m_id  = [[dic objectForKey:@"m_id"] integerValue];
            NSString *_newfunc =  [NSString stringWithFormat:@"%@",[dic objectForKey:@"newfunc"]];
            NSString *sw_type =  [NSString stringWithFormat:@"%@",[dic objectForKey:@"sw_type"]];
            
            if([_newfunc isEqualToString:@"1"] && [sw_type isEqualToString:@"1"]) {
                hasNewFunc = ![PublicFunction hasSpEnterClicked:_m_id];
                if(hasNewFunc){
                    break;
                }
            }
        }
    }
    
    if(!hasNewFunc){
        //发通知隐藏tabbar上的红点（服务）
        if([[PublicFunction getConfigWithKey:@"hasNewService"] isEqualToString:@"yes"]) {
            //[PublicFunction saveConfig:@"yes" forKey:@"hasNewServiceOfCurrentUse"];
            [PublicFunction saveConfig:@"no" forKey:@"hasNewService"];
            
            NSString *flag = @"21";
            [[NSNotificationCenter defaultCenter] postNotificationName:@"showRedDot" object:flag];
        }
    }
}
+(BOOL)hasSpEnterClicked:(NSInteger)mid{
    
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]){
        [PublicFunction saveSpEnterClicked:mid];
    }
    
    NSString *key = [NSString stringWithFormat:@"%ld_clicked",(long)mid];
    if([[PublicFunction getConfigWithKey:key] isEqualToString:@"yes"]) {
        return YES;
    } else {
        return NO;
    }
}

+(BOOL)hasDiscoverData{
    NSDictionary * dic = [PublicFunction getConfigWithKey:@"discoverData"];
    return (dic==nil)?NO:YES;
}

+(NSDictionary*)getDiscoverData{
    id data =  [PublicFunction getConfigWithKey:@"discoverData"];
    NSDictionary *discoverData = data;
    return discoverData;
}

+ (NSString *)md5:(NSString *)str {
    
    const char *cStr = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, strlen(cStr), result);
    
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
    
}
+ (NSString *)getSHA256String:(NSString *)srcString{
    const char *cstr = [srcString cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:srcString.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, data.length, digest);
    
    NSMutableString* result = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH *2];
    
    for(int i =0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x", digest[i]];
    }
    
    return result;
}

//获得设备型号（包含iphone 7）
+ (NSString *)getCurrentDeviceModel
{
    int mib[2];
    size_t len;
    char *machine;
    
    mib[0] = CTL_HW;
    mib[1] = HW_MACHINE;
    sysctl(mib, 2, NULL, &len, NULL, 0);
    machine = malloc(len);
    sysctl(mib, 2, machine, &len, NULL, 0);
    
    NSString *platform = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
    free(machine);
    // iPhone
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone2G";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone3G";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone3GS";
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone4";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone4";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone4";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone4S";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone5";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone5";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone5c";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone5c";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone5s";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone5s";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone6";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone6Plus";
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone6s";
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone6sPlus";
    if ([platform isEqualToString:@"iPhone8,3"]) return @"iPhoneSE";
    if ([platform isEqualToString:@"iPhone8,4"]) return @"iPhoneSE";
    if ([platform isEqualToString:@"iPhone9,1"]) return @"iPhone7";
    if ([platform isEqualToString:@"iPhone9,2"]) return @"iPhone7Plus";
    if([platform isEqualToString:@"iPhone10,1"]) return@"iPhone 8";
    if([platform isEqualToString:@"iPhone10,4"]) return@"iPhone 8";
    if([platform isEqualToString:@"iPhone10,2"]) return@"iPhone 8 Plus";
    if([platform isEqualToString:@"iPhone10,5"]) return@"iPhone 8 Plus";
    if([platform isEqualToString:@"iPhone10,3"]) return@"iPhone X";
    if([platform isEqualToString:@"iPhone10,6"]) return@"iPhone X";
    
    //iPod Touch
    if ([platform isEqualToString:@"iPod1,1"])   return @"iPodTouch";
    if ([platform isEqualToString:@"iPod2,1"])   return @"iPodTouch2G";
    if ([platform isEqualToString:@"iPod3,1"])   return @"iPodTouch3G";
    if ([platform isEqualToString:@"iPod4,1"])   return @"iPodTouch4G";
    if ([platform isEqualToString:@"iPod5,1"])   return @"iPodTouch5G";
    if ([platform isEqualToString:@"iPod7,1"])   return @"iPodTouch6G";
    
    //iPad
    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad";
    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad2";
    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad2";
    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad2";
    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad2";
    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad3";
    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad3";
    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad3";
    if ([platform isEqualToString:@"iPad3,4"])   return @"iPad4";
    if ([platform isEqualToString:@"iPad3,5"])   return @"iPad4";
    if ([platform isEqualToString:@"iPad3,6"])   return @"iPad4";
    
    //iPad Air
    if ([platform isEqualToString:@"iPad4,1"])   return @"iPadAir";
    if ([platform isEqualToString:@"iPad4,2"])   return @"iPadAir";
    if ([platform isEqualToString:@"iPad4,3"])   return @"iPadAir";
    if ([platform isEqualToString:@"iPad5,3"])   return @"iPadAir2";
    if ([platform isEqualToString:@"iPad5,4"])   return @"iPadAir2";
    
    //iPad mini
    if ([platform isEqualToString:@"iPad2,5"])   return @"iPadmini1G";
    if ([platform isEqualToString:@"iPad2,6"])   return @"iPadmini1G";
    if ([platform isEqualToString:@"iPad2,7"])   return @"iPadmini1G";
    if ([platform isEqualToString:@"iPad4,4"])   return @"iPadmini2";
    if ([platform isEqualToString:@"iPad4,5"])   return @"iPadmini2";
    if ([platform isEqualToString:@"iPad4,6"])   return @"iPadmini2";
    if ([platform isEqualToString:@"iPad4,7"])   return @"iPadmini3";
    if ([platform isEqualToString:@"iPad4,8"])   return @"iPadmini3";
    if ([platform isEqualToString:@"iPad4,9"])   return @"iPadmini3";
    if ([platform isEqualToString:@"iPad5,1"])   return @"iPadmini4";
    if ([platform isEqualToString:@"iPad5,2"])   return @"iPadmini4";
    
    if ([platform isEqualToString:@"i386"])      return @"iPhoneSimulator";
    if ([platform isEqualToString:@"x86_64"])    return @"iPhoneSimulator";
    return platform;
}
//设置圆角
+(void) setViewCorner:(UIView*)view radius:(CGFloat)radius color:(CGColorRef)color
{
    [view.layer setCornerRadius:radius]; //设置矩形四个圆角半径
    [view.layer setBorderWidth:1.0]; //边框宽度
    [view.layer setBorderColor:color];//边框颜色
}

//字符串分割
//参数1：keyStr    关键key的字符串
//参数2：inputStr  需要分割的原始字符串
//参数3：cutStr    按照该字符串进行分割
//例如：   a=12&b=34&c=56   要获得a的值，
//则：     a为keyStr       a=12&b=34&c=56为inputStr         &为cutStr
+(NSString *) ToCutStrAboutKeyStr:(NSString *)keyStr inputStr:(NSString *)inputStr cutStr:(NSString *)cutStr{
    
    if (inputStr.length > 0 && inputStr != nil) {
        //分割字符串
        NSArray * arrayOfInputStr = [inputStr componentsSeparatedByString:cutStr];
        NSString * finalStr = @"";//初始化
        for (NSString * cutedStr in arrayOfInputStr) {
            //遍历数组，判断是否包含关键key字符串
            if ([cutedStr rangeOfString:keyStr].length > 0) {
                //切割字符串
                finalStr = [cutedStr substringFromIndex:keyStr.length + 1];
            }
        }
        return finalStr;
    } else
    return nil;
}

#pragma mark - 颜色转换 IOS中十六进制的颜色转换为UIColor
+ (UIColor *) colorWithHexString: (NSString *)color
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

//URL转化为image
+(UIImage *)withURLChangeImage:(NSString *)url{
    NSString * URL = url;
    NSData *imageData = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:URL]];
    UIImage *image=[[UIImage alloc] initWithData:imageData];
    return image;
}
+(UIImageView *)getimageviewwithimageurl:(NSString *)imageurl imagename:(NSString *)imagename fram:(CGRect)fram cornerRadius:(CGFloat)cornerRadius{
    UIImageView *image=[[UIImageView alloc] initWithFrame:fram];
    if (imagename.length!=0) {
        image.image=[UIImage imageNamed:imagename];
    }
    if (imageurl.length!=0) {
       [image sd_setImageWithURL:[NSURL URLWithString:imageurl] placeholderImage:[UIImage imageNamed:imageurl]];
    }
  
    if (cornerRadius!=0) {
        image.layer.cornerRadius=cornerRadius;
    }
    image.clipsToBounds=YES;
    return image;
}
+(UILabel *)getlabelwithtexttitle:(NSString *)texttitle fram:(CGRect)fram cornerRadius:(CGFloat)cornerRadius textcolor:(UIColor *)textcolor textfont:(UIFont*)textfont backcolor:(UIColor *)backcolor textAlignment:(NSTextAlignment)textAlignment
{
    UILabel *Label=[[UILabel alloc] initWithFrame:fram];
    if (cornerRadius!=0) {
        Label.layer.cornerRadius=cornerRadius;
    }
    Label.clipsToBounds=YES;
    Label.text=texttitle;
    Label.textColor=textcolor;
    Label.font=textfont;
    Label.backgroundColor=backcolor;
    Label.textAlignment=textAlignment;
    Label.numberOfLines=0;
    return Label;
    
}
+(UIButton *)getbtnwithtexttitle:(NSString *)texttitle fram:(CGRect)fram cornerRadius:(CGFloat)cornerRadius textcolor:(UIColor *)textcolor textfont:(UIFont*)textfont backcolor:(UIColor *)backcolor{
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    if (cornerRadius!=0) {
        btn.layer.cornerRadius=cornerRadius;
    }
    btn.frame=fram;
    btn.clipsToBounds=YES;
    [btn setTitle:texttitle forState:UIControlStateNormal];
    [btn setTitleColor:textcolor forState:UIControlStateNormal];
    [btn.titleLabel setFont:textfont];
    btn.backgroundColor=backcolor;
    return btn;
}
+(UIView *)getheadviewfram:(CGRect)fram{
    UIView *headview=[[UIView alloc]initWithFrame:fram];
    headview.backgroundColor=[UIColor clearColor];
    UIView *cell1=[[UIView alloc] initWithFrame:CGRectMake(0,0,ScreenWidth, 0.7)];
    cell1.backgroundColor=RGB(238, 238, 238);
    UIView *cell2=[[UIView alloc] initWithFrame:CGRectMake(0,fram.size.height-1, ScreenWidth, 0.7)];
    cell2.backgroundColor=RGB(238, 238, 238);
    [headview addSubview:cell1];
    [headview addSubview:cell2];
    return headview;
}
+(NSString *)JsonModel:(NSDictionary *)dictModel
{
    if ([NSJSONSerialization isValidJSONObject:dictModel])
    {
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictModel options:NSJSONWritingPrettyPrinted error:nil];
        NSString * jsonStr = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        return jsonStr;
    }
    return nil;
}
+(CGFloat)getnavi_heightwithcontroller:(UIViewController *)controller
{
     CGFloat off_y=[[UIApplication sharedApplication] statusBarFrame].size.height;
    CGFloat rectNav = controller.navigationController.navigationBar.frame.size.height;
    return off_y+rectNav;
}
+(CGFloat)gettabbar_heighttwithcontroller:(UIViewController *)controller
{
    return controller.tabBarController.tabBar.frame.size.height;
}
//根据色值返回图片
+(UIImage *)createImageWithColor: (UIColor *) color
{
    CGRect rect = CGRectMake(0.0f,0.0f,1.0f,1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *myImage =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return myImage;
}
//将HTML字符串转化为NSAttributedString富文本字符串
+(NSAttributedString *)attributedStringWithHTMLString:(NSString *)htmlString
{
    NSDictionary *options = @{ NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType,
                               NSCharacterEncodingDocumentAttribute :@(NSUTF8StringEncoding) };
    
    NSData *data = [htmlString dataUsingEncoding:NSUTF8StringEncoding];
    
    return [[NSAttributedString alloc] initWithData:data options:options documentAttributes:nil error:nil];
}

//爱好只能由中文、字母组成
+ (BOOL)isValidateHobby:(NSString *)nickname
{
    NSString *realnameRegex = @"[a-zA-Z\u4e00-\u9fa5]+";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",realnameRegex];
    return [passWordPredicate evaluateWithObject:nickname];
}

//昵称，个性签名只能由中文、字母或数字组成
+ (BOOL)isValidateNick:(NSString *)nickname{
    NSString *realnameRegex = @"[a-zA-Z\u4e00-\u9fa5][a-zA-Z0-9\u4e00-\u9fa5]+";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",realnameRegex];
    return [passWordPredicate evaluateWithObject:nickname];
}

//验证真实姓名
+ (BOOL)isValidateRealname:(NSString *)realname
{
    NSString *realnameRegex = @"^[\u4e00-\u9fa5]{2,3}$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",realnameRegex];
    return [passWordPredicate evaluateWithObject:realname];
}

//验证账号是不是纯英文 或者 英文加数字
+ (BOOL)isValidateNickname:(NSString *)Nickname
{
    NSString *nameRegex = @"^(?!\\d+$)[a-zA-Z0-9]{1,}$";
    NSPredicate *nameTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",nameRegex];
    return [nameTest evaluateWithObject:Nickname];
}

//验证邮箱格式
+ (BOOL)isValidateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailRegex];
    return [emailTest evaluateWithObject:email];
}

//验证电话格式
+ (BOOL)isValidatePhone:(NSString *)phone
{
    NSString *phoneRegex = @"^((17[2,3,4,5,6,8,9])|(14[0])|(13[0-9])|(15[[0-3],[5-9]])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@", phoneRegex];
    return [phoneTest evaluateWithObject:phone];
}

//验证身份证格式
+ (BOOL)isIdNumberValid:(NSString*)idNum
{
    NSString *idNumRegex = @"^(^\\d{15}$|^\\d{18}$|^\\d{17}(\\d|X|x))$";
    NSPredicate *idNumTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@", idNumRegex];
    return [idNumTest evaluateWithObject:idNum];
}
+ (NSMutableDictionary *)getHeaderParameter
{
    NSMutableDictionary *headerDic = [[NSMutableDictionary alloc] initWithCapacity:20];
    [headerDic setValue: [PublicFunction getUUIDOfDevice] forKey:@"deviceid"];
    [headerDic setValue:[PublicFunction getConfigWithKey:@"userid"] forKey:@"userid"];
    [headerDic setValue:[PublicFunction getConfigWithKey:@"token"] forKey:@"token"];
    [headerDic setValue: @"ios" forKey:@"clienttype"];
    [headerDic setValue: @"3.0.0" forKey:@"appversion"];
    [headerDic setValue: [PublicFunction getVersionNumberOfDeviceSystem] forKey:@"devicecode"];
    [headerDic setValue:[PublicFunction getCurrentDeviceModel] forKey:@"devicename"];
    [headerDic setValue:@"app_store" forKey:@"channelid"];
    return headerDic;
}
//
+(UIImage *)stretchOldImegeWithGetNewImage:(UIImage *)imagename topScale:(CGFloat)topscale leftScale:(CGFloat)leftscale bottomScale:(CGFloat)bottomscale rightScale:(CGFloat)rightscale{
    //
    UIImage *image = imagename;
    CGFloat top = image.size.height * topscale;//0.5
    CGFloat left = image.size.width * leftscale;//1.0
    CGFloat bottom = image.size.height * bottomscale;//0.5
    CGFloat right = image.size.width * rightscale;//1.0
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(top, left, bottom, right);
    UIImageResizingMode mode = UIImageResizingModeStretch;
    UIImage *newImage = [image resizableImageWithCapInsets:edgeInsets resizingMode:mode];
    return newImage;
}
+ (NSString *)transform:(NSString *)chinese{
    //将NSString装换成NSMutableString
    NSMutableString *pinyin = [chinese mutableCopy];
    
    //将汉字转换为拼音(带音标)
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    NSLog(@"%@", pinyin);
    
    //去掉拼音的音标
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
    NSLog(@"%@", pinyin);
    
    //返回最近结果
    return pinyin;
    
}
#pragma mark 字符串转为字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
        options:NSJSONReadingMutableContainers
        error:&err];
    if(err)
    {
        ZKLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}
+(NSString *)inputTimeStr:(NSString *)timeStr

{
    NSDate *nowDate = [NSDate date];
    NSDate *sinceDate = [self becomeDateStr:timeStr];
    int i  = [nowDate timeIntervalSinceDate:sinceDate];
    NSString  *str  = @"";
    if (i <= 60)
    {//小于60s
        str = @"刚刚";
    }else if(i>60 && i<=3600)
        
    {//大于60s，小于一小时
        str = [NSString stringWithFormat:@"%d分钟前",i/60];
    }else if (i>3600 && i<60*60*24)
        
    {//
        if ([self isYesterdayWithDate:sinceDate])
            
        {//24小时内可能是昨天
            str = [NSString stringWithFormat:@"昨天"];
        }else
            
        {//今天
            str = [NSString stringWithFormat:@"%d小时前",i/3600];
        }
        
    }else
        
    {//
        int k = i/(3600*24);
        
        if ([self isYesterdayWithDate:sinceDate])
            
        {//大于24小时也可能是昨天
            
            str = [NSString stringWithFormat:@"昨天"];
            
        }else
            
        {
            //在这里大于1天的我们可以以周几的形式显示
            if (k>=1)
                
            {
                if (k < [self getNowDateWeek])
                    
                {//本周
                    str  = [self weekdayStringFromDate:[self becomeDateStr:timeStr]];
                }else
                    
                {//不是本周
                    
                    //                    str  = [NSString stringWithFormat:@"不是本周%@",[self weekdayStringFromDate:[self becomeDateStr:timeStr]]];
                    str  = [self changeDisplayTime:timeStr];
                }
                
            }else
            {//
                str = [NSString stringWithFormat:@"%d天前",i/(3600*24)];
            }
        }
        
    }
    return str;
    
}
+ (NSDate *)becomeDateStr:(NSString *)dateStr
{
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:[dateStr floatValue]/1000];
    return date;
}
//把时间转换成星期

+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate {
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"星期日", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
  //    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"zh-Hans"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];

    return [weekdays objectAtIndex:theComponents.weekday];
    
}

//判断是否为昨天

+ (BOOL)isYesterdayWithDate:(NSDate *)newDate

{
    BOOL isYesterday = YES;
    
    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    //
    
    NSDate *yearsterDay =  [[NSDate alloc] initWithTimeIntervalSinceNow:-secondsPerDay];
    
    /** 前天判断
     
     //    NSDate *qianToday =  [[NSDate alloc] initWithTimeIntervalSinceNow:-2*secondsPerDay];
     
     //    NSDateComponents* comp3 = [calendar components:unitFlags fromDate:qianToday];
     
     //    if (comp1.year == comp3.year && comp1.month == comp3.month && comp1.day == comp3.day)
     
     //    {
     
     //        dateContent = @"前天";
     
     //    }
     
     **/
    
    NSCalendar* calendar = [NSCalendar currentCalendar];
    
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    
    //    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    
    NSDateComponents* comp1 = [calendar components:unitFlags fromDate:newDate];
    
    NSDateComponents* comp2 = [calendar components:unitFlags fromDate:yearsterDay];
    
    if ( comp1.year == comp2.year && comp1.month == comp2.month && comp1.day == comp2.day)
        
    {
        
        isYesterday = YES;
        
    }else
        
    {
        isYesterday = NO;
    }
    return isYesterday;
}

//判断今天是本周的第几天

+ (int)getNowDateWeek
{
    NSDate *nowDate = [NSDate date];
    NSString *nowWeekStr = [self weekdayStringFromDate:nowDate];
    int  factWeekDay = 0;
    if ([nowWeekStr isEqualToString:@"星期日"])
    {
        factWeekDay = 7;
        
    }else if ([nowWeekStr isEqualToString:@"星期一"])
    {
        factWeekDay = 1;
    }else if ([nowWeekStr isEqualToString:@"星期二"])
    {
        factWeekDay = 2;
        
    }else if ([nowWeekStr isEqualToString:@"星期三"])
    {
        factWeekDay = 3;
    }else if ([nowWeekStr isEqualToString:@"星期四"])
    {
        factWeekDay = 4;
    }else if ([nowWeekStr isEqualToString:@"星期五"])
    {
        factWeekDay = 5;
    }else if ([nowWeekStr isEqualToString:@"星期六"])
    {
        factWeekDay = 6;
    }
    return  factWeekDay;
}
//判断是否全是空格
+(BOOL)isEmptystr:(NSString *) str {
    if (!str) {
        return true;
    } else {
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        NSString *trimedString = [str stringByTrimmingCharactersInSet:set];
        if ([trimedString length] == 0) {
            return true;
        } else {
            return false;
        }
    }
}
/**
 *  加密方式,MAC算法: HmacSHA256
 *
 *  @param plaintext 要加密的文本
 *  @param key       秘钥
 *
 *  @return 加密后的字符串
 */
+ (NSString *)hmac:(NSString *)plaintext withKey:(NSString *)key
{
    const char *cKey  = [key cStringUsingEncoding:NSASCIIStringEncoding];
    const char *cData = [plaintext cStringUsingEncoding:NSASCIIStringEncoding];
    unsigned char cHMAC[CC_SHA256_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA256, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    NSData *HMACData = [NSData dataWithBytes:cHMAC length:sizeof(cHMAC)];
    const unsigned char *buffer = (const unsigned char *)[HMACData bytes];
    NSMutableString *HMAC = [NSMutableString stringWithCapacity:HMACData.length * 2];
    for (int i = 0; i < HMACData.length; ++i){
        [HMAC appendFormat:@"%02x", buffer[i]];
    }
    
    return HMAC;
}
//创建签名
+(NSString*)creatallparimstr:(NSMutableDictionary*)dict{
    NSMutableString *contentString  =[NSMutableString string];
    for (NSString *key in dict.allKeys) {
        if ([[dict objectForKey:key] isEqual:[NSNull null]]||[[dict objectForKey:key] isEqual:@""]) {
            [dict removeObjectForKey:key];
        }
    }
    
    NSArray *keys = [dict allKeys];
    //按字母顺序排序
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    //拼接字符串
    for (NSString *categoryId in sortedArray) {
        if ( ![categoryId isEqualToString:@"sign"]
            && ![categoryId isEqualToString:@"Key"]
            ){
            [contentString appendFormat:@"%@%@", categoryId, [dict objectForKey:categoryId]];
        }
    }
    [contentString insertString:PostKey atIndex:0];
    [contentString appendFormat:@"%@", PostKey];
    NSString *transString = [contentString escapedURLString];
    NSMutableString *outputStr = [NSMutableString stringWithString:transString];
    [outputStr replaceOccurrencesOfString:@"%20"
                               withString:@"+"
                                  options:NSLiteralSearch
                                    range:NSMakeRange(0, [outputStr length])];
    [outputStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [outputStr replaceOccurrencesOfString:@"\n"
                               withString:@"%0A"
                                  options:NSLiteralSearch
                                    range:NSMakeRange(0, [outputStr length])];
    [outputStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [outputStr replaceOccurrencesOfString:@"\\"
                               withString:@"%5C"
                                  options:NSLiteralSearch
                                    range:NSMakeRange(0, [outputStr length])];
    [outputStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //得到MD5 sign签名
    //NSString *md5Sign =[WXUtil md5:outputStr];
    
    return outputStr;
}

@end
