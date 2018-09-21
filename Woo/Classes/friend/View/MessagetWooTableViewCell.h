//
//  MessagetWooTableViewCell.h
//  Woo
//
//  Created by 王起锋 on 2018/8/22.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^myclickblock) (void);
@interface MessagetWooTableViewCell : UITableViewCell
@property(nonatomic,copy)myclickblock myblock;
@property(nonatomic,strong)UILabel *namelabel;
@property(nonatomic,strong)UILabel *messagelabel;
@property(nonatomic,strong)UIButton *tipslabel;
@property(nonatomic,strong)RCConversation *model;
@property(nonatomic,strong)UIImageView *avrimage;
@end
