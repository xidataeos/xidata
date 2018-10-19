

//
//  MygraphicTableViewCell.m
//  Woo
//
//  Created by 王起锋 on 2018/10/14.
//  Copyright © 2018年 杭州蜂布式. All rights reserved.
//

#import "MygraphicTableViewCell.h"

@implementation MygraphicTableViewCell
-(UILabel *)timeLabel
{
    if (_timeLabel==nil) {
        _timeLabel=[[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-100*KWidth_Scale, 38*KWidth_Scale,85*KWidth_Scale, 25*KWidth_Scale)];
        _timeLabel.font=UIFont(12);
        _timeLabel.textColor=WordsofcolorColor;
        _timeLabel.numberOfLines=0;
        _timeLabel.textAlignment=NSTextAlignmentRight;
    }
    return _timeLabel;
}
-(UIImageView *)imageview
{
    if (_imageview==nil) {
        _imageview=[[UIImageView alloc] initWithFrame:CGRectMake(10*KWidth_Scale, 15*KWidth_Scale, 50*KWidth_Scale, 50*KWidth_Scale)];
    }
    return _imageview;
}
-(UILabel *)titllabel
{
    if (_titllabel==nil) {
        _titllabel=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.imageview.frame)+5*KWidth_Scale,15*KWidth_Scale, SCREEN_WIDTH*0.5, 20*KWidth_Scale)];
        _titllabel.font=UIFont(15);
        _titllabel.textColor=WordsofcolorColor;
        _titllabel.numberOfLines=0;
    }
    return _titllabel;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self  creatUI];
    }
    return self;
}
-(UILabel *)videocount
{
    if (_videocount==nil) {
        _videocount=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.zhuanjiiconimageview.frame)+5*KWidth_Scale,CGRectGetMaxY(self.titllabel.frame)+0*KWidth_Scale, 60*KWidth_Scale*KWidth_Scale, 25*KWidth_Scale)];
        _videocount.font=UIFont(12);
        _videocount.textColor=WordsofcolorColor;
    }
    return _videocount;
}
-(UILabel *)zhuanji
{
    if (_zhuanji==nil) {
        _zhuanji=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.ima2.frame)+2, CGRectGetMaxY(self.titllabel.frame)+0*KWidth_Scale,60*KWidth_Scale, 25*KWidth_Scale)];
        _zhuanji.font=UIFont(12);
        _zhuanji.textColor=WordsofcolorColor;
    }
    return _zhuanji;
}
-(UIButton *)MoreBtn
{
    if (_MoreBtn==nil) {
        _MoreBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _MoreBtn.frame=CGRectMake(SCREEN_WIDTH-5*KWidth_Scale-45*KWidth_Scale,15*KWidth_Scale, 45*KWidth_Scale, 20*KWidth_Scale);
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
-(void)creatUI
{
    [self addSubview:self.imageview];
    [self addSubview:self.titllabel];
    [self addSubview:self.MoreBtn];
    self.zhuanjiiconimageview=[[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.imageview.frame)+5*KWidth_Scale,38*KWidth_Scale, 20*KWidth_Scale, 20*KWidth_Scale)];
    self.zhuanjiiconimageview.image=[UIImage imageNamed:@"playBack_Image"];
    [self addSubview:self.zhuanjiiconimageview];
    [self addSubview:self.videocount];
    self.ima2=[[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.videocount.frame)+5*KWidth_Scale, 40*KWidth_Scale, 20*KWidth_Scale, 20*KWidth_Scale)];
    self.ima2.image=[UIImage imageNamed:@"playBack_Image"];
    [self addSubview: self.ima2];
    [self addSubview:self.zhuanji];
    [self addSubview:self.timeLabel];
    
    self.timeLabel.text=@"2019-10-23";
    self.titllabel.text=@"我是标题";
    [self.imageview sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1539075998765&di=20f535ed353cc2be1e53063d3627c683&imgtype=0&src=http%3A%2F%2Fpic30.photophoto.cn%2F20140218%2F0013025939222600_b.jpg"]];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
