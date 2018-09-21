//
//  SAVideoMaskView.h
//  SouthAsiaLottery
//
//  Created by 风外杏林香 on 2017/8/31.
//  Copyright © 2017年 风外杏林香. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ButtonClick) (UIButton *button);

@interface SAVideoMaskView : UIView
/**视频加载菊花**/
@property (nonatomic, strong)UIActivityIndicatorView *activityView;

/**全屏切换按钮**/
@property (nonatomic, strong)UIButton *fullScreenBtn;

/**播放/暂停按钮**/
@property (nonatomic, strong)UIButton *playBtn;

/**当前播放时间label**/
@property (nonatomic, strong)UILabel *currentTimeLabel;

/**视频slider**/
@property (nonatomic, strong)UISlider *videoSlider;

/**总播放时间label**/
@property (nonatomic, strong)UILabel *totalTimeLabel;

/**缓冲进度条**/
@property (nonatomic, strong)UIProgressView *progessView;

/**底部backgroundView**/
@property (nonatomic, strong)UIView *bottomBackgroundView;

/**顶部backgroundView**/
@property (nonatomic, strong)UIView *topBackgroundView;

/**返回button**/
@property (nonatomic, strong)UIButton *backBtn;

/**未播放时候放的图片**/
@property (nonatomic, strong)UIImageView *backgroundImageView;

/*分享按钮*/
@property (nonatomic, strong)UIButton *shareBtn;

/**
 init
 
 @param frame              smallFrame
 
 @param playBtnClick       播放暂停按钮block
 
 @param fullScreenBtnClick 视频播放右下角全屏和smallFrame切换
 
 return  maskView实例
 */
- (instancetype)initWithFrame:(CGRect)frame
                 playBtnClick: (void (^) (UIButton *playBtn))playBtnClick
           fullScreenBtnClick: (void (^) (UIButton *fullScreenBtn))fullScreenBtnClick
                 backBtnClick: (void (^) (UIButton *backBtn))backBtnClick;

@end
