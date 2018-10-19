//
//  GameHeadview.m
//  Woo
//
//  Created by 王起锋 on 2018/8/28.
//  Copyright © 2018年 杭州蜂布式. All rights reserved.
//

#import "GameHeadview.h"
@interface GameHeadview ()
{
    dispatch_source_t countdowntimer;
}
@end
@implementation GameHeadview
-(UIImageView *)backImage
{
    if (_backImage==nil) {
        _backImage=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 300*KWidth_Scale)];
        _backImage.image=[UIImage imageNamed:@"playback"];
        _backImage.userInteractionEnabled=YES;
    }
    return _backImage;
}
-(UILabel *)allegenumber
{
    if (_allegenumber==nil) {
        _allegenumber=[[UILabel alloc] initWithFrame:CGRectMake(0, StatusBarAndNavigationBarHeight+35*KWidth_Scale, SCREEN_WIDTH, 25*KWidth_Scale)];
        _allegenumber.textColor=RGB(255, 255, 0);
        _allegenumber.font=UIFont(25);
        _allegenumber.text=@"2000000";
        _allegenumber.textAlignment=NSTextAlignmentCenter;
    }
    return _allegenumber;
}
-(UILabel *)CurrentPrice
{
    if (_CurrentPrice==nil) {
        _CurrentPrice=[[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.allegenumber.frame)+10*KWidth_Scale, SCREEN_WIDTH, 25*KWidth_Scale)];
        _CurrentPrice.textColor=[UIColor whiteColor];
        _CurrentPrice.font=UIFont(18);
        _CurrentPrice.text=@"当前价格:";
        _CurrentPrice.textAlignment=NSTextAlignmentCenter;
    }
    return _CurrentPrice;
}
-(UILabel *)CountdownLabel
{
    if (_CountdownLabel==nil) {
        _CountdownLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.CurrentPrice.frame)+10*KWidth_Scale+5*KWidth_Scale, SCREEN_WIDTH, 25*KWidth_Scale)];
        _CountdownLabel.textColor=RGB(38, 253, 250);
        _CountdownLabel.font=UIFont(25);
        _CountdownLabel.text=@"01:20:53";
        _CountdownLabel.textAlignment=NSTextAlignmentCenter;
    }
    return _CountdownLabel;
}
-(UIButton *)PlayGamebutton
{
    if (_PlayGamebutton==nil) {
        _PlayGamebutton=[UIButton buttonWithType:UIButtonTypeCustom];
        _PlayGamebutton.frame=CGRectMake((SCREEN_WIDTH-159*KWidth_Scale)/2.0, CGRectGetMaxY(self.CountdownLabel.frame)+20*KWidth_Scale, 159*KWidth_Scale, 54*KWidth_Scale);
        [_PlayGamebutton setBackgroundImage:[UIImage imageNamed:@"playbtn"] forState:UIControlStateNormal];
        [_PlayGamebutton setTitle:@"玩彩蛋" forState:UIControlStateNormal];
        [_PlayGamebutton.titleLabel setFont:UIFont(18)];
        [_PlayGamebutton setTitleColor:RGB(38, 253, 250) forState:UIControlStateNormal];
        [_PlayGamebutton addTarget:self action:@selector(playBegin:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _PlayGamebutton;
}
-(void)playBegin:(UIButton *)btn
{
    if (self.myblock) {
        self.myblock(123456);
    }
}
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self==[super initWithFrame:frame]) {
        [self setUI];
    }
    return self;
}
-(void)setUI
{
    UILabel* title=[[UILabel alloc] initWithFrame:CGRectMake(0, StatusBarAndNavigationBarHeight+0*KWidth_Scale, SCREEN_WIDTH, 25*KWidth_Scale)];
    title.textColor=[UIColor whiteColor];
    title.textAlignment=NSTextAlignmentCenter;
    title.font=UIFont(20);
    title.text=@"奖池总数";
    title.textAlignment=NSTextAlignmentCenter;
    [self addSubview:self.backImage];
    [self.backImage addSubview:title];
    [self.backImage addSubview:self.allegenumber];
    [self.backImage addSubview:self.CurrentPrice];
    [self.backImage addSubview:self.CountdownLabel];
    [self.backImage addSubview:self.PlayGamebutton];
}
//倒计时操作
- (void)counterDownTime
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //每秒执行
    countdowntimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(countdowntimer, dispatch_walltime(nil, 0), 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(countdowntimer, ^{
        if (_timeout<= 0) {
            dispatch_source_cancel(countdowntimer);
            dispatch_async(dispatch_get_main_queue(), ^{
            self.CountdownLabel.text=[self getMMSSFromSS:[NSString stringWithFormat:@"%d",_timeout]];
                self.PlayGamebutton.userInteractionEnabled=NO;
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
            self.PlayGamebutton.userInteractionEnabled=YES;
                self.CountdownLabel.text=[self getMMSSFromSS:[NSString stringWithFormat:@"%d",_timeout]];
            });
            _timeout--;
        }
    });
    dispatch_resume(countdowntimer);
}
-(NSString *)getMMSSFromSS:(NSString *)totalTime{
    NSInteger seconds = [totalTime integerValue];
    //format of hour
    NSString *str_hour = [NSString stringWithFormat:@"%02ld",seconds/3600];
    //format of minute
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(seconds%3600)/60];
    //format of second
    NSString *str_second = [NSString stringWithFormat:@"%02ld",seconds%60];
    //format of time
    
    NSString *format_time = [NSString stringWithFormat:@"%@:%@:%@",str_hour,str_minute,str_second];
    return format_time;
}
-(void)setModeldic:(NSDictionary *)modeldic
{
  _timeout =  (int)[self getCountDownStringWithEndTime:modeldic[@"gameStopTime"]];
    if (_timeout<0) {
        self.PlayGamebutton.userInteractionEnabled=NO;
    }
    [self counterDownTime];
    self.allegenumber.text=[NSString stringWithFormat:@"%@",modeldic[@"bonusCount"]];
    
    
     NSString *price =[NSString stringWithFormat:@"当前价格:%@",modeldic[@"nowPrice"]];
    // 1.创建NSMutableAttributedString实例
    NSMutableAttributedString *fontAttributeNameStr = [[NSMutableAttributedString alloc]initWithString:price];
    
    // 2.添加属性
    [fontAttributeNameStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:NSMakeRange(0, 5)];
    [fontAttributeNameStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Courier-BoldOblique" size:25] range:NSMakeRange(5, price.length - 5)];
    [fontAttributeNameStr addAttribute:NSForegroundColorAttributeName value:NaviBackgroundColor range:NSMakeRange(5, price.length - 5)];
    self.CurrentPrice.attributedText=fontAttributeNameStr;
    self.CurrentPrice.textAlignment=NSTextAlignmentCenter;
}
//计算当前时间与订单生成时间的时间差，转化成分钟
/**
 *  计算剩余时间
 *
 *  @param endTime   结束日期
 *
 *  @return 剩余时间
 */
-(int)getCountDownStringWithEndTime:(NSString *)endTime {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *now = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];//设置时区
    NSInteger interval = [zone secondsFromGMTForDate: now];
    NSDate *localDate = [now  dateByAddingTimeInterval: interval];
    endTime = [NSString stringWithFormat:@"%@", endTime];
    NSDate *endDate = [dateFormatter dateFromString:endTime];
    NSInteger endInterval = [zone secondsFromGMTForDate: endDate];
    NSDate *end = [endDate dateByAddingTimeInterval: endInterval];
    NSUInteger voteCountTime = ([end timeIntervalSinceDate:localDate]);
    return (int)voteCountTime;
}

-(void)canldountdown
{
    if (countdowntimer) {
       dispatch_source_cancel(countdowntimer);
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
