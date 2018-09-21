
//
//  CustAlertview.m
//  Woo
//
//  Created by 王起锋 on 2018/8/14.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import "CustAlertview.h"
#define CUST_HEIGHT 45
#define selftag 899

@implementation CustAlertview
- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title detailstr:(NSString *)detailstr;
{
    if (self==[super initWithFrame:frame]) {
        mytitle=title;
        detaistr=detailstr;
        [self addSubview:self.botomo];
        [self.botomo addSubview:self.selftitleLable];
        [self.botomo addSubview:self.detaillabel];
        UIView *botoview=[[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.detaillabel.frame), SCREEN_WIDTH-100*KWidth_Scale, 60*KWidth_Scale)];
        [self.botomo addSubview:botoview];
        CGFloat with=(SCREEN_WIDTH-200*KWidth_Scale-10*KWidth_Scale)/2.0;
        for (int i=0; i<2; i++) {
            UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame=CGRectMake(50*KWidth_Scale+10*KWidth_Scale*i+i*with,15*KWidth_Scale , with, 30*KWidth_Scale);
            btn.titleLabel.font=UIFont(14);
            btn.tag=selftag+i;
            if (i==0) {
                btn.backgroundColor=[UIColor whiteColor];
                [btn setTitle:@"取消" forState:UIControlStateNormal];
                [btn setTitleColor:[PublicFunction colorWithHexString:@"666666"] forState:UIControlStateNormal];
            }
            else{
                btn.backgroundColor=NaviBackgroundColor;
                [btn setTitle:@"确定" forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                btn.layer.cornerRadius=4*KWidth_Scale;
                btn.clipsToBounds=YES;
            }
            [btn addTarget:self action:@selector(clickbtn:) forControlEvents:UIControlEventTouchUpInside];
            [botoview addSubview:btn];
        }
    }
    return self;
}
-(void)clickbtn:(UIButton *)sender
{
    if (sender.tag-selftag==0) {
        [self canleclick];
    }
    else{
        if (self.myblock) {
            [self canleclick];
            self.myblock();
        }
    }
}
-(void)canleclick
{
    [self removeFromSuperview];
}
-(UILabel *)selftitleLable
{
    if (_selftitleLable==nil) {
        _selftitleLable=[[UILabel alloc] initWithFrame:CGRectMake(15*KWidth_Scale, 0, SCREEN_WIDTH*0.4, 40*KWidth_Scale)];
        _selftitleLable.textColor=NaviBackgroundColor;
        _selftitleLable.font=UIFont(17);
        _selftitleLable.numberOfLines=0;
         _selftitleLable.numberOfLines=0;
        _selftitleLable.text=mytitle;
    }
    return _selftitleLable;
}
-(UIView *)botomo
{
    if (_botomo==nil) {
        CGFloat offy=[self getMyheight:detaistr];
        _botomo=[[UIView alloc] initWithFrame:CGRectMake(50*KWidth_Scale,CUST_HEIGHT, SCREEN_WIDTH-100*KWidth_Scale, offy+100*KWidth_Scale+10*KWidth_Scale)];
        _botomo.layer.cornerRadius=5*KWidth_Scale;
        _botomo.clipsToBounds=YES;
        _botomo.backgroundColor=[UIColor whiteColor];
        _botomo.center=self.center;
    }
    return _botomo;
}
-(UILabel *)detaillabel
{
    if (_detaillabel==nil) {
        _detaillabel=[[UILabel alloc] initWithFrame:CGRectMake(15*KWidth_Scale, CGRectGetMaxY(self.selftitleLable.frame), SCREEN_WIDTH-100*KWidth_Scale-30*KWidth_Scale,[self getMyheight:detaistr])];
        _detaillabel.numberOfLines=0;
        _detaillabel.textColor=WordsofcolorColor;
        _detaillabel.font=UIFont(15);
        _detaillabel.text=detaistr;
    }
    return _detaillabel;
}
-(CGFloat)getMyheight:(NSString *)detaillabel;
{
    CGSize pricelabelsize=[detaillabel boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-130*KWidth_Scale, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:UIFont(17) forKey:NSFontAttributeName] context:nil].size;
    return pricelabelsize.height;
}
-(void)shareviewShow
{
    [UIView animateWithDuration:0.2f animations:^{
        self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.3f];
    } completion:^(BOOL finished) {
        CGPoint center=self.botomo.center;
        CGPoint startCenter = self.botomo.center;
        startCenter.y-=CUST_HEIGHT;
        self.botomo.center=center;
        [UIView animateWithDuration:0.3f animations:^{
            self.botomo.center=startCenter;
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            [self removeFromSuperview];
            [window addSubview:self];
        } completion:^(BOOL finished) {
            
        }];
        
    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
