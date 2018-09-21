//
//  UIApplication+Common.m
//  FuelTreasureProject
//
//  Created by 吴仕海 on 4/13/15.
//  Copyright (c) 2015 XiTai. All rights reserved.
//

#import "UIApplication+Common.h"
#import "MBProgressHUD.h"

#define IsStrEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref)isEqualToString:@""]))

@interface UIApplication ()<MBProgressHUDDelegate>
@end

@implementation UIApplication (Common)

- (void)showcurrentNetworkStatusStr:(NSString *)message
{
    if (!IsStrEmpty(message))
    {
        NSArray *windows = self.windows;
        UIWindow *presentMessageWindow = [windows lastObject];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:presentMessageWindow.rootViewController.view animated:YES];
//        hud.labelColor=[UIColor yellowColor];
        hud.mode = MBProgressHUDModeText;
        hud.margin = 15.f;
        hud.removeFromSuperViewOnHide = YES;
        hud.delegate = self;
        hud.detailsLabelText=message;
        hud.detailsLabelColor = [UIColor whiteColor];
        hud.detailsLabelFont = [UIFont systemFontOfSize:17.0f];
        [hud hide:YES afterDelay:2.5f];
    }
}

#pragma mark -
- (void)hudWasHidden:(MBProgressHUD *)hud
{
    [hud removeFromSuperview];
    hud = nil;
}

//+ (NFTabBarViewController *)viewControllerInMainStoryBoardAccording:(NSString *)identifier{
//    if (identifier.length == 0) {
//        return nil;
//    }
//    
//    NFTabBarViewController *viewController = [[UIStoryboard storyboardWithName:@"NFHomeStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:identifier];
//    return viewController;
//}
@end
