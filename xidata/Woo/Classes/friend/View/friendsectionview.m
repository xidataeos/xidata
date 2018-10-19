//
//  friendsectionview.m
//  Woo
//
//  Created by 王起锋 on 2018/8/2.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import "friendsectionview.h"

@implementation friendsectionview
-(instancetype)initWithFrame:(CGRect)frame
{
    
    if (self==[super initWithFrame:frame]) {
        self.backgroundColor=[UIColor whiteColor];
        [self creatUI];
    }
    return self;
}
-(void)creatUI
{
    [self addSubview:self.titlelable];
    //[self addSubview:self.clickbtn];
}
-(UILabel*)titlelable
{
    if (_titlelable==nil) {
        _titlelable=[[UILabel alloc] initWithFrame:CGRectMake(15*KWidth_Scale,0,SCREEN_WIDTH*0.4, self.height)];
        _titlelable.textColor=RGB(102, 102, 102);
        _titlelable.font=DefleFuont;
    }
    return _titlelable;
}
-(UIButton *)clickbtn
{
    if (_clickbtn==nil) {
        _clickbtn =[UIButton buttonWithType:UIButtonTypeCustom];
        _clickbtn.frame=CGRectMake(SCREEN_WIDTH-self.height, 0, self.height, self.height);
        [_clickbtn setImage:[UIImage imageNamed:@"me_sel_Image"] forState:UIControlStateNormal];
        [_clickbtn setImageEdgeInsets:UIEdgeInsetsMake(15, 15, 15, 15)];
        [_clickbtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _clickbtn;
}
-(void)click:(UIButton *)sender
{
    if (self.myblock) {
        self.myblock();
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
