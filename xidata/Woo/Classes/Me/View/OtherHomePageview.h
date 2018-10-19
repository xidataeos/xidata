//
//  OtherHomePageview.h
//  Woo
//
//  Created by 王起锋 on 2018/10/11.
//  Copyright © 2018年 杭州蜂布式. All rights reserved.
//

#import "baseview.h"
typedef void (^headblock) (UIImageView* headimage);

NS_ASSUME_NONNULL_BEGIN

@interface OtherHomePageview : baseview
@property(nonatomic,strong)UIButton *backBtn;
@property(nonatomic,strong)UIButton *GuanzhukBtn;
@property(nonatomic,strong)UIButton *sixinkBtn;
@property(nonatomic,strong)UIButton *fensiBtn;
@property(nonatomic,strong)UIImageView *topview;
@property(nonatomic,strong)UIImageView *avimage;
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UILabel *xinyongLabel;
@property(nonatomic,strong)UILabel *guanzhuLabel;
@property(nonatomic,strong)UILabel *fensiLabel;
@property(nonatomic,strong)UIImageView *daV;
@property(nonatomic,strong)UIImageView *rezheng;
@property(nonatomic,copy)headblock clickblock;
@property(nonatomic,copy)publicnoamlblock backBlock;
@property(nonatomic,copy)publicclickblock publickblock;
@end

NS_ASSUME_NONNULL_END
