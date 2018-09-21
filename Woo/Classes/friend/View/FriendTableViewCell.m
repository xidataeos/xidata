
//
//  FriendTableViewCell.m
//  Woo
//
//  Created by 王起锋 on 2018/8/8.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import "FriendTableViewCell.h"

@implementation FriendTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self==[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creatUI];
    }
    return self;
}
-(UILabel *)celltitlable
{
    if (_celltitlable==nil) {
        _celltitlable=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.userimageview.frame)+10*KWidth_Scale, 0,SCREEN_WIDTH*0.5, 55*KWidth_Scale)];
    }
    return _celltitlable;
}
-(UIImageView *)userimageview
{
    if (_userimageview==nil) {
        _userimageview=[[UIImageView alloc] initWithFrame:CGRectMake(15*KWidth_Scale, 10*KWidth_Scale, 35*KWidth_Scale, 35*KWidth_Scale)];
        _userimageview.contentMode=UIViewContentModeScaleAspectFill;
        _userimageview.clipsToBounds=YES;
    }
    return _userimageview;
}
-(void)creatUI
{
    [self addSubview:self.celltitlable];
    [self addSubview:self.userimageview];
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
