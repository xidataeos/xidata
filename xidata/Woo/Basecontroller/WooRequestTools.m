//
//  WooRequestTools.m
//  Woo
//
//  Created by 风外杏林香 on 2018/7/26.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import "WooRequestTools.h"
#import "WooHeader.h"
@implementation WooRequestTools
/**
 *  发送get请求
 *
 *  @param urlString  请求的网址字符串
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
+ (void)getWithUrlString:(NSString *)urlString
              parameters:(NSDictionary *)parameters
                 success:(HttpRequestSuccess)success
                 failure:(HttpRequestFailure)failure
                showView:(UIView *)showView
{
    if ([self isNetWorkConnectionAvailable]) {
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        //请求内容类型
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.requestSerializer.timeoutInterval = 10;
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css", @"text/plain", @"application/x-javascript", @"application/javascript", nil];
        NSMutableDictionary *allDic = [NSMutableDictionary dictionary];
        [allDic addEntriesFromDictionary:parameters];
        [allDic setValue:@"1" forKey:@"appVersion"];
        NSString *isLogin = [UserDefaults objectForKey:@"isLogin"];
        if ([isLogin intValue] != 0) {
            [allDic setValue:[UserDefaults objectForKey:@"clientUserSession"] forKey:@"clientUserSession"];
        }
        [allDic setValue:@"1" forKey:@"version"];
        NSString *urlStr = [NSString stringWithFormat:@"%@%@", @"域名", urlString];
        if ([urlStr isEqualToString:@"http://client.jicai500.com/lottery/app_buy_lottery.htm?"]) {
            [allDic setValue:@"3" forKey:@"requestType"];
        } else {
            [allDic setValue:@"" forKey:@"requestType"];
        }
        //        输出URL
        NSMutableString *keyValue = [[NSMutableString alloc]init];
        [allDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [keyValue appendFormat:@"%@=%@&",key,(NSString *)obj];
        }];
        NSLog(@"当前网址：%@?%@",urlStr,keyValue);
        
        //get请求
        [manager GET:urlStr parameters:allDic progress:^(NSProgress * _Nonnull downloadProgress) {
            //请求的进度（此处可为显示下载的进度条）
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (success) {
                NSDictionary *dictionary = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                success(dictionary);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failure) {
                failure(error);
            }
        }];
        
    } else {
        //        NSLog(@"当前无网络链接...");
    }
}
/**
 *  发送post请求
 *
 *  @param urlString  请求的网址字符串
 *  @param parameters 请求的参数
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
+ (void)postWithUrlString:(NSString *)urlString
               parameters:(NSDictionary *)parameters
                  success:(HttpRequestSuccess)success
                  failure:(HttpRequestFailure)failure
                 showView:(UIView *)showView
{
    if ([self isNetWorkConnectionAvailable]) {
        //创建请求管理者
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        //
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.requestSerializer.timeoutInterval = 15;
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        //请求内容类型
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css", @"text/plain", @"application/x-javascript", @"application/javascript", nil];
        NSMutableDictionary *allDic = [NSMutableDictionary dictionary];
        [allDic addEntriesFromDictionary:parameters];
        [allDic setValue:@"2" forKey:@"appVersion"];
        [allDic setValue:@"1" forKey:@"version"];
        NSString *isLogin = [UserDefaults objectForKey:@"isLogin"];
        if ([isLogin intValue] != 0) {
            [allDic setValue:[UserDefaults objectForKey:@"clientUserSession"] forKey:@"clientUserSession"];
        }
        NSString *urlStr = [NSString stringWithFormat:@"%@%@", @"域名", urlString];
        if ([urlString isEqualToString:@"lottery/app_buy_lottery.htm"]) {
            [allDic setValue:@"3" forKey:@"requestType"];
        } else {
            [allDic setValue:@"" forKey:@"requestType"];
        }
        
        //输出URL
        NSMutableString *keyValue = [[NSMutableString alloc]init];
        [allDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [keyValue appendFormat:@"%@=%@&",key,(NSString *)obj];
        }];
        NSLog(@"当前网址：%@?%@",urlStr,keyValue);
        //post请求
        [manager POST:urlStr parameters:allDic progress:^(NSProgress * _Nonnull uploadProgress) {
            //请求的进度（此处可为显示下载的进度条）
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (success) {
                NSDictionary *dictionary = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                success(dictionary);
            }
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failure) {
                failure(error);
            }
            
        }];
        
    } else {
        NSLog(@"当前无网络连接...");
    }
}


/**
 *  发送网络请求
 *
 *  @param urlString   请求的网址字符串
 *  @param parameters  请求的参数
 *  @param type        请求的类型
 *  @param success     请求的结果
 */
+ (void)requestWithURLString:(NSString *)urlString
                  parameters:(id)parameters
                        type:(HttpRequestType)type
                     success:(void (^)(id responseObject))success
                     failure:(void (^)(NSError *error))failure
                    showView:(UIView *)showView
{
    if ([self isNetWorkConnectionAvailable]) {
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.requestSerializer.timeoutInterval = 10;
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css", @"text/plain", @"application/x-javascript", @"application/javascript", nil];
        switch (type) {
            case HttpRequestTypeGet:
            {
                [manager GET:urlString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
                    //请求的进度（此处可为显示下载的进度条）
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    if (success) {
                        success(responseObject);
                    }
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    if (failure) {
                        failure(error);
                    }
                }];
            }
                break;
            case HttpRequestTypePost:
            {
                [manager POST:urlString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
                    //请求的进度（此处可为显示下载的进度条）
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    if (success) {
                        success(responseObject);
                    }
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    if (failure) {
                        failure(error);
                    }
                }];
            }
                break;
                
            default:
                break;
        }
        
    } else {
        
    }

}

/*
 * 上传多张图片封装
 */
+ (void)commitPictureWithDict:(NSDictionary *)dictionary//上传图片时可能有的附加条件如userid;
                withUrlString:(NSString *)ulrStr//存图片的字典
                    withImage:(NSDictionary *)imageDict//存图片的字典
                      success:(void (^)(id responseObject))success
                      failure:(void (^)(NSError *error))failure
                     showView:(UIView *)showView
{
    if ([self isNetWorkConnectionAvailable]) {
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css", @"text/plain", @"application/x-javascript", @"application/javascript", nil];
        NSString *urlString = [NSString stringWithFormat:@"%@%@", @"", ulrStr];
        NSMutableString *keyValue = [[NSMutableString alloc]init];
        [dictionary enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [keyValue appendFormat:@"%@=%@&",key,(NSString *)obj];
        }];
        NSLog(@"当前网址：%@?%@",urlString,keyValue);
        
        [manager POST:urlString parameters:dictionary constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            for (id key in imageDict) {
                //FileData:图片压缩后的data类型
                //name: 后台规定的key
                //fileName:自己给文件起名
                //mimeType :图片类型
                NSData *data = UIImageJPEGRepresentation([UIImage imageWithContentsOfFile:[imageDict objectForKey:key]], 1);
                UIImage *imageSource = [UIImage imageWithData:data];
                [formData appendPartWithFileData:data name:[NSString stringWithFormat:@"file"] fileName:[NSString stringWithFormat:@"%f.jpg", imageSource.size.width * imageSource.size.height] mimeType:@"jpg/png"];
            }
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            //请求的进度（此处可为显示下载的进度条）
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failure) {
                failure(error);
            }
        }];
        
        
    } else {
        
    }
    
}

/**
 *  网络判断
 *
 *  @return YES 有网 WIFI/WWAN  NO 无网络连接
 */
+ (BOOL)isNetWorkConnectionAvailable
{
    BOOL isExistenceNetWork = YES;
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    switch ([reach currentReachabilityStatus]) {
        case NotReachable:
            isExistenceNetWork = NO;
            break;
        case ReachableViaWiFi:
            isExistenceNetWork = YES;
            break;
        case ReachableViaWWAN:
            isExistenceNetWork = YES;
            break;
            
        default:
            break;
    }
    return isExistenceNetWork;
}
@end
