//
//  WatchtwoTableViewCell.m
//  Woo
//
//  Created by 王起锋 on 2018/8/13.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import "WatchtwoTableViewCell.h"

@implementation WatchtwoTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self==[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor=CellBackgroundColor;
        [self addSubview:self.botomoview];
        [self.botomoview addSubview:self.userimage];
   self.titleLabel.frame=CGRectMake(CGRectGetMaxX(self.userimage.frame)+15*KWidth_Scale, 15*KWidth_Scale, SCREEN_WIDTH-100*KWidth_Scale-65*KWidth_Scale, 15*KWidth_Scale);
        [self.botomoview addSubview:self.titleLabel];
        [self.botomoview addSubview:self.describelabel];
        [self.botomoview addSubview:self.nameLabel];
        self.nameLabel.frame=CGRectMake(10*KWidth_Scale, CGRectGetMaxY(self.userimage.frame), SCREEN_WIDTH-50*KWidth_Scale, 35*KWidth_Scale);
    }
    return self;
}
-(UILabel *)describelabel
{
    if (_describelabel==nil) {
        _describelabel=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.userimage.frame)+15*KWidth_Scale, CGRectGetMaxY(self.titleLabel.frame)+5*KWidth_Scale, SCREEN_WIDTH-100*KWidth_Scale-65*KWidth_Scale, 80*KWidth_Scale)];
        _describelabel.numberOfLines=0;
        _describelabel.font=UIFont(14);
        _describelabel.textColor=[PublicFunction colorWithHexString:@"999999"];
    }
    return _describelabel;
}
-(UIImageView *)userimage
{
    if (_userimage==nil) {
        _userimage=[[UIImageView alloc] initWithFrame:CGRectMake(10*KWidth_Scale, 15*KWidth_Scale, 112*KWidth_Scale, 100*KWidth_Scale)];
        [_userimage setContentMode:UIViewContentModeScaleAspectFill];
        
        _userimage.clipsToBounds = YES;
        //[self.userimage sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1534157253341&di=1d4582cbf1993f09812c804e862d8f80&imgtype=0&src=http%3A%2F%2Fnews.hangzhou.com.cn%2Fgjxw%2Fimages%2Fattachement%2Fjpg%2Fsite2%2F20180312%2F509a4c0da4451c1038672a.jpg"]];
    }
    return _userimage;
}
-(void)setModel:(Watchobject *)model
{
    NSCharacterSet *set1 = [NSCharacterSet characterSetWithCharactersInString:@"@／：；（）¥「」＂、[]{}#%-*+=_\\|~＜＞$€^•'@#$%^&*()_+'\""];
    NSString *newstr = [model.img stringByTrimmingCharactersInSet:set1];
    [self.userimage sd_setImageWithURL:[NSURL URLWithString:newstr]];
    self.nameLabel.text=model.userName;
    self.titleLabel.text=model.title;
    self.describelabel.text=model.intro;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
//压缩图片
-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
