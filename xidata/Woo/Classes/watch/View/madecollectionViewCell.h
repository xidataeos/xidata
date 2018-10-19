//
//  WatchoneTableViewCell.h
//  Woo
//
//  Created by 王起锋 on 2018/8/13.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"
typedef void (^click) (void);
NS_ASSUME_NONNULL_BEGIN

@interface madecollectionViewCell : UICollectionViewCell
@property(nonatomic,strong)UILabel *titllabel;
@property(nonatomic,strong)UIImageView *imageview;
@property(nonatomic,strong)UIImageView *zhuanjiiconimageview;
@property(nonatomic,strong)UIImageView *watchimage;
@property(nonatomic,strong)UILabel *timeLabel;
@property(nonatomic,strong)UILabel *videocount;
@property(nonatomic,strong)UILabel *zhuanji;
@property(nonatomic,strong)UIButton *submitBtn;
@property(nonatomic,strong)UIView *botomoview;
@property(nonatomic,strong)UILabel *publiclable;
@property(nonatomic,strong)UIButton *MoreBtn;
@property(nonatomic,copy)click madeblock;
@property(nonatomic,copy)click moreblock;
@property(nonatomic,strong)HomeModel *model;
-(void)setmoreBtnHide;
NS_ASSUME_NONNULL_END
@end
