//
//  WooPhotoView.m
//  Woo
//
//  Created by 风外杏林香 on 2018/8/10.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import "WooPhotoView.h"

@interface WooPhotoView ()
@property (nonatomic, strong)UIView *backgroundView;
@end

@implementation WooPhotoView

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
    self.backgroundView = [[UIView alloc] init];
    self.backgroundView.backgroundColor = [UIColor blackColor];
    self.backgroundView.userInteractionEnabled = YES;
    self.backgroundView.alpha = 0.3;
    self.backgroundView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight - StatusBarAndNavigationBarHeight);
    [self addSubview:self.backgroundView];
    NSLog(@"height -- %.f", self.backgroundView.frame.size.height);
    UIButton *button1 = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button1.backgroundColor = [UIColor whiteColor];
    [button1 setTitle:@"拍照" forState:(UIControlStateNormal)];
    [button1 setTitleColor:RGB(51, 51, 51) forState:(UIControlStateNormal)];
    button1.titleLabel.font = UIFont(15);
    button1.tag = 1;
    [button1 addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    UIButton *button2 = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button2.backgroundColor = [UIColor whiteColor];
    [button2 setTitle:@"从相册选择" forState:(UIControlStateNormal)];
    [button2 setTitleColor:RGB(51, 51, 51) forState:(UIControlStateNormal)];
    button2.titleLabel.font = UIFont(15);
    button2.tag = 2;
    [button2 addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    UIButton *button3 = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button3.backgroundColor = [UIColor whiteColor];
    [button3 setTitle:@"取消" forState:(UIControlStateNormal)];
    [button3 setTitleColor:RGB(51, 51, 51) forState:(UIControlStateNormal)];
    button3.titleLabel.font = UIFont(15);
    button3.tag = 3;
    [button3 addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    button3.frame = CGRectMake(0, SCREEN_HEIGHT - 100 - TabbarHeight - 40, ScreenWidth, 40);
    [self addSubview:button3];
    
    
    UIView *line = [UIView new];
    line.backgroundColor = RGB(230, 231, 232);
    line.frame = CGRectMake(0, CGRectGetMinY(button3.frame) - 10, ScreenWidth, 10);
    [self addSubview:line];
    button2.frame = CGRectMake(0, CGRectGetMinY(line.frame) - 40, ScreenWidth, 40);
    [self addSubview:button2];
    button1.frame = CGRectMake(0, CGRectGetMinY(button2.frame) - 40.5, ScreenWidth, 40);
    [self addSubview:button1];
}

- (void)buttonAction:(UIButton *)sender
{
    if (sender.tag != 3) {
        _buttonAction(sender.tag);
    } else {
        [self removeFromSuperview];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
