//
//  CustomTableViewCell.m
//  Woo
//
//  Created by 王起锋 on 2018/8/2.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import "CustomTableViewCell.h"

@implementation CustomTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self==[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.userimageview];
        [self addSubview:self.tipslabel];
        [self addSubview:self.celltitlable];
        [self addSubview:self.cellline];
    }
    return self;
}
-(UIView *)cellline
{
    if (_cellline==nil) {
        _cellline=[[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height, SCREEN_WIDTH, 0.7)];
        _cellline.backgroundColor=CellBackgroundColor;
    }
    return _cellline;
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
-(UILabel *)tipslabel
{
    if (_tipslabel==nil) {
        _tipslabel=[[UILabel alloc] init];
        _tipslabel.textColor=[UIColor whiteColor];
        _tipslabel.font=UIFont(12);
        _tipslabel.backgroundColor=NaviBackgroundColor;
        _tipslabel.textAlignment=NSTextAlignmentCenter;
    }
    return _tipslabel;
}
-(void)setdata:(NSString *)unreadcountstr
{
    CGFloat tipwith=0;
    if (unreadcountstr.length<=2) {
        tipwith=30;
        _tipslabel.text=unreadcountstr;
    }
    else{
        tipwith=35;
        _tipslabel.text=@"99+";
    }
    _tipslabel.frame=CGRectMake(ScreenWidth-15-tipwith, 11, tipwith, 18);
    _tipslabel.layer.cornerRadius=9;
    _tipslabel.clipsToBounds=YES;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setFrame:(CGRect)frame
{
//    frame.size.height-=1;
//    [super setFrame:frame];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
