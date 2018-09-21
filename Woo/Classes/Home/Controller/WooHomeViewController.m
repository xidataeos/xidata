//
//  WooHomeViewController.m
//  Woo
//
//  Created by 风外杏林香 on 2018/7/25.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import "WooHomeViewController.h"
#import "MeetingissuedViewController.h"
#import "EducationViewController.h"
#import "TBSegementControl.h"
@interface WooHomeViewController ()<UIScrollViewDelegate,TBSegementControlDelegate, UISearchBarDelegate>
{
    UIScrollView *scroll;
    UIView *view_bar;
}
@property (strong, nonatomic)TBSegementControl *segementView;
@property (nonatomic, strong)RCDSearchBar *searchBar;
@end

@implementation WooHomeViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (RCDSearchBar *)searchBar
{
    if (!_searchBar) {
        _searchBar = [[RCDSearchBar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
        _searchBar.delegate = self;
    }
    return _searchBar;
}

#pragma mark - UISearchBarDelegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [self tosearchview:Seatch_allviews];
}
-(void)tosearchview:(SearchType)type
{
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [[WooSearchmanger shareInstance] begintosearch:self navi:self.searchNavigationController search:type];
}


- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    self.isnosetfbackbtn=YES;
    [super viewDidLoad];
    [self setview_bar];
    [self constantSegement];
    [self setupScrollView];
    self.title=@"首页";
    [self setnavitionright];
    [self badgeValue];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveMessageNotification:)name:RCKitDispatchMessageNotification
        object:nil];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.searchBar];
    
}

- (void)didReceiveMessageNotification:(NSNotification *)notification {
    [self badgeValue];
}
-(void)badgeValue
{
    WooBaseNavigationViewController *nav = self.navigationController.tabBarController.viewControllers[1];
    dispatch_async(dispatch_get_main_queue(), ^{
        int count=[[RCIMClient sharedRCIMClient] getTotalUnreadCount];
        if (count<=0) {
            nav.tabBarItem.badgeValue = nil;
        }
        else{
            nav.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",count];
        }
    });
}
-(void)setnavitionright
{
    UIButton *  rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setImage:[UIImage imageNamed:@"jiahao"]  forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(addAction) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.frame = CGRectMake(SCREEN_WIDTH, 25, 45, 45);
    [rightBtn setImageEdgeInsets:UIEdgeInsetsMake(7, 20, 7, 0)];
    UIBarButtonItem *right=[[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem=right;
}
- (void)addAction
{
    NSArray *titles = @[@"扫一扫",@"创建社群",@"添加好友/社群"];
    
    MLMenuView *menuView = [[MLMenuView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 110 - 10, 0, 110, 40 * 3) WithTitles:titles WithImageNames:nil WithMenuViewOffsetTop:StatusBarAndNavigationBarHeight WithTriangleOffsetLeft:90 triangleColor:RGBAColor(255, 255, 255, 1.0)];
    [menuView setCoverViewBackgroundColor:RGBAColor(255, 255, 255, 0.1)];
    [menuView setSeparatorOffSet:0];
    menuView.separatorColor = RGBAColor(151, 151, 151,0.2);
    [menuView setMenuViewBackgroundColor:RGBAColor(255, 255, 255, 1.0)];
    menuView.layer.shadowOpacity = 0.4f;
    menuView.layer.shadowColor=[UIColor blackColor].CGColor;
    menuView.layer.shadowOffset=CGSizeMake(2, 2);
    menuView.titleColor =  WordsofcolorColor;
    menuView.didSelectBlock = ^(NSInteger index) {
        if (index == 0) {
            ZKLog(@"扫码");
            HCScanQRViewController *scan = [[HCScanQRViewController alloc]init];
            //调用此方法来获取二维码信息
            [scan successfulGetQRCodeInfo:^(NSString *QRCodeInfo) {
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
                //                UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
                //                cell.detailTextLabel.text = QRCodeInfo;
            }];
            [self.navigationController pushViewController:scan animated:YES];
        } else if (index == 1) {
            ZKLog(@"创建社群");
//            SelectContactViewController *control=[[SelectContactViewController alloc] init];
//            control.delegate=self;
//            [self.navigationController pushViewController:control animated:YES];
        } else {
            ZKLog(@"添加好友/社群");
        }
//        ZKLog(@"%zd",index);
    };
    [menuView showMenuEnterAnimation:MLAnimationStyleNone];
}
    
-(void)setview_bar
{
    view_bar=[[UIView alloc]initWithFrame:CGRectMake(0,40,SCREEN_WIDTH,50)];
    view_bar.backgroundColor=RGB(255, 255, 255);
    view_bar.userInteractionEnabled=YES;
    [self.view addSubview:view_bar];
    //    UILabel *title=[[UILabel alloc] initWithFrame:CGRectMake(0, off_y+15, kScreenWidth, 15)];
    //    title.text=@"还款";
    //    title.textAlignment=NSTextAlignmentCenter;
    //    title.textColor=RGB(102, 102, 102);
    //    title.font=[UIFont systemFontOfSize:17];
    //    [view_bar addSubview:title];
    
}
-(void)constantSegement {
    self.segementView = [[TBSegementControl alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 50)];
    self.segementView.backgroundColor = [UIColor clearColor];
    self.segementView.itemsArray      = @[@"会议发布",@"教育培训"];
    self.segementView.delegate        = self;
    [view_bar addSubview:self.segementView];
}
//-(void)refreshWaitloadData{
//    [self setupScrollView];
//
//}

#pragma mark - 我的分段账单 待还 和 已还
- (void)setupScrollView{
    CGFloat off_y=[[UIApplication sharedApplication] statusBarFrame].size.height;
    scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(view_bar.frame), SCREEN_WIDTH, SCREEN_HEIGHT-64-off_y)];
    [self.view addSubview:scroll];
    scroll.pagingEnabled                      = YES;
    scroll.delegate                           = self;
    scroll.bounces                            = NO;
    scroll.alwaysBounceHorizontal = NO;
    scroll.alwaysBounceVertical = NO;
    scroll.showsVerticalScrollIndicator       = NO;
    scroll.showsHorizontalScrollIndicator=NO;
    scroll.directionalLockEnabled             = YES;
    scroll.contentSize = CGSizeMake((SCREEN_WIDTH) * 2, 0);
    scroll.backgroundColor=[UIColor clearColor];
    scroll.layer.cornerRadius=8;
    scroll.clipsToBounds=YES;
    /*待还*/
    MeetingissuedViewController *RechargeRecordVC = [[MeetingissuedViewController alloc]init];
    RechargeRecordVC.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, /*SCREEN_HEIGHT-(50 +off_y)*KWidth_Scale - TabbarHeight*/ ScreenHeight - 50 - 40 - TabbarHeight - StatusBarAndNavigationBarHeight);
    [self addChildViewController:RechargeRecordVC];
    [scroll addSubview:RechargeRecordVC.view];
    
    /*已还清*/
    EducationViewController *consumptionVC = [[EducationViewController alloc]init];
    consumptionVC.view.frame = CGRectMake(SCREEN_WIDTH, 0,SCREEN_WIDTH, /*SCREEN_HEIGHT-(50 +off_y)*/ScreenHeight - 50 - 40 - TabbarHeight - StatusBarAndNavigationBarHeight);
    [self addChildViewController:consumptionVC];
    [scroll addSubview:consumptionVC.view];
}


#pragma mark ---UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.segementView setAnimationWithOffSet:scrollView.contentOffset.x totalWidth:scrollView.bounds.size.width];
    [self.searchBar resignFirstResponder];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    self.segementView.selectedIndex = (int)(scrollView.contentOffset.x / ([UIScreen mainScreen].bounds.size.width));
}
#pragma mark ---TBSegementControlDelegate
-(void)segementButtonClickedAtIndex:(NSInteger)index {
    [scroll setContentOffset:CGPointMake(([UIScreen mainScreen].bounds.size.width) * index, 0) animated:YES];
}
-(void)dealloc{
    //[[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
