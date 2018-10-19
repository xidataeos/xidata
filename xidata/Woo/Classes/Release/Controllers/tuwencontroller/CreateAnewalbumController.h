//
//  CreateAnewalbumController.h
//  Woo
//
//  Created by 王起锋 on 2018/10/14.
//  Copyright © 2018年 杭州蜂布式. All rights reserved.
//

#import "WooBaseViewController.h"

@protocol CreateAnewalbumDelegate <NSObject>

-(void)getAlbum:(HomeModel *)Album;

@end
NS_ASSUME_NONNULL_BEGIN

@interface CreateAnewalbumController : WooBaseViewController
@property(nonatomic,weak)id<CreateAnewalbumDelegate>Creatdeleagte;
@end

NS_ASSUME_NONNULL_END
