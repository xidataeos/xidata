

//
//  ContentCollectionViewCell.m
//  Woo
//
//  Created by 王起锋 on 2018/10/9.
//  Copyright © 2018年 杭州蜂布式. All rights reserved.
//

#import "ContentCollectionViewCell.h"

@implementation ContentCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
    }
    return self;
}
-(void)creatUI
{
    self.imageview=[[UIImageView alloc] initWithFrame:CGRectMake(1*KWidth_Scale,0,SCREEN_WIDTH/2.0-3, SCREEN_WIDTH/2.0-3-25*KWidth_Scale)];
    self.imageview.contentMode=UIViewContentModeScaleAspectFill;
    self.imageview.layer.cornerRadius=5;
    self.imageview.clipsToBounds=YES;
    self.titllabel=[PublicFunction getlabelwithtexttitle:@"" fram:CGRectMake(1*KWidth_Scale,SCREEN_WIDTH/2.0-3-25*KWidth_Scale,SCREEN_WIDTH/2.0-3,25*KWidth_Scale) cornerRadius:0 textcolor:[PublicFunction colorWithHexString:@"#666666"] textfont:[UIFont systemFontOfSize:12] backcolor:[PublicFunction colorWithHexString:@"00000"] textAlignment:NSTextAlignmentCenter];
    
    self.iconimageview=[[UIImageView alloc] initWithFrame:CGRectMake(5*KWidth_Scale,0,20*KWidth_Scale,20*KWidth_Scale)];
    self.iconimageview.contentMode=UIViewContentModeScaleAspectFill;
    self.numberLabel=[PublicFunction getlabelwithtexttitle:@"" fram:CGRectMake(30*KWidth_Scale,0,SCREEN_WIDTH/2.0-33*KWidth_Scale-45*KWidth_Scale,20*KWidth_Scale) cornerRadius:0 textcolor:[PublicFunction colorWithHexString:@"#333333"] textfont:[UIFont systemFontOfSize:12] backcolor:[PublicFunction colorWithHexString:@"00000"] textAlignment:NSTextAlignmentLeft];
    self.botomo=[[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_WIDTH/2.0-3-50*KWidth_Scale, SCREEN_WIDTH/2.0, 25*KWidth_Scale)];
    [self.botomo addSubview:self.numberLabel];
    [self.botomo addSubview:self.iconimageview];
    self.numberLabel.backgroundColor=[UIColor redColor];
    [self addSubview:self.imageview];
    [self addSubview:self.titllabel];
    [self.imageview addSubview:self.botomo];
}
-(void)setModel:(HomeModel *)model
{
    [self.iconimageview sd_setImageWithURL:[NSURL URLWithString:model.graphicinfoModel.albumImg]];
    [self.imageview sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1539148469446&di=5a5e6997f65174dc6ed7e610eabf0701&imgtype=0&src=http%3A%2F%2Fscimg.jb51.net%2Fallimg%2F170113%2F106-1F11314442U30.jpg"]];
    self.titllabel.text=model.title;
    self.numberLabel.text=@"12";
    [self.iconimageview sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1539148469446&di=5a5e6997f65174dc6ed7e610eabf0701&imgtype=0&src=http%3A%2F%2Fscimg.jb51.net%2Fallimg%2F170113%2F106-1F11314442U30.jpg"]];
}
@end
