
//
//  AfnetHttpsTool.m
//  zjcmcc
//
//  Created by 彩讯 on 17/1/12.
//  Copyright © 2017年 sjyyt. All rights reserved.
//

#import "AfnetHttpsTool.h"
@implementation AfnetHttpsTool

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static AfnetHttpsTool *_manager;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [super allocWithZone:zone];
    });
    return _manager;
}
/// 返回单例
+(instancetype)sharedInstance
{
    return [[super alloc] init];
}
#pragma mark - GET 请求的三种回调方法
/**
 *   GET请求的公共方法 方法都调用这个方法 根据传入的不同参数觉得回调的方式
 *
 *   @param url           ur
 *   @param params   paramsDict
 *   @param delegate     delegate
 *   @param successBlock successBlock
 *   @param failureBlock failureBlock
 */
+ (void)getRequstWithURL:(NSString*)url
                ResuestWorkType:(WQAsiNetResuestWorkType)ResuestWorkType
                  params:(NSDictionary*)params
                delegate:(id)delegate
            successBlock:(MHAsiSuccessBlock)successBlock
            failureBlock:(MHAsiFailureBlock)failureBlock
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionaryWithDictionary:params];
    [[WQAsiNetworkHandler sharedInstance]conURL:url ResuestWorkType:ResuestWorkType networkType:MHAsiNetWorkGET params:mutableDict delegate:delegate successBlock:successBlock failureBlock:failureBlock];
}

/**
 *   GET请求通过Block 回调结果
 *
 *   @param url          url
 *   @param params   paramsDict
 *   @param successBlock  成功的回调
 *   @param failureBlock  失败的回调
 */
+ (void)getRequstWithURL:(NSString*)url
                 ResuestWorkType:(WQAsiNetResuestWorkType)ResuestWorkType
                  params:(NSDictionary*)params
            successBlock:(MHAsiSuccessBlock)successBlock
            failureBlock:(MHAsiFailureBlock)failureBlock
{
    [self getRequstWithURL:url ResuestWorkType:ResuestWorkType params:params delegate:nil successBlock:successBlock failureBlock:failureBlock];
}
#pragma mark - POST请求的三种回调方法
/**
 *   发送一个 POST请求的公共方法 传入不同的回调参数决定回调的方式
 *
 *   @param url           ur
 *   @param params   paramsDict
 *   @param delegate     delegate
 *   @param successBlock successBlock
 *   @param failureBlock failureBlock
 */
+ (void)postReqeustWithURL:(NSString*)url
                    ResuestWorkType:(WQAsiNetResuestWorkType)ResuestWorkType
                    params:(NSDictionary*)params
              delegate:(id<MHAsiNetworkDelegate>)delegate
              successBlock:(MHAsiSuccessBlock)successBlock
              failureBlock:(MHAsiFailureBlock)failureBlock
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionaryWithDictionary:params];
    [[WQAsiNetworkHandler sharedInstance]conURL:url ResuestWorkType:WQAsiNetWorkJson networkType:MHAsiNetWorkPOST params:mutableDict delegate:nil successBlock:successBlock failureBlock:failureBlock];
}
/**
 *   通过 Block回调结果
 *
 *   @param url           url
 *   @param params    请求的参数字典
 *   @param successBlock  成功的回调
 *   @param failureBlock  失败的回调

 */
+ (void)postReqeustWithURL:(NSString*)url
                    ResuestWorkType:(WQAsiNetResuestWorkType)ResuestWorkType
                    params:(NSDictionary*)params
              successBlock:(MHAsiSuccessBlock)successBlock
              failureBlock:(MHAsiFailureBlock)failureBlock
{
    [self postReqeustWithURL:url ResuestWorkType:ResuestWorkType params:params delegate:nil successBlock:successBlock failureBlock:failureBlock];
}

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
              uploadParam:(WQUploadParam *)uploadParam
{
    ZKLog(@"上传图片接口 URL-> %@",url);
    ZKLog(@"上传图片的参数-> %@",paramsDict);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 90;
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    //本地证书文件验证
    //        NSString * cerPath = [[NSBundle mainBundle] pathForResource:@"xxx" ofType:@"cer"];
    //        NSData * cerData = [NSData dataWithContentsOfFile:cerPath];
    // 2.设置证书模式
    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    // 客户端是否信任非法证书
    manager.securityPolicy.allowInvalidCertificates = YES;
    // 是否在证书域字段中验证域名
    [manager.securityPolicy setValidatesDomainName:NO];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html",@"text/plain",nil];
    
    
    //AFJSONResponseSerializer *jsonSer =(AFJSONResponseSerializer*) manager.responseSerializer;
    // jsonSer.removesKeysWithNullValues = YES;
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    
    [manager POST:url parameters:paramsDict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (uploadParam.name.length!=0) {
            [formData appendPartWithFileData:uploadParam.data name:uploadParam.name fileName:uploadParam.fileName mimeType:uploadParam.mimeType];
        }
        if (uploadParam.name1.length!=0)
        {
            [formData appendPartWithFileData:uploadParam.data1 name:uploadParam.name1 fileName:uploadParam.fileName mimeType:uploadParam.mimeType];
        }
         
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ZKLog(@"----> %@",responseObject);
        if (successBlock) {
            successBlock(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ZKLog(@"----> %@",error.domain);
        if (error) {
            failureBlock(error);
        }
    }];
}


@end
