//
//  uploadalertview.h
//  Backtorent
//
//  Created by 零号007 on 2017/12/9.
//  Copyright © 2017年 零号007. All rights reserved.
//

#import "baseview.h"
typedef  void (^cliclblock)(id project);
typedef enum {
    WQAlertView_no_btn = 1,   /**无按钮的弹框 */
    WQAlertViewType_with_btn       /**<有按钮的弹框 */
} WQAlertViewType;
@interface Theselectorview : baseview
@property(nonatomic,copy)cliclblock block;
@property(nonatomic,strong)UITableView *tableview;
-(instancetype)initWithFrame:(CGRect)frame withWQAlertViewType:(WQAlertViewType)AlertViewType title:(NSString *)title detailtitle:(NSMutableArray *)detailtitle btntitle:(NSString *)btntitle;
-(void)show;
-(void)closepage;
@end
