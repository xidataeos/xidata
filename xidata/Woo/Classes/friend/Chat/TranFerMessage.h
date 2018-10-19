//
//  TranFerMessage.h
//  Woo
//
//  Created by 王起锋 on 2018/8/27.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import <RongIMLib/RongIMLib.h>
#define TranFerMessageIdentifier @"TranFerMsg"
@interface TranFerMessage : RCMessageContent
@property(nonatomic, copy) NSString *TranFerZize;//红包大小
@property(nonatomic, copy) NSString *content;
@property(nonatomic, copy) NSString *TranSingleId;//转账ID
+(instancetype)messageWithredZize:(NSString *)TranFerZize content:(NSString *)content TranSingleId:(NSString *)TranSingleId;
@end
