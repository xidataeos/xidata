
//
//  WQAsiNetworkItem.m
//  zjcmcc
//
//  Created by 彩讯 on 17/1/12.
//  Copyright © 2017年 sjyyt. All rights reserved.
//

#import "WQAsiNetworkItem.h"
#import "WQAsiNetworkDefine.h"
#import "WQAsiNetworkDelegate.h"
@implementation WQAsiNetworkItem

#pragma mark - 创建一个网络请求项，开始请求网络
/**
 *  创建一个网络请求项，开始请求网络
 *
 *  @param networkType  网络请求方式
 *  @param url          网络请求URL
 *  @param params       网络请求参数
 *  @param hashValue    网络请求的委托delegate的唯一标示
 *  @param successBlock 请求成功后的block
 *  @param failureBlock 请求失败后的block
 *
 *  @return MHAsiNetworkItem对象
 */
- (WQAsiNetworkItem *)initWithtype:(MHAsiNetWorkType)networkType
                     ResuestWorkType:(WQAsiNetResuestWorkType)ResuestWorkType
                     url:(NSString *)url
                     params:(NSDictionary *)params
                     delegate:(id)delegate
                     hashValue:(NSUInteger)hashValue
                     successBlock:(MHAsiSuccessBlock)successBlock
                     failureBlock:(MHAsiFailureBlock)failureBlock
{
    if (self = [super init])
    {
       NSString *urlStr = [url stringByReplacingOccurrencesOfString:@" " withString:@""];
        self.networkType    = networkType;
        self.url            = url;
        self.params         = params;
        __weak typeof(self)weakSelf = self;
        ZKLog(@"--请求url地址--%@\n",url);
        ZKLog(@"----请求参数%@\n",params);
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.requestSerializer.timeoutInterval = 30;
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
        
        if (networkType==MHAsiNetWorkGET)
        {
            [manager GET:urlStr parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id responseObject) {
                ZKLog(@"\n\n----请求的返回结果 %@\n",responseObject);
                if (successBlock) {
                    successBlock(responseObject);
                }
                [weakSelf removewItem];
            } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
                ZKLog(@"---error==%@\n",error.localizedDescription);
                if (failureBlock) {
                    failureBlock(error);
                }
                [weakSelf removewItem];
            }];
            
        }else{
            [manager POST:urlStr parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id responseObject) {
                ZKLog(@"\n\n----请求的返回结果 %@\n",responseObject);
                if (successBlock) {
                    successBlock(responseObject);
                }
                [weakSelf removewItem];
            } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
                ZKLog(@"---error==%@\n",error.localizedDescription);
                if (failureBlock) {
                    failureBlock(error);
                }
                [weakSelf removewItem];
            }];
        }
    }
    return self;
}
/**
 *   移除网络请求项
 */
- (void)removewItem
{
    __weak typeof(self)weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if ([weakSelf.delegate respondsToSelector:@selector(netWorkWillDealloc:)]) {
            [weakSelf.delegate netWorkWillDealloc:weakSelf];
        }
    });
}

@end
