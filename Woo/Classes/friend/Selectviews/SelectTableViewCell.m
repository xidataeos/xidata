
//
//  SelectTableViewCell.m
//  Woo
//
//  Created by 王起锋 on 2018/8/8.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import "SelectTableViewCell.h"

@implementation SelectTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self==[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUI];
        [self addSubview:self.selectBtn];
    }
    return self;
}
-(UIButton *)selectBtn
{
    if (_selectBtn==nil) {
        CGFloat paing=(50*KWidth_Scale-22)/2.0;
        _selectBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _selectBtn.frame=CGRectMake(SCREEN_WIDTH-50*KWidth_Scale, 0, 50*KWidth_Scale,50*KWidth_Scale);
        [_selectBtn setImage:[UIImage imageNamed:@"unsekecticon"] forState:UIControlStateNormal];
        [_selectBtn setImage:[UIImage imageNamed:@"selecticon"] forState:UIControlStateSelected];
        [_selectBtn setImageEdgeInsets:UIEdgeInsetsMake(paing,paing, paing,paing)];
        [_selectBtn addTarget:self action:@selector(tapclick) forControlEvents:UIControlEventTouchUpInside];
        _selectBtn.selected=NO;
    }
    return _selectBtn;;
}

-(void)tapclick
{
    if (self.selectBtn.selected) {
        self.selectBtn.selected=NO;
    }
    else{
        self.selectBtn.selected=YES;
    }
    if (self.myblock) {
        self.myblock(self.selectBtn.selected);
    }
}
-(UILabel *)celltitlable
{
    if (_celltitlable==nil) {
        _celltitlable=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.userimageview.frame)+8*KWidth_Scale, 0, SCREEN_WIDTH*0.6, self.frame.size.height)];
    }
    return _celltitlable;
}
-(UIImageView *)userimageview
{
    if (_userimageview==nil) {
        _userimageview=[[UIImageView alloc] initWithFrame:CGRectMake(15*KWidth_Scale, 8*KWidth_Scale, (self.frame.size.height-16*KWidth_Scale), (self.frame.size.height-16*KWidth_Scale))];
        _userimageview.contentMode=UIViewContentModeScaleAspectFill;
        _userimageview.clipsToBounds=YES;
    }
    return _userimageview;
}
-(void)setUI
{
    self.userimageview.frame=CGRectMake(15*KWidth_Scale, 8*KWidth_Scale, 34*KWidth_Scale, 34*KWidth_Scale);
    self.celltitlable.frame=CGRectMake(CGRectGetMaxX(self.userimageview.frame)+10*KWidth_Scale, 0, SCREEN_WIDTH*0.5, 50*KWidth_Scale);
    [self addSubview:self.userimageview];
    [self addSubview:self.celltitlable];
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
