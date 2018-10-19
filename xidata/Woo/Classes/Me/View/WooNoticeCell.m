//
//  WooNoticeCell.m
//  Woo
//
//  Created by 风外杏林香 on 2018/9/3.
//  Copyright © 2018年 杭州蜂布式. All rights reserved.
//

#import "WooNoticeCell.h"

@implementation WooNoticeCell

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
    self.label1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, ScreenWidth - 20, 30)];
    self.label1.font = UIFont(16);
    self.label1.textAlignment = NSTextAlignmentLeft;
    self.label1.textColor = RGB(51, 51, 51);
    [self.contentView addSubview:self.label1];
    
    self.label2 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.label1.frame), CGRectGetMaxY(self.label1.frame), ScreenWidth - 20, 30)];
    self.label2.font = UIFont(13);
    self.label2.textAlignment = NSTextAlignmentLeft;
    self.label2.textColor = RGB(102, 102, 102);
    [self.contentView addSubview:self.label2];
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
