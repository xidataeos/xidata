//
//  MygraphicTableViewCell.h
//  Woo
//
//  Created by 王起锋 on 2018/10/14.
//  Copyright © 2018年 杭州蜂布式. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^click) (void);
NS_ASSUME_NONNULL_BEGIN

@interface MygraphicTableViewCell : UITableViewCell
@property(nonatomic,strong)UILabel *titllabel;
@property(nonatomic,strong)UIImageView *zhuanjiiconimageview;
@property(nonatomic,strong)UIImageView *imageview;
@property(nonatomic,strong)UILabel *timeLabel;
@property(nonatomic,strong)UILabel *zhuanji;
@property(nonatomic,strong)UILabel *videocount;
@property(nonatomic,strong)UIImageView *ima2;
@property(nonatomic,strong)UIButton *MoreBtn;
@property(nonatomic,copy)click madeblock;
@property(nonatomic,copy)click moreblock;
@end

NS_ASSUME_NONNULL_END
