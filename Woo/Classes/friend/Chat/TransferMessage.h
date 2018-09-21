//
//  TranFerMessage.h
//  Woo
//
//  Created by 王起锋 on 2018/8/27.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import <RongIMLib/RongIMLib.h>
#define TranFerMessageIdentifier @"TransferMsg"
@interface TransferMessage : RCMessageContent
@property(nonatomic, copy) NSString *asset;//红包大小
@property(nonatomic, copy) NSString *tip;
@property(nonatomic,copy)NSString *mode;
@property(nonatomic,copy)NSString *recv;
@property(nonatomic, copy) NSString *redId;//红包ID
+(instancetype)messageWithredZize:(NSString *)asset  tip:(NSString *)tip redId:(NSString *)redId recv:(NSString *)recv mode:(NSString *)mode;
@end
