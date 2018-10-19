//
//  FooterCollectionReusableView.m
//  Woo
//
//  Created by 王起锋 on 2018/10/8.
//  Copyright © 2018年 杭州蜂布式. All rights reserved.
//

#import "MoreCollectionReusableView.h"

@implementation MoreCollectionReusableView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self==[super initWithFrame:frame]) {
        [self addSubview:self.titlelabel];
        [self addSubview:self.MoretapBtn];
    }
    return self;
}
-(UILabel *)titlelabel
{
    if (_titlelabel==nil) {
        _titlelabel=[[UILabel alloc] initWithFrame:CGRectMake(15*KWidth_Scale,0, SCREEN_WIDTH*0.5, 44*KWidth_Scale)];
        _titlelabel.font=UIFont(15);
        _titlelabel.textColor=WordsofcolorColor;
    }
    return _titlelabel;
}
-(UIButton *)MoretapBtn
{
    if (_MoretapBtn==nil) {
        _MoretapBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _MoretapBtn.titleLabel.font=UIFont(12);
        [_MoretapBtn setTitleColor:WordsofcolorColor forState:UIControlStateNormal];
        _MoretapBtn.frame=CGRectMake(SCREEN_WIDTH-60, 0, 60, 44*KWidth_Scale);
        [_MoretapBtn setTitle:@"更多" forState:UIControlStateNormal];
        [_MoretapBtn setImage:[UIImage imageNamed:@"redmore"] forState:UIControlStateNormal];
        [_MoretapBtn setTitleEdgeInsets:UIEdgeInsetsMake(10*KWidth_Scale, 5*KWidth_Scale, 10*KWidth_Scale, 15)];
        [_MoretapBtn setImageEdgeInsets:UIEdgeInsetsMake(8*KWidth_Scale, 40, 8*KWidth_Scale, 0)];
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
