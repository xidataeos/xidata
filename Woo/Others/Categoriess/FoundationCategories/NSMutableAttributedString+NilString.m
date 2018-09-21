//
//  NSMutableAttributedString+NilString.m
//  zjcmcc
//
//  Created by 周中广 on 15/1/4.
//  Copyright (c) 2015年 sjyyt. All rights reserved.
//

#import "NSMutableAttributedString+NilString.h"

@implementation NSMutableAttributedString (NilString)

- (instancetype)initWithNotNilString:(NSString *)str{
    if ([PublicFunction isEmpty:str]) {
        str = @"";
    }
    NSMutableAttributedString * attStr = [self initWithString:str];
    return attStr;
}

- (instancetype)initWithNotNilString:(NSString *)str attributes:(NSDictionary *)attrs{
    if ([PublicFunction isEmpty:str]) {
        str = @"";
    }
    NSMutableAttributedString * attStr = [self initWithString:str attributes:attrs];
    return attStr;
}

@end
