//
//  FootCollectionReusableView.m
//  Woo
//
//  Created by 王起锋 on 2018/10/8.
//  Copyright © 2018年 杭州蜂布式. All rights reserved.
//

#import "FootCollectionReusableView.h"

@implementation FootCollectionReusableView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self==[super initWithFrame:frame]) {
        [self setview];
    }
    return self;
}
-(void)setview
{
    UIImageView *tipsiamge=[[UIImageView alloc] initWithFrame:CGRectMake(10*KWidth_Scale, 5, 30, 25)];
    tipsiamge.image=[UIImage imageNamed:@"fire_Image"];
    UIView *backvew=[[UIView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 35)];
    backvew.layer.borderWidth=1.0;
    backvew.layer.borderColor=WordsofcolorColor.CGColor;
    [backvew addSubview:tipsiamge];
    backvew.backgroundColor=[UIColor clearColor];
    self.tiptitle=[PublicFunction getlabelwithtexttitle:nil fram:CGRectMake(10*KWidth_Scale+35,5,SCREEN_WIDTH-30,25) cornerRadius:0 textcolor:RGB(53,53,53) textfont:[UIFont systemFontOfSize:11] backcolor:[UIColor clearColor] textAlignment:NSTextAlignmentLeft];
    self.tiptitle.text=@"我是通知";
    [self.tiptitle setFont:[UIFont systemFontOfSize:12]];
    [backvew addSubview:self.tiptitle];
    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(scroll) userInfo:nil repeats:YES];
    [self addSubview:backvew];
}
-(void)scroll{
    _index += 1;
    if (_index == self.datarr.count) {
        _index = 0;
    }
    CATransition *tran = [CATransition animation];
    tran.type = kCATransitionPush;
    tran.subtype = kCATransitionFromTop;
    
    CATransition * transition =[CATransition animation];
    [transition setDuration:0.4f];
    transition.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    transition.type = @"cube";
    transition.subtype =kCATransitionFromTop ;
    [self.tiptitle.layer addAnimation:transition forKey:nil];
    NSInteger idx = _index;
    self.tiptitle.text=@"我是第二个通知";
    [self.tiptitle setFont:[UIFont systemFontOfSize:12]];
    ;
}
@end
