//
//  LSTabBarController.m
//  TabBar
//
//  Created by Airy on 16/4/12.
//  Copyright © 2016年 Airy. All rights reserved.
//

#import "LSTabBarController.h"
#import "WooBaseNavigationViewController.h"
#define kClassKey   @"rootVCClassString"
#define kTitleKey   @"title"
#define kImgKey     @"imageName"
#define kSelImgKey  @"selectedImageName"

@interface LSTabBarController ()


@end

@implementation LSTabBarController
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addChildVC];
    [self addObserver:self
           forKeyPath:@"selectedIndex"
              options:NSKeyValueObservingOptionNew
              context:nil];
}

- (void)addChildVC
{
    NSArray *childItemsArray = @[
                                 @{kClassKey : @"WooHomeViewController",
                                   kTitleKey : @"首页",
                                   kImgKey  : @"home_Image",
                                   kSelImgKey : @"home_sel_Image"},
                                 
                                 @{kClassKey : @"WooWatchViewController",
                                   kTitleKey : @"看点",
                                   kImgKey : @"kandian",
                                   kSelImgKey : @"kandiansel"},
                                 @{kClassKey : @"WooFriendViewController",
                                   kTitleKey : @"朋友",
                                   kImgKey : @"friend_Image",
                                   kSelImgKey : @"friend_sel_Image"},
                                 @{kClassKey : @"WooMeViewController",
                                   kTitleKey : @"我的",
                                   kImgKey : @"me_Image",
                                   kSelImgKey : @"me_sel_Image"},
                                 ];
    
    [childItemsArray enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL *stop) {
        UIViewController *vc = [NSClassFromString(dict[kClassKey]) new];
        vc.title = dict[kTitleKey];
        [self addVCWithvc:vc
                    title:dict[kTitleKey]
                    image:dict[kImgKey]
            selectedImage:dict[kSelImgKey]
               badgeValue:@"0"];
        
    }];
}

- (void)addVCWithvc:(UIViewController *)vc
              title:(NSString *)title
              image:(NSString *)image
      selectedImage:(NSString *)selectedImage
         badgeValue:(NSString *)badgeValue
{
    WooBaseNavigationViewController *navigationController = [[WooBaseNavigationViewController alloc] initWithRootViewController:vc];
    navigationController.tabBarItem.title = title;
    navigationController.tabBarItem.image = [UIImage imageNamed:image];
    UIImage *selected = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = RGB(123, 123, 123);
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    selectTextAttrs[NSForegroundColorAttributeName] = NaviBackgroundColor;
    [navigationController.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [navigationController.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    navigationController.tabBarItem.selectedImage = selected;
    [self addChildViewController:navigationController];
    
}
@end
