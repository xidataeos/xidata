
//
//  Gropudetailheadview.m
//  Woo
//
//  Created by 王起锋 on 2018/8/7.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import "Gropudetailheadview.h"

@implementation Gropudetailheadview
-(instancetype)initWithFrame:(CGRect)frame withgroupmodel:(RCDGroupInfo *)groupmodel
{
    if (self=[super initWithFrame:frame]) {
        self.groupmodel=groupmodel;
        [self setUI];
    }
    return self;
}
-(void)setUI
{
    [self addSubview:self.userimage];
    [self addSubview:self.namelabel];
    [self addSubview:self.groupusercount];
    [self addSubview:self.jianjie];
    [self addSubview:self.Introduction];
}
-(UIImageView *)userimage
{
    if (_userimage==nil) {
        _userimage=[[UIImageView alloc] initWithFrame:CGRectMake(15+15, 15, 60, 60)];
        if ([self.groupmodel.portraitUri isKindOfClass:[NSString class]]) {
           [_userimage sd_setImageWithURL:[NSURL URLWithString:self.groupmodel.portraitUri] placeholderImage:[UIImage imageNamed:@"photo_boy"]];
        }
        else{
            _userimage.image=[UIImage imageNamed:@"photo_boy"];
        }
        
    }
    return _userimage;
}
-(UILabel *)namelabel
{
    if (_namelabel==nil) {
        _namelabel=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.userimage.frame)+5, 15+10, SCREEN_WIDTH*0.4, 20)];
        _namelabel.textColor=WordsofcolorColor;
        _namelabel.text=self.groupmodel.groupName;
        _namelabel.font=DefleFuont;
    }
    return _namelabel;
}
-(UILabel *)groupusercount
{
    if (_groupusercount==nil) {
        _groupusercount=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.userimage.frame)+5,CGRectGetMaxY(self.namelabel.frame)+2, SCREEN_WIDTH*0.4, 20)];
        _groupusercount.textColor=WordsofcolorColor;
        _groupusercount.text=self.groupmodel.number;
        _groupusercount.font=UIFont(13);
    }
    return _groupusercount;
}
-(UILabel *)jianjie
{
    if (_jianjie==nil) {
        _jianjie=[[UILabel alloc] initWithFrame:CGRectMake(15,CGRectGetMaxY(self.userimage.frame)+10, SCREEN_WIDTH*0.4, 15)];
        _jianjie.textColor=WordsofcolorColor;
        _jianjie.text=@"简介";
        _jianjie.font=UIFont(14);
    }
    return _jianjie;
}
-(UILabel *)Introduction
{
    CGSize rect=[self getusetlabelsize:[NSString stringWithFormat:@"      %@",self.groupmodel.introduce] font:UIFont(14)];
    if (_Introduction==nil) {
        _Introduction=[[UILabel alloc] initWithFrame:CGRectMake(15,CGRectGetMaxY(self.jianjie.frame)+10, SCREEN_WIDTH-30, rect.height)];
        _Introduction.textColor=RGB(153, 152, 153);
        _Introduction.text=[NSString stringWithFormat:@"      %@",self.groupmodel.introduce];
        _Introduction.font=UIFont(14);
        _Introduction.numberOfLines=0;
    }
    return _Introduction;
}
-(CGSize)getusetlabelsize:(NSString *)text font:(UIFont*)font
{
    return  [text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName] context:nil].size;
    
}
+ (CGFloat)getmyheight:(NSString *)introduction
{
    CGSize pricelabelsize=[introduction boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:UIFont(14) forKey:NSFontAttributeName] context:nil].size;;
    return pricelabelsize.height+15+60+20+30;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
