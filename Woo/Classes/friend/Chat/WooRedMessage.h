//
//  WooRedMessage.h
//  Woo
//
//  Created by 王起锋 on 2018/8/15.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import <RongIMLib/RongIMLib.h>
#define WooRedMessageIdentifier @"WooRedMsg"
@interface WooRedMessage : RCMessageContent
@property(nonatomic, copy) NSString *redZize;//红包大小
@property(nonatomic, copy) NSString *redCount;//红包个数
@property(nonatomic, copy) NSString *content;
@property(nonatomic, copy) NSString *redSingleId;//红包ID
+(instancetype)messageWithredZize:(NSString *)redZize redCount:(NSString *)redCount content:(NSString *)content redSingleId:(NSString *)redSingleId;
@end
