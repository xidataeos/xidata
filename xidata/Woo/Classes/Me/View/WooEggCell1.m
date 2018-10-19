//
//  WooEggCell1.m
//  Woo
//
//  Created by 风外杏林香 on 2018/9/6.
//  Copyright © 2018年 杭州蜂布式. All rights reserved.
//

#import "WooEggCell1.h"

@implementation WooEggCell1

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
    
    self.label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
    self.label1.text = @"总资产";
    self.label1.textAlignment = NSTextAlignmentCenter;
    self.label1.font = UIFont(18);
    [self.contentView addSubview:self.label1];
    
    self.label2 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.label1.frame), ScreenWidth, 50)];
    self.label2.text = @"1000000.00";
    self.label2.textAlignment = NSTextAlignmentCenter;
    self.label2.font = UIFont(30);
    [self.contentView addSubview:self.label2];
    
    self.label3 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.label2.frame), ScreenWidth, 50)];
    self.label3.text = @"彩蛋（WOT）";
    self.label3.textAlignment = NSTextAlignmentCenter;
    self.label3.font = UIFont(18);
    [self.contentView addSubview:self.label3];
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
