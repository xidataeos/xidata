//
//  Acountsetingcell.m
//  Woo
//
//  Created by 王起锋 on 2018/10/11.
//  Copyright © 2018年 杭州蜂布式. All rights reserved.
//

#import "Acountsetingcell.h"

@implementation Acountsetingcell
-(UIImageView *)iconimage
{
    if (_iconimage==nil) {
        _iconimage=[[UIImageView alloc] initWithFrame:CGRectMake(15*KWidth_Scale, 10*KWidth_Scale, 30*KWidth_Scale, 30*KWidth_Scale)];
    _iconimage.contentMode=UIViewContentModeScaleAspectFill;
    }
    return _iconimage;
}
-(UILabel *)cellLabel
{
    if (_cellLabel==nil) {
        _cellLabel=[[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-15*KWidth_Scale-90*KWidth_Scale, 0, 90*KWidth_Scale, 50*KWidth_Scale)];
        _cellLabel.font=UIFont(14);
        _cellLabel.textColor=UIColorFromRGB(0xE51C23);
        _cellLabel.numberOfLines=0;
        _cellLabel.textAlignment=NSTextAlignmentRight;
    }
    return _cellLabel;
}
-(UILabel *)titllabel
{
    if (_titllabel==nil) {
        _titllabel=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.iconimage.frame)+10*KWidth_Scale,0*KWidth_Scale, SCREEN_WIDTH-120*KWidth_Scale, 50*KWidth_Scale)];
        _titllabel.font=UIFont(15);
        _titllabel.textColor=WordsofcolorColor;
        _titllabel.numberOfLines=0;
    }
    return _titllabel;
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
    [self addSubview:self.iconimage];
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
