//
//  MycreatGroupdetailViewController.m
//  Woo
//
//  Created by 王起锋 on 2018/8/7.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import "MycreatGroupdetailViewController.h"
#import "MLSearchBar.h"
#import "Gropudetailheadview.h"
#import "SetGrouptViewController.h"
#import "GroupMemberInfo.h"
#import "ContactdetailViewController.h"
#import "FriendTableViewCell.h"
@interface MycreatGroupdetailViewController ()
<UITableViewDelegate,UITableViewDataSource,SearchViewDelegate,UISearchBarDelegate,SelectContactViewDelegate>
@property (nonatomic, strong)  BaseTableView * myTableView;
@property (nonatomic, strong)  NSArray * titlearr;
@property (nonatomic, strong)  UIImageView * erweimashow;
@property (nonatomic, strong)  UISwitch * shieldingswitch;
@property(nonatomic, strong) MLSearchBar *searchBar;
@property(nonatomic,strong)WooBaseNavigationViewController *searchNavigationController;
@end

@implementation MycreatGroupdetailViewController

- (MLSearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar =
        [[MLSearchBar alloc]initWithFrame:CGRectMake(90,8*KWidth_Scale, self.view.frame.size.width-90-65, 35*KWidth_Scale) boardColor:NaviBackgroundColor placeholderString:@"请输入关键词搜索"];
        _searchBar.delegate=self;
        UITextField * searchField = [_searchBar valueForKey:@"_searchField"];
        [searchField setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
        [searchField setValue:[UIFont boldSystemFontOfSize:14*KWidth_Scale] forKeyPath:@"_placeholderLabel.font"];
    }
    return _searchBar;
}
- (UISwitch *)shieldingswitch
{
    if (_shieldingswitch==nil) {
        _shieldingswitch=[[UISwitch alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-15-50, 7, 40, 20)];
        _shieldingswitch.onTintColor = NaviBackgroundColor;
        //缩小或者放大switch的size
        //        _shieldingswitch.transform = CGAffineTransformMakeScale(0.8, 0.8);
        //        _shieldingswitch.layer.anchorPoint = CGPointMake(0,0.5);
        //tintColor 关状态下的背景颜色
        //        _shieldingswitch.tintColor = NaviBackgroundColor;
        //        //onTintColor 开状态下的背景颜色
        [[RCIMClient sharedRCIMClient] getConversationNotificationStatus:ConversationType_GROUP targetId:self.GroupInfo.groupId success:^(RCConversationNotificationStatus nStatus) {
            if (nStatus==DO_NOT_DISTURB) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    // UI更新代码
                    [_shieldingswitch setOn:YES];
                });
               
            }
            else{
                // 3.GCD
                dispatch_async(dispatch_get_main_queue(), ^{
                    // UI更新代码
                    [_shieldingswitch setOn:NO];
                });
                
            }
           
        } error:^(RCErrorCode status) {
            
        }];
        [_shieldingswitch addTarget:self action:@selector(setchatmessagetstatus:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _shieldingswitch;
}

-(void)setchatmessagetstatus:(UISwitch *)selfswitch
{
    [[RCIMClient sharedRCIMClient] setConversationNotificationStatus:ConversationType_GROUP targetId:self.GroupInfo.groupId isBlocked:selfswitch.isOn success:^(RCConversationNotificationStatus nStatus) {
        
    } error:^(RCErrorCode status) {
        
    }];
     
}

-(UIImageView *)erweimashow
{
    if (_erweimashow==nil) {
        _erweimashow=[[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-15-30, 11, 20, 20)];
        _erweimashow.image=[UIImage imageNamed:@"erweima"];
    }
    return _erweimashow;
}
-(void)getGroupMember
{
    WEAKSELF;
    [self.dataArray removeAllObjects];
    [self showhudmessage:@"群成员加载中..." offy:-100];
    NSMutableDictionary *parametDic = [NSMutableDictionary dictionaryWithCapacity:9];
    [parametDic setObject:self.GroupInfo.groupId forKey:@"crewId"];
    [UserRequestToo shareInstance].rquesturl=GroupsMembersRequrl;
    [UserRequestToo shareInstance].params=parametDic;
    [[UserRequestToo shareInstance] statrrequestgetwith:MHAsiNetWorkGET successBlock:^(id returnData) {
        [weakSelf.myTableView.mj_header endRefreshing];
        [weakSelf hideHud];
        if (returnData[@"success"]) {
            if([returnData[@"status"] isEqualToString:@"200"]) {
                NSArray *datalist=returnData[@"data"];
                //顺序遍历
                [datalist enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    NSDictionary *dic=(NSDictionary *)obj;
                    RCDUserInfo *model=[[RCDUserInfo alloc] init];
                    model.displayName=dic[@"name"];
                    model.userId=dic[@"uid"];
                    model.portraitUri=dic[@"photo"];
                    model.userId=dic[@"uid"];
                    [self.dataArray addObject:model];
                    //局部section刷新
                    NSIndexSet * indexnd=[[NSIndexSet alloc]initWithIndex:1];//刷新第二个section
                    [self.myTableView reloadSections:indexnd withRowAnimation:UITableViewRowAnimationAutomatic];
                }];
            }
        }
        else{
            [self showAlertHud:self.view.center withStr:returnData[@"message"] offy:-100];
        }
    } failureBlock:^(NSError *error) {
        [weakSelf.myTableView.mj_header endRefreshing];
        [self hideHud];
        [self showAlertHud:self.view.center withStr:@"群成员获取失败" offy:-100];
    }];
}
-(void)setnavigation
{
    UIButton *  rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setTitle:@"聊天" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(tochat) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.frame = CGRectMake(SCREEN_WIDTH - 45, 25, 20, 20);
    UIBarButtonItem *right=[[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem=right;
}
-(void)tochat
{
     [[ChatmangerObject ShareManger] gotoChatViewtargetid:self.GroupInfo.groupId convertitle:self.GroupInfo.groupName conversationModelType:ConversationType_GROUP fromview:self];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self settableviewheadview];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setnavigation];
    [self getGroupMember];
    self.changestatuscolor=NO;
    self.title=@"社群详情";
    self.titlearr=[[NSArray alloc] initWithObjects:@"群二维码",@"屏蔽群消息",@"邀请好友",@"信息设置",@"解散社群", nil];
    [self.myTableView reloadData];
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
-(void)settableviewheadview
{
    CGFloat heightY=[Gropudetailheadview getmyheight:[NSString stringWithFormat:@"      %@",self.GroupInfo.introduce]];
    Gropudetailheadview *headview=[[Gropudetailheadview alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, heightY) withgroupmodel:self.GroupInfo];
    [self.myTableView setTableHeaderView:headview];
}
#pragma mark tableview的代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return self.titlearr.count;
    }
    return self.dataArray.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 44;
    }
    return 55*KWidth_Scale;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *mycellid=@"FriendTableViewCell";
     FriendTableViewCell*newcell=[tableView dequeueReusableCellWithIdentifier:mycellid];
    if (newcell==nil) {
        newcell=[[FriendTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:mycellid];
    }
    if (indexPath.section==0) {
        newcell.textLabel.text=self.titlearr[indexPath.row];
        newcell.textLabel.textColor=WordsofcolorColor;
        newcell.textLabel.font=UIFont(15);
        if (indexPath.row==0) {
            [newcell addSubview:self.erweimashow];
        }
        else if (indexPath.row==1){
            [newcell addSubview:self.shieldingswitch];
        }
    }
    else{
        RCDUserInfo *model=self.dataArray[indexPath.row];
        [newcell.userimageview sd_setImageWithURL:[NSURL URLWithString:model.portraitUri] placeholderImage:[UIImage imageNamed:@"pgoto_girl"]];
        newcell.celltitlable.text=model.displayName;
        newcell.celltitlable.text=model.userId;
        newcell.celltitlable.textColor=RGB(153, 153, 153);
    }
    newcell.celltitlable.font=DefleFuont;
    newcell.selectionStyle = UITableViewCellSelectionStyleNone;
    newcell.accessoryType = UITableViewCellAccessoryNone;
    return newcell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 8*KWidth_Scale;
    }
    else{
        return 58*KWidth_Scale;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==0) {
        return 0.01;
    }
    return 40*KWidth_Scale;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headview=[[UIView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, 8*KWidth_Scale)];
    headview.backgroundColor=CellBackgroundColor;
    
    if (section==0) {
        return headview;
    }
    return [self getheadview];
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footview=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40*KWidth_Scale)];
    UIButton *sele=[PublicFunction getbtnwithtexttitle:@"更多成员" fram:CGRectMake(0, 0, SCREEN_WIDTH, 40*KWidth_Scale) cornerRadius:0 textcolor:WordsofcolorColor textfont:DefleFuont backcolor:[UIColor whiteColor]];
    [sele setTitleEdgeInsets:UIEdgeInsetsMake(0, 15*KWidth_Scale, 0, SCREEN_WIDTH*0.3 )];
     sele.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [sele addTarget:sele action:@selector(showmore) forControlEvents:UIControlEventTouchUpInside];
    [footview addSubview:sele];
    
    if (section==1) {
        if (self.dataArray.count>5) {
             return footview;
        }
        else{
             return [UIView new];
        }
    }
    return [UIView new];
}
-(void)showmore
{
    return;
}
-(UIView *)getheadview
{
    UIView *headview1=[[UIView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, 58*KWidth_Scale)];
    headview1.backgroundColor=[UIColor whiteColor];
    UIView *topview=[[UIView alloc] initWithFrame:CGRectMake(0, -1,SCREEN_WIDTH, 8*KWidth_Scale)];
    topview.backgroundColor=CellBackgroundColor;
    [headview1 addSubview:topview];
    UIView *botomo=[[UIView alloc] initWithFrame:CGRectMake(0, 8*KWidth_Scale,SCREEN_WIDTH, 50*KWidth_Scale)];
    botomo.backgroundColor=[UIColor whiteColor];
    UILabel *title=[PublicFunction getlabelwithtexttitle:@"社群成员" fram:CGRectMake(15, 8*KWidth_Scale, 90*KWidth_Scale, 35*KWidth_Scale) cornerRadius:0 textcolor:WordsofcolorColor textfont:DefleFuont backcolor:[UIColor whiteColor] textAlignment:NSTextAlignmentLeft];
    UIView *cell=[[UIView alloc] initWithFrame:CGRectMake(0, 58*KWidth_Scale, SCREEN_WIDTH, 0.7)];
    cell.backgroundColor=CellBackgroundColor;
    [botomo addSubview:title];
    [botomo addSubview:self.searchBar];
    [headview1 addSubview:botomo];
    //[headview1 addSubview:cell];
    return headview1;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.section==0) {
        if (indexPath.row==0) {
                Showerwimaview *show=[[Showerwimaview alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) groupInfo:self.GroupInfo];
                [show customeviewShow];
            [self.view endEditing:YES];
            }
        else if (indexPath.row==2){
            SelectContactViewController *control=[[SelectContactViewController alloc] init];
            control.type=ADD_FRIEND;
            control.delegate=self;
            [self.navigationController pushViewController:control animated:YES];
        }
       else if (indexPath.row==4) {
           NSString  *title=@"解散此群将会清除所有成员并所有资料将会丢失.确定要解散此群?";
           CustAlertview *alert=[[CustAlertview alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) title:@"注意" detailstr:title];
           [alert shareviewShow];
           [alert setMyblock:^{
               [self dissolutionGroup];
           }];
            return;
        }
        else if (indexPath.row==3){
            SetGrouptViewController *push=[[SetGrouptViewController alloc] init];
            push.froupmodel=self.GroupInfo;
            [self.navigationController pushViewController:push animated:YES];
        }
    }
    else{
        if (self.dataArray.count!=0) {
           [self getFriendRelationship:self.dataArray[indexPath.row]];
        }
    }
}
-(void)getFriendRelationship:(RCDUserInfo *)model
{
    WEAKSELF;
    //[self showhudmessage:@"群成员加载中..." offy:-100];
    NSMutableDictionary *parametDic = [NSMutableDictionary dictionaryWithCapacity:9];
    [parametDic setObject:RCLOUD_ID forKey:@"mid"];
    [parametDic setObject:model.userId forKey:@"fid"];
    [UserRequestToo shareInstance].rquesturl=getfriendRelationshipRequrl;
    [UserRequestToo shareInstance].params=parametDic;
    [[UserRequestToo shareInstance] statrrequestgetwith:MHAsiNetWorkGET successBlock:^(id returnData) {
        [weakSelf hideHud];
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
        else{
          [self showAlertHud:self.view.center withStr:returnData[@"message"] offy:-100];
        }
    } failureBlock:^(NSError *error) {
        [self hideHud];
    }];
}
-(void)dissolutionGroup
{
    WEAKSELF;
    [self.dataArray removeAllObjects];
    [self showhudmessage:@"解散群组处理中..." offy:-100];
    NSMutableDictionary *parametDic = [NSMutableDictionary dictionaryWithCapacity:9];
    [parametDic setObject:self.GroupInfo.groupId forKey:@"crewId"];
    [parametDic setObject:RCLOUD_ID forKey:@"ownerId"];
    [UserRequestToo shareInstance].rquesturl=DeletesomeGroup;
    [UserRequestToo shareInstance].params=parametDic;
    [[UserRequestToo shareInstance] statrrequestgetwith:MHAsiNetWorkPOST successBlock:^(id returnData) {
        [weakSelf.myTableView.mj_header endRefreshing];
        [weakSelf hideHud];
        if (returnData[@"success"]) {
            
            if([returnData[@"status"] isEqualToString:@"200"]) {
                [self showAlertHud:self.view.center withStr:@"解散群组成功" offy:-100];
                double delayInSeconds = 1.5;
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    [[RCDataBaseManager shareInstance]deleteGroupToDB:self.GroupInfo.groupId];
                    [self.navigationController popViewControllerAnimated:YES];
//                    for (UIViewController *controller in self.navigationController.viewControllers) {
//                        if ([controller isKindOfClass:[WOOGroupListViewController class]]) {
//                            [self.navigationController popToViewController:controller animated:YES];
//                        }
//                    }
                });
            }
            else{
                [self hideHud];
                [self showAlertHud:self.view.center withStr:returnData[@"message"] offy:-100];
            }
        }
        else{
            [self hideHud];
            [self showAlertHud:self.view.center withStr:returnData[@"message"] offy:-100];
        }
    } failureBlock:^(NSError *error) {
        [self hideHud];
        [self showAlertHud:self.view.center withStr:@"解散群组失败" offy:-100];
    }];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.searchBar resignFirstResponder];
}
#pragma mark - UISearchBarDelegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    SearchViewController *searchViewController = [[SearchViewController alloc] init];
    self.searchNavigationController = [[WooBaseNavigationViewController alloc] initWithRootViewController:searchViewController];
    searchViewController.delegate = self;
    self.changestatuscolor=YES;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [self preferredStatusBarStyle];
    self.tabBarController.tabBar.hidden=YES;
    self.searchNavigationController.navigationBar.barStyle = UIBarStyleDefault;
    searchViewController.searchtype=Addfread_search;
    [self.navigationController.view addSubview:self.searchNavigationController.view];
}
- (void)onSearchCancelClick {
    self.changestatuscolor=NO;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self preferredStatusBarStyle];
    [self.searchBar resignFirstResponder];
    [self.searchNavigationController.view removeFromSuperview];
    [self.searchNavigationController removeFromParentViewController];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)sendThecontacts:(NSMutableArray *)selectedcontacts
{
    [[ChatmangerObject ShareManger] addsomegroup:selectedcontacts fromcontroller:self Groupid:self.GroupInfo.groupId];
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
