
//
//  SearchTableViewCell.m
//  Woo
//
//  Created by 王起锋 on 2018/8/14.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import "SearchTableViewCell.h"

@implementation SearchTableViewCell
-(UIImageView *)avimage
{
    if (_avimage==nil) {
        _avimage=[[UIImageView alloc] initWithFrame:CGRectMake(15*KWidth_Scale, 7.5*KWidth_Scale, 30*KWidth_Scale, 30*KWidth_Scale)];
    }
    return _avimage;
}
-(UILabel *)namelabel
{
    if (_namelabel==nil) {
        _namelabel=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.avimage.frame)+5*KWidth_Scale, 0, SCREEN_WIDTH*0.7, 44*KWidth_Scale)];
        _namelabel.textColor=WordsofcolorColor;
        _namelabel.font=UIFont(15);
    }
    return _namelabel;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self==[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creatUI];
    }
    return self;
}
-(void)creatUI
{
    [self addSubview:self.avimage];
    [self addSubview:self.namelabel];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setFrame:(CGRect)frame
{
    frame.size.height-=0.8;
    [super setFrame:frame];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
