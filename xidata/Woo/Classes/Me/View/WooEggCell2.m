//
//  WooEggCell2.m
//  Woo
//
//  Created by 风外杏林香 on 2018/9/6.
//  Copyright © 2018年 杭州蜂布式. All rights reserved.
//

#import "WooEggCell2.h"

@implementation WooEggCell2

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initWithUI];
    }
    return self;
}
- (void)initWithUI
{
    self.label1 = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, ScreenWidth - 40, 30)];
    self.label1.textAlignment = NSTextAlignmentLeft;
    self.label1.font = UIFont(14);
    self.label1.text = @"登录奖励";
    [self.contentView addSubview:self.label1];
    
    self.label2 = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(self.label1.frame), (ScreenWidth - 40) / 2, 30)];
    self.label2.textAlignment = NSTextAlignmentLeft;
    self.label2.font = UIFont(12);
    self.label2.textColor = RGB(153, 153, 153);
    self.label2.text = @"2018 09-06";
    [self.contentView addSubview:self.label2];
    
    self.label3 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.label2.frame), CGRectGetMaxY(self.label1.frame), (ScreenWidth - 40) / 2, 30)];
    self.label3.textAlignment = NSTextAlignmentRight;
    self.label3.font = UIFont(12);
    self.label3.textColor = RGB(255, 101, 0);
    self.label3.text = @"+1000";
    [self.contentView addSubview:self.label3];
}

- (void)setModel:(WooEggModel *)model
{
    _model = model;
    self.label1.text = [NSString stringWithFormat:@"%@", model.scene];
    self.label2.text = [NSString stringWithFormat:@"%@", model.tradeTime];
    self.label3.text = [NSString stringWithFormat:@"%@", model.asset];
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
