//
//  WooInfoCell.m
//  Woo
//
//  Created by 风外杏林香 on 2018/8/9.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import "WooInfoCell.h"

@implementation WooInfoCell

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
    CGFloat width = (ScreenWidth - 40) / 2;

    self.label1 = [UILabel new];
    self.label1.textAlignment = NSTextAlignmentLeft;
    self.label1.frame = CGRectMake(20, 5, width, 50);
//    self.label1.backgroundColor = [UIColor redColor];
    self.label1.textColor = RGB(51, 51, 51);
    self.label1.adjustsFontSizeToFitWidth = YES;
    self.label1.font = UIFont(18);
    [self.contentView addSubview:self.label1];
    
    self.label2 = [UILabel new];
    self.label2.textAlignment = NSTextAlignmentRight;
//    self.label2.backgroundColor = [UIColor redColor];
    self.label2.textColor = RGB(51, 51, 51);
    self.label2.adjustsFontSizeToFitWidth = YES;
    self.label2.font = UIFont(15);
    self.label2.frame = CGRectMake(CGRectGetMaxX(self.label1.frame), 5, width, 50);
    [self.contentView addSubview:self.label2];
    self.imageView1 = [UIImageView new];
//    self.imageView1.backgroundColor = [UIColor redColor];
    self.imageView1.frame = CGRectMake(ScreenWidth - 60, 10, 40, 40);
    [self.contentView addSubview:self.imageView1];
    
    /*
    [self.contentView sd_addSubviews:@[self.label1, self.label2, self.imageView1]];
    
    self.label1.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .topSpaceToView(self.contentView, 5)
    .bottomSpaceToView(self.contentView, 5)
    .widthIs(width);
    
    self.label2.sd_layout
    .rightSpaceToView(self.contentView, 10)
    .topSpaceToView(self.contentView, 5)
    .bottomSpaceToView(self.contentView, 5)
    .widthIs(width);
    
    self.imageView1.sd_layout
    .rightSpaceToView(self.contentView, 10)
    .topSpaceToView(self.contentView, 10)
    .widthIs(40)
    .heightIs(40);
     */
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
