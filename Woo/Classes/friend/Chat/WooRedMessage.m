
//
//  WooRedMessage.m
//  Woo
//
//  Created by 王起锋 on 2018/8/15.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import "WooRedMessage.h"

@implementation WooRedMessage
///初始化
+ (instancetype)messageWithredZize:(NSString *)redZize redCount:(NSString *)redCount content:(NSString *)content redSingleId:(NSString *)redSingleId {
    WooRedMessage *message = [[WooRedMessage alloc] init];
    if (message) {
        message.content = content;
        message.redCount=redCount;
        message.redZize=redZize;
        message.redSingleId=redSingleId;
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
        self.redCount = [aDecoder decodeObjectForKey:@"redCount"];
        self.redZize = [aDecoder decodeObjectForKey:@"redZize"];
        self.redSingleId=[aDecoder decodeObjectForKey:@"redSingleId"];
        self.content=[aDecoder decodeObjectForKey:@"content"];
    }
    return self;
}

/// NSCoding
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.redCount forKey:@"redCount"];
    [aCoder encodeObject:self.redZize forKey:@"redZize"];
    [aCoder encodeObject:self.content forKey:@"content"];
    [aCoder encodeObject:self.redSingleId forKey:@"redSingleId"];
}

///将消息内容编码成json
- (NSData *)encode {
    NSMutableDictionary *dataDict = [NSMutableDictionary dictionary];
    [dataDict setObject:self.redCount forKey:@"redCount"];
    [dataDict setObject:self.content forKey:@"content"];
    [dataDict setObject:self.redSingleId forKey:@"redSingleId"];
    if (self.redZize) {
        [dataDict setObject:self.redZize forKey:@"redZize"];
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
            self.redZize = dictionary[@"redZize"];
            self.redCount = dictionary[@"redCount"];
            self.content = dictionary[@"content"];
            self.redSingleId = dictionary[@"redSingleId"];
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
    return WooRedMessageIdentifier;
}

@end
