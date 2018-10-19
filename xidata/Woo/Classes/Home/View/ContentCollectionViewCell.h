//
//  ContentCollectionViewCell.h
//  Woo
//
//  Created by 王起锋 on 2018/10/9.
//  Copyright © 2018年 杭州蜂布式. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ContentCollectionViewCell : UICollectionViewCell
@property(nonatomic,strong)UILabel *titllabel;
@property(nonatomic,strong)UIImageView *imageview;
@property(nonatomic,strong)UIImageView *iconimageview;
@property(nonatomic,strong)UILabel *numberLabel;
@property(nonatomic,strong)UIView *botomo;
@property(nonatomic,strong)HomeModel *model;
-(instancetype)initWithFrame:(CGRect)frame;
@end

NS_ASSUME_NONNULL_END
