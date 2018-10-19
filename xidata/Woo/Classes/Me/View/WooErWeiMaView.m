//
//  WooErWeiMaView.m
//  Woo
//
//  Created by 风外杏林香 on 2018/8/9.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import "WooErWeiMaView.h"

@interface WooErWeiMaView ()
@property (nonatomic, strong)UIView *backgroundView;
@property (nonatomic, strong)UIView *whiteView;

@end

@implementation WooErWeiMaView

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
    UIImage *im=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[UserDefaults objectForKey:@"photo"]]]];
    self.backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    self.backgroundView.backgroundColor = [UIColor blackColor];
    self.backgroundView.alpha = 0.3;
    [self addSubview:self.backgroundView];
    
    self.whiteView = [[UIView alloc]initWithFrame:CGRectMake(30, 30, ScreenWidth - 60, ScreenHeight - 250)];
    self.whiteView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.whiteView];
    
    self.imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(10, 20, ScreenWidth - 80, CGRectGetHeight(self.whiteView.frame) - 60 - 30 - 40)];

   self.imageView1.image = [UIImage qrImageWithContent:[NSString stringWithFormat:@"wowo,0,%@",RCLOUD_ID] logo:im size:260*KWidth_Scale red:20 green:100 blue:100];

    [self.whiteView addSubview:self.imageView1];
    
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button.frame = CGRectMake(0, CGRectGetHeight(self.whiteView.frame) - 60, CGRectGetWidth(self.whiteView.frame), 60);
//    button.backgroundColor = [UIColor redColor];
    [button setTitle:@"取消" forState:(UIControlStateNormal)];
    button.titleLabel.font = UIFont(18);
    [button setTitleColor:UIColorFromRGB(0xff6400) forState:(UIControlStateNormal)];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.whiteView addSubview:button];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMinY(button.frame), CGRectGetWidth(button.frame), 0.5)];
    lineView.backgroundColor = RGB(230, 231, 232);
    [self.whiteView addSubview:lineView];
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMinY(lineView.frame) - 40, CGRectGetWidth(button.frame), 30)];
    label1.text = @"扫描识别二维码可以加我好友哦";
    label1.font = UIFont(15);
    label1.textColor = RGB(102, 102, 102);
    label1.textAlignment = NSTextAlignmentCenter;
    [self.whiteView addSubview:label1];
}

- (void)buttonAction:(UIButton *)sender
{
    [self removeFromSuperview];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
