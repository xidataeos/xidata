
//
//  CopyrightCollectionViewCell.m
//  Woo
//
//  Created by 王起锋 on 2018/10/9.
//  Copyright © 2018年 杭州蜂布式. All rights reserved.
//

#import "CopyrightCollectionViewCell.h"

@implementation CopyrightCollectionViewCell
-(UILabel *)publiclable
{
    if (_publiclable==nil) {
        _publiclable=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.imageview.frame)+2, CGRectGetMaxY(self.titllabel.frame), SCREEN_WIDTH-115*KWidth_Scale, 40*KWidth_Scale)];
        _publiclable.font=UIFont(12);
        _publiclable.textColor=[PublicFunction colorWithHexString:@"999999"];
        _publiclable.numberOfLines=0;
    }
    return _publiclable;
}
-(UILabel *)videocount
{
    if (_videocount==nil) {
        _videocount=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.zhuanjiiconimageview.frame)+20*KWidth_Scale, 0, 60*KWidth_Scale, 20*KWidth_Scale)];
        _videocount.font=UIFont(12);
        _videocount.textColor=WordsofcolorColor;
    }
    return _videocount;
}
-(UILabel *)haxilabel
{
    if (_haxilabel==nil) {
        _haxilabel=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.imageview.frame)+2, CGRectGetMaxY(self.publiclable.frame),SCREEN_WIDTH-115*KWidth_Scale, 50*KWidth_Scale)];
        _haxilabel.font=UIFont(12);
        _haxilabel.numberOfLines=0;
        _haxilabel.textColor=WordsofcolorColor;
    }
    return _haxilabel;
}
-(UIView *)botomoview
{
    if (_botomoview==nil) {
        _botomoview=[[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.imageview.frame)+2, CGRectGetMaxY(self.haxilabel.frame)+5*KWidth_Scale, SCREEN_WIDTH-115*KWidth_Scale, 25*KWidth_Scale)];
        self.zhuanjiiconimageview=[[UIImageView alloc] initWithFrame:CGRectMake(5*KWidth_Scale, 5*KWidth_Scale, 20*KWidth_Scale, 20*KWidth_Scale)];
        [_botomoview addSubview:self.zhuanjiiconimageview];
        [_botomoview addSubview:self.videocount];
        [_botomoview addSubview:self.timeLabel];
    }
    return _botomoview;
}

-(UILabel *)timeLabel
{
    if (_timeLabel==nil) {
        _timeLabel=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.videocount.frame)+2, 5*KWidth_Scale, SCREEN_WIDTH-115*KWidth_Scale-95*KWidth_Scale, 25*KWidth_Scale)];
        _timeLabel.font=UIFont(12);
        _timeLabel.textColor=WordsofcolorColor;
        _timeLabel.numberOfLines=0;
    }
    return _timeLabel;
}
-(UIImageView *)imageview
{
    if (_imageview==nil) {
        _imageview=[[UIImageView alloc] initWithFrame:CGRectMake(10*KWidth_Scale, 5*KWidth_Scale, 100*KWidth_Scale*KWidth_Scale, 150*KWidth_Scale)];
    }
    return _imageview;
}
-(UILabel *)titllabel
{
    if (_titllabel==nil) {
        _titllabel=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.imageview.frame)+2, 5*KWidth_Scale, SCREEN_WIDTH-115*KWidth_Scale, 20*KWidth_Scale)];
        _titllabel.font=UIFont(15);
        _titllabel.textColor=WordsofcolorColor;
        _titllabel.numberOfLines=0;
    }
    return _titllabel;
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self  creatUI];
    }
    return self;
}
-(void)creatUI
{
    [self addSubview:self.imageview];
    [self addSubview:self.titllabel];
    [self addSubview:self.publiclable];
    [self addSubview:self.haxilabel];
    [self addSubview:self.botomoview];
    self.timeLabel.text=@"确权时间2016-09-09";
    self.titllabel.text=@"我是标题";
    self.publiclable.text=@"我是简洁或者是i哈希我是能存很多的书中的你可以测试可以是多行吗是不是多行";
     self.haxilabel.text=@"我是简洁或者是i哈希我是能存很多的书中的你可以测试可以是多行吗是不是多行";
    [self.imageview sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1539075998765&di=20f535ed353cc2be1e53063d3627c683&imgtype=0&src=http%3A%2F%2Fpic30.photophoto.cn%2F20140218%2F0013025939222600_b.jpg"]];
    UIView *cell=[[UIView alloc] initWithFrame:CGRectMake(0, 159, SCREEN_WIDTH, 0.7)];
    cell.backgroundColor=CellBackgroundColor;
    [self.zhuanjiiconimageview sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1539075998765&di=20f535ed353cc2be1e53063d3627c683&imgtype=0&src=http%3A%2F%2Fpic30.photophoto.cn%2F20140218%2F0013025939222600_b.jpg"]];
    self.videocount.text=@"作者";
    [self addSubview:cell];
}
-(void)setModel:(HomeModel *)model
{
    self.timeLabel.text=[NSString stringWithFormat:@"确权时间:%@",model.createDate];
    self.titllabel.text=model.title;
    self.publiclable.text=model.intro;
    self.haxilabel.text=@"我是简洁或者是i哈希我是能存很多的书中的你可以测试可以是多行吗是不是多行";
    [self.imageview sd_setImageWithURL:[NSURL URLWithString:model.img]];
}
@end
