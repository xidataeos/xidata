//
//  GroupTableViewCell.h
//  Woo
//
//  Created by 王起锋 on 2018/8/6.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KYCuteView.h"
@interface GroupTableViewCell : UITableViewCell
@property(nonatomic,strong)UILabel *namelabel;
@property(nonatomic,strong)UILabel *messagelabel;
@property(nonatomic,strong)KYCuteView *tipslabel;
@property(nonatomic,strong)UILabel *timeslabel;
@property(nonatomic,strong)RCConversation *model;
@property(nonatomic,strong)UIImageView *avrimage;
-(void)setdata:(NSString *)unreadcountstr;
@end
