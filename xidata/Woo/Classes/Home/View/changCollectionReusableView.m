//
//  changCollectionReusableView.m
//  Woo
//
//  Created by 王起锋 on 2018/10/9.
//  Copyright © 2018年 杭州蜂布式. All rights reserved.
//

#import "changCollectionReusableView.h"

@implementation changCollectionReusableView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self==[super initWithFrame:frame]) {
        [self addSubview:self.MoretapBtn];
    }
    return self;
}
-(UIButton *)MoretapBtn
{
    if (_MoretapBtn==nil) {
        _MoretapBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _MoretapBtn.titleLabel.font=UIFont(15);
        [_MoretapBtn setTitleColor:WordsofcolorColor forState:UIControlStateNormal];
        _MoretapBtn.frame=CGRectMake(0, 0,SCREEN_WIDTH, 30*KWidth_Scale);
        [_MoretapBtn setTitle:@"换一批" forState:UIControlStateNormal];
        [_MoretapBtn setImage:[UIImage imageNamed:@"fire_Image"] forState:UIControlStateNormal];
         [_MoretapBtn setImageEdgeInsets:UIEdgeInsetsMake(5*KWidth_Scale, SCREEN_WIDTH/2.0-30*KWidth_Scale, 5*KWidth_Scale,SCREEN_WIDTH/2.0)];
        [_MoretapBtn setTitleEdgeInsets:UIEdgeInsetsMake(0*KWidth_Scale, SCREEN_WIDTH/3.0+18*KWidth_Scale, 0*KWidth_Scale,SCREEN_WIDTH/2.0-50*KWidth_Scale)];
        [_MoretapBtn addTarget:self action:@selector(clickself:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _MoretapBtn;
}
-(void)clickself:(UIButton *)sender
{
    if (self.myblock) {
        self.myblock();
    }
}
@end
