//
//  WooMeCell.m
//  Woo
//
//  Created by 风外杏林香 on 2018/8/9.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import "WooMeCell.h"

@implementation WooMeCell

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
    self.imageView1 = [UIImageView new];
    self.imageView1.frame = CGRectMake(20, 10, self.contentView.frame.size.height - 20, self.contentView.frame.size.height - 20);
    [self.contentView addSubview:self.imageView1];
    
    self.label1 = [UILabel new];
    self.label1.textAlignment = NSTextAlignmentLeft;
    self.label1.textColor = RGB(51, 51, 51);
    self.label1.adjustsFontSizeToFitWidth = YES;
    self.label1.font = UIFont(15);
    self.label1.frame = CGRectMake(CGRectGetMaxX(self.imageView1.frame) + 10, 10, 100, self.contentView.frame.size.height - 20);
    [self.contentView addSubview:self.label1];
    
    self.label2 = [UILabel new];
    self.label2.textAlignment = NSTextAlignmentRight;
    self.label2.textColor = RGB(51, 51, 51);
    self.label2.font = UIFont(15);
    self.label2.frame = CGRectMake(ScreenWidth - 120, 10, 100, self.contentView.frame.size.height - 20);
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
