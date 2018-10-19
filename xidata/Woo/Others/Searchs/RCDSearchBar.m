//
//  RCDSearchBar.m
//  RCloudMessage
//
//  Created by 张改红 on 16/9/7.
//  Copyright © 2016年 RongCloud. All rights reserved.
//

#import "RCDSearchBar.h"

@implementation RCDSearchBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.placeholder = @"搜索";
        self.keyboardType = UIKeyboardTypeDefault;
        self.backgroundImage = [self getImageWithColor:[UIColor whiteColor] andHeight:44.0f];
        //设置顶部搜索栏的背景色
        [self setBackgroundColor:[PublicFunction colorWithHexString:@"0xf0f0f6"]];
        //设置顶部搜索栏输入框的样式
        UITextField *searchField = [self valueForKey:@"_searchField"];
        searchField.backgroundColor=CellBackgroundColor;
        searchField.layer.borderWidth = 0.5f;
        searchField.layer.borderColor = [PublicFunction colorWithHexString:@"0xdfdfdf"].CGColor;
        searchField.layer.cornerRadius = 8.f;
    }
    return self;
}
-(UIImage *)getImageWithColor:(UIColor *)color andHeight:(CGFloat)height {
    CGRect r = CGRectMake(0.0f, 0.0f, 1.0f, height);
    UIGraphicsBeginImageContext(r.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, r);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}
@end
