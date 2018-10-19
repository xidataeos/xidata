//
//  MywalletCell.h
//  Woo
//
//  Created by 王起锋 on 2018/10/11.
//  Copyright © 2018年 杭州蜂布式. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "shawview.h"
NS_ASSUME_NONNULL_BEGIN

@interface MywalletCell : UITableViewCell
@property(nonatomic,strong)UIButton *WithdrawalBtn;
@property(nonatomic,strong)UILabel *Monthlyincome;
@property(nonatomic,strong)UILabel *Withdrawalamount;
@property(nonatomic,strong)UIImageView *cellimage;
@property(nonatomic,strong)UILabel *titllabel;
@property(nonatomic,copy)publicnoamlblock WithdrawalBlock;
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier indexpath:(NSIndexPath *)indexpath;
@end

NS_ASSUME_NONNULL_END
