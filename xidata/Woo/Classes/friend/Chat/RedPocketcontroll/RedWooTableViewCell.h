//
//  RedWooTableViewCell.h
//  Woo
//
//  Created by 王起锋 on 2018/8/24.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RedWooTableViewCell : UITableViewCell
@property(nonatomic,strong)UILabel *countlabel;
@property(nonatomic,strong)UIImageView *tipsimage;
@property(nonatomic,strong)UILabel *textLanel;
@property(nonatomic,strong)UILabel *detailtextview;
@property(nonatomic,strong)UIImageView *photo;
@property(nonatomic,strong)RedmessageModle *model;
@end
