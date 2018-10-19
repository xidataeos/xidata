
//
//  WatchViewController.m
//  Woo
//
//  Created by 王起锋 on 2018/8/2.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import "MadeViewController.h"
#import "MadeSureViewController.h"
#import "auditingViewController.h"
#import "WooSearchmanger.h"
#import "TosubmitViewController.h"
#import "TBSegementControl.h"
@interface MadeViewController ()<UIScrollViewDelegate,TBSegementControlDelegate>
{
    int pagenum;
    UIScrollView *scroll;
    UIView *view_bar;
}

@property(nonatomic, strong) UIView *headerView;
@property (strong, nonatomic)TBSegementControl *segementView;
@property (nonatomic, strong)  BaseTableView * myTableView;

@end

@implementation MadeViewController

- (UIView *)headerView {
    if (!_headerView) {
        _headerView =
        [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.myTableView.frame.size.width, 44)];
    }
    return _headerView;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
}
- (void)viewDidLoad {
    self.isnosetfbackbtn=YES;
    [super viewDidLoad];
    self.title=@"确权";
    [self setview_bar];
    [self constantSegement];
    [self setupScrollView];
}
-(void)setview_bar
{
    view_bar=[[UIView alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,50)];
    view_bar.backgroundColor=RGB(255, 255, 255);
    view_bar.userInteractionEnabled=YES;
    [self.view addSubview:view_bar];
}

-(void)constantSegement {
    self.segementView = [[TBSegementControl alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 50)];
    self.segementView.backgroundColor = [UIColor clearColor];
    self.segementView.itemsArray      = @[@"以确权",@"审核中",@"待提交"];
    self.segementView.delegate        = self;
    [view_bar addSubview:self.segementView];
}
#pragma mark - 我的分段账单 待还 和 已还
- (void)setupScrollView{
    CGFloat off_y=[[UIApplication sharedApplication] statusBarFrame].size.height;
    scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(view_bar.frame), SCREEN_WIDTH, SCREEN_HEIGHT-StatusBarAndNavigationBarHeight-50-off_y)];
    [self.view addSubview:scroll];
    scroll.pagingEnabled                      = YES;
    scroll.delegate                           = self;
    scroll.bounces                            = NO;
    scroll.alwaysBounceHorizontal = NO;
    scroll.alwaysBounceVertical = NO;
    scroll.showsVerticalScrollIndicator       = NO;
    scroll.showsHorizontalScrollIndicator=NO;
    scroll.directionalLockEnabled             = YES;
    scroll.contentSize = CGSizeMake((SCREEN_WIDTH) * 3, 0);
    scroll.backgroundColor=[UIColor clearColor];
    scroll.layer.cornerRadius=8;
    scroll.clipsToBounds=YES;
    /*已确权*/
    MadeSureViewController *RechargeRecordVC = [[MadeSureViewController alloc]init];
    RechargeRecordVC.view.frame = CGRectMake(0, 0, SCREEN_WIDTH,ScreenHeight - 50 - 40 - TabbarHeight - StatusBarAndNavigationBarHeight);
    [self addChildViewController:RechargeRecordVC];
    [scroll addSubview:RechargeRecordVC.view];
    
    /*审核中*/
    auditingViewController *consumptionVC = [[auditingViewController alloc]init];
    consumptionVC.view.frame = CGRectMake(SCREEN_WIDTH, 0,SCREEN_WIDTH,ScreenHeight - 50 - 40 - TabbarHeight - StatusBarAndNavigationBarHeight);
    [self addChildViewController:consumptionVC];
    
    /*待提交*/
    TosubmitViewController *submitView = [[TosubmitViewController alloc]init];
    submitView.view.frame = CGRectMake(SCREEN_WIDTH*2, 0,SCREEN_WIDTH,ScreenHeight - 50 - 40 - TabbarHeight - StatusBarAndNavigationBarHeight);
    [self addChildViewController:submitView];
    [scroll addSubview:consumptionVC.view];
    [scroll addSubview:submitView.view];
}


#pragma mark ---UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.segementView setAnimationWithOffSet:scrollView.contentOffset.x totalWidth:scrollView.bounds.size.width];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    self.segementView.selectedIndex = (int)(scrollView.contentOffset.x / ([UIScreen mainScreen].bounds.size.width));
}
#pragma mark ---TBSegementControlDelegate
-(void)segementButtonClickedAtIndex:(NSInteger)index {
    [scroll setContentOffset:CGPointMake(([UIScreen mainScreen].bounds.size.width) * index, 0) animated:YES];
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
