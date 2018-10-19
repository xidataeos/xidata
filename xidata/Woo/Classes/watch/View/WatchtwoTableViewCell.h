//
//  WatchtwoTableViewCell.h
//  Woo
//
//  Created by 王起锋 on 2018/8/13.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import "WatchoneTableViewCell.h"

@interface WatchtwoTableViewCell : WatchoneTableViewCell
@property(nonatomic,strong)UIImageView *userimage;
@property(nonatomic,strong)UILabel *describelabel;
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end
