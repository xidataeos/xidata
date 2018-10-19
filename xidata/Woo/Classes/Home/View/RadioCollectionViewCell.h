//
//  RadioCollectionViewCell.h
//  Woo
//
//  Created by 王起锋 on 2018/10/9.
//  Copyright © 2018年 杭州蜂布式. All rights reserved.
//

#import "ContentCollectionViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface RadioCollectionViewCell : ContentCollectionViewCell
@property(nonatomic,strong)UILabel *categorylable;
@property(nonatomic,strong)UILabel *paylabel;
@property(nonatomic,strong)HomeModel *model;
@end

NS_ASSUME_NONNULL_END
