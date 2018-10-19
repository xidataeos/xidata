//
//  WatchthreeTableViewCell.h
//  Woo
//
//  Created by 王起锋 on 2018/8/13.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import "WatchoneTableViewCell.h"
@interface WatchthreeTableViewCell : WatchoneTableViewCell
@property(nonatomic,strong)UILabel *describelabel;
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end
