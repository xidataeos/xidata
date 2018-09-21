//
//  UIDevice+SADevice.m
//  SouthAsiaLottery
//
//  Created by 风外杏林香 on 2017/9/1.
//  Copyright © 2017年 风外杏林香. All rights reserved.
//

#import "UIDevice+SADevice.h"

@implementation UIDevice (SADevice)
//调用私有方法实现
+ (void)setOrientation:(UIInterfaceOrientation)orientation {
    SEL selector = NSSelectorFromString(@"setOrientation:");
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[self instanceMethodSignatureForSelector:selector]];
    [invocation setSelector:selector];
    [invocation setTarget:[self currentDevice]];
    int val = orientation;
    [invocation setArgument:&val atIndex:2];
    [invocation invoke];
}

@end
