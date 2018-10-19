//
//  ShareConnectionStatus.m
//  PandaLive
//
//  Created by 李继鹏 on 2018/2/1.
//  Copyright © 2018年 sjyyt. All rights reserved.
//

#import "ShareConnectionStatus.h"

@implementation ShareConnectionStatus

+ (void)request:(NSString * _Nonnull)method url:(NSString * _Nonnull)url callback:(void (^ _Nonnull)(BOOL))callback;

{
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *sessionDataTask = [session dataTaskWithURL:[NSURL URLWithString:url] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            callback(YES);
        }else
        {
            callback(NO);
        }
    }];
    [sessionDataTask resume];
}


@end
