//
//  AlbumdetailsViewCell.h
//  Woo
//
//  Created by 王起锋 on 2018/10/15.
//  Copyright © 2018年 杭州蜂布式. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AlbumdetailsViewCell : UITableViewCell
@property(nonatomic,strong)UILabel *titllabel;
@property(nonatomic,strong)UILabel *imageview;
@property(nonatomic,strong)UIImageView *zhuanjiiconimageview;
@property(nonatomic,strong)UILabel *timeLabel;
@property(nonatomic,strong)UILabel *videocount;
@property(nonatomic,strong)UILabel *tipsLabel;
@property(nonatomic,strong)UILabel *zhuanjiLabel;
@property(nonatomic,strong)UIImageView *img2;
@property(nonatomic,strong)UIView *botomoview;
@property(nonatomic,strong)GraphicinfoModel *model;
@end

NS_ASSUME_NONNULL_END
