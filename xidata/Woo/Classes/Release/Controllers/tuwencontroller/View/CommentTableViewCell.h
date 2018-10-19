//
//  CommentTableViewCell.h
//  Woo
//
//  Created by 王起锋 on 2018/10/10.
//  Copyright © 2018年 杭州蜂布式. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommentTableViewCell : UITableViewCell
@property(nonatomic,strong)UILabel *celllabel;
@property(nonatomic,strong)UIImageView *cellimage;
@property(nonatomic,strong)UILabel *detailcelllabel;
@property(nonatomic,strong)UILabel *commentLabel;
+ (CGFloat)getCommentheight:(NSString *)introduction;
@end

NS_ASSUME_NONNULL_END
