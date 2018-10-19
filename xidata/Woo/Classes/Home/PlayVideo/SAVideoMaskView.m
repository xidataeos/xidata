//
//  SAVideoMaskView.m
//  SouthAsiaLottery
//
//  Created by 风外杏林香 on 2017/8/31.
//  Copyright © 2017年 风外杏林香. All rights reserved.
//

#import "SAVideoMaskView.h"
//#import "SAHeader.h"
@interface SAVideoMaskView ()
@property (nonatomic, copy) ButtonClick playBtnClick;
@property (nonatomic, copy) ButtonClick fullScreenBtnClick;
@property (nonatomic, copy) ButtonClick backClick;
@end

@implementation SAVideoMaskView
- (instancetype)initWithFrame:(CGRect)frame
                 playBtnClick: (void (^) (UIButton *playBtn))playBtnClick
           fullScreenBtnClick: (void (^) (UIButton *fullScreenBtn))fullScreenBtnClick
                 backBtnClick: (void (^) (UIButton *backBtn))backBtnClick {
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        self.userInteractionEnabled = YES;
        self.playBtnClick = playBtnClick;
        self.fullScreenBtnClick = fullScreenBtnClick;
        self.backClick = backBtnClick;
        
        UITapGestureRecognizer *hidenTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenBottonView:)];
        [self addGestureRecognizer:hidenTap];
    }
    
    return self;
}

- (void)hiddenBottonView: (UITapGestureRecognizer *)tap {
    
    if (self.bottomBackgroundView.hidden || self.topBackgroundView.hidden) {
        self.bottomBackgroundView.hidden = NO;
        self.topBackgroundView.hidden = NO;
    } else {
        self.bottomBackgroundView.hidden = YES;
        self.topBackgroundView.hidden = YES;
    }
}

- (void)drawRect:(CGRect)rect {
    
    [super drawRect:rect];
    
    [self createViews];
}

-(void)createViews {
    
    self.playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.playBtn addTarget:self action:@selector(playBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.playBtn setImage:[UIImage imageNamed:@"play_Image"] forState:UIControlStateNormal];
    [self.playBtn setImage:[UIImage imageNamed:@"pause_Image"] forState:UIControlStateSelected];
    
    self.activityView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [self addSubview:self.activityView];
    
    self.backgroundImageView = [[UIImageView alloc]init];
    self.backgroundImageView.image = [UIImage imageNamed:@"backgroundView"];
    [self addSubview:self.backgroundImageView];
    
    self.bottomBackgroundView = [[UIView alloc] init];
    self.bottomBackgroundView.backgroundColor = [UIColor blackColor];
    self.bottomBackgroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    [self addSubview:self.bottomBackgroundView];
    [self.bottomBackgroundView addSubview:self.playBtn];
    
    self.backBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.backBtn setImage:[UIImage imageNamed:@"playBack_Image"] forState:(UIControlStateNormal)];
    [self.backBtn addTarget:self action:@selector(backClick:) forControlEvents:(UIControlEventTouchUpInside)];
    self.topBackgroundView = [[UIView alloc]init];
    self.topBackgroundView.backgroundColor = [UIColor blackColor];
    self.topBackgroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    [self addSubview:self.topBackgroundView];
    self.backBtn.tag = 2;
    [self.topBackgroundView addSubview:self.backBtn];
    
    self.shareBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.shareBtn setImage:[UIImage imageNamed:@"fenxiang"] forState:(UIControlStateNormal)];
    [self.shareBtn addTarget:self action:@selector(backClick:) forControlEvents:(UIControlEventTouchUpInside)];
    self.shareBtn.tag = 110;
    [self.topBackgroundView addSubview:self.shareBtn];
    
    self.currentTimeLabel = [[UILabel alloc]init];
    self.currentTimeLabel.font = [UIFont systemFontOfSize:11];
    self.currentTimeLabel.textColor = [UIColor whiteColor];
    self.currentTimeLabel.text = @"00:00";
    self.currentTimeLabel.textAlignment = NSTextAlignmentCenter;
    [self.bottomBackgroundView addSubview:self.currentTimeLabel];
    
    self.totalTimeLabel = [[UILabel alloc]init];
    self.totalTimeLabel.font = [UIFont systemFontOfSize:11];
    self.totalTimeLabel.textColor = [UIColor whiteColor];
    self.totalTimeLabel.text = @"00:00";
    self.totalTimeLabel.textAlignment = NSTextAlignmentCenter;
    [self.bottomBackgroundView addSubview:self.totalTimeLabel];
    
    self.fullScreenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.fullScreenBtn addTarget:self action:@selector(fullScreenBtnCLick:) forControlEvents:UIControlEventTouchUpInside];
    [self.fullScreenBtn setImage:[UIImage imageNamed:@"max_Image"] forState:UIControlStateNormal];
    [self.fullScreenBtn setImage:[UIImage imageNamed:@"min_Image"] forState:UIControlStateSelected];
    self.fullScreenBtn.tag = 1;
    [self.bottomBackgroundView addSubview:self.fullScreenBtn];
    
    self.videoSlider = [[UISlider alloc]init];
    [self.videoSlider setThumbImage:[UIImage imageNamed:@"slider_Image"] forState:UIControlStateNormal];
    self.videoSlider.minimumTrackTintColor = [UIColor whiteColor];
    self.videoSlider.maximumTrackTintColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1];
    
    [self.bottomBackgroundView addSubview:self.videoSlider];
    
    self.progessView = [[UIProgressView alloc]init];
    self.progessView.progressTintColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.6];
    self.progessView.trackTintColor = [UIColor clearColor];
    
    [self.bottomBackgroundView addSubview:self.progessView];
}

//playBtnClick
- (void)playBtnClick: (UIButton *)button {
    
    if (self.playBtnClick != nil) {
        self.playBtnClick(button);
    }
}

- (void)fullScreenBtnCLick: (UIButton *)button {
    
    if (self.fullScreenBtnClick != nil) {
        self.fullScreenBtnClick (button);
    }
}

-(void)backClick:(UIButton *)button
{
    if (self.backClick != nil) {
        self.backClick(button);
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat width = self.frame.size.width;
    CGFloat heihgt = self.frame.size.height;
    
    self.playBtn.frame = CGRectMake(0, 0, 25, 25);
    CGPoint center = CGPointMake(width / 2, heihgt / 2);
    self.activityView.center = center;
    self.bottomBackgroundView.frame = CGRectMake(0, heihgt - 25, width, 25);
    self.backgroundImageView.frame = CGRectMake(0, 0, width, heihgt);
    self.backgroundImageView.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    
    self.topBackgroundView.frame = CGRectMake(0, 0, width, 25);
    self.backBtn.frame = CGRectMake(0, 0, 25, 25);
    self.currentTimeLabel.frame = CGRectMake(CGRectGetMaxX(self.playBtn.frame), 0, 60, self.bottomBackgroundView.frame.size.height);
    self.fullScreenBtn.frame = CGRectMake(width - 25, 0, 25, self.bottomBackgroundView.frame.size.height);
    self.totalTimeLabel.frame = CGRectMake(self.frame.size.width - 85, 0, 60, self.bottomBackgroundView.frame.size.height);
    self.shareBtn.frame = CGRectMake(width - 25, 0, 25, 25);
    
    CGFloat sliderWidth = width - (170);// label * 2 + button * 2
    self.videoSlider.frame = CGRectMake(CGRectGetMaxX(self.currentTimeLabel.frame), 0, sliderWidth, self.bottomBackgroundView.frame.size.height);
    self.progessView.frame = CGRectMake(CGRectGetMaxX(self.currentTimeLabel.frame), 24, sliderWidth, self.bottomBackgroundView.frame.size.height + 3);
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
