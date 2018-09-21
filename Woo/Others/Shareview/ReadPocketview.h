//
//  ReadPocketview.h
//  Woo
//
//  Created by 王起锋 on 2018/8/24.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import "baseview.h"
typedef enum {
    red_type_have= 1,   /**领取界面*/
    red_type_no       /**红包无法领取提醒界面*/
} redmessagetype;
typedef void (^myclickblock) (void);
@interface ReadPocketview : baseview
@property(nonatomic,copy)myclickblock myblock;
@property(nonatomic,strong)UILabel *selftitleLable;
@property(nonatomic,strong)UILabel *detaillabel;
@property(nonatomic,strong)UIImageView *headimage;
@property(nonatomic,strong)UIImageView *botomo;
-(instancetype)initWithFrame:(CGRect)frame retype:(redmessagetype)retype withtips:(NSString *)tips;
-(void)shareviewShow;
@end
