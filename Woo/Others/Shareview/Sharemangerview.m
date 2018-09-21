
//
//  Sharemangerview.m
//  Woo
//
//  Created by 王起锋 on 2018/8/6.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import "Sharemangerview.h"
#define TAG_U 76767
#define LXD_SCREEN_HEIGHT SCREEN_HEIGHT
@implementation Sharemangerview
-(instancetype)initWithFrame:(CGRect)frame withtype:(sharType)type
{
    if (self==[super initWithFrame:frame]) {
        self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:1.0f];
        [self creatview:type];
    }
    return self;
}

-(void)creatview:(sharType)type
{
    if (type==sharType_friend) {
        [self creatcustbtn];
    }
    else{
        [self cgreatshareview];
    }
    
    [self.botomoview addSubview:self.canlebtn];
}
-(void)cgreatshareview
{
    NSArray *titles=[[NSArray alloc] initWithObjects:@"QQ",@"空间",@"微信",@"朋友圈", nil];
    NSArray *imageicons=[[NSArray alloc] initWithObjects:@"qq_icon",@"kongjian",@"weixin_icon",@"pengyouquan", nil];
    CGFloat btnwith=SCREEN_WIDTH/imageicons.count;
    for (int i=0; i<titles.count; i++) {
        UIButton *newbtn=[self getbtnwithfram:CGRectMake(i*btnwith, 0, btnwith, 140) title:titles[i]];
        newbtn.tag=TAG_U+i;
        [newbtn setImage:[UIImage imageNamed:imageicons[i]] forState:UIControlStateNormal];
        [newbtn addTarget:self action:@selector(shreclick:) forControlEvents:UIControlEventTouchUpInside];
        [self.topview addSubview:newbtn];
    }
}
-(void)creatcustbtn
{
    NSArray *titles=[[NSArray alloc] initWithObjects:@"QQ好友",@"微信好友", nil];
    NSArray *imageicons=[[NSArray alloc] initWithObjects:@"qq_icon",@"weixin_icon", nil];
    CGFloat btnwith=SCREEN_WIDTH/2.0;
    for (int i=0; i<titles.count; i++) {
        UIButton *newbtn=[self getbtnwithfram:CGRectMake(i*btnwith, 0, btnwith, 140) title:titles[i]];
        newbtn.tag=TAG_U+i;
        [newbtn setImage:[UIImage imageNamed:imageicons[i]] forState:UIControlStateNormal];
        [newbtn addTarget:self action:@selector(shreclick:) forControlEvents:UIControlEventTouchUpInside];
        [self.topview addSubview:newbtn];
    }
}
-(UIButton *)getbtnwithfram:(CGRect)rect title:(NSString *)title
{
    CGFloat offleft=(rect.size.width-50)/2.0;
    CGFloat offtop=rect.size.height-50-30;
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor=[UIColor whiteColor];
    btn.frame=rect;
    [btn setImageEdgeInsets:UIEdgeInsetsMake(30, offleft, offtop, offleft)];
    UILabel *titlela=[[UILabel alloc] initWithFrame:CGRectMake(0, 80, rect.size.width, 30)];
    titlela.text=title;
    titlela.textColor=[PublicFunction colorWithHexString:@"666666"];
    [titlela setFont:UIFont(13)];
    titlela.textAlignment=NSTextAlignmentCenter;
    [btn addSubview:titlela];
    return btn;
}
-(void)shareviewShow
{
    [UIView animateWithDuration:0.2f animations:^{
        self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.3f];
    } completion:^(BOOL finished) {
        CGPoint center=self.botomoview.center;
        CGPoint startCenter = self.center;
        startCenter.y=+LXD_SCREEN_HEIGHT;
        self.botomoview.center=startCenter;
        [UIView animateWithDuration:0.3f animations:^{
            self.botomoview.center=center;
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            [window addSubview:self];
        } completion:^(BOOL finished) {
            
        }];
        
    }];
}
-(void)canleclick
{
    [self removeFromSuperview];
}
-(UIView *)botomoview
{
    CGFloat offy=0;
    if (iPhoneX) {
        offy=0;
    }
    if (_botomoview==nil) {
        _botomoview=[[UIView alloc] initWithFrame:CGRectMake(0,ScreenHeight-200-offy, SCREEN_WIDTH, 200+offy)];
        _botomoview.backgroundColor=RGB(238, 238, 238);
        [self addSubview:_botomoview];
    }
    return _botomoview;
}
-(UIButton *)canlebtn
{
    CGFloat offy=0;
    if (iPhoneX) {
        offy=0;
    }
    if (_canlebtn==nil) {
        _canlebtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _canlebtn.backgroundColor=[UIColor whiteColor];
        _canlebtn.frame=CGRectMake(0, 200-50-offy, SCREEN_WIDTH, 50);
        [_canlebtn setTitle:@"取消" forState:UIControlStateNormal];
        [_canlebtn setTitleColor:[PublicFunction colorWithHexString:@"666666"] forState:UIControlStateNormal];
        [_canlebtn.titleLabel setFont:DefleFuont];
        [_canlebtn addTarget:self action:@selector(canleclick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _canlebtn;
}
-(UIView *)topview
{
    if (_topview==nil) {
        _topview=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 140)];
        _topview.backgroundColor=[UIColor whiteColor];
        [self.botomoview addSubview:_topview];
    }
    return _topview;
}
-(void)shreclick:(UIButton *)sender
{
    if (self.myblock) {
        self.myblock(sender.tag-TAG_U);
    }
    ZKLog(@"分享的第几个%ld",sender.tag-TAG_U);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
