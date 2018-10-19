
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
#import "MycreatGroupdetailViewController.h"
#import "GroupsdetailViewController.h"
#import "StrangecommunityViewController.h"
#import "MadeSureViewController.h"
#import "WooHMeetingModel.h"
#import "CopyrightViewController.h"
#import "WooHEducateModel.h"
#import "CopyrigDetailViewController.h"
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
        NSArray *titarr=[[NSArray alloc] initWithObjects:@"找群",@"找人",@"找看点",@"找会议",@"找教育", nil];
        if (self.searchtype==Seatch_self_addsomeone) {
            titarr=[[NSArray alloc] initWithObjects:@"找群",@"找人", nil];
        }
         CGFloat with=(SCREEN_WIDTH-50*KWidth_Scale-(titarr.count-1)*15*KWidth_Scale)/titarr.count;
        for (int i=0; i<titarr.count; i++) {
            UIButton *tapBtn=[UIButton buttonWithType:UIButtonTypeCustom];
            tapBtn.frame=CGRectMake(25*KWidth_Scale+i*15*KWidth_Scale+with*i, CGRectGetMaxY(label.frame)+15*KWidth_Scale, with, 30*KWidth_Scale);
            [tapBtn setTitle:titarr[i] forState:UIControlStateNormal];
            [tapBtn setTitleColor:NaviBackgroundColor forState:UIControlStateNormal];
            tapBtn.tag=TAG_SELF+i;
            [tapBtn addTarget:self action:@selector(tapclick:) forControlEvents:UIControlEventTouchUpInside];
            [tapBtn.titleLabel setFont:UIFont(13)];
            [_topview addSubview:tapBtn];
        }
    }
    return _topview;
}
-(void)tapclick:(UIButton *)sender
{
    NSInteger tag=sender.tag-TAG_SELF;
    if (tag==0) {
        self.searchtype=Seatch_content_shequn;
        self.searchBar.placeholder=@"搜索社群";
    }
    else if (tag==1){
        self.searchtype=Seatch_content_friend;
        self.searchBar.placeholder=@"搜索好友";
    }
    else if (tag==2){
        self.searchtype=Seatch_content_whacth;
        self.searchBar.placeholder=@"搜索看点";
    }
    else if (tag==3){
        self.searchtype=Seatch_content_meeting;
        self.searchBar.placeholder=@"搜索会议";
    }
    else{
        self.searchtype=Seatch_content_education;
        self.searchBar.placeholder=@"搜索教育";
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
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}
-(void)loadrequest
{
    [self.view endEditing:YES];
    [self.topview removeFromSuperview];
    WEAKSELF;
    //[self showhudmessage:@"群成员加载中..." ];
    NSMutableDictionary *parametDic = [NSMutableDictionary dictionaryWithCapacity:9];
    [parametDic setObject:self.searchBar.text forKey:@"crewId"];
    [parametDic setObject:RCLOUD_ID forKey:@"userId"];
    [UserRequestToo shareInstance].rquesturl=SearchSomeGroup;
    [UserRequestToo shareInstance].params=parametDic;
    [[UserRequestToo shareInstance] statrrequestgetwith:MHAsiNetWorkGET successBlock:^(id returnData) {
        [weakSelf dismiss];
        if (returnData[@"success"]) {
         
        }
    } failureBlock:^(NSError *error) {
        [self dismiss];
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.line.hidden=YES;
    self.searchBar.delegate = self;
    [self.headerView addSubview:self.searchBar];
    self.myTableView.tableHeaderView = self.headerView;
    [self addcanbtn];
    [self.searchBar becomeFirstResponder];
    if (self.searchtype==Seatch_self_allviews||self.searchtype==Seatch_self_addsomeone) {
        [self.myTableView addSubview:self.topview];
    }
    if (self.searchtype==begin_search_frien) {
        self.searchBar.placeholder=@"搜索好友";
    }
    else if (self.searchtype==begin_search_group) {
        self.searchBar.placeholder=@"搜索社群";
    }
    else if (self.searchtype==Seatch_self_groupmember) {
        self.searchBar.placeholder=@"搜索群成员";
    }
}
#pragma mark tableview的代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.searchlist.count;
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
    return 45*KWidth_Scale;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *mycellid=@"SearchTableViewCell";
    SearchTableViewCell *newcell=[tableView dequeueReusableCellWithIdentifier:mycellid];
    if (newcell==nil) {
        newcell=[[SearchTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:mycellid];
    }
    newcell.textLabel.textColor=RGB(51, 51, 51);
    newcell.textLabel.font=UIFont(15);
    newcell.detailTextLabel.textColor=[PublicFunction colorWithHexString:@"#666666"];
    if (self.searchtype==begin_search_frien||self.searchtype==Seatch_content_friend||self.searchtype==Seatch_self_groupmember) {
        RCDUserInfo *info=self.searchlist[indexPath.row];
        newcell.namelabel.attributedText=[self settextcolor:info.name];
        if (![PublicFunction isEmpty:info.displayName]) {
         newcell.namelabel.attributedText=[self settextcolor:info.displayName];
        }
        [newcell.avimage sd_setImageWithURL:[NSURL URLWithString:info.portraitUri] placeholderImage:[UIImage imageNamed:@"photo_boy"]];
    }
    else if (self.searchtype==begin_search_group||self.searchtype==Seatch_content_shequn)
    {
        RCDGroupInfo *info=self.searchlist[indexPath.row];
        if (![PublicFunction isEmpty:info.groupName]) {
            newcell.namelabel.attributedText=[self settextcolor:info.groupName];
        }
        [newcell.avimage sd_setImageWithURL:[NSURL URLWithString:info.portraitUri] placeholderImage:[UIImage imageNamed:@"photo_boy"]];
    }
    if (self.searchtype==Seatch_content_whacth) {
        Watchobject *object =self.searchlist[indexPath.row];
        newcell.textLabel.attributedText=[self settextcolor:object.title];
        newcell.detailTextLabel.attributedText=[self settextcolor:[NSString stringWithFormat:@"%@   %@   %@",object.userName,object.createTime,object.readNum]];
        //title=@"搜索看点结果";
    }
    else if (self.searchtype==Seatch_content_meeting)
    {
        WooHMeetingModel *modle=self.searchlist[indexPath.row];
        
        newcell.textLabel.attributedText=[self settextcolor:modle.mName];
        newcell.detailTextLabel.attributedText=[self settextcolor:modle.mAddress];
        //title=@"搜索会议结果";
    }
    else if (self.searchtype==Seatch_content_education)
    {
        WooHEducateModel *model=self.searchlist[indexPath.row];
        newcell.textLabel.attributedText=[self settextcolor:model.eTitle];
        newcell.detailTextLabel.attributedText=[self settextcolor:model.eSyIntro];
        //title=@"搜索会议结果";
    }
    newcell.selectionStyle=UITableViewCellSelectionStyleNone;
    return newcell;
}
-(NSMutableAttributedString *)settextcolor:(NSString *)showLabel
{
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:showLabel];
     NSRange range;
    //判断字符串中有没有回复
    if([showLabel rangeOfString:self.searchBar.text].location !=NSNotFound){
        range = [showLabel rangeOfString:self.searchBar.text];
        [AttributedStr addAttribute:NSForegroundColorAttributeName
           value:NaviBackgroundColor
          range:NSMakeRange(range.location, range.length)];
    }
    else{//没有回复那就默认判断审核
        range = [showLabel rangeOfString:self.searchBar.text];
        [AttributedStr addAttribute:NSForegroundColorAttributeName
            value:NaviBackgroundColor
            range:NSMakeRange(range.location, range.length)];
    }
    return AttributedStr;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.searchtype==Seatch_self_allviews) {
        if ([PublicFunction isEmpty:self.searchBar.text]) {
            [self showInfoWithStatus:@"请输入搜索内容"];
            return;
        }
    }
    if (self.searchtype==begin_search_frien) {
        ContactdetailViewController *contact=[[ContactdetailViewController alloc] init];
        contact.userinfo=self.searchlist[indexPath.row];
        contact.ismyfriend=YES;
        [self.navigationController pushViewController:contact animated:YES];
        //title=@"搜索好友结果";
    }
    else if (self.searchtype==Seatch_content_friend||self.searchtype==Seatch_self_groupmember)
    {
        [self getFriendRelationship:self.searchlist[indexPath.row]];
        //全局好友搜索
    }
    else if (self.searchtype==begin_search_group)
    {
        MycreatGroupdetailViewController *pushview=[[MycreatGroupdetailViewController alloc] init];
        pushview.GroupInfo=self.searchlist[indexPath.row];
        [self.navigationController pushViewController:pushview animated:YES];
        //title=@"搜索群组结果";
    }
    else if (self.searchtype==Seatch_content_shequn)
    {
        [self pushgroupdetail:self.searchlist[indexPath.row]];
        //全局群组搜索
    }
    else if (self.searchtype==Seatch_content_meeting)
    {
        WooHMeetingModel *model = [self.searchlist objectAtIndex:indexPath.row];
        CopyrightViewController *singVC = [[CopyrightViewController alloc]init];
        singVC.mId = [NSString stringWithFormat:@"%@", model.mId];
        [self.navigationController pushViewController:singVC animated:YES];
        //title=@"搜索会议结果";
    }
    else if (self.searchtype==Seatch_content_education)
    {
        WooHEducateModel *model = self.searchlist[indexPath.row];
        CopyrigDetailViewController *educateVC = [[CopyrigDetailViewController alloc]init];
        educateVC.eId = [NSString stringWithFormat:@"%@", model.eId];
        [self.navigationController pushViewController:educateVC animated:YES];
        //title=@"搜索会议结果";
    }

}
#pragma mark 获取群组关系
-(void)pushgroupdetail:(RCDGroupInfo *)groups
{
    if (groups.isCrewMember) {
        if ([groups.creatorId isEqualToString:RCLOUD_ID]) {
            MycreatGroupdetailViewController *pushview=[[MycreatGroupdetailViewController alloc] init];
            pushview.GroupInfo=groups;
            [self.navigationController pushViewController:pushview animated:YES];
        }
        else{
            GroupsdetailViewController *pushview=[[GroupsdetailViewController alloc] init];
            pushview.GroupInfo=groups;
            [self.navigationController pushViewController:pushview animated:YES];
        }
        
    }
    else{
        StrangecommunityViewController *push=[[StrangecommunityViewController alloc] init];
        push.groups=groups;
        [self.navigationController pushViewController:push animated:NO];
    }
}
#pragma mark 获取好友关系
-(void)getFriendRelationship:(RCDUserInfo *)model
{
    WEAKSELF;
    //[self showhudmessage:@"群成员加载中..." ];
    NSMutableDictionary *parametDic = [NSMutableDictionary dictionaryWithCapacity:9];
    [parametDic setObject:RCLOUD_ID forKey:@"mid"];
    [parametDic setObject:model.userId forKey:@"fid"];
    [UserRequestToo shareInstance].rquesturl=getfriendRelationshipRequrl;
    [UserRequestToo shareInstance].params=parametDic;
    [[UserRequestToo shareInstance] statrrequestgetwith:MHAsiNetWorkGET successBlock:^(id returnData) {
        [weakSelf dismiss];
        if (returnData[@"success"]) {
            ContactdetailViewController *contact=[[ContactdetailViewController alloc] init];
            contact.userinfo=model;
            if([returnData[@"status"] isEqualToString:@"200"]) {
                NSDictionary *dic=returnData[@"data"];
                if ([dic[@"isFriend"] isEqual:@1]) {
                    contact.ismyfriend=YES;
                    [self.navigationController pushViewController:contact animated:YES];
                    return ;
                }
                else{
                    contact.ismyfriend=NO;
                    [self.navigationController pushViewController:contact animated:YES];
                    return;
                }
            }
        }
    } failureBlock:^(NSError *error) {
        [self dismiss];
    }];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.searchlist.count==0) {
        return 0.0;
    }
    return 50*KWidth_Scale;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headview=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50*KWidth_Scale)];
    headview.backgroundColor=[PublicFunction colorWithHexString:@"f0f0f0"];
    NSString *title;
    if (self.searchtype==begin_search_frien) {
        title=@"    搜索好友结果";
    }
    else if (self.searchtype==Seatch_content_friend)
    {
        title=@"    找人搜索结果";
    }
    else if (self.searchtype==begin_search_group)
    {
        title=@"    搜索群组结果";
    }
    else if (self.searchtype==Seatch_content_shequn)
    {
        title=@"    找群搜索结果";
    }
    else if (self.searchtype==Seatch_content_whacth) {
        title=@"    搜索看点结果";
    }
    else if (self.searchtype==Seatch_content_meeting)
    {
        title=@"    搜索会议结果";
    }
    else if (self.searchtype==Seatch_content_education)
    {
        title=@"    搜索教育结果";
    }
    else if (self.searchtype==Seatch_content_education)
    {
        title=@"    搜索群成员结果";
    }
    UILabel *nametitle=[PublicFunction getlabelwithtexttitle:title fram:CGRectMake(0,0, SCREEN_WIDTH, 40*KWidth_Scale) cornerRadius:0 textcolor:WordsofcolorColor textfont:DefleFuont backcolor:[UIColor whiteColor] textAlignment:NSTextAlignmentLeft];
    nametitle.backgroundColor=[UIColor whiteColor];
    [headview addSubview:nametitle];
    if (self.searchlist.count==0) {
        return [UIView new];
    }
    return headview;
}
#pragma mark - UISearchBarDelegate
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    if (self.searchtype==Seatch_self_allviews) {
       [self showInfoWithStatus:@"请输入指定内容进行搜索"];
        return;
    }
    else if ([PublicFunction isEmptystr:self.searchBar.text]) {
         [self showInfoWithStatus:@"请输入搜索内容"];
        return;
    }
    [self.searchlist removeAllObjects];
    if (self.searchtype==begin_search_frien) {
        self.searchlist=[[RCDataBaseManager shareInstance] getfriendlistMember:self.searchBar.text];
        if(self.searchlist.count==0)
        {
            [self.myTableView showEmptyViewWithType:1];
            [self.myTableView reloadData];
        }
        else{
            [self.myTableView removeEmptyView];
            [self.myTableView reloadData];
        }
        //title=@"搜索好友结果";
    }
    else if (self.searchtype==Seatch_content_friend)
    {
        [self seartchFriend];
         //全局好友搜索
    }
    else if (self.searchtype==begin_search_group)
    {
        self.searchlist=[[RCDataBaseManager shareInstance]  getGroups:self.searchBar.text];
        if(self.searchlist.count==0)
        {
            [self.myTableView showEmptyViewWithType:1];
            [self.myTableView reloadData];
        }
        else{
            [self.myTableView removeEmptyView];
            [self.myTableView reloadData];
        }
        //title=@"搜索群组结果";
    }
    else if (self.searchtype==Seatch_content_shequn)
    {
        [self searctchGroup];
        //全局群组搜索
    }
    else if (self.searchtype==Seatch_content_whacth) {
        [self searctwatch];
        //title=@"搜索看点结果";
    }
    else if (self.searchtype==Seatch_content_meeting)
    {
        [self searctmetting];
        //title=@"搜索会议结果";
    }
    else if (self.searchtype==Seatch_content_education){
         [self searctedication];
    }
    else if (self.searchtype==Seatch_self_groupmember){
        [self searcgroupmember];
    }
   // [self loadrequest];
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
#pragma mark 搜索好友
-(void)seartchFriend
{
    WEAKSELF;
    [self.dataArray removeAllObjects];
    [self showWithStatus:@"搜索加载中..." ];
    NSMutableDictionary *parametDic = [NSMutableDictionary dictionaryWithCapacity:9];
    [parametDic setObject:self.searchBar.text forKey:@"query"];
    [UserRequestToo shareInstance].rquesturl=SearchFriendRequesturl;
    [UserRequestToo shareInstance].params=parametDic;
    [[UserRequestToo shareInstance] statrrequestgetwith:MHAsiNetWorkGET successBlock:^(id returnData) {
        [weakSelf dismiss];
        if (returnData[@"success"]) {
            
            if([returnData[@"status"] isEqualToString:@"200"]) {
                NSArray *datalist=returnData[@"data"];
                //顺序遍历
                [datalist enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    NSDictionary *dic=(NSDictionary *)obj;
                    RCDUserInfo *model=[[RCDUserInfo alloc] init];
                    model.name=dic[@"name"];
                    model.sex=[NSString stringWithFormat:@"%@",dic[@"sex"]];
                    model.signature=dic[@"brief"];
                    model.displayName=dic[@"nickname"];
                    model.userId=dic[@"userId"];
                    model.portraitUri=dic[@"urlPhoto"];
                    [self.searchlist addObject:model];
                    //局部section刷新
                   
                }];
                if(self.searchlist.count==0)
        {
            [self.myTableView showEmptyViewWithType:1];
        }
        else{
            [self.myTableView removeEmptyView];
        }
        [self.myTableView reloadData];
            }
        }
        else{
            [self showErrorWithStatus:returnData[@"message"] ];
        }
    } failureBlock:^(NSError *error) {
        [self dismiss];
        [self showErrorWithStatus:@"群成员获取失败" ];
    }];
}
#pragma mark 搜索群组
-(void)searctchGroup
{
    WEAKSELF;
    [self.dataArray removeAllObjects];
    [self showWithStatus:@"搜索加载中..." ];
    NSMutableDictionary *parametDic = [NSMutableDictionary dictionaryWithCapacity:9];
    [parametDic setObject:self.searchBar.text forKey:@"query"];
    [UserRequestToo shareInstance].rquesturl=SearchallgroupRequesturl;
    [UserRequestToo shareInstance].params=parametDic;
    [[UserRequestToo shareInstance] statrrequestgetwith:MHAsiNetWorkGET successBlock:^(id returnData) {
        [weakSelf dismiss];
        if (returnData[@"success"]) {
            
            if([returnData[@"status"] isEqualToString:@"200"]) {
                NSArray *datalist=returnData[@"data"];
                //顺序遍历
                [datalist enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    NSDictionary *dic=(NSDictionary *)obj;
                    RCDGroupInfo *model;
                    model = [[RCDGroupInfo alloc] init];
                    model.groupId = dic[@"cid"];
                    model.groupName = dic[@"name"];
                    model.portraitUri = dic[@"urlPhoto"];
                    model.number = dic[@"num"];
                    model.introduce = dic[@"brief"];
                    model.creatorId = dic[@"uid"];
                    model.creatorTime = dic[@"createTime"];
                    model.isJoin = dic[@"isCrewMember"];
                    model.qrcode = dic[@"qrcode"];
                    model.pub = dic[@"pub"];
                    [self.searchlist addObject:model];
                }];
                if(self.searchlist.count==0)
        {
            [self.myTableView showEmptyViewWithType:1];
        }
        else{
            [self.myTableView removeEmptyView];
        }
        [self.myTableView reloadData];
            }
        }
        else{
            [self showErrorWithStatus:returnData[@"message"] ];
        }
    } failureBlock:^(NSError *error) {
        [self dismiss];
        [self showErrorWithStatus:@"群成员获取失败" ];
    }];
}
#pragma mark 搜索会议
-(void)searctmetting
{
    WEAKSELF;
    [self.dataArray removeAllObjects];
    [self showWithStatus:@"搜索加载中..." ];
    NSMutableDictionary *parametDic = [NSMutableDictionary dictionaryWithCapacity:9];
    [parametDic setObject:self.searchBar.text forKey:@"query"];
    [UserRequestToo shareInstance].rquesturl=SearchmeetingRequesturl;
    [UserRequestToo shareInstance].params=parametDic;
    [[UserRequestToo shareInstance] statrrequestgetwith:MHAsiNetWorkGET successBlock:^(id returnData) {
        [weakSelf dismiss];
        if (returnData[@"success"]) {
            
            if([returnData[@"status"] isEqualToString:@"200"]) {
                NSArray *datalist=returnData[@"data"];
                //顺序遍历
                [datalist enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    NSDictionary *dic=(NSDictionary *)obj;
                    WooHMeetingModel *model = [WooHMeetingModel mj_objectWithKeyValues:dic];
                    [self.searchlist addObject:model];
                }];
                if(self.searchlist.count==0)
        {
            [self.myTableView showEmptyViewWithType:1];
        }
        else{
            [self.myTableView removeEmptyView];
        }
        [self.myTableView reloadData];
            }
        }
        else{
            [self showErrorWithStatus:returnData[@"message"] ];
        }
    } failureBlock:^(NSError *error) {
        [self dismiss];
        [self showErrorWithStatus:@"群成员获取失败" ];
    }];
}

#pragma mark 搜索教育
-(void)searctedication
{
    WEAKSELF;
    [self.dataArray removeAllObjects];
    [self showWithStatus:@"搜索加载中..." ];
    NSMutableDictionary *parametDic = [NSMutableDictionary dictionaryWithCapacity:9];
    [parametDic setObject:self.searchBar.text forKey:@"query"];
    [UserRequestToo shareInstance].rquesturl=SearchalledicationRequesturl;
    [UserRequestToo shareInstance].params=parametDic;
    [[UserRequestToo shareInstance] statrrequestgetwith:MHAsiNetWorkGET successBlock:^(id returnData) {
        [weakSelf dismiss];
        if (returnData[@"success"]) {
            
            if([returnData[@"status"] isEqualToString:@"200"]) {
                NSArray *datalist=returnData[@"data"];
                //顺序遍历
                [datalist enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    NSDictionary *dic=(NSDictionary *)obj;
                    WooHEducateModel *model = [WooHEducateModel mj_objectWithKeyValues:dic];
                    [self.searchlist addObject:model];
                }];
        if(self.searchlist.count==0)
        {
            [self.myTableView showEmptyViewWithType:1];
        }
        else{
            [self.myTableView removeEmptyView];
        }
        [self.myTableView reloadData];
            }
        }
        else{
            [self showErrorWithStatus:returnData[@"message"] ];
        }
    } failureBlock:^(NSError *error) {
        [self dismiss];
        [self showErrorWithStatus:@"群成员获取失败" ];
    }];
}
#pragma mark 搜索群成员
-(void)searcgroupmember
{
    NSString *searchString = [self.searchBar text];
    //NSPredicate 多个条件查询
    NSPredicate *p1 = [NSPredicate predicateWithFormat:@"userId CONTAINS[c] %@",
                       searchString];
    NSPredicate *p2 = [NSPredicate predicateWithFormat:@"SELF.name CONTAINS[c] %@",searchString];
    NSPredicate *p3 = [NSPredicate predicateWithFormat:@"SELF.displayName CONTAINS[c] %@",searchString];
    if (self.searchlist!= nil) {
        [self.searchlist removeAllObjects];
    }
    //过滤数据
    NSMutableArray *onearray= [NSMutableArray arrayWithArray:[self.dataArray filteredArrayUsingPredicate:p1]];
    NSMutableArray *twoarray= [NSMutableArray arrayWithArray:[self.dataArray filteredArrayUsingPredicate:p2]];
     NSMutableArray *threearray= [NSMutableArray arrayWithArray:[self.dataArray filteredArrayUsingPredicate:p3]];
    [self.searchlist addObjectsFromArray:onearray];
    [self.searchlist addObjectsFromArray:twoarray];
    [self.searchlist addObjectsFromArray:threearray];
    //如果SELF.DiscussionName和SELF.userName是同一个人的名字，那么就会造成searchList里面出现两个重复的人，此时我们就需要移除数组中重复的数据了。而用nsset的allObjects则不会返回重复的元素。
    NSSet *set = [NSSet setWithArray:self.searchlist];
    self.searchlist=[NSMutableArray arrayWithArray:[set allObjects]];
    [self.myTableView reloadData];
    //刷新表格
}
#pragma mark 搜索看点
-(void)searctwatch
{
    WEAKSELF;
    [self.dataArray removeAllObjects];
    [self showWithStatus:@"搜索加载中..." ];
    NSMutableDictionary *parametDic = [NSMutableDictionary dictionaryWithCapacity:9];
    [parametDic setObject:self.searchBar.text forKey:@"query"];
    [UserRequestToo shareInstance].rquesturl=SearchwatchRequesturl;
    [UserRequestToo shareInstance].params=parametDic;
    [[UserRequestToo shareInstance] statrrequestgetwith:MHAsiNetWorkGET successBlock:^(id returnData) {
        [weakSelf dismiss];
        if (returnData[@"success"]) {
            
            if([returnData[@"status"] isEqualToString:@"200"]) {
                NSArray *datalist=returnData[@"data"];
                //顺序遍历
                [datalist enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    NSDictionary *dic=(NSDictionary *)obj;
                    Watchobject *object=[[Watchobject alloc] init];
                    [object setValuesForKeysWithDictionary:dic];
                    object.createTime=dic[@"createDate"];
                    [self.searchlist addObject:object];
                }];
                
        if(self.searchlist.count==0)
        {
            [self.myTableView showEmptyViewWithType:1];
        }
        else{
            [self.myTableView removeEmptyView];
        }
        [self.myTableView reloadData];
    }
        }
        else{
            [self showErrorWithStatus:returnData[@"message"] ];
        }
    } failureBlock:^(NSError *error) {
        [self dismiss];
        [self showErrorWithStatus:@"群成员获取失败" ];
    }];
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
