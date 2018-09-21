//
//  WooBaseViewController.m
//  Woo
//
//  Created by 风外杏林香 on 2018/7/26.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import "WooBaseViewController.h"

@interface WooBaseViewController ()<UIScrollViewDelegate,MBProgressHUDDelegate,UINavigationControllerDelegate>
{
    MBProgressHUD * HUD;
    UIPanGestureRecognizer *panGesture;
}
@property (nonatomic, weak) UIPageControl *pageControl;
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *btnArray;
@property(nonatomic,strong)MBProgressHUD *myhub;
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
#pragma mark - show alert hud

-(void)showAlertHud:(CGPoint)point withStr:(NSString *)message offy:(CGFloat)offy
{
//    CGPoint center=self.view.center;
//    center.y-=offy;
    MBProgressHUD *hudP = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hudP.mode = MBProgressHUDModeText;
    hudP.margin = 15.f;
    //[hudP setOffset:center];
    //[hudP setY:offy];
    //RGB(60, 74, 93)
    hudP.bezelView.backgroundColor=NaviBackgroundColor;
    hudP.bezelView.layer.cornerRadius=22;
    hudP.bezelView.clipsToBounds=YES;
    hudP.removeFromSuperViewOnHide = YES;
    hudP.delegate = self;
    hudP.detailsLabel.text=message;
    hudP.detailsLabel.textColor=RGB(255, 255, 255);
    hudP.detailsLabel.font = [UIFont systemFontOfSize:13.0f];
    [hudP hideAnimated:YES afterDelay:2.0];
}

#pragma mark - showHUD
/**
 *  开启HUD等待请求接口
 */
- (void)showhudmessage:(NSString *)message offy:(CGFloat)offy{
    
    self.myhub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _myhub.label.backgroundColor=RGB(153, 153, 153);
    _myhub.mode = MBProgressHUDModeIndeterminate;
    _myhub.margin = 15.f;
    _myhub.bezelView.backgroundColor=NaviBackgroundColor;
    //[_myhub setY:offy];
    _myhub.removeFromSuperViewOnHide = YES;
    _myhub.delegate = self;
    _myhub.detailsLabel.text=message;
    _myhub.detailsLabel.textColor=RGB(255, 255, 255);
    _myhub.detailsLabel.font = [UIFont systemFontOfSize:13.0f];
    _myhub.activityIndicatorColor = [UIColor whiteColor];
}

#pragma mark - hideHud
/**
 *  结束HUD
 */
-(void)hideHud
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.myhub hideAnimated:YES];
        [self.myhub setHidden:YES];
    });
    
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
