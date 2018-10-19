//
//  ShareConnectionStatus.h
//  PandaLive
//
//  Created by 李继鹏 on 2018/2/1.
//  Copyright © 2018年 sjyyt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShareConnectionStatus : NSObject

+ (void)request:(NSString * _Nonnull)method url:(NSString * _Nonnull)url callback:(void (^ _Nonnull)(BOOL))callback;

@end
