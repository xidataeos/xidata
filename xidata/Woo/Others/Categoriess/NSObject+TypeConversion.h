//
//  NSObject+TypeConversion.h
//  NJMobileBus
//
//  Created by launching on 14-5-19.
//  Copyright (c) 2014年 launching. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (TypeConversion)

- (NSNumber *)asNSNumber;
- (NSString *)asNSString;
- (NSDate *)asNSDate;
- (NSData *)asNSData;
- (NSArray *)asNSArray;
- (NSMutableArray *)asNSMutableArray;
- (NSDictionary *)asNSDictionary;
- (NSMutableDictionary *)asNSMutableDictionary;

@end
