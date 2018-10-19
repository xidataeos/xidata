
//
//  cusetselectview.m
//  Woo
//
//  Created by 王起锋 on 2018/10/8.
//  Copyright © 2018年 杭州蜂布式. All rights reserved.
//

#import "cusetselectview.h"
#define selecttag_mybtn 832
@implementation cusetselectview
-(instancetype)initWithFrame:(CGRect)frame withdata:(NSMutableArray *)data
{
    if (self==[super initWithFrame:frame]) {
         selecteddata=[[NSMutableArray alloc] init];
        [self creatUI:data];
    }
    return self;
}
-(void)creatUI:(NSMutableArray *)messagedata
{
    NSInteger count=messagedata.count;
    CGFloat paing=15;
    CGFloat midpaing=10;
     CGFloat width=(SCREEN_WIDTH*0.75-paing*2-midpaing*(count-1))/count+5;
    for (int i=0; i<messagedata.count; i++) {
        UIButton *selfbtn=[self getselectbtn:CGRectMake(paing+i*(width+midpaing),5, width, 24) title:messagedata[i]];
        selfbtn.tag=selecttag_mybtn+i;
        selfbtn.layer.borderColor=RGB(153, 153, 153).CGColor;
        if (i==0) {
            
            [self selectedbtn:selfbtn selected:YES];
        }
        [selecteddata addObject:selfbtn];
        [selfbtn addTarget:self action:@selector(selected:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:selfbtn];
    }
    
}
-(void)selected:(UIButton *)sender
{
    self.myselectindex=sender.tag-selecttag_mybtn;
    for (int i=0; i<selecteddata.count; i++) {
        UIButton *btn=selecteddata[i];
        if (self.myselectindex==i) {
            [self selectedbtn:btn selected:YES];
            if (self.myblock) {
                self.myblock(self.myselectindex);
            }
        }
        else{
            [self selectedbtn:btn selected:NO];
        }
    }
}
-(UIButton *)getselectbtn:(CGRect)frame title:(NSString *)title
{
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=frame;
    btn.backgroundColor=[UIColor clearColor];
    [btn setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
    btn.titleLabel.lineBreakMode = 0;
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font=[UIFont systemFontOfSize:13];
    return btn;
}
-(void)selectedbtn:(UIButton *)btn selected:(BOOL)selected
{
    if (selected) {
        btn.layer.cornerRadius=12;
        btn.clipsToBounds=YES;
        btn.layer.borderWidth=1.0;
        btn.layer.borderColor=NaviBackgroundColor.CGColor;
        [btn setTitleColor:NaviBackgroundColor forState:UIControlStateNormal];
    }
    else{
        btn.layer.cornerRadius=0;
        btn.clipsToBounds=YES;
        btn.layer.borderWidth=0;
        btn.layer.borderColor=[UIColor clearColor].CGColor;
        [btn setTitleColor:[PublicFunction colorWithHexString:@"#333333"] forState:UIControlStateNormal];
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
