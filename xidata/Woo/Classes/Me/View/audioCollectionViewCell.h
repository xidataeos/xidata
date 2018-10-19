//
//  audioCollectionViewCell.h
//  Woo
//
//  Created by 王起锋 on 2018/10/11.
//  Copyright © 2018年 杭州蜂布式. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface audioCollectionViewCell : UICollectionViewCell
@property(nonatomic,strong)UILabel *titllabel;
@property(nonatomic,strong)UIImageView *zhuanjiiconimageview;
@property(nonatomic,strong)UIImageView *imageview;
@property(nonatomic,strong)UILabel *timeLabel;
@property(nonatomic,strong)UILabel *zhuanji;
@property(nonatomic,strong)UILabel *videocount;
@property(nonatomic,strong)UIButton *submitBtn;
@property(nonatomic,strong)UIView *botomoview;

@end

NS_ASSUME_NONNULL_END
