
//
//  WatchoneTableViewCell.m
//  Woo
//
//  Created by 王起锋 on 2018/8/13.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import "madecollectionViewCell.h"

@implementation madecollectionViewCell
-(UILabel *)publiclable
{
    if (_publiclable==nil) {
        _publiclable=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.imageview.frame)+2, CGRectGetMaxY(self.titllabel.frame), SCREEN_WIDTH-90*KWidth_Scale, 30*KWidth_Scale)];
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
-(UILabel *)zhuanji
{
    if (_zhuanji==nil) {
        _zhuanji=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.videocount.frame)+2+20*KWidth_Scale, 0,60*KWidth_Scale, 20*KWidth_Scale)];
        _zhuanji.font=UIFont(12);
        _zhuanji.textColor=WordsofcolorColor;
    }
    return _zhuanji;
}
-(UIButton *)MoreBtn
{
    if (_MoreBtn==nil) {
        _MoreBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _MoreBtn.frame=CGRectMake(SCREEN_WIDTH-5*KWidth_Scale-45*KWidth_Scale,0, 45*KWidth_Scale, 20*KWidth_Scale);
        [_MoreBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _MoreBtn.titleLabel.font=UIFont(14);
        _MoreBtn.layer.cornerRadius=3;
        _MoreBtn.clipsToBounds=YES;
        _MoreBtn.backgroundColor=NaviBackgroundColor;
        [_MoreBtn addTarget:self action:@selector(moreselect:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _MoreBtn;
}
-(void)moreselect:(UIButton *)btn
{
    if (self.moreblock) {
        self.moreblock();
    }
}
-(UIButton *)submitBtn
{
    if (_submitBtn==nil) {
        _submitBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _submitBtn.frame=CGRectMake(SCREEN_WIDTH-5*KWidth_Scale-45*KWidth_Scale,CGRectGetMaxY(self.publiclable.frame), 45*KWidth_Scale, 20*KWidth_Scale);
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _submitBtn.titleLabel.font=UIFont(14);
        _submitBtn.layer.cornerRadius=3;
        _submitBtn.clipsToBounds=YES;
        _submitBtn.backgroundColor=NaviBackgroundColor;
        [_submitBtn addTarget:self action:@selector(sumibclick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitBtn;
}
-(UIView *)botomoview
{
    if (_botomoview==nil) {
        _botomoview=[[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.imageview.frame)+2, CGRectGetMaxY(self.publiclable.frame), SCREEN_WIDTH-90*KWidth_Scale, 20*KWidth_Scale)];
        self.zhuanjiiconimageview=[[UIImageView alloc] initWithFrame:CGRectMake(5*KWidth_Scale, 5*KWidth_Scale, 20*KWidth_Scale, 20*KWidth_Scale)];
        [_botomoview addSubview:self.zhuanjiiconimageview];
        [_botomoview addSubview:self.videocount];
        self.watchimage=[[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.videocount.frame)+0*KWidth_Scale, 5*KWidth_Scale, 20*KWidth_Scale, 20*KWidth_Scale)];
        [_botomoview addSubview:self.watchimage];
        [_botomoview addSubview:self.zhuanji];
    }
    return _botomoview;
}

-(UILabel *)timeLabel
{
    if (_timeLabel==nil) {
        _timeLabel=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.imageview.frame)+2, CGRectGetMaxY(self.publiclable.frame), SCREEN_WIDTH-90*KWidth_Scale-52*KWidth_Scale, 20*KWidth_Scale)];
        _timeLabel.font=UIFont(13);
        _timeLabel.textColor=WordsofcolorColor;
        _timeLabel.numberOfLines=0;
    }
    return _timeLabel;
}
-(UIImageView *)imageview
{
    if (_imageview==nil) {
        _imageview=[[UIImageView alloc] initWithFrame:CGRectMake(10*KWidth_Scale, 5*KWidth_Scale, 70*KWidth_Scale, 70*KWidth_Scale)];
    }
    return _imageview;
}
-(UILabel *)titllabel
{
    if (_titllabel==nil) {
        _titllabel=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.imageview.frame)+2, 5*KWidth_Scale, SCREEN_WIDTH-90*KWidth_Scale, 20*KWidth_Scale)];
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
    [self addSubview:self.MoreBtn];
    [self addSubview:self.publiclable];
    [self addSubview:self.submitBtn];
    [self addSubview:self.timeLabel];
    UIView *cell=[[UIView alloc] initWithFrame:CGRectMake(0, 80*KWidth_Scale, SCREEN_WIDTH, 0.8)];
    cell.backgroundColor=CellBackgroundColor;
    [self addSubview:cell];
}
-(void)sumibclick:(UIButton *)sender
{
    if (self.madeblock) {
        self.madeblock();
    }
}
-(void)setModel:(HomeModel *)model
{
    self.timeLabel.text=@"2016-09-09";
    self.timeLabel.hidden=YES;
    self.titllabel.text=model.title;
    self.publiclable.text=model.intro;
    [self.imageview sd_setImageWithURL:[NSURL URLWithString:model.img]];
    [self addSubview:self.botomoview];
    self.videocount.text=[NSString stringWithFormat:@"%ld",model.pageView];
}
-(void)setmoreBtnHide
{
    self.MoreBtn.hidden=YES;
}
-(void)setFrame:(CGRect)frame
{
    frame.size.height-=1.0;
    [super setFrame:frame];
}
@end
