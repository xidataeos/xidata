
//
//  audioCollectionViewCell.m
//  Woo
//
//  Created by 王起锋 on 2018/10/11.
//  Copyright © 2018年 杭州蜂布式. All rights reserved.
//

#import "audioCollectionViewCell.h"

@implementation audioCollectionViewCell

-(UILabel *)videocount
{
    if (_videocount==nil) {
        _videocount=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.zhuanjiiconimageview.frame)+20*KWidth_Scale, 0, 60*KWidth_Scale, 20*KWidth_Scale)];
        _videocount.font=UIFont(12);
        _videocount.textColor=WordsofcolorColor;
    }
    return _videocount;
}
-(UILabel *)zhuanji
{
    if (_zhuanji==nil) {
        _zhuanji=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.videocount.frame)+2+20*KWidth_Scale, 0,60*KWidth_Scale, 20*KWidth_Scale)];
        _zhuanji.font=UIFont(12);
        _zhuanji.textColor=WordsofcolorColor;
    }
    return _zhuanji;
}
-(UIView *)botomoview
{
    if (_botomoview==nil) {
        _botomoview=[[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.imageview.frame)+5*KWidth_Scale, CGRectGetMaxY(self.titllabel.frame), SCREEN_WIDTH-90*KWidth_Scale, 20*KWidth_Scale)];
        self.zhuanjiiconimageview=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20*KWidth_Scale, 20*KWidth_Scale)];
        self.zhuanjiiconimageview.image=[UIImage imageNamed:@"playBack_Image"];
        [_botomoview addSubview:self.zhuanjiiconimageview];
        [_botomoview addSubview:self.videocount];
        UIImageView *ima2=[[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.videocount.frame)+0*KWidth_Scale, 5*KWidth_Scale, 20*KWidth_Scale, 20*KWidth_Scale)];
        ima2.image=[UIImage imageNamed:@"playBack_Image"];
        [_botomoview addSubview:ima2];
        [_botomoview addSubview:self.zhuanji];
    }
    return _botomoview;
}

-(UILabel *)timeLabel
{
    if (_timeLabel==nil) {
        _timeLabel=[[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-90*KWidth_Scale, 10*KWidth_Scale,80*KWidth_Scale, 20*KWidth_Scale)];
        _timeLabel.font=UIFont(13);
        _timeLabel.textColor=WordsofcolorColor;
        _timeLabel.numberOfLines=0;
        _timeLabel.textAlignment=NSTextAlignmentRight;
    }
    return _timeLabel;
}
-(UIImageView *)imageview
{
    if (_imageview==nil) {
        _imageview=[[UIImageView alloc] initWithFrame:CGRectMake(10*KWidth_Scale, 10*KWidth_Scale, 40*KWidth_Scale, 40*KWidth_Scale)];
    }
    return _imageview;
}
-(UILabel *)titllabel
{
    if (_titllabel==nil) {
        _titllabel=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.imageview.frame)+5*KWidth_Scale, 10*KWidth_Scale, SCREEN_WIDTH-90*KWidth_Scale, 20*KWidth_Scale)];
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
    [self addSubview:self.botomoview];
    [self addSubview:self.timeLabel];
    self.timeLabel.text=@"2016-09-09";
    self.titllabel.text=@"我是标题";
    [self.imageview sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1539075998765&di=20f535ed353cc2be1e53063d3627c683&imgtype=0&src=http%3A%2F%2Fpic30.photophoto.cn%2F20140218%2F0013025939222600_b.jpg"]];
}
@end
