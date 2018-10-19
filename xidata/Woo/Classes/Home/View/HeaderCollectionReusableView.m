
//
//  HeaderCollectionReusableView.m
//  newLoan
//
//  Created by 王起锋 on 2018/6/20.
//  Copyright © 2018年 王起锋. All rights reserved.
//

#import "HeaderCollectionReusableView.h"
@interface HeaderCollectionReusableView()<SDCycleScrollViewDelegate>

@end
@implementation HeaderCollectionReusableView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self==[super initWithFrame:frame]) {
        
    }
    return self;
}
-(void)setData:(NSMutableArray *)data
{
    UIView *bottom=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.frame.size.height)];
    bottom.backgroundColor=[UIColor whiteColor];
    [self addSubview:bottom];
    UIView * SDCybackview=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.frame.size.height)];
    SDCybackview.backgroundColor=[UIColor whiteColor];
    [bottom addSubview:SDCybackview];
    // 网络加载 --- 创建自定义图片的pageControlDot的图片轮播器
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0,0,SCREEN_WIDTH,self.frame.size.height) delegate:self placeholderImage:[UIImage imageNamed:@"background_wode"]];
    cycleScrollView.currentPageDotImage = [UIImage imageNamed:@"step-on"];
    cycleScrollView.pageDotImage = [UIImage imageNamed:@"step-off"];
    cycleScrollView.imageURLStringsGroup = data;
    [SDCybackview addSubview:cycleScrollView];
}
@end
