//
//  CopyrightCollectionViewCell.h
//  Woo
//
//  Created by 王起锋 on 2018/10/9.
//  Copyright © 2018年 杭州蜂布式. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CopyrightCollectionViewCell : UICollectionViewCell
@property(nonatomic,strong)UILabel *titllabel;
@property(nonatomic,strong)UIImageView *imageview;
@property(nonatomic,strong)UIImageView *zhuanjiiconimageview;
@property(nonatomic,strong)UILabel *timeLabel;
@property(nonatomic,strong)UILabel *videocount;
@property(nonatomic,strong)UILabel *haxilabel;
@property(nonatomic,strong)UIView *botomoview;
@property(nonatomic,strong)UILabel *publiclable;
@property(nonatomic,strong)HomeModel *model;
@end

NS_ASSUME_NONNULL_END
