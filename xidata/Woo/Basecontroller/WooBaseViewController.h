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
-(void)toorootview;
- (void)dismiss;
- (void)show;
-(void)showInfoWithStatus:(NSString *)UsefulInfo;
- (void)showWithStatus:(NSString *)Information;
- (void)showSuccessWithStatus:(NSString*)SuccessMessage;

- (void)showErrorWithStatus:(NSString *)ErrorMessage;
@end
