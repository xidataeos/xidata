//
//  UIButton+Category.m
//  MarriageLeLe
//
//  Created by 结婚乐 on 15/9/23.
//  Copyright (c) 2015年 hunShang.com. All rights reserved.
//

#import "UIButton+Category.h"
#import "UIView+ZLExtension.h"
@implementation UIButton (Category)

/**
 *  @param image          正常图片
 *  @param highlightImage 高亮图片
 */
- (void)buttonWithImage:(NSString *)image highlightImage:(NSString *)highlightImage
{
    //设置图片
    [self setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [self setImage:[UIImage imageNamed:highlightImage] forState:UIControlStateHighlighted];
    //设置尺寸
    self.zl_size = self.currentImage.size;
   
}

@end
