//
//  AfnetHttpsTool.h
//  zjcmcc
//
//  Created by 彩讯 on 17/1/12.
//  Copyright © 2017年 sjyyt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WQUploadParam.h"
#import "WQAsiNetworkHandler.h"
#import "WQAsiNetworkDefine.h"
#import "WQAsiNetworkDelegate.h"// 请求管理着
@interface AfnetHttpsTool : NSObject

// 返回单例
+(instancetype)sharedInstance;

#pragma mark - 发送 GET 请求的方法
/**
 *   GET请求通过Block 回调结果
 *
 *   @param url          url
 *   @param paramsDict   paramsDict
 *   @param successBlock  成功的回调
 *   @param failureBlock  失败的回调
 */
+ (void)getRequstWithURL:(NSString*)url
            ResuestWorkType:(WQAsiNetResuestWorkType)ResuestWorkType
             params:(NSDictionary*)paramsDict
            successBlock:(MHAsiSuccessBlock)successBlock
failureBlock:(MHAsiFailureBlock)failureBlock;

#pragma mark - 发送 POST 请求的方法
/**
 *   通过 Block回调结果
 *
 *   @param url           url
 *   @param paramsDict    请求的参数字典
 *   @param successBlock  成功的回调
 *   @param failureBlock  失败的回调
 */
+ (void)postReqeustWithURL:(NSString*)url
              ResuestWorkType:(WQAsiNetResuestWorkType)ResuestWorkType
              params:(NSDictionary*)paramsDict
              successBlock:(MHAsiSuccessBlock)successBlock
              failureBlock:(MHAsiFailureBlock)failureBlock;


/**
 *  上传文件
 *
 *  @param url          上传文件的 url 地址
 *  @param paramsDict   参数字典
 *  @param successBlock 成功
 *  @param failureBlock 失败
 */
+ (void)uploadFileWithURL:(NSString*)url
                   params:(NSDictionary*)paramsDict
             successBlock:(MHAsiSuccessBlock)successBlock
failureBlock:(MHAsiFailureBlock)failureBlock
uploadParam:(WQUploadParam *)uploadParam;


@end
