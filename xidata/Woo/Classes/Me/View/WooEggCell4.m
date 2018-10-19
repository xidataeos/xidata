//
//  WooEggCell4.m
//  Woo
//
//  Created by 风外杏林香 on 2018/9/6.
//  Copyright © 2018年 杭州蜂布式. All rights reserved.
//

#import "WooEggCell4.h"

@implementation WooEggCell4

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
    self.label1 = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, width + width / 2, 30)];
    self.label1.text = @"登录奖励";
    self.label1.textAlignment = NSTextAlignmentLeft;
    self.label1.font = UIFont(14);
//    self.label1.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.label1];
    
    self.label2 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.label1.frame), 0, ScreenWidth - 40 - CGRectGetWidth(self.label1.frame), 30)];
//    self.label2.backgroundColor = [UIColor redColor];
    self.label2.textAlignment = NSTextAlignmentRight;
    self.label2.font = UIFont(15);
    self.label2.textColor = RGB(255, 101, 0);
    self.label2.text = @"+ 2000";
    [self.contentView addSubview:self.label2];
    
    self.label3 = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(self.label1.frame), CGRectGetWidth(self.label1.frame), 30)];
    self.label3.textAlignment = NSTextAlignmentLeft;
    self.label3.font = UIFont(12);
    self.label3.textColor = RGB(153, 153, 153);
    self.label3.text = @"2018 09-06";
    [self.contentView addSubview:self.label3];
    
    self.button1 = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.button1.frame = CGRectMake(CGRectGetMinX(self.label2.frame), CGRectGetMaxY(self.label2.frame), CGRectGetWidth(self.label2.frame), 30);
    [self.button1 setTitle:@"游戏数据" forState:(UIControlStateNormal)];
    self.button1.titleLabel.font = UIFont(14);
    [self.button1 setTitleColor:RGB(255, 101, 0) forState:(UIControlStateNormal)];
    UIImage *imgArrow = [UIImage imageNamed:@"zhankai_Image"];
    [self.button1 setImage:imgArrow forState:(UIControlStateNormal)];
    self.button1.titleEdgeInsets = UIEdgeInsetsMake(0, -self.button1.imageView.size.width - 5, 0, self.button1.imageView.size.width);
    self.button1.imageEdgeInsets = UIEdgeInsetsMake(0, self.button1.titleLabel.size.width, 0, -self.button1.titleLabel.size.width);
    [self.button1 addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.contentView addSubview:self.button1];
    
}


- (void)buttonAction:(UIButton *)sender
{
    WEAKSELF;
    if (_delegate && [_delegate respondsToSelector:@selector(didClickButtonInCell:)]) {
        [_delegate didClickButtonInCell:weakSelf];
    }
}

- (void)setModel:(WooDrawEggModel *)model
{
    _model = model;
    ZKLog(@"model -- %@", model.startTime);
    self.label1.text = [NSString stringWithFormat:@"%@", model.meetingName];
    self.label2.text = [NSString stringWithFormat:@"%@", model.myPutNumber];
    self.label3.text = [NSString stringWithFormat:@"%@", model.startTime];
    self.label3.adjustsFontSizeToFitWidth = YES;
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
