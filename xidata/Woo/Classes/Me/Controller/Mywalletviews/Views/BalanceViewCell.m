
//
//  BalanceViewCell.m
//  Woo
//
//  Created by 王起锋 on 2018/10/11.
//  Copyright © 2018年 杭州蜂布式. All rights reserved.
//

#import "BalanceViewCell.h"

@implementation BalanceViewCell
-(UILabel *)titllabel
{
    if (_titllabel==nil) {
        _titllabel=[[UILabel alloc] initWithFrame:CGRectMake(15*KWidth_Scale,10*KWidth_Scale, SCREEN_WIDTH-110*KWidth_Scale, 20*KWidth_Scale)];
        _titllabel.font=UIFont(15);
        _titllabel.textColor=WordsofcolorColor;
        _titllabel.numberOfLines=0;
    }
    return _titllabel;
}
-(UILabel *)detailcellLabel
{
    if (_detailcellLabel==nil) {
        _detailcellLabel=[[UILabel alloc] initWithFrame:CGRectMake(15*KWidth_Scale, CGRectGetMaxY(self.titllabel.frame), SCREEN_WIDTH-110*KWidth_Scale, 20*KWidth_Scale)];
        _detailcellLabel.font=UIFont(12);
        _detailcellLabel.textColor=RGB(153, 153, 153);
        _detailcellLabel.numberOfLines=0;
    }
    return _detailcellLabel;
}
-(UILabel *)cellLabel
{
    if (_cellLabel==nil) {
        _cellLabel=[[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-10*KWidth_Scale-90*KWidth_Scale, 10*KWidth_Scale, 80*KWidth_Scale, 20*KWidth_Scale)];
        _cellLabel.font=UIFont(14);
        _cellLabel.textColor=WordsofcolorColor;
        _cellLabel.numberOfLines=0;
        _cellLabel.textAlignment=NSTextAlignmentRight;
    }
    return _cellLabel;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self==[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUIwith];
    }
    return self;
}
-(void)initUIwith
{
    [self addSubview:self.titllabel];
    [self addSubview:self.detailcellLabel];
    [self addSubview:self.cellLabel];
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
