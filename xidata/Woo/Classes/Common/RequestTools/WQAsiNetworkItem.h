//
//  WQAsiNetworkItem.h
//  zjcmcc
//
//  Created by 彩讯 on 17/1/12.
//  Copyright © 2017年 sjyyt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WQAsiNetworkDefine.h"
#import "WQAsiNetworkDelegate.h"// 请求管理着
@interface WQAsiNetworkItem : NSObject
/**
 *  网络请求方式
 */
@property (nonatomic, assign) MHAsiNetWorkType networkType;

/**
 *  网络请求URL
 */
@property (nonatomic, strong) NSString *url;

/**
 *  网络请求参数
 */
@property (nonatomic, strong) NSDictionary *params;

/**
 *  网络请求的委托
 */
@property (nonatomic, assign) id<MHAsiNetworkDelegate>delegate;
/**
 *  是否显示HUD
 */

#pragma mark - 创建一个网络请求项，开始请求网络
/**
 *  创建一个网络请求项，开始请求网络
 *
 *  @param networkType  网络请求方式
 *  @param url          网络请求URL
 *  @param params       网络请求参数
 *  @param delegate     网络请求的委托，如果没有取消网络请求的需求，可传nil
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
                      failureBlock:(MHAsiFailureBlock)failureBlock;

@end
