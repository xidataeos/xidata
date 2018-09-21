//
//  WatchoneTableViewCell.h
//  Woo
//
//  Created by 王起锋 on 2018/8/13.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WatchoneTableViewCell : UITableViewCell

@property(nonatomic,strong)UIView *botomoview;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)Watchobject *model;
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier datarr:(NSArray *)datarr;
@end
