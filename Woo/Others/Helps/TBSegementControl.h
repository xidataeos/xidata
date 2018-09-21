//
//  TBSegementContrl.h
//  DefineSegementControl
//
//  Created by Pengfei_Luo on 15/11/9.
//  Copyright © 2015年 骆朋飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TBSegementControlDelegate;
@interface TBSegementControl : UIView

@property (nonatomic, assign) id<TBSegementControlDelegate> delegate;
/**
 *  
 */
@property (nonatomic, strong) NSArray *itemsArray;
/**
 *  选中索引
 */
@property (nonatomic, assign) NSInteger selectedIndex;
/**
 *  正常颜色
 */
@property (nonatomic, strong) UIColor *normalColor;
/**
 *  选中颜色
 */
@property (nonatomic, strong) UIColor *selectedColor;
/**
 *  scrollview偏移
 *
 *  @param offSet scrollview偏移量
 *  @param width  scrollview宽度
 */
- (void)setAnimationWithOffSet:(CGFloat)offSet totalWidth:(CGFloat)width;
@end

@protocol TBSegementControlDelegate <NSObject>

@optional
- (void)segementButtonClickedAtIndex:(NSInteger)index;

@end
