//
//  ReddetailWooViewController.h
//  Woo
//
//  Created by 王起锋 on 2018/8/24.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import "WooBaseViewController.h"

@interface ReddetailWooViewController : WooBaseViewController
<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)  BaseTableView * myTableView;
@property(nonatomic,strong)UIImageView *imagevew;
@property(nonatomic,strong)UILabel *countlabel;
@property(nonatomic,strong)UILabel *allcountlabel;
@property(nonatomic,strong)RedmessageModle *redmodle;
@property(nonatomic,assign)RCConversationType type;
@end
