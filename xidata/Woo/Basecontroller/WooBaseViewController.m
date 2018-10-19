//
//  WooBaseViewController.m
//  Woo
//
//  Created by 风外杏林香 on 2018/7/26.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import "WooBaseViewController.h"
#import "SVProgressHUD.h"
@interface WooBaseViewController ()<UIScrollViewDelegate,MBProgressHUDDelegate,UINavigationControllerDelegate>
{
    MBProgressHUD * HUD;
    UIPanGestureRecognizer *panGesture;
}
@property (nonatomic, weak) UIPageControl *pageControl;
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *btnArray;
@property(nonatomic,strong)MBProgressHUD *myhub;
@property (nonatomic, readwrite) NSUInteger activityCount;
@end

@implementation WooBaseViewController

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.changestatuscolor=NO;
    self.view.backgroundColor=RGB(242, 242, 242);
    [[UINavigationBar appearance]setTitleTextAttributes:@{NSForegroundColorAttributeName:RGB(255, 255, 255)}];
    self.btnArray = [NSMutableArray array];
    [self setbackview];
    [self setline];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self preferredStatusBarStyle];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    [self.navigationController.navigationBar setBarTintColor:NaviBackgroundColor];
    // Do any additional setup after loading the view.
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    if (self.changestatuscolor) {
        return UIStatusBarStyleDefault;
    }
    return UIStatusBarStyleLightContent;
}

-(void)setline
{
    //去掉导航栏底部黑线
    [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init]
                                      forBarPosition:UIBarPositionAny
                                          barMetrics:UIBarMetricsDefault];
    
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    
    self.line = [[UILabel alloc] init];
    self.line.frame = CGRectMake(0, self.navigationController.navigationBar.frame.size.height, self.view.frame.size.width, 0.5);
    self.line.backgroundColor = RGB(222, 222, 222);
    [self.navigationController.navigationBar addSubview:self.line];
}

-(void)setbackview
{
    NSDictionary * textAttributes = @{
                                      NSFontAttributeName: [UIFont systemFontOfSize:18.0f]};
    self.navigationController.navigationBar.titleTextAttributes =textAttributes;
    if ([PublicFunction isIOS7OrLater]) {
        [self showNavBackItem];
    }
}
- (void)showNavBackItem
{
    if (!self.isnosetfbackbtn)
    {
        UIImage * backIndicatorImage = [UIImage imageNamed:@"whiteback"];
        UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [leftButton setImage:backIndicatorImage forState:UIControlStateNormal];
        [leftButton setImageEdgeInsets:UIEdgeInsetsMake(10, 0, 12, 22)];
        [leftButton addTarget:self action:@selector(doReturn) forControlEvents:UIControlEventTouchUpInside];
        leftButton.frame = CGRectMake(0, -10, 44, 44);
        leftButton.backgroundColor = [UIColor clearColor];
        UIBarButtonItem* leftNavBtn = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
        //出现返回按钮，肯定不是root
        self.navigationItem.leftBarButtonItem = leftNavBtn;
    }
}
- (void)doReturn{
    if (self.toroot) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    double page = scrollView.contentOffset.x / scrollView.width;
    self.pageControl.currentPage = (int)(page + 0.5);
}
- (void)nextButtonClick
{
    CGPoint oldContentOffset = self.scrollView.contentOffset;
    CGPoint newContentOffset = CGPointMake(oldContentOffset.x + SCREEN_WIDTH, oldContentOffset.y);
    [self.scrollView setContentOffset:newContentOffset animated:YES];
}

- (void)show {
    [SVProgressHUD show];
    self.activityCount++;
}
-(void)showInfoWithStatus:(NSString *)UsefulInfo{
    [SVProgressHUD showInfoWithStatus:UsefulInfo];
    [self hidProgress];
    self.activityCount++;
}
- (void)showWithStatus:(NSString *)Information {
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD showWithStatus:Information];
    self.activityCount++;
}
- (void)showSuccessWithStatus:(NSString*)SuccessMessage{
    [SVProgressHUD showSuccessWithStatus:SuccessMessage];
    [self hidProgress];
    self.activityCount++;
}

- (void)showErrorWithStatus:(NSString *)ErrorMessage{
    [SVProgressHUD showErrorWithStatus:ErrorMessage];
    [self hidProgress];
    self.activityCount++;
}
- (void)dismiss {
    [SVProgressHUD dismiss];
    self.activityCount = 0;
}
-(void)hidProgress
{
    [self performSelector:@selector(dismiss) withObject:nil afterDelay:2.0];
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
