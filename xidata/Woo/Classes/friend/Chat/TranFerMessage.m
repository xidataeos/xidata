//
//  TranFerMessage.m
//  Woo
//
//  Created by 王起锋 on 2018/8/27.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import "TranFerMessage.h"

@implementation TranFerMessage
///初始化
+(instancetype)messageWithredZize:(NSString *)TranFerZize content:(NSString *)content
{
    TranFerMessage *message = [[TranFerMessage alloc] init];
    if (message) {
        message.content = content;
        message.TranFerZize=TranFerZize;
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
        self.TranFerZize = [aDecoder decodeObjectForKey:@"TranFerZize"];
        self.content=[aDecoder decodeObjectForKey:@"content"];
    }
    return self;
}

/// NSCoding
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.TranFerZize forKey:@"TranFerZize"];
    [aCoder encodeObject:self.content forKey:@"content"];
}

///将消息内容编码成json
- (NSData *)encode {
    NSMutableDictionary *dataDict = [NSMutableDictionary dictionary];
    [dataDict setObject:self.content forKey:@"content"];
    if (self.TranFerZize) {
        [dataDict setObject:self.TranFerZize forKey:@"TranFerZize"];
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
            self.TranFerZize = dictionary[@"TranFerZize"];
            self.content = dictionary[@"content"];
            NSDictionary *userinfoDic = dictionary[@"user"];
            [self decodeUserInfo:userinfoDic];
        }
    }
}
/// 会话列表中显示的摘要
- (NSString *)conversationDigest {
    return self.content;
}

///消息的类型名
+ (NSString *)getObjectName {
    return TranFerMessageIdentifier;
}
@end
