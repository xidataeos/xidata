//
//  PersonalCenterViewController.h
//  PersonalCenter
//
//  Created by Arch on 2017/6/16.
//  Copyright © 2017年 mint_bin. All rights reserved.
//

#import "WooBaseViewController.h"
@interface AlbumdetailsController : WooBaseViewController
//默认上下左右放大
@property (nonatomic, assign) BOOL isEnlarge;
@property (nonatomic, assign) NSUInteger selectedIndex;
@property (nonatomic, readonly, assign) BOOL isBacking;
@property (nonatomic, strong)HomeModel *AlbumModel;

@end
