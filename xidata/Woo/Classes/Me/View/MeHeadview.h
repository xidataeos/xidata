//
//  MeHeadview.h
//  Woo
//
//  Created by 王起锋 on 2018/10/10.
//  Copyright © 2018年 杭州蜂布式. All rights reserved.
//

#import "baseview.h"

NS_ASSUME_NONNULL_BEGIN

@interface MeHeadview : baseview
@property(nonatomic,strong)UIButton *avimage;
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UILabel *xinyongLabel;
@property(nonatomic,strong)UILabel *guanzhuLabel;
@property(nonatomic,strong)UILabel *fensiLabel;
@property(nonatomic,strong)UIImageView *daV;
@property(nonatomic,strong)UIImageView *rezheng;
@property(nonatomic,copy)publicnoamlblock clickblock;
@property(nonatomic,copy)publicnoamlblock guanzhublock;
@property(nonatomic,copy)publicnoamlblock fensiblock;
@end

NS_ASSUME_NONNULL_END
