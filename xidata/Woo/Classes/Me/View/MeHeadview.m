//
//  MeHeadview.m
//  Woo
//
//  Created by 王起锋 on 2018/10/10.
//  Copyright © 2018年 杭州蜂布式. All rights reserved.
//

#import "MeHeadview.h"

@implementation MeHeadview
-(UILabel *)guanzhuLabel
{
    if (_guanzhuLabel==nil) {
        _guanzhuLabel=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.avimage.frame)+10*KWidth_Scale, CGRectGetMaxY(self.xinyongLabel.frame), 80*KWidth_Scale, 20*KWidth_Scale)];
        _guanzhuLabel.textColor=WordsofcolorColor;
        _guanzhuLabel.font=UIFont(12);
        _guanzhuLabel.text=@"关注";
        _guanzhuLabel.userInteractionEnabled=YES;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(guanzhuclick)];
        [_guanzhuLabel addGestureRecognizer:tap];
    }
    return _guanzhuLabel;
}
-(void)guanzhuclick
{
    if (self.guanzhublock) {
        self.guanzhublock();
    }
}
-(void)fensiclick
{
    if (self.fensiblock) {
        self.fensiblock();
    }
}
-(UILabel *)fensiLabel
{
    if (_fensiLabel==nil) {
        _fensiLabel=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.guanzhuLabel.frame)+5*KWidth_Scale, CGRectGetMaxY(self.xinyongLabel.frame), 80*KWidth_Scale, 20*KWidth_Scale)];
        _fensiLabel.textColor=WordsofcolorColor;
        _fensiLabel.font=UIFont(12);
        _fensiLabel.text=@"粉丝";
        _fensiLabel.userInteractionEnabled=YES;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fensiclick)];
        [_fensiLabel addGestureRecognizer:tap];
    }
    return _fensiLabel;
}
-(UILabel *)xinyongLabel
{
    if (_xinyongLabel==nil) {
        _xinyongLabel=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.avimage.frame)+10*KWidth_Scale, CGRectGetMaxY(self.nameLabel.frame), SCREEN_WIDTH*0.5, 20*KWidth_Scale)];
        _xinyongLabel.textColor=RGB(153, 153, 153);
        _xinyongLabel.font=UIFont(13);
        _xinyongLabel.text=@"发布于10分钟前";
    }
    return _xinyongLabel;
}
-(UIButton *)avimage
{
    if (_avimage==nil) {
        _avimage=[UIButton buttonWithType:UIButtonTypeCustom];
        _avimage.frame=CGRectMake(10*KWidth_Scale,10*KWidth_Scale, 75*KWidth_Scale, 75*KWidth_Scale);
        _avimage.layer.cornerRadius=75*KWidth_Scale/2.0;
        _avimage.clipsToBounds=YES;
        [_avimage addTarget:self action:@selector(clickhead:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _avimage;
}
-(void)clickhead:(UIButton *)sender
{
    if (self.clickblock) {
        self.clickblock();
    }
}
-(UILabel *)nameLabel
{
    if (_nameLabel==nil) {
        _nameLabel=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.avimage.frame)+10*KWidth_Scale, 18*KWidth_Scale, 100*KWidth_Scale, 20*KWidth_Scale)];
        _nameLabel.textColor=WordsofcolorColor;
        _nameLabel.font=UIFont(15);
        _nameLabel.text=@"我的名字";
    }
    return _nameLabel;
}
-(UIImageView *)daV
{
    if (_daV==nil) {
        _daV=[[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.nameLabel.frame)+5*KWidth_Scale, 14*KWidth_Scale, 25*KWidth_Scale, 25*KWidth_Scale)];
        _daV.image=[UIImage imageNamed:@"logo_icon"];
    }
    return _daV;
}
-(UIImageView *)rezheng
{
    if (_rezheng==nil) {
        _rezheng=[[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.daV.frame)+5*KWidth_Scale, 14*KWidth_Scale, 25*KWidth_Scale, 25*KWidth_Scale)];
        _rezheng.image=[UIImage imageNamed:@"logo_icon"];
    }
    return _rezheng;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self==[super initWithFrame:frame]) {
        [self creatview];
    }
    return self;
}
-(void)creatview
{
    [self addSubview:self.avimage];
    [self addSubview:self.nameLabel];
    [self addSubview:self.xinyongLabel];
    [self addSubview:self.fensiLabel];
    [self addSubview:self.guanzhuLabel];
    [self addSubview:self.daV];
    [self addSubview:self.rezheng];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
