
//
//  RedWooTableViewCell.m
//  Woo
//
//  Created by 王起锋 on 2018/8/24.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import "RedWooTableViewCell.h"

@implementation RedWooTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self==[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.photo];
    }
    return self;
}
-(UILabel *)countlabel{
    if (_countlabel==nil) {
        _countlabel=[[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*0.6, 0, SCREEN_WIDTH*0.4-15*KWidth_Scale, 25*KWidth_Scale)];
        _countlabel.textColor=WordsofcolorColor;
        _countlabel.font=UIFont(15);
        _countlabel.textAlignment=NSTextAlignmentRight;
        [self addSubview:_countlabel];
    }
    return _countlabel;
}
-(UIImageView *)tipsimage
{
    if (_tipsimage==nil) {
        _tipsimage=[[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-15*KWidth_Scale-20*KWidth_Scale, CGRectGetMaxY(self.countlabel.frame), 20*KWidth_Scale, 20*KWidth_Scale)];
    }
    return _tipsimage;
}
-(UILabel *)textLanel
{
    if (_textLanel==nil) {
        _textLanel=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.photo.frame)+12*KWidth_Scale, 10*KWidth_Scale, SCREEN_WIDTH*0.4, 20)];
        _textLanel.textColor=WordsofcolorColor;
        _textLanel.font=UIFont(15);
    }
    return _textLanel;
}
-(UIImageView *)photo
{
    if (_photo==nil) {
        _photo=[[UIImageView alloc] initWithFrame:CGRectMake(15*KWidth_Scale,10*KWidth_Scale, 35*KWidth_Scale, 35*KWidth_Scale)];
    }
    return _photo;
}
-(UILabel *)detailtextview
{
    if (_detailtextview==nil) {
        _detailtextview=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.photo.frame)+12*KWidth_Scale, CGRectGetMaxY(self.textLanel.frame)+0*KWidth_Scale, SCREEN_WIDTH*0.4, 17)];
        _detailtextview.textColor=[PublicFunction colorWithHexString:@"999999"];
        _detailtextview.font=UIFont(13);
    }
    return _detailtextview;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setModel:(RedmessageModle *)model
{
    self.textLanel.text=model.toName;
    if ([PublicFunction isEmpty:model.toName]) {
       self.textLanel.text=model.name;
    }
    self.textLanel.font=DefleFuont;
    self.textLanel.textColor=[PublicFunction colorWithHexString:@"333333"];
    self.accessoryType = UITableViewCellAccessoryNone;
    self.detailtextview.text=model.recvTime;
    self.detailtextview.textColor=[PublicFunction colorWithHexString:@"999999"];
     [self.photo sd_setImageWithURL:[NSURL URLWithString:model.toPhoto] placeholderImage:[UIImage imageNamed:@"photo_boy"]];
     if ([PublicFunction isEmpty:model.toPhoto]) {
          [self.photo sd_setImageWithURL:[NSURL URLWithString:model.photo] placeholderImage:[UIImage imageNamed:@"photo_boy"]];
     }
   
    self.clipsToBounds=YES;
    self.contentMode=UIViewContentModeScaleAspectFill;
    self.countlabel.text=[NSString stringWithFormat:@"%@ 枚",model.asset];
    [self addSubview:self.textLanel];
    [self addSubview:self.detailtextview];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
