//
//  CustAlertview.h
//  Woo
//
//  Created by 王起锋 on 2018/8/14.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import "baseview.h"
typedef void (^myclickblock) (void);
@interface CustAlertview : baseview
{
    NSString *mytitle;
    NSString *detaistr;
}
@property(nonatomic,copy)myclickblock myblock;
@property(nonatomic,strong)UILabel *selftitleLable;
@property(nonatomic,strong)UILabel *detaillabel;
@property(nonatomic,strong)UIView *botomo;
-(instancetype)initWithFrame:(CGRect)frame title:(NSString *)title detailstr:(NSString *)detailstr;
-(CGFloat)getMyheight:(NSString *)descrption;
-(void)shareviewShow;
-(void)canleclick;
@end
