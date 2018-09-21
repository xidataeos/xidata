
//
//  SelectContactViewController.m
//  Woo
//
//  Created by 王起锋 on 2018/8/8.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//选择成员视图界面

#import "SelectContactViewController.h"
#import "SelectTableViewCell.h"
#import "SelectfriendViewController.h"
@interface SelectContactViewController
()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,SelectfriendViewDelegate>
@property (nonatomic, strong)  BaseTableView * myTableView;
@property(nonatomic, strong) RCDSearchBar *searchBar;
@property (nonatomic, strong)  NSMutableArray * titlearr;
@property (nonatomic, strong)  NSMutableArray * selectcontacts;
@property(nonatomic, strong) UIView *headerView;
@property(nonatomic,strong)WooBaseNavigationViewController *searchNavigationController;
@end

@implementation SelectContactViewController
-(NSMutableArray *)selectcontacts
{
    if (_selectcontacts==nil) {
        _selectcontacts=[[NSMutableArray alloc] init];
    }
    return _selectcontacts;
}
- (RCDSearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar =
        [[RCDSearchBar alloc] initWithFrame:CGRectMake(0, 0, self.myTableView.frame.size.width, 44)];
    }
    return _searchBar;
}
- (UIView *)headerView {
    if (!_headerView) {
        _headerView =
        [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.myTableView.frame.size.width, 44)];
    }
    return _headerView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"邀请社群成员数";
    [self.myTableView reloadData];
    self.searchBar.delegate = self;
    [self.headerView addSubview:self.searchBar];
    self.myTableView.tableHeaderView = self.headerView;
    [self setnavigation];
    [self loadFriendList];
}
-(void)loadFriendList
{
    [self.dataArray removeAllObjects];
    [self.dataArray addObjectsFromArray: [[RCDataBaseManager shareInstance] getAllFriends]];
}
-(void)setnavigation
{
    UIButton *  rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setTitle:@"完成" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(setBtnClick) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.frame = CGRectMake(SCREEN_WIDTH - 45, 25, 20, 20);
    UIBarButtonItem *right=[[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem=right;
}
-(void)setBtnClick
{
    if(self.selectcontacts.count!=0)
    {
        if ([self.delegate respondsToSelector:@selector(sendThecontacts:)]) {
            [self.delegate sendThecontacts:self.selectcontacts];
        }
        [self.searchBar resignFirstResponder];
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    else{
        [self showAlertHud:self.view.center withStr:@"还没有任何选择" offy:-100];
        return;
    }
}
-(BaseTableView *)myTableView{
    if (!_myTableView) {
        _myTableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-StatusBarAndNavigationBarHeight) style:UITableViewStyleGrouped];
        //_myTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _myTableView.separatorColor=CellBackgroundColor;
        _myTableView.delegate=self;
        _myTableView.dataSource = self;
        _myTableView.showsVerticalScrollIndicator = NO;
        _myTableView.showsHorizontalScrollIndicator = NO;
        [_myTableView setTableFooterView:[UIView new]];
        _myTableView.backgroundColor=[UIColor whiteColor];
        if (@available(iOS 11.0, *)) {
            _myTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _myTableView.estimatedRowHeight = 0;
            _myTableView.estimatedSectionFooterHeight = 0;
            _myTableView.estimatedSectionHeaderHeight = 0;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        [self.view  addSubview:_myTableView];
    }
    return _myTableView;
}

#pragma mark tableview的代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50*KWidth_Scale;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *mycellid=@"SelectTableViewCell";
    SelectTableViewCell *newcell=[tableView dequeueReusableCellWithIdentifier:mycellid];
    if (newcell==nil) {
        newcell=[[SelectTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:mycellid];
    }
    RCDUserInfo *model=self.dataArray[indexPath.row];
    newcell.celltitlable.text=model.displayName;
    newcell.celltitlable.textColor=WordsofcolorColor;
    newcell.celltitlable.font=DefleFuont;
    newcell.userimageview.image=[UIImage imageNamed:@"pgoto_girl"];
    newcell.selectionStyle=UITableViewCellSelectionStyleNone;
    newcell.accessoryType = UITableViewCellAccessoryNone;
    [newcell setMyblock:^(BOOL selectstatus) {
        if (selectstatus) {
               [self.selectcontacts addObject:model];
        }
        else{
               [self.selectcontacts removeObject:model];
        }
    }];
    return newcell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    return;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}
#pragma mark - UISearchBarDelegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    SelectfriendViewController *searchViewController = [[SelectfriendViewController alloc] init];
    self.searchNavigationController = [[WooBaseNavigationViewController alloc] initWithRootViewController:searchViewController];
    searchViewController.SearchViewDelegate = self;
    self.changestatuscolor=YES;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [self preferredStatusBarStyle];
    [self.navigationController.view addSubview:self.searchNavigationController.view];
}
- (void)SelectfriendCancelClick {
    self.changestatuscolor=NO;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self preferredStatusBarStyle];
    [self.searchBar resignFirstResponder];
    [self.searchNavigationController.view removeFromSuperview];
    [self.searchNavigationController removeFromParentViewController];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.searchBar resignFirstResponder];
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
