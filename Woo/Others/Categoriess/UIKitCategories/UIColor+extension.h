//
//  UIColor+extension.h
//  zjcmcc
//
//  Created by xxd on 15-1-15.
//  Copyright (c) 2015年 sjyyt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIColor (extension)

+ (UIColor*) colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue;
+ (UIColor*) colorWithHex:(NSInteger)hexValue;
+ (NSString *) hexFromUIColor: (UIColor*) color;

@end
