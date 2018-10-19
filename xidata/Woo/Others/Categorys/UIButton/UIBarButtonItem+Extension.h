//
//  UIBarButtonItem+Extension.h
//  yoowei
//
//  Created by yoowei on 14-10-7.
//  Copyright (c) 2014年 weiyong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage;
@end
