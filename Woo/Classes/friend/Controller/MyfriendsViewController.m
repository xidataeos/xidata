
//
//  MyfriendsViewController.m
//  Woo
//
//  Created by 王起锋 on 2018/8/10.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import "MyfriendsViewController.h"
#import "FriendTableViewCell.h"
#import "ContactdetailViewController.h"
#import "MycreatGroupdetailViewController.h"
#import "GroupsdetailViewController.h"

@interface MyfriendsViewController ()
<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,SearchViewDelegate>
@property(nonatomic, strong) RCDSearchBar *searchBar;
@property(nonatomic, strong) UIView *headerView;
@property (nonatomic, strong)  NSMutableArray * titlearr;
@property (nonatomic, strong)  NSMutableArray * imageicomarr;
@property (nonatomic, strong)  BaseTableView * myTableView;
@end

@implementation MyfriendsViewController

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
        _myTableView.backgroundColor=RGB(255, 255, 255);
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
-(void)creatMjRefresh{
    
    MJRefreshNormalHeader *narmalHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadrequestlistdata];
    }];
    self.myTableView.mj_header = narmalHeader;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
     [self loadrequestlistdata];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.chatype==Single_chat) {
         self.title=@"好友列表";
    }
    else{
         self.title=@"社群列表";
    }
    self.imageicomarr=[[NSMutableArray alloc] initWithObjects:@"addpeople",@"addressbook", nil];
     [self creatMjRefresh];
    //self.titlearr=[[NSMutableArray alloc] initWithObjects:@"邀请好友",@"我的朋友", nil];
    self.searchBar.delegate = self;
    [self.headerView addSubview:self.searchBar];
    self.myTableView.tableHeaderView = self.headerView;
    if(self.dataArray.count==0)
    [self.myTableView reloadData];
}
-(void)loadrequestlistdata
{
    [self.dataArray removeAllObjects];
    if (self.chatype==Single_chat) {
         [self.dataArray addObjectsFromArray: [[RCDataBaseManager shareInstance] getAllFriends]];
    }
    else{
        [self.dataArray addObjectsFromArray: [[RCDataBaseManager shareInstance] getAllGroup]];
    }
    if(self.dataArray.count==0)
    {
        [self.myTableView showEmptyViewWithType:1];
        [self.myTableView reloadData];
    }
    else{
        [self.myTableView removeEmptyView];
        [self.myTableView reloadData];
    }
    [self.myTableView.mj_header endRefreshing];
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
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 12*KWidth_Scale;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55*KWidth_Scale;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *mycellid=@"FriendTableViewCell";
    FriendTableViewCell *newcell=[tableView dequeueReusableCellWithIdentifier:mycellid];
    if (newcell==nil) {
        newcell=[[FriendTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:mycellid];
    }
    RCDUserInfo *model;
    RCDGroupInfo *groupmodel;
    if (self.chatype==Single_chat) {
        model=self.dataArray[indexPath.row];
    }
    else{
       groupmodel=self.dataArray[indexPath.row];
    }
    
    newcell.selectionStyle = UITableViewCellSelectionStyleNone;
    newcell.celltitlable.textColor=RGB(102, 102, 102);
    newcell.celltitlable.font=DefleFuont;
    
    if (self.chatype==Single_chat) {
        [newcell.userimageview sd_setImageWithURL:[NSURL URLWithString:model.portraitUri] placeholderImage:[UIImage imageNamed:@"photo_boy"]];
        if (![PublicFunction isEmpty:model.displayName]) {
            newcell.celltitlable.text=model.displayName;
        }
        else{
            newcell.celltitlable.text=model.name;
        }
    }
    else{
        [newcell.userimageview sd_setImageWithURL:[NSURL URLWithString:groupmodel.portraitUri] placeholderImage:[UIImage imageNamed:@"photo_boy"]];
        if (![PublicFunction isEmpty:groupmodel.groupName]) {
            newcell.celltitlable.text=groupmodel.groupName;
        }
       
    }
    newcell.accessoryType = UITableViewCellAccessoryNone;
    newcell.selectionStyle = UITableViewCellSelectionStyleNone;
    return newcell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     if (self.chatype==Single_chat) {
         ContactdetailViewController *push=[[ContactdetailViewController alloc] init];
         push.userinfo=self.dataArray[indexPath.row];
         push.ismyfriend=YES;
         [tableView deselectRowAtIndexPath:indexPath animated:NO];
         [self.navigationController pushViewController:push animated:YES];
         return;
     }
     else{
         RCDGroupInfo *model=self.dataArray[indexPath.row];
         if ([model.creatorId isEqualToString:RCLOUD_ID]) {
             MycreatGroupdetailViewController *pushview=[[MycreatGroupdetailViewController alloc] init];
             pushview.GroupInfo=model;
             [self.navigationController pushViewController:pushview animated:YES];
         }
         else{
             GroupsdetailViewController *pushview=[[GroupsdetailViewController alloc] init];
             pushview.GroupInfo=model;
             [self.navigationController pushViewController:pushview animated:YES];
         }
         
         return;
     }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return CGFLOAT_MIN;
    }
    else if (section==1){
        return CGFLOAT_MIN;
    }
    return 0.1*KWidth_Scale;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footview=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 13*KWidth_Scale)];
    footview.backgroundColor=CellBackgroundColor;
    if (section!=2) {
        return [UIView new];
    }
    return [UIView new];
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *backview=[[UIView alloc] initWithFrame:CGRectMake(0, 0*KWidth_Scale, SCREEN_WIDTH, 50*KWidth_Scale)];
    backview.backgroundColor=[UIColor whiteColor];
    UILabel *nametitle=[PublicFunction getlabelwithtexttitle:@"聊天" fram:CGRectMake(15*KWidth_Scale,0, SCREEN_WIDTH*0.5, 50*KWidth_Scale) cornerRadius:0 textcolor:WordsofcolorColor textfont:DefleFuont backcolor:[UIColor whiteColor] textAlignment:NSTextAlignmentLeft];
    [backview
     addSubview:nametitle];
    UIView *cellview=[[UIView alloc] initWithFrame:CGRectMake(0, 50*KWidth_Scale, SCREEN_WIDTH, 0.7*KWidth_Scale)];
    cellview.backgroundColor=CellBackgroundColor;
    [backview addSubview:cellview];
    return [UIView new];
}
#pragma mark - UISearchBarDelegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    self.changestatuscolor=YES;
    [[WooSearchmanger shareInstance] begintosearch:self navi:self.searchNavigationController search:Addfread_search];
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
