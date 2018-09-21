

//
//  Showerwimaview.m
//  Woo
//
//  Created by 王起锋 on 2018/8/8.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import "Showerwimaview.h"
#import "HCCreateQRCode.h"
#define TOP_H 150
@interface Showerwimaview ()
@property(nonatomic,strong)UIView *cellline;
@end
@implementation Showerwimaview
-(instancetype)initWithFrame:(CGRect)frame groupInfo:(RCDGroupInfo *)groupInfo
{
    if (self==[super initWithFrame:frame]) {
        self.groupinfo=groupInfo;
        [self creatUI];
    }
    return self;
}
-(void)creatUI
{
    [self addSubview:self.bottomview];
    [self.bottomview addSubview:self.userimageview];
    [self.bottomview addSubview:self.namelabel];
    [self.bottomview addSubview:self.erweimaimageview];
    UILabel *tips=[PublicFunction getlabelwithtexttitle:@"扫描二维码即可快速进群哦" fram:CGRectMake(0, CGRectGetMaxY(self.erweimaimageview.frame)+20*KWidth_Scale, SCREEN_WIDTH-30*KWidth_Scale, 15*KWidth_Scale) cornerRadius:0 textcolor:RGB(102, 102, 102) textfont:DefleFuont backcolor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter];
    [self.bottomview addSubview:tips];
    [self.bottomview addSubview:self.canlBtn];
    
}
-(UIButton *)canlBtn
{
    if (_canlBtn==nil) {
        _canlBtn=[PublicFunction getbtnwithtexttitle:@"取消" fram:CGRectMake(0,ScreenHeight-StatusBarAndNavigationBarHeight-TabbarHeight-60*KWidth_Scale, SCREEN_WIDTH-30*KWidth_Scale, 60*KWidth_Scale) cornerRadius:0 textcolor:WordsofcolorColor textfont:DefleFuont backcolor:[UIColor whiteColor]];
        [_canlBtn addTarget:self action:@selector(canlclick:) forControlEvents:UIControlEventTouchUpInside];
        [_canlBtn addSubview:self.cellline];
    }
    return _canlBtn;
}
-(UIView *)cellline
{
    if (_cellline==nil) {
        _cellline=[[UIView alloc] initWithFrame:CGRectMake(0,0,SCREEN_WIDTH-30*KWidth_Scale,1.0)];
        _cellline.backgroundColor=CellBackgroundColor;
    }
    return _cellline;
}
-(UIView *)bottomview
{
    if (_bottomview==nil) {
        _bottomview=[[UIView alloc] initWithFrame:CGRectMake(15*KWidth_Scale, StatusBarAndNavigationBarHeight+TOP_H, SCREEN_WIDTH-30*KWidth_Scale, ScreenHeight-StatusBarAndNavigationBarHeight-TabbarHeight)];
        _bottomview.layer.cornerRadius=5;
        _bottomview.clipsToBounds=YES;
        _bottomview.backgroundColor=[UIColor whiteColor];
    }
    return _bottomview;
}
-(UIImageView *)userimageview
{
    if (_userimageview==nil) {
        _userimageview=[[UIImageView alloc] initWithFrame:CGRectMake(15*KWidth_Scale, 20*KWidth_Scale, 80*KWidth_Scale, 80*KWidth_Scale)];
        _userimageview.backgroundColor=[UIColor lightGrayColor];
        _userimageview.layer.cornerRadius=40*KWidth_Scale;
        [_userimageview sd_setImageWithURL:[NSURL URLWithString:self.groupinfo.groupId] placeholderImage:[UIImage imageNamed:@"photo_boy"]];
    _userimageview.contentMode=UIViewContentModeScaleAspectFill;
        _userimageview.clipsToBounds=YES;
    }
    return _userimageview;
}
-(UILabel *)namelabel
{
    if (_namelabel==nil) {
        _namelabel=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.userimageview.frame)+10*KWidth_Scale, 40*KWidth_Scale, SCREEN_WIDTH*0.6, 40*KWidth_Scale)];
        _namelabel.textColor=WordsofcolorColor;
        _namelabel.font=UIFont(18);
        _namelabel.text=self.groupinfo.groupName;
    }
    return _namelabel;
}
-(UIImageView *)erweimaimageview
{
    if (_erweimaimageview==nil) {
        _erweimaimageview=[[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-30*KWidth_Scale-260*KWidth_Scale)/2.0, CGRectGetMaxY(self.userimageview.frame)+25*KWidth_Scale, 260*KWidth_Scale, 260*KWidth_Scale)];
       _erweimaimageview.image =[UIImage qrImageWithContent:[NSString stringWithFormat:@"wowo,1,%@",self.groupinfo.groupId] logo:[UIImage imageNamed:@"pgoto_girl"] size:260*KWidth_Scale red:20 green:100 blue:100];
    }
    return _erweimaimageview;
}
-(void)customeviewShow
{
    [UIView animateWithDuration:0.3f animations:^{
        self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.3f];
        CGPoint center=self.bottomview.center;
        self.bottomview.center=center;
    } completion:^(BOOL finished) {
        CGPoint startcenter=self.bottomview.center;
        startcenter.y-=TOP_H;
        [UIView animateWithDuration:0.2 animations:^{
            self.bottomview.center=startcenter;
        } completion:^(BOOL finished) {
            
        }];
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window addSubview:self];
    }];
}

-(void)canlclick:(UIButton *)sender
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
