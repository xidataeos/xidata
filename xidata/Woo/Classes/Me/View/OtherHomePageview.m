//
//  OtherHomePageview.m
//  Woo
//
//  Created by 王起锋 on 2018/10/11.
//  Copyright © 2018年 杭州蜂布式. All rights reserved.
//

#import "OtherHomePageview.h"

@implementation OtherHomePageview
-(UIButton *)backBtn
{
    if (_backBtn==nil) {
        _backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _backBtn.frame=CGRectMake(0,StatusBarHeight, 60*KWidth_Scale, 60*KWidth_Scale);
        [_backBtn setImageEdgeInsets:UIEdgeInsetsMake(15*KWidth_Scale, 15*KWidth_Scale, 15*KWidth_Scale, 15*KWidth_Scale)];
        [_backBtn setImage:[UIImage imageNamed:@"whiteback"] forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(baclclick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}
-(void)baclclick:(UIButton *)sender
{
    if (self.backBlock) {
        self.backBlock();
    }
}
-(UIView *)topview
{
    if (_topview==nil) {
        _topview=[[UIImageView alloc] initWithFrame:self.bounds];
        [_topview sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1539236588886&di=875133f078c0f23a240c2afac719b615&imgtype=0&src=http%3A%2F%2Fpic76.nipic.com%2Ffile%2F20150828%2F6320137_141832330000_2.jpg"]];
        _topview.userInteractionEnabled=YES;
        [_topview addSubview:self.avimage];
    }
    return _topview;
}
-(UILabel *)guanzhuLabel
{
    if (_guanzhuLabel==nil) {
        _guanzhuLabel=[[UILabel alloc] initWithFrame:CGRectMake(15*KWidth_Scale, CGRectGetMaxY(self.xinyongLabel.frame), 80*KWidth_Scale, 20*KWidth_Scale)];
        _guanzhuLabel.textColor=NaviBackgroundColor;
        _guanzhuLabel.font=UIFont(12);
        _guanzhuLabel.text=@"关注";
        _guanzhuLabel.userInteractionEnabled=YES;
    }
    return _guanzhuLabel;
}
-(UILabel *)fensiLabel
{
    if (_fensiLabel==nil) {
        _fensiLabel=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.guanzhuLabel.frame)+5*KWidth_Scale, CGRectGetMaxY(self.xinyongLabel.frame), 80*KWidth_Scale, 20*KWidth_Scale)];
        _fensiLabel.textColor=NaviBackgroundColor;
        _fensiLabel.font=UIFont(12);
        _fensiLabel.text=@"粉丝";
        _fensiLabel.userInteractionEnabled=YES;
    }
    return _fensiLabel;
}
-(UILabel *)xinyongLabel
{
    if (_xinyongLabel==nil) {
        _xinyongLabel=[[UILabel alloc] initWithFrame:CGRectMake(15*KWidth_Scale, CGRectGetMaxY(self.nameLabel.frame)+25*KWidth_Scale, SCREEN_WIDTH*0.5, 20*KWidth_Scale)];
        _xinyongLabel.textColor=RGB(153, 153, 153);
        _xinyongLabel.font=UIFont(13);
        _xinyongLabel.text=@"信用分";
    }
    return _xinyongLabel;
}
-(UIButton *)GuanzhukBtn
{
    if (_GuanzhukBtn==nil) {
        _GuanzhukBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _GuanzhukBtn.frame=CGRectMake(SCREEN_WIDTH/2.0,CGRectGetMaxY(self.nameLabel.frame)+25*KWidth_Scale, 40*KWidth_Scale, 40*KWidth_Scale);
        [_GuanzhukBtn sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1539162370911&di=c972ae0e80d51e307ac9eedd20719693&imgtype=0&src=http%3A%2F%2Fimg5.duitang.com%2Fuploads%2Fitem%2F201409%2F20%2F20140920163111_fsSQj.thumb.700_0.png"] forState:UIControlStateNormal];
        [_GuanzhukBtn addTarget:self action:@selector(selectclick:) forControlEvents:UIControlEventTouchUpInside];
        _GuanzhukBtn.tag=1;
    }
    return _GuanzhukBtn;
}
-(UIButton *)fensiBtn
{
    if (_fensiBtn==nil) {
        _fensiBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _fensiBtn.frame=CGRectMake(CGRectGetMaxX(self.sixinkBtn.frame)+20*KWidth_Scale,CGRectGetMaxY(self.nameLabel.frame)+25*KWidth_Scale, 40*KWidth_Scale, 40*KWidth_Scale);
        [_fensiBtn sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1539162370911&di=c972ae0e80d51e307ac9eedd20719693&imgtype=0&src=http%3A%2F%2Fimg5.duitang.com%2Fuploads%2Fitem%2F201409%2F20%2F20140920163111_fsSQj.thumb.700_0.png"] forState:UIControlStateNormal];
        [_fensiBtn addTarget:self action:@selector(selectclick:) forControlEvents:UIControlEventTouchUpInside];
        _GuanzhukBtn.tag=3;
    }
    return _fensiBtn;
}
-(UIButton *)sixinkBtn
{
    if (_sixinkBtn==nil) {
        _sixinkBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _sixinkBtn.frame=CGRectMake(CGRectGetMaxX(self.GuanzhukBtn.frame)+20*KWidth_Scale,CGRectGetMaxY(self.nameLabel.frame)+25*KWidth_Scale, 40*KWidth_Scale, 40*KWidth_Scale);
        [_sixinkBtn sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1539162370911&di=c972ae0e80d51e307ac9eedd20719693&imgtype=0&src=http%3A%2F%2Fimg5.duitang.com%2Fuploads%2Fitem%2F201409%2F20%2F20140920163111_fsSQj.thumb.700_0.png"] forState:UIControlStateNormal];
        [_sixinkBtn addTarget:self action:@selector(selectclick:) forControlEvents:UIControlEventTouchUpInside];
         _GuanzhukBtn.tag=2;
    }
    return _sixinkBtn;
}
-(void)selectclick:(UIButton *)sender
{
    if (self.publickblock) {
        self.publickblock(sender.tag);
    }
}
-(UIImageView *)avimage
{
    if (_avimage==nil) {
        _avimage=[[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2.0-35*KWidth_Scale,StatusBarAndNavigationBarHeight-25*KWidth_Scale, 70*KWidth_Scale, 70*KWidth_Scale)];
        _avimage.layer.cornerRadius=35*KWidth_Scale;
        _avimage.clipsToBounds=YES;
        [_avimage sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1539239204142&di=b8efbc8aa9ce18904824491842b11497&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimgad%2Fpic%2Fitem%2F1ad5ad6eddc451da5cb9c818bcfd5266d11632f2.jpg"]];
        _avimage.userInteractionEnabled=YES;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickhead:)];
        [_avimage addGestureRecognizer:tap];
    }
    return _avimage;
}
-(void)clickhead:(UITapGestureRecognizer *)tap
{
    if (self.clickblock) {
        self.clickblock(self.avimage);
    }
}
-(UILabel *)nameLabel
{
    if (_nameLabel==nil) {
        _nameLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.avimage.frame)+5*KWidth_Scale, SCREEN_WIDTH, 25*KWidth_Scale)];
        _nameLabel.textColor=NaviBackgroundColor;
        _nameLabel.font=UIFont(16);
        _nameLabel.text=@"我的名字";
        _nameLabel.textAlignment=NSTextAlignmentCenter;
        [_nameLabel addSubview:self.daV];
    }
    return _nameLabel;
}
-(UIImageView *)daV
{
    if (_daV==nil) {
        _daV=[[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2.0+50*KWidth_Scale,0, 20*KWidth_Scale, 20*KWidth_Scale)];
        _daV.image=[UIImage imageNamed:@"logo_icon"];
    }
    return _daV;
}
-(UIImageView *)rezheng
{
    if (_rezheng==nil) {
        _rezheng=[[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.daV.frame)+5*KWidth_Scale, CGRectGetMaxY(self.topview.frame)+10*KWidth_Scale, 25*KWidth_Scale, 25*KWidth_Scale)];
        _rezheng.image=[UIImage imageNamed:@"logo_icon"];
    }
    return _rezheng;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self==[super initWithFrame:frame]) {
        self.backgroundColor=[UIColor whiteColor];
        [self creatview];
    }
    return self;
}
-(void)creatview
{
    [self addSubview:self.topview];
    [self.topview addSubview:self.avimage];
    [self.topview addSubview:self.backBtn];
    [self.topview addSubview:self.nameLabel];
    [self.topview addSubview:self.xinyongLabel];
    [self.topview addSubview:self.fensiLabel];
    [self.topview addSubview:self.guanzhuLabel];
    [self.topview addSubview:self.GuanzhukBtn];
    [self.topview addSubview:self.GuanzhukBtn];
    [self.topview addSubview:self.sixinkBtn];
    [self.topview addSubview:self.fensiBtn];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
