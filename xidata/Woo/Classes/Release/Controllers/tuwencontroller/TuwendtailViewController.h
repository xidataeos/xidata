//
//  TuwendtailViewController.h
//  Woo
//
//  Created by 王起锋 on 2018/10/10.
//  Copyright © 2018年 杭州蜂布式. All rights reserved.
//

#import "WooBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, payType) {
    Freestatus = 0,
    Paymenstatus
};
@interface TuwendtailViewController : WooBaseViewController
@property(nonatomic,assign)payType Paystatus;
@property(nonatomic,strong)HomeModel *tuwModel;
@end

NS_ASSUME_NONNULL_END
