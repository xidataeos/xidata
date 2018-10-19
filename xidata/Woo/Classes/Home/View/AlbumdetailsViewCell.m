//
//  AlbumdetailsViewCell.m
//  Woo
//
//  Created by 王起锋 on 2018/10/15.
//  Copyright © 2018年 杭州蜂布式. All rights reserved.
//

#import "AlbumdetailsViewCell.h"

@implementation AlbumdetailsViewCell
-(UILabel *)tipsLabel{
    if (_tipsLabel==nil) {
        _tipsLabel=[[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-30-10*KWidth_Scale,CGRectGetMaxY(self.titllabel.frame)+2, 31, 16*KWidth_Scale)];
        _tipsLabel.textAlignment=NSTextAlignmentCenter;
        _tipsLabel.clipsToBounds=YES;
        _tipsLabel.font=UIFont(12);
    }
    return _tipsLabel;
}
-(UILabel *)zhuanjiLabel
{
    if (_zhuanjiLabel==nil) {
        _zhuanjiLabel=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.img2.frame)+2*KWidth_Scale, 2, 60*KWidth_Scale, 20*KWidth_Scale)];
        _zhuanjiLabel.font=UIFont(12);
        _zhuanjiLabel.textColor=WordsofcolorColor;
    }
    return _zhuanjiLabel;
}
-(UILabel *)videocount
{
    if (_videocount==nil) {
        _videocount=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.zhuanjiiconimageview.frame)+2*KWidth_Scale, 2, 60*KWidth_Scale, 20*KWidth_Scale)];
        _videocount.font=UIFont(12);
        _videocount.textColor=WordsofcolorColor;
    }
    return _videocount;
}
-(UIView *)botomoview
{
    if (_botomoview==nil) {
        _botomoview=[[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.imageview.frame)+2, CGRectGetMaxY(self.titllabel.frame)+5*KWidth_Scale, SCREEN_WIDTH-115*KWidth_Scale, 25*KWidth_Scale)];
        self.zhuanjiiconimageview=[[UIImageView alloc] initWithFrame:CGRectMake(5*KWidth_Scale, 2, 20*KWidth_Scale, 20*KWidth_Scale)];
         self.img2=[[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.videocount.frame)+2, 2, 20*KWidth_Scale, 20*KWidth_Scale)];
        [_botomoview addSubview:self.zhuanjiiconimageview];
        [_botomoview addSubview:self.img2];
        [_botomoview addSubview:self.zhuanjiLabel];
        [_botomoview addSubview:self.videocount];
    }
    return _botomoview;
}

-(UILabel *)timeLabel
{
    if (_timeLabel==nil) {
        _timeLabel=[[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-10*KWidth_Scale-90, 10*KWidth_Scale, 90, 20*KWidth_Scale)];
        _timeLabel.font=UIFont(12);
        _timeLabel.textColor=WordsofcolorColor;
        _timeLabel.textAlignment=NSTextAlignmentRight;
        _timeLabel.numberOfLines=0;
    }
    return _timeLabel;
}
-(UILabel *)imageview
{
    if (_imageview==nil) {
        _imageview=[[UILabel alloc] initWithFrame:CGRectMake(0,5, 50*KWidth_Scale, 50*KWidth_Scale)];
        _imageview.textColor=WordsofcolorColor;
        _imageview.font=UIFont(15);
        _imageview.textAlignment=NSTextAlignmentCenter;
    }
    return _imageview;
}
-(UILabel *)titllabel
{
    if (_titllabel==nil) {
        _titllabel=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.imageview.frame), 10*KWidth_Scale, SCREEN_WIDTH-115*KWidth_Scale, 20*KWidth_Scale)];
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
-(void)creatUI
{
    [self addSubview:self.imageview];
    [self addSubview:self.titllabel];
    [self addSubview:self.timeLabel];
    [self addSubview:self.botomoview];
    [self addSubview:self.tipsLabel];
   
    self.zhuanjiiconimageview.image=[UIImage imageNamed:@"pay_selected"];
    self.img2.image=[UIImage imageNamed:@"pay_selected"];
    UIView *cell=[[UIView alloc] initWithFrame:CGRectMake(0, 159, SCREEN_WIDTH, 0.7)];
    cell.backgroundColor=CellBackgroundColor;
    //[self addSubview:cell];
}
-(void)setModel:(GraphicinfoModel *)model
{
    self.timeLabel.text=model.createDate;
    self.titllabel.text=model.title;
    self.zhuanjiLabel.text=[NSString stringWithFormat:@"%ld",(long)model.likeNum];
    self.videocount.text=[NSString stringWithFormat:@"%ld",(long)model.commentNum];
    if (model.price) {
        self.tipsLabel.text=@"付费";
        _tipsLabel.layer.borderWidth=1.0;
        _tipsLabel.layer.cornerRadius=3;
        _tipsLabel.layer.borderColor=UIColorFromRGB(0xE51C23).CGColor;
        _tipsLabel.textColor=UIColorFromRGB(0xE51C23);
    }
    else{
        self.tipsLabel.text=@"免费";
        _tipsLabel.layer.borderWidth=1.0;
        _tipsLabel.layer.cornerRadius=3;
    _tipsLabel.layer.borderColor=NaviBackgroundColor.CGColor;
        _tipsLabel.textColor=NaviBackgroundColor;
    }
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
