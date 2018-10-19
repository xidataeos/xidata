//
//  ReadPocketview.m
//  Woo
//
//  Created by 王起锋 on 2018/8/24.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import "ReadPocketview.h"
#define CUST_HEIGHT 45
@implementation ReadPocketview
-(UIImageView *)headimage
{
    if (_headimage==nil) {
        _headimage=[[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-60*KWidth_Scale-88*KWidth_Scale)/2.0, 50*KWidth_Scale, 88*KWidth_Scale, 88*KWidth_Scale)];
        _headimage.image=[UIImage imageNamed:@"photo_boy"];
    }
    return _headimage;
}
-(UILabel *)selftitleLable
{
    if (_selftitleLable==nil) {
        _selftitleLable=[[UILabel alloc] initWithFrame:CGRectMake(15*KWidth_Scale,CGRectGetMaxY(self.headimage.frame)+10*KWidth_Scale, SCREEN_WIDTH-60*KWidth_Scale-30*KWidth_Scale, 18*KWidth_Scale)];
        _selftitleLable.textColor=[PublicFunction colorWithHexString:@"#fbdeb0"];
        _selftitleLable.font=UIFont(12);
        _selftitleLable.numberOfLines=0;
        _selftitleLable.text=@"我是谁啊";
        _selftitleLable.textAlignment=NSTextAlignmentCenter;
    }
    return _selftitleLable;
}
-(UIView *)botomo
{
    if (_botomo==nil) {
        _botomo=[[UIImageView alloc] initWithFrame:CGRectMake(30*KWidth_Scale,StatusBarAndNavigationBarHeight+60*KWidth_Scale, SCREEN_WIDTH-60*KWidth_Scale, SCREEN_HEIGHT-StatusBarAndNavigationBarHeight-120*KWidth_Scale)];
        _botomo.image=[UIImage imageNamed:@"redpocketBack"];
        _botomo.contentMode=UIViewContentModeScaleAspectFill;
        _botomo.layer.cornerRadius=8.0;
        CGPoint redcenter=self.center;
        _botomo.clipsToBounds=YES;
        redcenter.y+=CUST_HEIGHT;
        _botomo.userInteractionEnabled=YES;
        _botomo.center=redcenter;
    }
    return _botomo;
}
-(UILabel *)detaillabel
{
    if (_detaillabel==nil) {
        _detaillabel=[[UILabel alloc] initWithFrame:CGRectMake(15*KWidth_Scale, CGRectGetMaxY(self.selftitleLable.frame)+5*KWidth_Scale, SCREEN_WIDTH-60*KWidth_Scale-30*KWidth_Scale,16)];
        _detaillabel.numberOfLines=0;
        _detaillabel.textColor=[PublicFunction colorWithHexString:@"#fbdeb0"];;
        _detaillabel.font=UIFont(12);
        _detaillabel.textAlignment=NSTextAlignmentCenter;
        _detaillabel.text=@"发来一个红包,金额随机";
    }
    return _detaillabel;
}
-(instancetype)initWithFrame:(CGRect)frame retype:(redmessagetype)retype withtips:(NSString *)tips target:(NSString *)target isgroup:(BOOL)isgroup
{
    if (self==[super initWithFrame:frame]) {
        if (retype==red_type_have) {
            [self cgreatUI];
        }
        else{
            [self cgreatno:tips];
        }
    }
    [self getFriendRelationship:target];
    return self;
}
-(void)cgreatno:(NSString *)tips
{
    [self addSubview:self.botomo];
    [self.botomo addSubview:self.headimage];
    [self.botomo addSubview:self.selftitleLable];
    self.botomo.image=[RCKitUtility imageNamed:@"pck_openBG" ofBundle:@"JResource.bundle"];
    UILabel *leavelabel=[[UILabel alloc] initWithFrame:CGRectMake(15*KWidth_Scale, CGRectGetMaxY(self.selftitleLable.frame)+20*KWidth_Scale, SCREEN_WIDTH-90*KWidth_Scale,25)];
    leavelabel.numberOfLines=0;
    leavelabel.textColor=[PublicFunction colorWithHexString:@"#fbdeb0"];
    leavelabel.font=UIFont(18);
    leavelabel.textAlignment=NSTextAlignmentCenter;
    leavelabel.text=tips;
    [self.botomo addSubview:leavelabel];
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(15*KWidth_Scale,SCREEN_HEIGHT-StatusBarAndNavigationBarHeight-120*KWidth_Scale-80, SCREEN_WIDTH-90*KWidth_Scale,50);
    [btn setTitle:@"看看大家的手气!" forState:UIControlStateNormal];
    [btn.titleLabel setFont:UIFont(15)];
    [btn setTitleColor:[PublicFunction colorWithHexString:@"#fbdeb0"] forState:UIControlStateNormal];
    [self.botomo addSubview:btn];
    [btn addTarget:self action:@selector(chectredmessage) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *closebtn=[UIButton buttonWithType:UIButtonTypeCustom];
    closebtn.frame=CGRectMake(0*KWidth_Scale,0*KWidth_Scale,45, 45);
    [closebtn setImage:[UIImage imageNamed:@"closered"] forState:UIControlStateNormal];
    [closebtn setImageEdgeInsets:UIEdgeInsetsMake(15, 15, 15, 15)];
    [self.botomo addSubview:closebtn];
    [closebtn addTarget:self action:@selector(canleclick) forControlEvents:UIControlEventTouchUpInside];
}
-(void)chectredmessage
{
    if (self.myblock) {
        [self canleclick];
        self.myblock();
    }
}
-(void)cgreatUI
{
    [self addSubview:self.botomo];
    [self.botomo addSubview:self.headimage];
    [self.botomo addSubview:self.selftitleLable];
    [self.botomo addSubview:self.detaillabel];
    UILabel *leavelabel=[[UILabel alloc] initWithFrame:CGRectMake(15*KWidth_Scale, CGRectGetMaxY(self.detaillabel.frame)+20*KWidth_Scale, SCREEN_WIDTH-90*KWidth_Scale,25)];
    leavelabel.numberOfLines=0;
    leavelabel.textColor=[PublicFunction colorWithHexString:@"#fbdeb0"];;
    leavelabel.font=UIFont(18);
    leavelabel.textAlignment=NSTextAlignmentCenter;
    leavelabel.text=@"恭喜发财,大吉大利";
    [self.botomo addSubview:leavelabel];
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0, SCREEN_HEIGHT*0.3, SCREEN_WIDTH, SCREEN_HEIGHT*0.5);
    [self addSubview:btn];
    [btn addTarget:self action:@selector(openred) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *closebtn=[UIButton buttonWithType:UIButtonTypeCustom];
    closebtn.frame=CGRectMake(0*KWidth_Scale,0*KWidth_Scale,45, 45);
    [closebtn setImage:[UIImage imageNamed:@"closered"] forState:UIControlStateNormal];
    [closebtn setImageEdgeInsets:UIEdgeInsetsMake(15, 15, 15, 15)];
    [self.botomo addSubview:closebtn];
    [closebtn addTarget:self action:@selector(canleclick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)transform3D
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    // 结束值
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DRotate( self.xuanzhuanimage.layer.transform, M_PI, 0, 10, 0)];
    // 设置时间
    animation.duration = 1;
    animation.repeatCount=HUGE_VALF;
    [ self.xuanzhuanimage.layer addAnimation:animation forKey:@"transform"];
}

-(void)openred
{
    [self.botomo addSubview:self.xuanzhuanimage];
    self.botomo.image=[RCKitUtility imageNamed:@"pck_openBG" ofBundle:@"JResource.bundle"];
    self.xuanzhuanimage.image=[UIImage imageNamed:@"redopen"];
   // [self transform3D];
    if (self.myblock) {
        self.myblock();
    }
}
-(UIImageView *)xuanzhuanimage
{
    if (_xuanzhuanimage==nil) {
        _xuanzhuanimage=[[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-150-60*KWidth_Scale)/2.0,SCREEN_WIDTH*0.6, 120*KWidth_Scale, 120*KWidth_Scale)];
    }
    return _xuanzhuanimage;
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
            [window addSubview:self];
        } completion:^(BOOL finished) {
            
        }];
        
    }];
}
-(void)getFriendRelationship:(NSString *)fid
{
    //[self showhudmessage:@"群成员加载中..." offy:-100];
    NSMutableDictionary *parametDic = [NSMutableDictionary dictionaryWithCapacity:9];
    [parametDic setObject:RCLOUD_ID forKey:@"mid"];
    [parametDic setObject:fid forKey:@"fid"];
    [UserRequestToo shareInstance].rquesturl=getfriendRelationshipRequrl;
    [UserRequestToo shareInstance].params=parametDic;
    [[UserRequestToo shareInstance] statrrequestgetwith:MHAsiNetWorkGET successBlock:^(id returnData) {
        if (returnData[@"success"]) {
            if([returnData[@"status"] isEqualToString:@"200"])
            {
                NSDictionary *dic=returnData[@"data"];
                [self.headimage sd_setImageWithURL:[NSURL URLWithString:dic[@"photo"]] placeholderImage:[UIImage imageNamed:@"photo_boy"]];
                if ([PublicFunction isEmpty:dic[@"nickname"]]) {
                    self.selftitleLable.text=dic[@"name"];
                }
                else{
                    self.selftitleLable.text=dic[@"nickname"];
                }
            }
        }
    } failureBlock:^(NSError *error) {
    }];
}
-(void)canleclick
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
