//
//  SelectfriendViewController.m
//  Woo
//
//  Created by 王起锋 on 2018/8/15.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import "SelectfriendViewController.h"
#import "MLSearchBar.h"
#import "SelectTableViewCell.h"
@interface SelectfriendViewController ()
<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
@property(nonatomic, strong) UIView *headerView;
@property(nonatomic, strong) MLSearchBar *searchBar;
@property (nonatomic, strong)  NSMutableArray * titlearr;
@property (nonatomic, strong)  BaseTableView * myTableView;
@property(nonatomic, strong) UIButton *cancelButton;
@end

@implementation SelectfriendViewController

-(NSMutableArray *)searchlist
{
    if (_searchlist==nil) {
        _searchlist=[[NSMutableArray alloc] init];
    }
    return _searchlist;
}
- (MLSearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar =
        [[MLSearchBar alloc]initWithFrame:CGRectMake(15,[UIApplication sharedApplication].statusBarFrame.size.height, self.view.frame.size.width-65, 40) boardColor:NaviBackgroundColor placeholderString:@"请输入关键字"];
        UITextField * searchField = [_searchBar valueForKey:@"_searchField"];
        [searchField setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
        [searchField setValue:[UIFont boldSystemFontOfSize:14*KWidth_Scale] forKeyPath:@"_placeholderLabel.font"];
        
    }
    return _searchBar;
}
- (UIView *)headerView {
    if (!_headerView) {
        _headerView =
        [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 56+[UIApplication sharedApplication].statusBarFrame.size.height)];
        UIView * cellline=[[UIView alloc] initWithFrame:CGRectMake(0, 56+[UIApplication sharedApplication].statusBarFrame.size.height-1, SCREEN_WIDTH, 1.0)];
        cellline.backgroundColor=[PublicFunction colorWithHexString:@"f0f0f0"];
        [_headerView addSubview:cellline];
        _headerView.backgroundColor=[PublicFunction colorWithHexString:@"0xf0f0f6"];
    }
    return _headerView;
}
-(BaseTableView *)myTableView{
    if (!_myTableView) {
        _myTableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        //_myTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _myTableView.delegate=self;
        _myTableView.dataSource = self;
        _myTableView.showsVerticalScrollIndicator = NO;
        _myTableView.showsHorizontalScrollIndicator = NO;
        [_myTableView setTableFooterView:[UIView new]];
        _myTableView.backgroundColor=[UIColor whiteColor];
        _myTableView.separatorColor=CellBackgroundColor;
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
-(void)addcanbtn
{
    _cancelButton = [[UIButton alloc]
                     initWithFrame:CGRectMake(CGRectGetMaxX(_searchBar.frame) - 3, CGRectGetMinY(self.searchBar.frame), 55, 40)];
    [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [_cancelButton setTitleColor:NaviBackgroundColor forState:UIControlStateNormal];
    _cancelButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [_cancelButton addTarget:self action:@selector(cancelButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [_headerView addSubview:_cancelButton];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    self.line.hidden=YES;
    self.titlearr=[[NSMutableArray alloc] initWithObjects:@"朋友",@"社群", nil];
    self.searchBar.delegate = self;
    [self.headerView addSubview:self.searchBar];
    self.myTableView.tableHeaderView = self.headerView;
    [self addcanbtn];
    [self.searchBar becomeFirstResponder];
    [self.myTableView reloadData];
    // Do any additional setup after loading the view.
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
    return 0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50*KWidth_Scale;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WEAKSELF;
    static NSString *mycellid=@"SelectTableViewCell";
    SelectTableViewCell *newcell=[tableView dequeueReusableCellWithIdentifier:mycellid];
    if (newcell==nil) {
        newcell=[[SelectTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:mycellid];
    }
    RCDUserInfo *userinfo =self.dataArray[indexPath.row];
    newcell.celltitlable.text=userinfo.displayName;
    if ([PublicFunction isEmpty:userinfo.displayName]) {
     newcell.celltitlable.text=userinfo.name;
    }
    newcell.celltitlable.textColor=WordsofcolorColor;
    newcell.celltitlable.font=DefleFuont;
    [newcell.userimageview sd_setImageWithURL:[NSURL URLWithString:userinfo.portraitUri] placeholderImage:[UIImage imageNamed:@"pgoto_girl"]]; newcell.selectionStyle=UITableViewCellSelectionStyleNone;
    newcell.accessoryType = UITableViewCellAccessoryNone;
    if (self.searchlist.count!=0) {
        [self.searchlist containsObject:userinfo];
        newcell.selectBtn.selected=YES;
    }
    [newcell setMyblock:^(BOOL selectstatus) {
        if (selectstatus) {
            [weakSelf.searchlist addObject:userinfo];
        }
        else{
            [self.searchlist enumerateObjectsUsingBlock:^( RCDUserInfo* obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj.userId isEqualToString:userinfo.userId]) {
                    [self.searchlist removeObjectAtIndex:idx];
                }
            }];
        }
        if (self.searchlist.count==0) {
           [self.cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        }
        else{
            [self.cancelButton setTitle:@"完成" forState:UIControlStateNormal];
        }
        
    }];
    return newcell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50*KWidth_Scale;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headview=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50*KWidth_Scale)];
    headview.backgroundColor=[UIColor whiteColor];
    UILabel *nametitle=[PublicFunction getlabelwithtexttitle:@"搜索结果展示" fram:CGRectMake(15*KWidth_Scale,0, SCREEN_WIDTH*0.5, 50*KWidth_Scale) cornerRadius:0 textcolor:WordsofcolorColor textfont:DefleFuont backcolor:[UIColor whiteColor] textAlignment:NSTextAlignmentLeft];
    [headview addSubview:nametitle];
    return headview;
}
#pragma mark - UISearchBarDelegate
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    self.dataArray=[[RCDataBaseManager shareInstance] getfriendlistMember:self.searchBar.text];
    [self.myTableView reloadData];
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    //    [self.navigationController setNavigationBarHidden:YES animated:YES];
    //    RCDSearchViewController *searchViewController = [[RCDSearchViewController alloc] init];
    //    self.searchNavigationController = [[UINavigationController alloc] initWithRootViewController:searchViewController];
    //    searchViewController.delegate = self;
    //    [self.navigationController.view addSubview:self.searchNavigationController.view];
}
- (void)cancelButtonClicked {
    if ([self.SearchViewDelegate respondsToSelector:@selector(SelectfriendCancelClick:)]) {
        [self.SearchViewDelegate SelectfriendCancelClick:self.searchlist];
    }
    [self.searchBar resignFirstResponder];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.searchBar resignFirstResponder];
    [self.view endEditing:YES];
}
-(UIImage *)getImageWithColor:(UIColor *)color andHeight:(CGFloat)height {
    CGRect r = CGRectMake(0.0f, 0.0f, 1.0f, height);
    UIGraphicsBeginImageContext(r.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, r);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
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
