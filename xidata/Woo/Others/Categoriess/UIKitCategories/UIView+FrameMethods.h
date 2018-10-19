//
//  UIView+FrameMethods.h
//  zjcmcc
//
//  Created by xxd on 15-1-11.
//  Copyright (c) 2015年 sjyyt. All rights reserved.
//


@interface  UIView(FrameMethods)
- (void)moveToHorizontal:(CGFloat)horizontal toVertical:(CGFloat)vertical;

- (void)moveToHorizontal:(CGFloat)horizontal toVertical:(CGFloat)vertical setWidth:(CGFloat)width setHeight:(CGFloat)height;

- (void)moveHorizontal:(CGFloat)horizontal vertical:(CGFloat)vertical addWidth:(CGFloat)widthAdded addHeight:(CGFloat)heightAdded;


//Set width/height

- (void)setWidth:(CGFloat)width height:(CGFloat)height;

- (void)setWidth:(CGFloat)width;

- (void)setHeight:(CGFloat)height;

//Add width/height

- (void)addWidth:(CGFloat)widthAdded addHeight:(CGFloat)heightAdded;

- (void)addWidth:(CGFloat)widthAdded;

- (void)addHeight:(CGFloat)heightAdded;

//Set corner radius

- (void)setCornerRadius:(CGFloat)radius;

- (void)setCornerRadius:(CGFloat)radius borderColor:(UIColor *)borderColor;

- (CGRect)frameInWindow;

@end