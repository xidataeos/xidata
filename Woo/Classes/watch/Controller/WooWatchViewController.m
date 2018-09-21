
//
//  WatchViewController.m
//  Woo
//
//  Created by 王起锋 on 2018/8/2.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import "WooWatchViewController.h"
#import "WatchdetailViewController.h"
#import "WatchoneTableViewCell.h"
#import "WatchtwoTableViewCell.h"
#import "WatchthreeTableViewCell.h"
#import "WooSearchmanger.h"
#import "StrangecommunityViewController.h"
#import "MycreatGroupdetailViewController.h"
#import "GroupsdetailViewController.h"
@interface WooWatchViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,SelectContactViewDelegate,UISearchBarDelegate,SearchViewDelegate>
{
    int pagenum;
}
@property(nonatomic, strong) RCDSearchBar *searchBar;
@property(nonatomic,strong)CustAlertview *selfalert;
@property(nonatomic, strong) UIView *headerView;
@property (nonatomic, strong)  BaseTableView * myTableView;

@end

@implementation WooWatchViewController
- (RCDSearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar =
        [[RCDSearchBar alloc] initWithFrame:CGRectMake(0, 0, self.myTableView.frame.size.width, 44)];
        _searchBar.delegate=self;
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
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
}
- (void)viewDidLoad {
    self.isnosetfbackbtn=YES;
    [super viewDidLoad];
    [self setnavigation];
     pagenum=1;
    [self.myTableView reloadData];
    self.searchBar.delegate = self;
    [self.headerView addSubview:self.searchBar];
    self.myTableView.tableHeaderView = self.headerView;
    [self loadrequest];
    //[self updateimage];
    // Do any additional setup after loading the view.
}
-(void)loadrequest
{
    WEAKSELF;
    [self.dataArray removeAllObjects];
    [self showhudmessage:@"数据加载中..." offy:-100];
    NSMutableDictionary *parametDic = [NSMutableDictionary dictionaryWithCapacity:9];
    [parametDic setObject:[NSNumber numberWithInt:pagenum] forKey:@"pageNum"];
    [UserRequestToo shareInstance].rquesturl=getWatcRequrl;
    [UserRequestToo shareInstance].params=parametDic;
        [[UserRequestToo shareInstance] statrrequestgetwith:MHAsiNetWorkGET successBlock:^(id returnData) {
        [weakSelf.myTableView.mj_header endRefreshing];
        [weakSelf hideHud];
//            [weakSelf showAlertHud:weakSelf.view.center withStr:@"已没有更多数据" offy:-100];
//            return ;
        if (returnData[@"success"]) {
            NSMutableArray *data=returnData[@"data"];
            if (data.count>0) {
                for (int i=0; i<data.count; i++) {
                    NSDictionary *dic =data[i];
                    Watchobject *object=[[Watchobject alloc] init];
                    [object setValuesForKeysWithDictionary:dic];
                    
                    [weakSelf.dataArray addObject:object];
                }
                if (weakSelf.dataArray.count!=0) {
                dispatch_async(dispatch_get_main_queue(), ^{
                         [weakSelf.myTableView reloadData];
                    });
                }
            }
        }
        else{
            [weakSelf.myTableView.mj_header endRefreshing];
            [self showAlertHud:self.view.center withStr:@"数据获取失败" offy:-100];
        }
    } failureBlock:^(NSError *error) {
        [weakSelf.myTableView.mj_header endRefreshing];
        [self hideHud];
        [self showAlertHud:self.view.center withStr:@"数据获取失败" offy:-100];
    }];
    
}
-(void)updateimage
{
    NSMutableDictionary *parametDic = [[NSMutableDictionary alloc] init];
    NSData *dataImage = UIImageJPEGRepresentation([UIImage imageNamed:@"erweima"], 1.0);
    //生成签名
    [parametDic setValue:dataImage forKey:@"file"];
    WQUploadParam *loadimag=[[WQUploadParam alloc] init];
    loadimag.data=dataImage;
    loadimag.name=@"file";
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0),^{

        [AfnetHttpsTool uploadFileWithURL:@"http://192.168.50.1:8080/user/test1" params:parametDic successBlock:^(id returnData) {
            [self hideHud];
            if ([returnData[@"retcode"]isEqual:@1000]) {
                
            }
            else if ([returnData[@"retcode"]isEqual:@3510]){
         
            }
            else{
                [self showAlertHud:self.view.center withStr:returnData[@"retmsg"] offy:-200];
                
            }
        } failureBlock:^(NSError *error) {
            [self hideHud];
            if (error) {
                return ;
            }
        } uploadParam:loadimag];
        
    });
}
-(void)creatMjRefresh{
    
    MJRefreshNormalHeader *narmalHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadrequest];
        [self.myTableView reloadData];
    }];
    self.myTableView.mj_header = narmalHeader;
}
-(BaseTableView *)myTableView{
    if (!_myTableView) {
        _myTableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-StatusBarAndNavigationBarHeight-TabbarHeight) style:UITableViewStyleGrouped];
    _myTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _myTableView.delegate=self;
        _myTableView.dataSource = self;
        _myTableView.showsVerticalScrollIndicator = NO;
        _myTableView.showsHorizontalScrollIndicator = NO;
        [_myTableView setTableFooterView:[UIView new]];
        _myTableView.separatorColor=CellBackgroundColor;
        _myTableView.backgroundColor=BackcolorColor;
        if (@available(iOS 11.0, *)) {
            _myTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _myTableView.estimatedRowHeight = 0;
            _myTableView.estimatedSectionFooterHeight = 0;
            _myTableView.estimatedSectionHeaderHeight = 0;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        [self creatMjRefresh];
        [self.view  addSubview:_myTableView];
    }
    return _myTableView;
}
-(void)setnavigation
{
    UIButton *  rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setImage:[UIImage imageNamed:@"jiahao"]  forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(setBtnClick) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.frame = CGRectMake(SCREEN_WIDTH, 25, 45, 45);
    [rightBtn setImageEdgeInsets:UIEdgeInsetsMake(7, 20, 7, 0)];
    UIBarButtonItem *right=[[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem=right;
}
#pragma mark
-(void)setBtnClick
{
    WEAKSELF;
    NSArray *titles = @[@"扫一扫",@"创建社群",@"添加好友/社群"];
    
    MLMenuView *menuView = [[MLMenuView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 110 - 10, 0, 110, 40 * 4) WithTitles:titles WithImageNames:nil WithMenuViewOffsetTop:StatusBarAndNavigationBarHeight WithTriangleOffsetLeft:90 triangleColor:RGBAColor(255, 255, 255, 1.0)];
    [menuView setCoverViewBackgroundColor:RGBAColor(255, 255, 255, 0.1)];
    [menuView setSeparatorOffSet:0];
    menuView.separatorColor = RGBAColor(151, 151, 151,0.2);
    [menuView setMenuViewBackgroundColor:RGBAColor(255, 255, 255, 1.0)];
    menuView.layer.shadowOpacity = 0.4f;
    menuView.layer.shadowColor=[UIColor blackColor].CGColor;
    menuView.layer.shadowOffset=CGSizeMake(2, 2);
    menuView.titleColor =  WordsofcolorColor;
    menuView.didSelectBlock = ^(NSInteger index) {
        if (index==1) {
            SelectContactViewController *control=[[SelectContactViewController alloc] init];
            control.delegate=self;
            [self.navigationController pushViewController:control animated:YES];
        }
        else if (index==2){
            [self tosearchview:Addfread_search];
        }
        else if (index==0){
            HCScanQRViewController *scan = [[HCScanQRViewController alloc]init];
            //调用此方法来获取二维码信息
            [scan successfulGetQRCodeInfo:^(NSString *QRCodeInfo) {
                if(![QRCodeInfo containsString:@"wowo"]) {
                    return ;
                }
                NSArray *arr=[QRCodeInfo componentsSeparatedByString:@","];
                if ([arr[1] isEqualToString:@"0"]) {
                    [self getFriendRelationship:[arr lastObject]];
                }
                else{
                    [self getgroupnvate:[arr lastObject]];
                }
                return ;
            }];
            [self.navigationController pushViewController:scan animated:YES];
        }
        ZKLog(@"%zd",index);
    };
    [menuView showMenuEnterAnimation:MLAnimationStyleNone];
}
-(void)getFriendRelationship:(NSString *)fid
{
    WEAKSELF;
    //[self showhudmessage:@"群成员加载中..." offy:-100];
    NSMutableDictionary *parametDic = [NSMutableDictionary dictionaryWithCapacity:9];
    [parametDic setObject:RCLOUD_ID forKey:@"mid"];
    [parametDic setObject:fid forKey:@"fid"];
    [UserRequestToo shareInstance].rquesturl=getfriendRelationshipRequrl;
    [UserRequestToo shareInstance].params=parametDic;
    [[UserRequestToo shareInstance] statrrequestgetwith:MHAsiNetWorkGET successBlock:^(id returnData) {
        [weakSelf hideHud];
        if (returnData[@"success"]) {
            RCDUserInfo *userinfomodel=[[RCDUserInfo alloc] init];
            ContactdetailViewController *contact=[[ContactdetailViewController alloc] init];
            NSDictionary *dic=returnData[@"data"];
            userinfomodel.name=dic[@"name"];
            userinfomodel.userId=fid;
            userinfomodel.displayName=dic[@"nickname"];
            userinfomodel.signature=dic[@"brief"];
            userinfomodel.portraitUri=dic[@"photo"];
            userinfomodel.sex=[NSString stringWithFormat:@"%@",dic[@"sex"]];
            contact.userinfo=userinfomodel;
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
        [self hideHud];
    }];
}
-(void)getgroupnvate:(NSString *)groupid
{
    NSMutableDictionary *parametDic = [NSMutableDictionary dictionaryWithCapacity:9];
    [parametDic setObject:groupid forKey:@"crewId"];
    [parametDic setObject:RCLOUD_ID forKey:@"userId"];
    [UserRequestToo shareInstance].rquesturl=SearchSomeGroup;
    [UserRequestToo shareInstance].params=parametDic;
    [[UserRequestToo shareInstance] statrrequestgetwith:MHAsiNetWorkGET successBlock:^(id returnData) {
        if (returnData[@"success"]) {
            RCDGroupInfo *groups=[[RCDGroupInfo alloc] init];
            NSDictionary *dic = returnData[@"data"];
            groups.introduce=dic[@"brief"];
            groups.portraitUri=dic[@"photo"];
            groups.groupId=dic[@"cid"];
            groups.groupName=dic[@"name"];
            groups.creatorId=dic[@"uid"];
            groups.creatorTime=dic[@"createTime"];
            groups.number=[NSString stringWithFormat:@"%@",dic[@"num"]];
            groups.qrcode=dic[@"qrcode"];
            groups.pub= [NSString stringWithFormat:@"%@",dic[@"pub"]];
            if ([dic[@"isCrewMember"] isEqual:@1]) {
                groups.isCrewMember=YES;
            }
            else{
                groups.isCrewMember=NO;
            }
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
                [self.navigationController pushViewController:push animated:YES];
            }
        }
    } failureBlock:^(NSError *error) {
        [self hideHud];
    }];
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
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160*KWidth_Scale;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *onecellid=@"WatchoneTableViewCell";
    static NSString *twocellid=@"WatchtwoTableViewCell";
    static NSString *threecellid=@"WatchthreeTableViewCell";
    WatchoneTableViewCell *onecell=[tableView dequeueReusableCellWithIdentifier:onecellid];
    WatchtwoTableViewCell *twocell=[tableView dequeueReusableCellWithIdentifier:twocellid];
    WatchthreeTableViewCell *threecell=[tableView dequeueReusableCellWithIdentifier:threecellid];
    Watchobject *model=self.dataArray[indexPath.row];
    if (model.type>=2) {
        NSString *str=[model.img stringByReplacingOccurrencesOfString:@"[" withString:@""];
        NSString *newstr=[str stringByReplacingOccurrencesOfString:@"]" withString:@""];
        onecell=[[WatchoneTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:onecellid datarr:[newstr componentsSeparatedByString:@","]];
    }
    if (twocell==nil) {
        twocell=[[WatchtwoTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:twocellid];
    }
    if (threecell==nil) {
        threecell=[[WatchthreeTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:twocellid];
    }
    onecell.selectionStyle=UITableViewCellSelectionStyleNone;
    twocell.selectionStyle=UITableViewCellSelectionStyleNone;
    threecell.selectionStyle=UITableViewCellSelectionStyleNone;
    if (model.type==0) {
        threecell.model=model;
        return threecell;
    }
    else if (model.type==1){
        twocell.model=model;
        return twocell;
    }
    else{
        onecell.model=model;
        return onecell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 8*KWidth_Scale;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *cell=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 8*KWidth_Scale)];
    cell.backgroundColor=CellBackgroundColor;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    WatchdetailViewController *push=[[WatchdetailViewController alloc] init];
    push.modle=self.dataArray[indexPath.row];
    [self.navigationController pushViewController:push animated:YES];
}
#pragma mark SelectContactViewDelegate
-(void)sendThecontacts:(NSMutableArray *)selectedcontacts
{
    [[ChatmangerObject ShareManger] cgreatGroupwith:selectedcontacts fromview:self];
}
#pragma mark - UISearchBarDelegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    
    [self tosearchview:Seatch_allviews];
}
-(void)tosearchview:(SearchType)type
{
    self.changestatuscolor=YES;
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [[WooSearchmanger shareInstance] begintosearch:self navi:self.searchNavigationController search:type];
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
