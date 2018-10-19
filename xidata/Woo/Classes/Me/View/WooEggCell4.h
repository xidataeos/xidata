//
//  WooEggCell4.h
//  Woo
//
//  Created by 风外杏林香 on 2018/9/6.
//  Copyright © 2018年 杭州蜂布式. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WooDrawEggModel.h"
@class WooEggCell4;
@protocol WooEggCell4Delegate <NSObject>

- (void)didClickButtonInCell:(WooEggCell4 *)cell;

@end
@interface WooEggCell4 : UITableViewCell
@property (nonatomic, strong)UILabel *label1;
@property (nonatomic, strong)UILabel *label2;
@property (nonatomic, strong)UILabel *label3;
@property (nonatomic, strong)UIButton *button1;
@property (nonatomic, assign)id <WooEggCell4Delegate>delegate;
@property (nonatomic, strong)WooDrawEggModel *model;

@end
