//
//  publicBotomoview.m
//  Woo
//
//  Created by 王起锋 on 2018/10/10.
//  Copyright © 2018年 杭州蜂布式. All rights reserved.
//

#import "publicBotomoview.h"
#define btnwith (SCREEN_WIDTH-100*KWidth_Scale)/4
@implementation publicBotomoview
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self==[super initWithFrame:frame]) {
        [self creatBtn];
    }
    return self;
}
-(UIView *)botomo
{
    if (_botomo==nil) {
        _botomo=[[UIView alloc] initWithFrame:self.bounds];
    }
    return _botomo;
}
-(UILabel *)favorLabel
{
    if (_favorLabel==nil) {
        _favorLabel=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.favortButton.frame), 0, 40, self.height)];
        _favorLabel.textColor=WordsofcolorColor;
        _favorLabel.font=UIFont(12);
        _favorLabel.textAlignment=NSTextAlignmentCenter;
    }
    return _favorLabel;
}
-(UIButton *)favortButton
{
    if (_favortButton==nil) {
        _favortButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _favortButton.frame=CGRectMake(30*KWidth_Scale, 10, 22, 22);
        [_favortButton setTitleColor:WordsofcolorColor forState:UIControlStateNormal];
         [_favortButton.titleLabel setFont:UIFont(11)];
        _favortButton.tag=1;
        [_favortButton setImage:[UIImage imageNamed:@"empty_heart"] forState:UIControlStateNormal];
        [_favortButton setImage:[UIImage imageNamed:@"red_heart"] forState:UIControlStateSelected];
        [_favortButton addTarget:self action:@selector(publicclick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _favortButton;
}
-(UIButton *)SteponButton
{
    if (_SteponButton==nil) {
        _SteponButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _SteponButton.frame=CGRectMake(CGRectGetMaxX(self.favorLabel.frame)+5*KWidth_Scale, 10, 22,22);
        [_SteponButton setTitleColor:WordsofcolorColor forState:UIControlStateNormal];
        _SteponButton.tag=2;
        [_SteponButton setImage:[UIImage imageNamed:@"empty_heart"] forState:UIControlStateNormal];
        [_SteponButton setImage:[UIImage imageNamed:@"red_heart"] forState:UIControlStateSelected];
        [_SteponButton addTarget:self action:@selector(publicclick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _SteponButton;
}
-(UIButton *)commentButton
{
    if (_commentButton==nil) {
        _commentButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _commentButton.frame=CGRectMake(CGRectGetMaxX(self.SteponButton.frame)+btnwith+10*KWidth_Scale, 0, btnwith, self.height);
        [_commentButton setTitleColor:WordsofcolorColor forState:UIControlStateNormal];
         [_commentButton.titleLabel setFont:UIFont(11)];
        [_commentButton setImage:[UIImage imageNamed:@"empty_heart"] forState:UIControlStateNormal];
        _commentButton.tag=3;
        [_commentButton addTarget:self action:@selector(publicclick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commentButton;
}
-(UIButton *)collectionButton
{
    if (_collectionButton==nil) {
        _collectionButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _collectionButton.frame=CGRectMake(CGRectGetMaxX(self.commentButton.frame)+20*KWidth_Scale, 0, btnwith, self.height);
        [_collectionButton setTitleColor:WordsofcolorColor forState:UIControlStateNormal];
        [_collectionButton.titleLabel setFont:UIFont(11)];
        _collectionButton.tag=4;
        [_collectionButton setImage:[UIImage imageNamed:@"empty_heart"] forState:UIControlStateNormal];
        [_collectionButton setImage:[UIImage imageNamed:@"red_heart"] forState:UIControlStateSelected];
        [_collectionButton addTarget:self action:@selector(publicclick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _collectionButton;
}
-(void)publicclick:(UIButton *)sender
{
    if (sender.tag==1) {
        self.favortButton.selected=!sender.selected;
        if (self.selfBlock) {
            self.selfBlock(sender.tag, self.favortButton.selected);
        }
    }
    else if (sender.tag==2)
    {
        self.SteponButton.selected=!sender.selected;
        if (self.selfBlock) {
            self.selfBlock(sender.tag, self.SteponButton.selected);
        }
    }
    else if (sender.tag==3)
    {
        if (self.selfBlock) {
            self.selfBlock(sender.tag, self.commentButton.selected);
        }
    }
    else{
        self.collectionButton.selected=!sender.selected;
        if (self.selfBlock) {
            self.selfBlock(sender.tag, self.collectionButton.selected);
        }
    }
}
-(void)creatBtn
{
    [self addSubview:self.botomo];
    [self.botomo addSubview:self.favortButton];
    [self.botomo addSubview:self.favorLabel];
    [self.botomo addSubview:self.SteponButton];
    [self.botomo addSubview:self.commentButton];
    [self.botomo addSubview:self.collectionButton];
    [self.favortButton setTitle:@"" forState:UIControlStateNormal];
    [self.SteponButton setTitle:@"" forState:UIControlStateNormal];
    [self.commentButton setTitle:@"" forState:UIControlStateNormal];
    [self.collectionButton setTitle:@"" forState:UIControlStateNormal];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
