//
//  CustomTableViewCell.h
//  Woo
//
//  Created by 王起锋 on 2018/8/2.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableViewCell : UITableViewCell
@property(nonatomic,strong)UIImageView *userimageview;
@property(nonatomic,strong)UILabel *celltitlable;
@property(nonatomic,strong)UILabel *tipslabel;
@property(nonatomic,strong)UIView *cellline;
-(void)setdata:(NSString *)unreadcountstr;
@end
