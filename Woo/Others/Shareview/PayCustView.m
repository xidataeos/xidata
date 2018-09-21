

//
//  PayCustView.m
//  Woo
//
//  Created by 王起锋 on 2018/8/27.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import "PayCustView.h"
#define CUST_HEIGHT 45
#define selftag 899
@implementation PayCustView
- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title detailstr:(NSString *)detailstr;
{
    if (self==[super initWithFrame:frame]) {
        mytitle=title;
        detaistr=detailstr;
        [self addSubview:self.botomo];
        [self.botomo addSubview:self.selftitleLable];
        [self.botomo addSubview:self.passtextfield];
        UIView *cellview=[[UIView alloc] initWithFrame:CGRectMake(25*KWidth_Scale, CGRectGetMaxY(self.passtextfield.frame), SCREEN_WIDTH-100*KWidth_Scale, 0.7*KWidth_Scale)];
        cellview.backgroundColor=CellBackgroundColor;
        [self.botomo addSubview:cellview];
        
        UIView *botoview=[[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(cellview.frame), SCREEN_WIDTH-100*KWidth_Scale, 60*KWidth_Scale)];
        [self.botomo addSubview:botoview];
        
        CGFloat with=80*KWidth_Scale;
        CGFloat paing=(SCREEN_WIDTH-160*KWidth_Scale-50*KWidth_Scale-15*KWidth_Scale)/2.0;
        for (int i=0; i<2; i++) {
            UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame=CGRectMake(paing+15*KWidth_Scale*i+i*with,15*KWidth_Scale , with, 30*KWidth_Scale);
            btn.titleLabel.font=UIFont(14);
            btn.tag=selftag+i;
            if (i==0) {
                btn.backgroundColor=NaviBackgroundColor;
                [btn setTitle:@"确定" forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                btn.layer.cornerRadius=4*KWidth_Scale;
                btn.clipsToBounds=YES;
            }
            else{
                btn.backgroundColor=[UIColor whiteColor];
                [btn setTitle:@"取消" forState:UIControlStateNormal];
                [btn setTitleColor:[PublicFunction colorWithHexString:@"666666"] forState:UIControlStateNormal];
            }
            [btn addTarget:self action:@selector(clickbtn:) forControlEvents:UIControlEventTouchUpInside];
            [botoview addSubview:btn];
            [self.passtextfield becomeFirstResponder];
        }
    }
    return self;
}
-(void)clickbtn:(UIButton *)sender
{
    if (sender.tag-selftag==0) {
        if (self.passtextfield.text.length!=6) {
            [self showhudmessage:@"密码位数不对哦!" offy:-100];
            return;
        }
        if (self.myblock) {
            [self canleclick];
            self.myblock(self.passtextfield.text);
        }
    }
    else{
        [self canleclick];
    }
}
-(void)canleclick
{
    [self removeFromSuperview];
}
-(UILabel *)selftitleLable
{
    if (_selftitleLable==nil) {
        _selftitleLable=[[UILabel alloc] initWithFrame:CGRectMake(0,15*KWidth_Scale, SCREEN_WIDTH-50*KWidth_Scale, 30*KWidth_Scale)];
        _selftitleLable.textColor=WordsofcolorColor;
        _selftitleLable.numberOfLines=0;
        _selftitleLable.numberOfLines=0;
        _selftitleLable.attributedText=[PublicFunction attributedStringWithHTMLString:mytitle];
        _selftitleLable.textAlignment=NSTextAlignmentCenter;
    }
    return _selftitleLable;
}
-(UIView *)botomo
{
    if (_botomo==nil) {
        CGFloat offy=180*KWidth_Scale;
        _botomo=[[UIView alloc] initWithFrame:CGRectMake(25*KWidth_Scale,StatusBarAndNavigationBarHeight+80*KWidth_Scale, SCREEN_WIDTH-50*KWidth_Scale, offy)];
        _botomo.layer.cornerRadius=5*KWidth_Scale;
        _botomo.clipsToBounds=YES;
        _botomo.backgroundColor=[UIColor whiteColor];
    }
    return _botomo;
}
-(UITextField *)passtextfield
{
    if (_passtextfield==nil) {
        _passtextfield=[[UITextField alloc] initWithFrame:CGRectMake(25*KWidth_Scale,CGRectGetMaxY(self.selftitleLable.frame)+10*KWidth_Scale, SCREEN_WIDTH-100*KWidth_Scale,45*KWidth_Scale)];
        _passtextfield.placeholder=@"输入支付密码";
        _passtextfield.keyboardType=UIKeyboardTypeNumberPad;
        _passtextfield.textAlignment=NSTextAlignmentCenter;
        _passtextfield.textColor=RGB(51, 51, 51);
        _passtextfield.font=[UIFont systemFontOfSize:15];
        _passtextfield.secureTextEntry=YES;
        _passtextfield.delegate=self;
        [_passtextfield addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _passtextfield;
}
-(void)textFieldDidChange:(UITextField *)textField
{
    if (textField == self.passtextfield) {
        if (textField.text.length >6) {
            textField.text = [textField.text substringToIndex:6];
        }
    }
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
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
