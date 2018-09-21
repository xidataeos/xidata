//
//  WooBaseNavigationViewController.m
//  Woo
//
//  Created by 风外杏林香 on 2018/7/25.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import "WooBaseNavigationViewController.h"

@interface WooBaseNavigationViewController ()

@end

@implementation WooBaseNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [super viewDidLoad];
    self.navigationBar.barStyle = UIBarStyleDefault;
    self.navigationBar.translucent = NO;//需要注意一下
    self.navigationBar.backgroundColor = [UIColor clearColor];
    if ([PublicFunction isIOS7OrLater]) {
        self.navigationBar.barTintColor = [UIColor whiteColor];
    }else{
        self.navigationBar.tintColor = [UIColor whiteColor];
    }
    NSDictionary * textAttributes = @{
                                      NSFontAttributeName: [UIFont systemFontOfSize:16.0f]};
    
    if ([PublicFunction isIOS7OrLater]) {
        UIImage * backIndicatorImage = [UIImage imageNamed:@"ic-o-back"];
        UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [leftButton setBackgroundImage:backIndicatorImage  forState:UIControlStateNormal];
        [leftButton addTarget:self action:@selector(doReturn) forControlEvents:UIControlEventTouchUpInside];
        leftButton.frame = CGRectMake(0, -10, 21, 18);
        leftButton.backgroundColor = [UIColor clearColor];
        UIBarButtonItem* leftNavBtn = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
        //出现返回按钮，肯定不是root
        self.navigationItem.leftBarButtonItem = leftNavBtn;
    }
    [self.navigationBar setTitleTextAttributes:textAttributes];
    // Do any additional setup after loading the view.
}
- (void)doReturn{
    [self.navigationController popViewControllerAnimated:YES];
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    UIViewController *VC = self.topViewController;
    
    return [VC preferredStatusBarStyle];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
