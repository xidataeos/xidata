//
//  GameHeadview.h
//  Woo
//
//  Created by 王起锋 on 2018/8/28.
//  Copyright © 2018年 杭州蜂布式. All rights reserved.
//

#import "baseview.h"

@interface GameHeadview : baseview
@property(nonatomic,strong)UIImageView *backImage;
@property(nonatomic,strong)UILabel *allegenumber;
@property(nonatomic,strong)UILabel *CurrentPrice;
@property(nonatomic,strong)UILabel *CountdownLabel;
@property(nonatomic,strong)UIButton *PlayGamebutton;
@property(nonatomic,copy)publicclickblock myblock;
@property (nonatomic,assign) int timeout;
@property(nonatomic,strong)NSDictionary *modeldic;
-(void)canldountdown;
@end
