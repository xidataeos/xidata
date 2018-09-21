//
//  NSArray+NoCrash.m
//  zjcmcc
//
//  Created by 周中广 on 14-7-16.
//  Copyright (c) 2014年 zjcmcc. All rights reserved.
//

#import "NSArray+NoCrash.h"

@implementation NSArray (NoCrash)

- (id)objectAtIndexNoCrash:(NSInteger)index{
    NSInteger count = [self count];
    if (count-1 >= index && index>= 0) {
        return [self objectAtIndex:index];
    }
    return nil;
}
@end
