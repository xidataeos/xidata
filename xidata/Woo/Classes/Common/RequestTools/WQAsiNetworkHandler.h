//
//  WQAsiNetworkHandler.h
//  zjcmcc
//
//  Created by 彩讯 on 17/1/12.
//  Copyright © 2017年 sjyyt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WQAsiNetworkDefine.h"
@class WQAsiNetworkItem;

/**
 *  网络请求Handler类
 */
@interface WQAsiNetworkHandler : NSObject
/**
 *  单例
 *
 *  @return BMNetworkHandler的单例对象
 */
+ (WQAsiNetworkHandler *)sharedInstance;

/**
 *  items
 */
@property(nonatomic,strong)NSMutableArray *items;

/**
 *   单个网络请求项
 */
@property(nonatomic,strong)WQAsiNetworkItem *netWorkItem;

/**
 *  networkError
 */
@property(nonatomic,assign)BOOL networkError;

#pragma mark - 创建一个网络请求项
/**
 *  创建一个网络请求项
 *
 *  @param url          网络请求URL
 *  @param networkType  网络请求方式
 *  @param params       网络请求参数
 *  @param delegate     网络请求的委托，如果没有取消网络请求的需求，可传nil
 *  @param successBlock 请求成功后的block
 *  @param failureBlock 请求失败后的block
 *
 *  @return 根据网络请求的委托delegate而生成的唯一标示
 */
- (WQAsiNetworkItem*)conURL:(NSString *)url
            ResuestWorkType:(WQAsiNetResuestWorkType)ResuestWorkType
            networkType:(MHAsiNetWorkType)networkType
            params:(NSMutableDictionary *)params
            delegate:(id)delegate
            successBlock:(MHAsiSuccessBlock)successBlock
            failureBlock:(MHAsiFailureBlock)failureBlock;
/**
 *   监听网络状态的变化
 */
+ (void)startMonitoring;
/**
 *   取消所有正在执行的网络请求项
 */
+ (void)cancelAllNetItems;
@end
