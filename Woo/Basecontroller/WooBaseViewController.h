//
//  WooBaseViewController.h
//  Woo
//
//  Created by 风外杏林香 on 2018/7/26.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WooBaseNavigationViewController.h"
@interface WooBaseViewController : UIViewController
@property (nonatomic, strong)NSMutableArray *dataArray;
@property(strong,nonatomic)UILabel *line;
@property(nonatomic)BOOL toroot;
@property(nonatomic)BOOL isnosetfbackbtn;
@property(nonatomic,assign)BOOL changestatuscolor;
@property(nonatomic,strong)WooBaseNavigationViewController *searchNavigationController;
/**
 *  自定义提示操作显示的弹框
 *  @param point 显示位置
 */
- (void)showAlertHud:(CGPoint)point withStr:(NSString *)message offy:(CGFloat)offy;

/**
 *  开启HUD等待请求接口
 */
- (void)showhudmessage:(NSString *)message offy:(CGFloat)offy;


/**
 *  结束HUD
 */
-(void)hideHud;
-(void)toorootview;
@end
