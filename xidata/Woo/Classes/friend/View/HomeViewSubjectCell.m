
//
//  HomeViewSubjectCell.m
//  newLoan
//
//  Created by 王起锋 on 2018/6/20.
//  Copyright © 2018年 王起锋. All rights reserved.
//

#import "HomeViewSubjectCell.h"

@implementation HomeViewSubjectCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self  creatUI];
    }
    return self;
}
-(void)creatUI
{
    self.imageview=[[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH/3.0-60*KWidth_Scale)/2.0,18*KWidth_Scale, 60*KWidth_Scale, 60*KWidth_Scale)];
    self.imageview.layer.cornerRadius=30*KWidth_Scale;
    self.imageview.clipsToBounds=YES;
    self.imageview.contentMode=UIViewContentModeScaleAspectFill;
    self.titllabel=[PublicFunction getlabelwithtexttitle:@"" fram:CGRectMake(0,CGRectGetMaxY(self.imageview.frame),SCREEN_WIDTH/3.0, 25*KWidth_Scale) cornerRadius:0 textcolor:[PublicFunction colorWithHexString:@"#666666"] textfont:[UIFont systemFontOfSize:12] backcolor:[PublicFunction colorWithHexString:@"00000"] textAlignment:NSTextAlignmentCenter];

    [self addSubview:self.imageview];
    [self addSubview:self.titllabel];
}
-(UILabel *)zhuanji
{
    if (_zhuanji==nil) {
        _zhuanji=[[UILabel alloc] init];
    }
    return _zhuanji;
}
-(void)setIndex:(NSIndexPath *)index
{
    CGRect fram;
    CGRect labelfram;
    if (index.section==0) {
        NSArray *titlearr=[[NSArray alloc] initWithObjects:@"全部",@"付费精选",@"微版权",@"电台直播",@"恋爱",@"游途",@"时尚",@"婚姻", nil];
        fram=CGRectMake((SCREEN_WIDTH/4.0-4-60*KWidth_Scale)/2.0, 15*KWidth_Scale, 60*KWidth_Scale, 60*KWidth_Scale);
        labelfram=CGRectMake(0,68*KWidth_Scale,SCREEN_WIDTH/4.0-4 , SCREEN_WIDTH/4.0-4+20*KWidth_Scale-70*KWidth_Scale);
        self.imageview.layer.cornerRadius=30*KWidth_Scale;
        self.imageview.clipsToBounds=YES;
        self.titllabel.text=titlearr[index.row];
    }
    else if (index.section==1)
    {
        self.imageview.layer.cornerRadius=5*KWidth_Scale;
        fram=CGRectMake(1*KWidth_Scale, 0,SCREEN_WIDTH/2.0-3, 180*KWidth_Scale);
        labelfram=CGRectMake(1,180*KWidth_Scale,SCREEN_WIDTH/2.0-3, 30*KWidth_Scale);
    }
    else if (index.section==2)
    {
        self.imageview.layer.cornerRadius=5*KWidth_Scale;
        fram=CGRectMake(1*KWidth_Scale, 0,SCREEN_WIDTH/2.0-3, 100*KWidth_Scale);
        labelfram=CGRectMake(1,100*KWidth_Scale,SCREEN_WIDTH/2.0-3, 30*KWidth_Scale);
    }
    else{
        self.imageview.layer.cornerRadius=5*KWidth_Scale;
        fram=CGRectMake(1*KWidth_Scale, 0,SCREEN_WIDTH/3.0-4, SCREEN_WIDTH/3.0-4);
        labelfram=CGRectMake(1,SCREEN_WIDTH/3.0-5,SCREEN_WIDTH/3.0-3, 20*KWidth_Scale);
    }
    self.imageview.frame=fram;
    self.titllabel.frame=labelfram;
    
    self.watchimage=[[UIImageView alloc] initWithFrame:CGRectMake(5,fram.size.height-25*KWidth_Scale , 20*KWidth_Scale, 20*KWidth_Scale)];
    
 self.zhuanji.frame=CGRectMake(CGRectGetMaxX(self.watchimage.frame)+3,fram.size.height-25*KWidth_Scale,60*KWidth_Scale, 20*KWidth_Scale);
    _zhuanji.font=UIFont(12);
    _zhuanji.textColor=WordsofcolorColor;
    if (index.section!=0) {
        [self.imageview addSubview:self.watchimage];
        self.watchimage.image=[UIImage imageNamed:@"logo_icon"];
        [self.imageview addSubview:self.zhuanji];
    }
}
-(void)setModel:(HomeModel *)model
{
    if (model) {
        [self.imageview sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"photo_boy"]];
        self.titllabel.text=model.title;
        self.zhuanji.text=@"100";
            //[NSString stringWithFormat:@"%ld",(long)model.pageView];
    }
}
-(void)setGroupmodel:(RCDGroupInfo *)groupmodel
{
    [self.imageview sd_setImageWithURL:[NSURL URLWithString:groupmodel.portraitUri] placeholderImage:[UIImage imageNamed:@"photo_boy"]];
    self.titllabel.text=groupmodel.groupName;
}
@end
