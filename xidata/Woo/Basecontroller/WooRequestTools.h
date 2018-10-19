//
//  WooRequestTools.h
//  Woo
//
//  Created by 风外杏林香 on 2018/7/26.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//宏定义成功block 回调成功后得到的信息
typedef void (^HttpRequestSuccess)(id data);
//宏定义失败block 回调失败信息
typedef void (^HttpRequestFailure)(NSError *error);
/**
 *  网络请求类型
 */
typedef NS_ENUM(NSUInteger,HttpRequestType) {
    /**
     *  get请求
     */
    HttpRequestTypeGet = 0,
    /**
     *  post请求
     */
    HttpRequestTypePost
};
@interface WooRequestTools : NSObject

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
                showView:(UIView *)showView;
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
                 showView:(UIView *)showView;


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
                    showView:(UIView *)showView;

/*
 * 上传多张图片封装
 */
+ (void)commitPictureWithDict:(NSDictionary *)dictionary//上传图片时可能有的附加条件如userid;
                withUrlString:(NSString *)ulrStr
                    withImage:(NSDictionary *)imageDict//存图片的字典
                      success:(void (^)(id responseObject))success
                      failure:(void (^)(NSError *error))failure
                     showView:(UIView *)showView;
/**
 *  网络判断
 *
 *  @return YES 有网 WIFI/WWAN  NO 无网络连接
 */
+ (BOOL)isNetWorkConnectionAvailable;

@end
