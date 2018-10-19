//
//  albumSelectview.h
//  Woo
//
//  Created by 王起锋 on 2018/10/12.
//  Copyright © 2018年 杭州蜂布式. All rights reserved.
//

#import "baseview.h"
NS_ASSUME_NONNULL_BEGIN

@interface albumSelectview : baseview
@property(nonatomic,copy)cliclblock block;
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)publicnoamlblock creatblock;
-(instancetype)initWithFrame:(CGRect)frame title:(NSString *)title detailtitle:(NSMutableArray *)detailtitle btntitle:(NSString *)btntitle;
-(void)show;
-(void)closepage;

@end

NS_ASSUME_NONNULL_END
