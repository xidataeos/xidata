//
//  TranFerMessage.m
//  Woo
//
//  Created by 王起锋 on 2018/8/27.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import "TransferMessage.h"

@implementation TransferMessage
///初始化
+(instancetype)messageWithredZize:(NSString *)asset  tip:(NSString *)tip redId:(NSString *)redId recv:(NSString *)recv mode:(NSString *)mode {
    TransferMessage *message = [[TransferMessage alloc] init];
    if (message) {
        message.asset = asset;
        message.tip=tip;
        message.redId=redId;
        message.recv=recv;
        message.mode=mode;
    }
    return message;
}

///消息是否存储，是否计入未读数
+ (RCMessagePersistent)persistentFlag {
    return (MessagePersistent_ISPERSISTED | MessagePersistent_ISCOUNTED);
}

/// NSCoding
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.asset = [aDecoder decodeObjectForKey:@"asset"];
        self.tip = [aDecoder decodeObjectForKey:@"tip"];
        self.redId=[aDecoder decodeObjectForKey:@"redId"];
        self.recv=[aDecoder decodeObjectForKey:@"recv"];
        self.mode=[aDecoder decodeObjectForKey:@"mode"];
    }
    return self;
}

/// NSCoding
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.asset forKey:@"asset"];
    [aCoder encodeObject:self.tip forKey:@"tip"];
    [aCoder encodeObject:self.redId forKey:@"redId"];
    [aCoder encodeObject:self.recv forKey:@"recv"];
    [aCoder encodeObject:self.mode forKey:@"mode"];
}

///将消息内容编码成json
- (NSData *)encode {
    NSMutableDictionary *dataDict = [NSMutableDictionary dictionary];
    [dataDict setObject:self.recv forKey:@"recv"];
    [dataDict setObject:self.mode forKey:@"mode"];
    [dataDict setObject:self.tip forKey:@"tip"];
    [dataDict setObject:self.redId forKey:@"redId"];
    if (self.asset) {
        [dataDict setObject:self.asset forKey:@"asset"];
    }
    
    if (self.senderUserInfo) {
        NSMutableDictionary *userInfoDic = [[NSMutableDictionary alloc] init];
        if (self.senderUserInfo.name) {
            [userInfoDic setObject:self.senderUserInfo.name forKeyedSubscript:@"name"];
        }
        if (self.senderUserInfo.portraitUri) {
            [userInfoDic setObject:self.senderUserInfo.portraitUri forKeyedSubscript:@"portrait"];
        }
        if (self.senderUserInfo.userId) {
            [userInfoDic setObject:self.senderUserInfo.userId forKeyedSubscript:@"id"];
        }
        [dataDict setObject:userInfoDic forKey:@"user"];
    }
    NSData *data = [NSJSONSerialization dataWithJSONObject:dataDict options:kNilOptions error:nil];
    return data;
}

///将json解码生成消息内容
- (void)decodeWithData:(NSData *)data {
    if (data) {
        __autoreleasing NSError *error = nil;
        
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        if (dictionary) {
            self.tip = dictionary[@"tip"];
            self.redId = dictionary[@"redId"];
            self.recv = dictionary[@"recv"];
            self.mode = dictionary[@"mode"];
            self.asset = dictionary[@"asset"];
            NSDictionary *userinfoDic = dictionary[@"user"];
            [self decodeUserInfo:userinfoDic];
        }
    }
}
/// 会话列表中显示的摘要
- (NSString *)conversationDigest {
    return self.tip;
}

///消息的类型名
+ (NSString *)getObjectName {
    return TranFerMessageIdentifier;
}
@end
