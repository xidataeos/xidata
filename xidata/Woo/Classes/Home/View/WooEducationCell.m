//
//  WooEducationCell.m
//  Woo
//
//  Created by 风外杏林香 on 2018/8/27.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import "WooEducationCell.h"

@implementation WooEducationCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initWithUI];
    }
    return self;
}
- (void)initWithUI
{
    CGFloat width = (ScreenWidth - 30) / 2;
    self.imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, width, 80)];
    self.imageView1.contentMode=UIViewContentModeScaleAspectFill;
    self.imageView1.clipsToBounds=YES;
//    self.imageView1.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.imageView1];
    
    self.label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.imageView1.frame), width, 25)];
    self.label1.textAlignment = NSTextAlignmentLeft;
    self.label1.font = UIFont(15);
    [self.contentView addSubview:self.label1];
    
    self.label2 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.label1.frame), width, 25)];
    self.label2.textAlignment = NSTextAlignmentLeft;
    self.label2.font = UIFont(12);
    self.label2.textColor = RGB(102, 102, 102);
    [self.contentView addSubview:self.label2];
}

- (void)setModel:(WooHEducateModel *)model
{
    _model = model;
    [self.imageView1 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", model.eImg]] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        ZKLog(@"错误信息:%@",error);
    }];
    self.label1.text = [NSString stringWithFormat:@"%@", model.eTitle];
    self.label2.text = [NSString stringWithFormat:@"%@", model.eSyIntro];
    float width = [self heightForString:self.label1.text fontSize:14 andWidth:0];
    ZKLog(@"width -- %.f", width);
    self.imageView2.hidden = YES;
    self.imageView2 = [[UIImageView alloc]init];

    if (width < ((ScreenWidth - 30) / 2 + 20)) {
        self.imageView2.frame = CGRectMake(width + 10, CGRectGetMaxY(self.imageView1.frame) + 2, 20, 20);
    } else {
        self.imageView2.frame = CGRectMake((ScreenWidth - 30) / 2 - 20, CGRectGetMaxY(self.imageView1.frame) + 2, 20, 20);
    }
    self.imageView2.hidden = YES;
    self.imageView2.image = [UIImage imageNamed:@"fire_Image"];
    [self.contentView addSubview:self.imageView2];
    
    ZKLog(@"flame -- %@", model.eFlame);
    if ([model.eFlame intValue] == 1) {
        self.imageView2.hidden = NO;
    }
}

- (float)heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width
{
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]};
    CGSize size = [value boundingRectWithSize:CGSizeMake(360, MAXFLOAT) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    return size.width;
}


@end
