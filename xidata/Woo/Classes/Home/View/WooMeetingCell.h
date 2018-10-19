//
//  WooMeetingCell.h
//  Woo
//
//  Created by 风外杏林香 on 2018/8/17.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WooHMeetingModel.h"
@interface WooMeetingCell : UITableViewCell
@property (nonatomic, strong)UIImageView *imageView1;
@property (nonatomic, strong)UILabel *label1;
@property (nonatomic, strong)UILabel *label2;
@property (nonatomic, strong)UILabel *label3;
@property (nonatomic, strong)WooHMeetingModel *model;
@end
