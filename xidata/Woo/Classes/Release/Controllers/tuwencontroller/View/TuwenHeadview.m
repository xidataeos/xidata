//
//  TuwenHeadview.m
//  Woo
//
//  Created by 王起锋 on 2018/10/10.
//  Copyright © 2018年 杭州蜂布式. All rights reserved.
//

#import "TuwenHeadview.h"
@implementation TuwenHeadview
-(UILabel *)numLabel
{
    if (_numLabel==nil) {
        _numLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 115, 19*KWidth_Scale)];
        _numLabel.textColor=WordsofcolorColor;
        _numLabel.font=UIFont(12);
        _numLabel.text=@"xidate:";
        _numLabel.textAlignment=NSTextAlignmentCenter;
    }
    return _numLabel;
}
-(UIView *)leftView
{
    if (_leftView==nil) {
        _leftView=[[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-125, 5*KWidth_Scale, 115, 40*KWidth_Scale)];
        _leftView.layer.borderWidth=0.7;
        _leftView.layer.borderColor=NaviBackgroundColor.CGColor;
        _leftView.layer.cornerRadius=2;
        _leftView.clipsToBounds=YES;
        UIView *cell=[[UIView alloc] initWithFrame:CGRectMake(0, 19*KWidth_Scale, 115, 0.7)];
        cell.backgroundColor=NaviBackgroundColor;
        [_leftView addSubview:cell];
        UILabel *tips=[[UILabel alloc] initWithFrame:CGRectMake(0, 20*KWidth_Scale, 115, 20*KWidth_Scale)];
        tips.textAlignment=NSTextAlignmentCenter;
        tips.textColor=[UIColor redColor];
        tips.font=UIFont(12);
        tips.text=@"内容已被区块登记";
        [_leftView addSubview:self.numLabel];
        [_leftView addSubview:tips];
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapclick)];
        [_leftView addGestureRecognizer:tap];
    }
    return _leftView;
}
-(void)tapclick
{
    if (self.qukuaiblock) {
        self.qukuaiblock();
    }
}
-(UILabel *)timeLabel
{
    if (_timeLabel==nil) {
        _timeLabel=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.avimage.frame)+5*KWidth_Scale, 25*KWidth_Scale, SCREEN_WIDTH*0.5, 15)];
        _timeLabel.textColor=RGB(153, 153, 153);
        _timeLabel.font=UIFont(13);
        _timeLabel.text=@"发布于10分钟前";
    }
    return _timeLabel;
}
-(UIButton *)avimage
{
    if (_avimage==nil) {
        _avimage=[UIButton buttonWithType:UIButtonTypeCustom];
        _avimage.frame=CGRectMake(10*KWidth_Scale,0, 50*KWidth_Scale, 50*KWidth_Scale);
        [_avimage setImageEdgeInsets:UIEdgeInsetsMake(5*KWidth_Scale, 0*KWidth_Scale, 5*KWidth_Scale, 10*KWidth_Scale)];
        [_avimage sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1539162370911&di=c972ae0e80d51e307ac9eedd20719693&imgtype=0&src=http%3A%2F%2Fimg5.duitang.com%2Fuploads%2Fitem%2F201409%2F20%2F20140920163111_fsSQj.thumb.700_0.png"] forState:UIControlStateNormal];
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
        _nameLabel=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.avimage.frame)+5*KWidth_Scale, 10*KWidth_Scale, SCREEN_WIDTH*0.5, 15*KWidth_Scale)];
        _nameLabel.textColor=WordsofcolorColor;
        _nameLabel.font=UIFont(15);
        _nameLabel.text=@"发布于";
    }
    return _nameLabel;
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
    [self addSubview:self.timeLabel];
    [self addSubview:self.leftView];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
