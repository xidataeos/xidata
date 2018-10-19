//
//  MyWorkcollectionCell.m
//  Woo
//
//  Created by 王起锋 on 2018/10/14.
//  Copyright © 2018年 杭州蜂布式. All rights reserved.
//

#import "MyWorkcollectionCell.h"

@implementation MyWorkcollectionCell
-(UILabel *)timeLabel
{
    if (_timeLabel==nil) {
        _timeLabel=[[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-100*KWidth_Scale, 0,85*KWidth_Scale, 50*KWidth_Scale)];
        _timeLabel.font=UIFont(12);
        _timeLabel.textColor=WordsofcolorColor;
        _timeLabel.numberOfLines=0;
        _timeLabel.textAlignment=NSTextAlignmentRight;
    }
    return _timeLabel;
}
-(UIImageView *)imageview
{
    if (_imageview==nil) {
        _imageview=[[UIImageView alloc] initWithFrame:CGRectMake(10*KWidth_Scale, 12.5*KWidth_Scale, 25*KWidth_Scale, 25*KWidth_Scale)];
    }
    return _imageview;
}
-(UILabel *)titllabel
{
    if (_titllabel==nil) {
        _titllabel=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.imageview.frame)+5*KWidth_Scale,0, SCREEN_WIDTH*0.5, 50*KWidth_Scale)];
        _titllabel.font=UIFont(15);
        _titllabel.textColor=WordsofcolorColor;
        _titllabel.numberOfLines=0;
    }
    return _titllabel;
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self  creatUI];
    }
    return self;
}
-(void)creatUI
{
    [self addSubview:self.imageview];
    [self addSubview:self.titllabel];
    
    [self addSubview:self.timeLabel];
    self.zhuanjiiconimageview=[[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-90*KWidth_Scale-8, 21*KWidth_Scale, 8, 8)];
    self.zhuanjiiconimageview.layer.cornerRadius=4;
    self.zhuanjiiconimageview.clipsToBounds=YES;
    self.zhuanjiiconimageview.backgroundColor=UIColorFromRGB(0xE51C23 );
    [self addSubview:self.zhuanjiiconimageview];
    self.timeLabel.text=@"10条等待上传";
    self.titllabel.text=@"我是标题";
    [self.imageview sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1539075998765&di=20f535ed353cc2be1e53063d3627c683&imgtype=0&src=http%3A%2F%2Fpic30.photophoto.cn%2F20140218%2F0013025939222600_b.jpg"]];
    UIView *cell=[[UIView alloc] initWithFrame:CGRectMake(0, 49*KWidth_Scale, SCREEN_WIDTH, 1.0)];
    cell.backgroundColor=CellBackgroundColor;
    [self addSubview:cell];
}
@end
