
//
//  SearchViewController.m
//  Woo
//
//  Created by 王起锋 on 2018/8/6.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//
#define TAG_SELF 8976
#import "SearchViewController.h"
#import "SearchTableViewCell.h"
#import "MLSearchBar.h"
#import "WooFriendViewController.h"
#import "BaseTableView.h"
@interface SearchViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
@property(nonatomic, strong) UIView *headerView;
@property(nonatomic, strong) MLSearchBar *searchBar;
@property (nonatomic, strong)  NSMutableArray * titlearr;
@property (nonatomic, strong)  BaseTableView * myTableView;
@property(nonatomic, strong) UIButton *cancelButton;
@property(nonatomic,strong)UIView *topview;
@property (nonatomic, strong)  NSMutableArray * searchlist;
@end

@implementation SearchViewController
-(UIView *)topview
{
    if (_topview==nil) {
        _topview=[[UIView alloc] initWithFrame:CGRectMake(0, StatusBarAndNavigationBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _topview.backgroundColor=[UIColor whiteColor];
        UILabel *label=[PublicFunction getlabelwithtexttitle:@"搜索指定内容" fram:CGRectMake(0, 25*KWidth_Scale, SCREEN_WIDTH, 20*KWidth_Scale) cornerRadius:0 textcolor:WordsofcolorColor textfont:UIFont(15) backcolor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter];
        [_topview addSubview:label];
        CGFloat with=(SCREEN_WIDTH-100*KWidth_Scale-3*25*KWidth_Scale)/4.0;
        NSArray *titarr=[[NSArray alloc] initWithObjects:@"社群",@"好友",@"看点",@"会议", nil];
        for (int i=0; i<4; i++) {
            UIButton *tapBtn=[UIButton buttonWithType:UIButtonTypeCustom];
            tapBtn.frame=CGRectMake(50*KWidth_Scale+i*25*KWidth_Scale+with*i, CGRectGetMaxY(label.frame)+15*KWidth_Scale, with, 30*KWidth_Scale);
            [tapBtn setTitle:titarr[i] forState:UIControlStateNormal];
            [tapBtn setTitleColor:NaviBackgroundColor forState:UIControlStateNormal];
            tapBtn.tag=TAG_SELF+i;
            [tapBtn addTarget:self action:@selector(tapclick:) forControlEvents:UIControlEventTouchUpInside];
            [tapBtn.titleLabel setFont:UIFont(15)];
            [_topview addSubview:tapBtn];
        }
    }
    return _topview;
}
-(void)tapclick:(UIButton *)sender
{
    NSInteger tag=sender.tag-TAG_SELF;
    if (tag==0) {
        self.searchcontenttype=Seatch_content_shequn;
        self.searchBar.placeholder=@"搜索社群";
    }
    else if (tag==1){
        self.searchcontenttype=Seatch_content_friend;
        self.searchBar.placeholder=@"搜索好友";
    }
    else if (tag==2){
        self.searchcontenttype=Seatch_content_whacth;
        self.searchBar.placeholder=@"搜索看点";
    }
    else if (tag==3){
        self.searchcontenttype=Seatch_content_meeting;
        self.searchBar.placeholder=@"搜索会议";
    }
    [self.topview removeFromSuperview];
}
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
    _myTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _myTableView.delegate=self;
        _myTableView.dataSource = self;
        _myTableView.showsVerticalScrollIndicator = NO;
        _myTableView.showsHorizontalScrollIndicator = NO;
        [_myTableView setTableFooterView:[UIView new]];
        _myTableView.backgroundColor=CellBackgroundColor;
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
    self.navigationController.navigationBar.barTintColor = [PublicFunction colorWithHexString:@"0099ff"];
}
-(void)loadrequest
{
    [self.view endEditing:YES];
    [self.topview removeFromSuperview];
    WEAKSELF;
    //[self showhudmessage:@"群成员加载中..." offy:-100];
    NSMutableDictionary *parametDic = [NSMutableDictionary dictionaryWithCapacity:9];
    [parametDic setObject:self.searchBar.text forKey:@"crewId"];
    [parametDic setObject:RCLOUD_ID forKey:@"userId"];
    [UserRequestToo shareInstance].rquesturl=SearchSomeGroup;
    [UserRequestToo shareInstance].params=parametDic;
    [[UserRequestToo shareInstance] statrrequestgetwith:MHAsiNetWorkGET successBlock:^(id returnData) {
        [weakSelf hideHud];
        if (returnData[@"success"]) {
         
        }
    } failureBlock:^(NSError *error) {
        [self hideHud];
    }];
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
    if (self.searchtype==Seatch_allviews) {
        self.searchcontenttype=Seatch_content_all;
        [self.myTableView addSubview:self.topview];
    }
}
#pragma mark tableview的代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.searchtype==Seatch_allviews) {
        return self.searchlist.count;
    }
    else if (self.searchtype ==Addfread_search)
    {
        return 2;
    }
    else{
        return self.searchlist.count;
    }
    return self.searchlist.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
        if (self.searchcontenttype==Seatch_content_all) {
            if (self.searchlist.count!=0) {
                return 4;
            }
            else{
                return 0;
            }
           
        }
        else if (self.searchtype==Addfread_search)
        {
            return 1;
        }
        else return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45*KWidth_Scale;
   
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *mycellid=@"SearchTableViewCell";
    SearchTableViewCell *newcell=[tableView dequeueReusableCellWithIdentifier:mycellid];
    if (newcell==nil) {
        newcell=[[SearchTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:mycellid];
    }
    newcell.textLabel.textColor=RGB(102, 102, 102);
    newcell.textLabel.font=DefleFuont;
    newcell.textLabel.text=self.titlearr[indexPath.row];
    newcell.accessoryType = UITableViewCellAccessoryNone;
    if (self.searchtype==Addfread_search) {
        if (indexPath.row==0) {
            newcell.imageView.image=[UIImage imageNamed:@"me_Image"];
        }
        else{
             newcell.imageView.image=[UIImage imageNamed:@"friend_Image"];
        }
       
    }
    newcell.selectionStyle=UITableViewCellSelectionStyleNone;
    return newcell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.searchtype==Addfread_search) {
        if ([PublicFunction isEmpty:self.searchBar.text]) {
            [self showAlertHud:self.view.center withStr:@"请输入搜索内容" offy:-100];
            return;
        }
        else{
            
        }
    }
    else{
        
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.searchtype==Addfread_search) {
        return 0.0;
    }
    return 50*KWidth_Scale;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headview=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50*KWidth_Scale)];
    UILabel *nametitle=[PublicFunction getlabelwithtexttitle:@"搜索结果展示" fram:CGRectMake(15*KWidth_Scale,0, SCREEN_WIDTH*0.5, 50*KWidth_Scale) cornerRadius:0 textcolor:WordsofcolorColor textfont:DefleFuont backcolor:[UIColor whiteColor] textAlignment:NSTextAlignmentLeft];
    [headview addSubview:nametitle];
    return headview;
}
#pragma mark - UISearchBarDelegate
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    ZKLog(@"开始进行搜索");
    //群组搜索
    [self loadrequest];
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    //    [self.navigationController setNavigationBarHidden:YES animated:YES];
    //    RCDSearchViewController *searchViewController = [[RCDSearchViewController alloc] init];
    //    self.searchNavigationController = [[UINavigationController alloc] initWithRootViewController:searchViewController];
    //    searchViewController.delegate = self;
    //    [self.navigationController.view addSubview:self.searchNavigationController.view];
}
- (void)cancelButtonClicked {
    if ([self.delegate respondsToSelector:@selector(onSearchCancelClick)]) {
        [self.delegate onSearchCancelClick];
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
