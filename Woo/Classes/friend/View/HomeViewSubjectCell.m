
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
-(void)setModel:(RCDGroupInfo *)model
{
    if (model) {
        [self.imageview sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1534398188766&di=3f2868831d5ca3641fdd5a68ed13ba1a&imgtype=0&src=http%3A%2F%2Fimg4.duitang.com%2Fuploads%2Fblog%2F201404%2F06%2F20140406232455_m5XVy.jpeg"] placeholderImage:[UIImage imageNamed:@"kouhong"]];
        self.titllabel.text=model.groupName;
    }
}
@end
