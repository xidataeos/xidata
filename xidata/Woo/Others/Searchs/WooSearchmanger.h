//
//  WooSearchmanger.h
//  Woo
//
//  Created by 王起锋 on 2018/8/16.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import "baseobject.h"
typedef void (^searchcanle) (void);
@interface WooSearchmanger : baseobject<SearchViewDelegate>
@property(nonatomic,strong)WooBaseViewController *fromecontroller;
@property(nonatomic,copy)searchcanle searchcanleblock;
+ (instancetype)shareInstance;
-(void)begintosearch:(WooBaseViewController *)fromeview navi:(WooBaseNavigationViewController *)navi search:(SearchType)type;
@end
