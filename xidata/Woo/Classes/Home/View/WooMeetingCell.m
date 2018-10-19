//
//  WooMeetingCell.m
//  Woo
//
//  Created by 风外杏林香 on 2018/8/17.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import "WooMeetingCell.h"

@implementation WooMeetingCell
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
    self.imageView1.layer.cornerRadius = 5;
    self.imageView1.layer.masksToBounds = YES;
    self.imageView1.frame = CGRectMake(10, 10, ScreenWidth - 20, 120);
    self.imageView1.contentMode=UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:self.imageView1];
    
    self.label1 = [UILabel new];
//    self.label1.backgroundColor = [UIColor redColor];
    self.label1.textAlignment = NSTextAlignmentLeft;
    self.label1.font = UIFont(18);
    self.label1.textColor = NaviBackgroundColor;
    self.label1.frame = CGRectMake(CGRectGetMinX(self.imageView1.frame), CGRectGetMaxY(self.imageView1.frame) + 5, ScreenWidth - 20, 30);
    [self.contentView addSubview:self.label1];
    
    self.label2 = [UILabel new];
//    self.label2.backgroundColor = [UIColor redColor];
    self.label2.textAlignment = NSTextAlignmentLeft;
    self.label2.font = UIFont(15);
    self.label2.textColor = [PublicFunction colorWithHexString:@"666666"];
    self.label2.frame = CGRectMake(CGRectGetMinX(self.label1.frame), CGRectGetMaxY(self.label1.frame), ScreenWidth - 20, 30);
    [self.contentView addSubview:self.label2];
    
    
    self.label3 = [UILabel new];
//    self.label3.backgroundColor = [UIColor redColor];
    self.label3.textAlignment = NSTextAlignmentLeft;
    self.label3.font = UIFont(15);
    self.label3.textColor = [PublicFunction colorWithHexString:@"666666"];
    self.label3.frame = CGRectMake(CGRectGetMinX(self.label2.frame), CGRectGetMaxY(self.label2.frame), ScreenWidth - 20, 30);
    [self.contentView addSubview:self.label3];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.label3.frame), ScreenWidth, 10)];
    line.backgroundColor = RGB(235, 235, 235);
    [self.contentView addSubview:line];
    
    /*
    [self.contentView sd_addSubviews:@[self.imageView1, self.label1, self.label2, self.label3]];
    
    self.imageView1.sd_layout
    .leftSpaceToView(self.contentView, 10)
    .topSpaceToView(self.contentView, 10)
    .rightSpaceToView(self.contentView, 10)
    .heightIs(120);
    
    self.label1.sd_layout
    .leftEqualToView(self.imageView1)
    .topSpaceToView(self.imageView1, 5)
    .rightEqualToView(self.imageView1)
    .heightIs(30);
    
    self.label2.sd_layout
    .leftEqualToView(self.label1)
    .topSpaceToView(self.label1, 0)
    .rightEqualToView(self.label1)
    .heightIs(30);
    
    self.label3.sd_layout
    .leftEqualToView(self.label2)
    .rightEqualToView(self.label2)
    .topSpaceToView(self.label2, 0)
    .heightIs(30);
     */
    
}

- (void)setModel:(WooHMeetingModel *)model
{
    _model = model;
    self.label1.text = [NSString stringWithFormat:@"%@", model.mName];
    self.label2.text = [NSString stringWithFormat:@"%@至%@", model.mStarttime,model.mStoptime];
    self.label3.text = [NSString stringWithFormat:@"%@", model.mAddress];
    [self.imageView1 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", model.mImg]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        ZKLog(@"错误信息:%@",error);
    }];
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
