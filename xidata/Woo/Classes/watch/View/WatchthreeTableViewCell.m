
//
//  WatchthreeTableViewCell.m
//  Woo
//
//  Created by 王起锋 on 2018/8/13.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import "WatchthreeTableViewCell.h"

@implementation WatchthreeTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self==[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor=CellBackgroundColor;
        [self addSubview:self.botomoview];
        self.titleLabel.frame=CGRectMake(10*KWidth_Scale, 12*KWidth_Scale, SCREEN_WIDTH-50*KWidth_Scale, 15*KWidth_Scale);
        [self.botomoview addSubview:self.describelabel];
         [self.botomoview addSubview:self.titleLabel];
         [self.botomoview addSubview:self.nameLabel];
        self.nameLabel.frame=CGRectMake(10*KWidth_Scale, CGRectGetMaxY(self.describelabel.frame), SCREEN_WIDTH-50*KWidth_Scale,30*KWidth_Scale);
    }
    return self;
}
-(UILabel *)describelabel
{
    if (_describelabel==nil) {
        _describelabel=[[UILabel alloc] initWithFrame:CGRectMake(10*KWidth_Scale, CGRectGetMaxY(self.titleLabel.frame)+5*KWidth_Scale, SCREEN_WIDTH-40*KWidth_Scale, 85*KWidth_Scale)];
        _describelabel.numberOfLines=0;
        _describelabel.font=UIFont(14);
        _describelabel.textColor=[PublicFunction colorWithHexString:@"999999"];
    }
    return _describelabel;
}
-(void)setModel:(Watchobject *)model
{
    self.nameLabel.text=model.userName;
    self.titleLabel.text=model.title;
    self.describelabel.text=model.intro;
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
