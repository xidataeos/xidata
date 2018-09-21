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
//    self.imageView1.backgroundColor = [UIColor redColor];
    self.imageView1.frame = CGRectMake(20, 10, self.contentView.frame.size.height - 20, self.contentView.frame.size.height - 20);
    [self.contentView addSubview:self.imageView1];
    
    self.label1 = [UILabel new];
    self.label1.textAlignment = NSTextAlignmentLeft;
//    self.label1.backgroundColor = [UIColor redColor];
    self.label1.textColor = RGB(51, 51, 51);
    self.label1.adjustsFontSizeToFitWidth = YES;
    self.label1.font = UIFont(15);
    self.label1.frame = CGRectMake(CGRectGetMaxX(self.imageView1.frame) + 10, 10, 100, self.contentView.frame.size.height - 20);
    [self.contentView addSubview:self.label1];
    
    self.label2 = [UILabel new];
    self.label2.textAlignment = NSTextAlignmentRight;
//    self.label2.backgroundColor = [UIColor redColor];
    self.label2.textColor = RGB(51, 51, 51);
    self.label2.font = UIFont(15);
    self.label2.frame = CGRectMake(ScreenWidth - 120, 10, 100, self.contentView.frame.size.height - 20);
    [self.contentView addSubview:self.label2];
    
    /*
    [self.contentView sd_addSubviews:@[self.imageView1, self.label1, self.label2]];
    
    self.imageView1.sd_layout
    .topSpaceToView(self.contentView, 10)
    .leftSpaceToView(self.contentView, 20)
    .bottomSpaceToView(self.contentView, 10)
    .widthEqualToHeight();
    
    self.label1.sd_layout
    .leftSpaceToView(self.imageView1, 10)
    .topEqualToView(self.imageView1)
    .bottomEqualToView(self.imageView1)
    .widthIs(100);
    
    self.label2.sd_layout
    .topEqualToView(self.label1)
    .rightSpaceToView(self.contentView, 20)
    .bottomEqualToView(self.label1)
    .widthIs(100);
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
