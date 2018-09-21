
//
//  WatchoneTableViewCell.m
//  Woo
//
//  Created by 王起锋 on 2018/8/13.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import "WatchoneTableViewCell.h"

@implementation WatchoneTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier datarr:(NSArray *)datarr
{
    if (self==[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor=CellBackgroundColor;
        [self addSubview:self.botomoview];
        [self.botomoview addSubview:self.titleLabel];
        [self.botomoview addSubview:self.nameLabel];
        [self creatview:datarr];
    }
    return self;
}
-(void)creatview:(NSArray *)datarr
{
    CGFloat paing=(SCREEN_WIDTH-3*112*KWidth_Scale-20*KWidth_Scale)/4;
    CGFloat float_h =80*KWidth_Scale;
    CGFloat float_W =112*KWidth_Scale;
    for (int i=0; i<3; i++) {
        UIImageView *imagevi=[[UIImageView alloc] initWithFrame:CGRectMake(paing*(i+1)+float_W*i,8*KWidth_Scale, float_W, float_h)];
        [imagevi setContentMode:UIViewContentModeScaleAspectFill];
        
        imagevi.clipsToBounds = YES;
        [imagevi sd_setImageWithURL:[NSURL URLWithString:@"https://img5q.duitang.com/uploads/item/201505/15/20150515205520_iWF2U.jpeg"]];
        [self.botomoview addSubview:imagevi];
    }
}
-(UILabel *)nameLabel
{
    if (_nameLabel==nil) {
        _nameLabel=[[UILabel alloc] initWithFrame:CGRectMake(10*KWidth_Scale,CGRectGetMaxY(self.titleLabel.frame), SCREEN_WIDTH-50*KWidth_Scale, 25*KWidth_Scale)];
        _nameLabel.textColor=[PublicFunction colorWithHexString:@"666666"];
        _nameLabel.font=UIFont(12);
    }
    return _nameLabel;
}
-(UILabel *)titleLabel
{
    if (_titleLabel==nil) {
        _titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(10*KWidth_Scale, 10*KWidth_Scale+80*KWidth_Scale, SCREEN_WIDTH-40*KWidth_Scale, 25*KWidth_Scale)];
        _titleLabel.textColor=WordsofcolorColor;
        _titleLabel.font=UIFont(15);
    }
    return _titleLabel;
}
-(UIView *)botomoview
{
    if (_botomoview==nil) {
        _botomoview=[[UIView alloc] initWithFrame:CGRectMake(10*KWidth_Scale, 0, SCREEN_WIDTH-20*KWidth_Scale, 150*KWidth_Scale)];
        _botomoview.backgroundColor=[UIColor whiteColor];
        _botomoview.layer.cornerRadius=5;
        _botomoview.clipsToBounds=YES;
    }
    return _botomoview;
}
-(void)setModel:(Watchobject *)model
{
    self.nameLabel.text=model.userName;
    self.titleLabel.text=model.title;;
}
-(void)setFrame:(CGRect)frame
{
    frame.size.height-=8*KWidth_Scale;
    [super setFrame:frame];
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
