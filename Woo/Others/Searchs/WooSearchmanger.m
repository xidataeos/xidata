
//
//  WooSearchmanger.m
//  Woo
//
//  Created by 王起锋 on 2018/8/16.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import "WooSearchmanger.h"
static WooSearchmanger *Searchmanger = nil;
@implementation WooSearchmanger
+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        Searchmanger = [WooSearchmanger new];
    });
    
    return Searchmanger;
}
-(void)begintosearch:(WooBaseViewController *)fromeview navi:(WooBaseNavigationViewController *)navi search:(SearchType)type
{
    self.fromecontroller=fromeview;
    SearchViewController *searchViewController = [[SearchViewController alloc] init];
    fromeview.searchNavigationController = [[WooBaseNavigationViewController alloc] initWithRootViewController:searchViewController];
    searchViewController.delegate = self;
    searchViewController.searchtype=type;
    fromeview.changestatuscolor=YES;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [fromeview preferredStatusBarStyle];
    if (![self.fromecontroller isKindOfClass:[MyfriendsViewController class]]) {
         fromeview.tabBarController.tabBar.hidden=YES;
    }
   
    navi.navigationBar.barStyle = UIBarStyleDefault;
    [fromeview.navigationController.view addSubview:fromeview.searchNavigationController.view];
}
-(void)onSearchCancelClick
{
    self.fromecontroller.changestatuscolor=NO;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self.fromecontroller preferredStatusBarStyle];
    [self.fromecontroller.searchNavigationController.view removeFromSuperview];
    [self.fromecontroller.searchNavigationController removeFromParentViewController];
    [self.fromecontroller.navigationController setNavigationBarHidden:NO animated:YES];
    self.fromecontroller.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    if (![self.fromecontroller isKindOfClass:[MyfriendsViewController class]]) {
        self.fromecontroller.tabBarController.tabBar.hidden=NO;
    }
}
@end
