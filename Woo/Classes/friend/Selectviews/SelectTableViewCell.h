//
//  SelectTableViewCell.h
//  Woo
//
//  Created by 王起锋 on 2018/8/8.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import "CustomTableViewCell.h"

@interface SelectTableViewCell : UITableViewCell
@property(nonatomic,strong)UIButton *selectBtn;
@property(nonatomic,assign)BOOL selectstatus;
@property(nonatomic,strong)UIImageView *userimageview;
@property(nonatomic,strong)UILabel *celltitlable;
@property(nonatomic,copy)publiselectstatusblock myblock;
@end
