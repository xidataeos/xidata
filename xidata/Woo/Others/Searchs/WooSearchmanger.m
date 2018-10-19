
//
//  WooSearchmanger.m
//  Woo
//
//  Created by 王起锋 on 2018/8/16.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import "WooSearchmanger.h"
#import "GroupsdetailViewController.h"
#import "MycreatGroupdetailViewController.h"
#import "WooHomeViewController.h"
#import "allcontentViewController.h"
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
    navi.navigationBar.barStyle = UIBarStyleDefault;
    if ([fromeview isKindOfClass:[GroupsdetailViewController class]]||[fromeview isKindOfClass:[MycreatGroupdetailViewController class]]){
        searchViewController.dataArray=fromeview.dataArray;
    }
    if ([fromeview isKindOfClass:[WooFriendViewController class]]||[fromeview isKindOfClass:[MadeViewController class]]||[fromeview isKindOfClass:[WooHomeViewController class]]) {
        fromeview.tabBarController.tabBar.hidden=YES;
    }
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
    if ([self.fromecontroller isKindOfClass:[WooFriendViewController class]]||[self.fromecontroller isKindOfClass:[MadeViewController class]]||[self.fromecontroller isKindOfClass:[WooHomeViewController class]]) {
        self.fromecontroller.tabBarController.tabBar.hidden=NO;
    }
    
    if (self.searchcanleblock) {
            self.searchcanleblock();
        }
 self.fromecontroller.navigationController.navigationBar.barStyle = UIBarStyleBlack;
}
@end
