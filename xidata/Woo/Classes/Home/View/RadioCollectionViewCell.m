//
//  RadioCollectionViewCell.m
//  Woo
//
//  Created by 王起锋 on 2018/10/9.
//  Copyright © 2018年 杭州蜂布式. All rights reserved.
//

#import "RadioCollectionViewCell.h"

@implementation RadioCollectionViewCell
-(UILabel *)categorylable
{
    if (_categorylable==nil) {
        _categorylable=[[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2.0-3-50*KWidth_Scale, 5*KWidth_Scale, 40*KWidth_Scale, 18*KWidth_Scale)];
        _categorylable.layer.cornerRadius=9;
        _categorylable.clipsToBounds=YES;
        _categorylable.backgroundColor=NaviBackgroundColor;
        _categorylable.font=UIFont(13);
        _categorylable.textColor=WordsofcolorColor;
        _categorylable.numberOfLines=0;
    }
    return _categorylable;
}
-(UILabel *)paylabel
{
    if (_paylabel==nil) {
        _paylabel=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.numberLabel.frame)+1, 0*KWidth_Scale, 45*KWidth_Scale, 20*KWidth_Scale)];
        _paylabel.font=UIFont(13);
        _paylabel.textColor=[UIColor whiteColor];
        _paylabel.numberOfLines=0;
    }
    return _paylabel;
}
- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self addlabel];
    }
    return self;
}
-(void)addlabel
{
    _paylabel.text=@"付费";
    [self.imageview addSubview:self.categorylable];
    [self.botomo addSubview:self.paylabel];
}
-(void)setModel:(HomeModel *)model
{
    [self.imageview sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"playback"]];
    self.titllabel.text=model.title;
    self.iconimageview.image=[UIImage imageNamed:@"selecticon"];
    self.numberLabel.text=@"11";
    self.categorylable.text=@"恋爱";
}
@end
