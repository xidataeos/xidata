//
//  UIColor+ZjcmccApplicationSpecific.m
//  zjcmcc
//
//  Created by 周中广 on 14/10/1.
//  Copyright (c) 2014年 sjyyt. All rights reserved.
//

#import "UIColor+ZjcmccApplicationSpecific.h"

@implementation UIColor (ZjcmccApplicationSpecific)

/*蓝色(#468cca):用于显示特殊的文字内容*/
+(UIColor *)zjcmcc_shareblueColor
{
    return [UIColor colorWithRed:47.0/255.0 green:164.0/255.0 blue:218/255.0 alpha:1];

}

+ (UIColor *)zjcmcc_blueColor
{
    return [UIColor colorWithRed:70/255.0 green:140/255.0 blue:202/255.0 alpha:1];
}

+ (UIColor *)zjcmcc_loginColor
{
    return [UIColor colorWithRed:50/255.0 green:156/255.0 blue:245/255.0 alpha:1];
}

+ (UIColor *)zjcmcc_charge_Color
{
    return [UIColor colorWithRed:239/255.0 green:248/255.0 blue:251/255.0 alpha:1];
}


+ (UIColor *)zjcmcc_charge_button_Color
{
    return [UIColor colorWithRed:51/255.0 green:157/255.0 blue:245/255.0 alpha:1];
}

/*绿色(#2e9858):*/
+ (UIColor *)zjcmcc_greenColor
{
    return [UIColor colorWithRed:45/255.0 green:152/255.0 blue:88/255.0 alpha:1];
}

/*玫红色*/
+ (UIColor *)zjcmcc_roseRedColor
{
    return [UIColor colorWithRed:202/255.0 green:86/255.0 blue:68/255.0 alpha:1];
}

//积分查询

+ (UIColor *)zjcmcc_point_Color
{
    return [UIColor colorWithRed:30/255.0 green:133/255.0 blue:180/255.0 alpha:1];
}

//积分查询

+ (UIColor *)zjcmcc_pointCharge_Color
{
    return [UIColor colorWithRed:254/255 green:228/255 blue:107/255 alpha:1];
}

@end
