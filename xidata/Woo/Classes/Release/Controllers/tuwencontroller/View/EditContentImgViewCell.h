//
//  TableViewCell.h
//  Woo
//
//  Created by 王起锋 on 2018/9/28.
//  Copyright © 2018年 杭州蜂布式. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditContentModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface EditContentImgViewCell : UITableViewCell
@property(nonatomic,strong)EditContentModel *Model;
@property(nonatomic,strong)UILabel *celllabel;
@property(nonatomic,strong)UIImageView *cellimage;
@property (nonatomic, copy) void (^retuimageviewcell)(UIImageView *cellimage);
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier celltype:(EditContentCellType)celltype;
+ (CGFloat)getmyheight:(NSString *)introduction;
@end

NS_ASSUME_NONNULL_END
