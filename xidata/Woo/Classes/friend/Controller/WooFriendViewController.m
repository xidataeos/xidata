//
//  WooFriendViewController.m
//  Woo
//
//  Created by 风外杏林香 on 2018/7/25.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import "WooFriendViewController.h"
#import "friendsectionview.h"
#import "HomeViewSubjectCell.h"
#import "WOOGroupListViewController.h"
#import "MyfriendlistViewController.h"
#import "StrangecommunityViewController.h"
#import "MessagetoremindWooViewController.h"
#import "MycreatGroupdetailViewController.h"
#import "GroupsdetailViewController.h"
@interface WooFriendViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,SelectContactViewDelegate,UISearchBarDelegate,SearchViewDelegate>

@property(nonatomic, strong) RCDSearchBar *searchBar;
@property(nonatomic, strong) UIView *headerView;
@property (nonatomic, strong)  BaseTableView * myTableView;
@property (nonatomic, strong)  NSMutableArray * titlearr;
@property (nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)NSMutableArray  *cllectionlist;
@end

@implementation WooFriendViewController
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
-(NSMutableArray *)cllectionlist
{
    if (_cllectionlist==nil) {
        _cllectionlist=[[NSMutableArray alloc] init];
    }
    return _cllectionlist;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self setnavigation];
    [self badgeValue];
    [self loadlist];
}
-(void)badgeValue
{
    //初始化配置信息
    JMConfig *config = [JMConfig config];
    //因为config是单例,在demo工程中需要重新设置图片大小, 在实际应用中不用设置该属性(因为尺寸会有默认值)
    dispatch_async(dispatch_get_main_queue(), ^{
        //- (int)getTotalUnreadCount:(NSArray<RCConversation *> *)conversations;
        int count=[[RCIMClient sharedRCIMClient] getUnreadCount:@[ @(ConversationType_GROUP),@(ConversationType_PRIVATE)]];
        if (count==0) {
            config.animType = JMConfigBadgeAnimTypeScale;
            [config hideBadgeAtIndex:2];
        }
        else{
            config.animType = JMConfigBadgeAnimTypeScale;
            if (count>99) {
                [config showNumberBadgeValue:[NSString stringWithFormat:@"99+"] AtIndex:2];
            }
            else{
                [config showNumberBadgeValue:[NSString stringWithFormat:@"%d",count] AtIndex:2];
            }
        }
    });
}

- (void)viewDidLoad {
    self.isnosetfbackbtn=YES;
    [super viewDidLoad];
    self.titlearr=[[NSMutableArray alloc] initWithObjects:@"好友",@"社群", nil];
    self.searchBar.delegate = self;
    [self.headerView addSubview:self.searchBar];
    self.myTableView.tableHeaderView = self.headerView;
}
-(void)loadlist
{
    WEAKSELF;
    [self.dataArray removeAllObjects];
    //[self showhudmessage:@"热门社群加载中..." offy:-100];
    NSMutableDictionary *parametDic = [NSMutableDictionary dictionaryWithCapacity:9];
    [UserRequestToo shareInstance].rquesturl=getHotgroupsRequrl;
    [UserRequestToo shareInstance].params=parametDic;
    [[UserRequestToo shareInstance] statrrequestgetwith:MHAsiNetWorkGET successBlock:^(id returnData) {
        [weakSelf dismiss];
        if (returnData[@"success"]) {
            
            if([returnData[@"status"] isEqualToString:@"200"]) {
                NSArray *datalist=returnData[@"data"];
                //顺序遍历
                [datalist enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    NSDictionary *dic=(NSDictionary *)obj;
                    RCDGroupInfo *model=[[RCDGroupInfo alloc] init];
                    model.introduce=dic[@"brief"];
                    model.portraitUri=dic[@"urlPhoto"];
                    model.groupId=dic[@"cid"];
                    model.groupName=dic[@"name"];
                    model.creatorId=dic[@"uid"];
                    model.creatorTime=dic[@"createTime"];
                    model.number=[NSString stringWithFormat:@"%@",dic[@"num"]];
                    model.qrcode=dic[@"qrcode"];
                    model.pub=[NSString stringWithFormat:@"%@",dic[@"pub"]];
                    [self.dataArray addObject:model];
                    [self.collectionView reloadData];
                }];
            }
        }
        else{
            [self showErrorWithStatus:returnData[@"message"]];
        }
    } failureBlock:^(NSError *error) {
        [self dismiss];
        [self showErrorWithStatus:@"热门社群获取失败"];
    }];
    
}
-(UICollectionView *)collectionView
{
    if (_collectionView==nil) {
        UICollectionViewFlowLayout *fallLayout=[[UICollectionViewFlowLayout alloc]init];
        fallLayout.scrollDirection=  UICollectionViewScrollDirectionVertical;
        fallLayout.minimumInteritemSpacing=0;
        fallLayout.minimumLineSpacing=0;
        fallLayout.sectionInset = UIEdgeInsetsMake(1*KWidth_Scale, 1*KWidth_Scale, 1*KWidth_Scale, 1*KWidth_Scale);
        _collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-90*KWidth_Scale-24*KWidth_Scale-50*KWidth_Scale-TabbarHeight) collectionViewLayout:fallLayout];
        // 注册header
        //[_collectionView registerClass:[HeaderCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderCollectionReusableView"];
        [_collectionView registerClass:[HomeViewSubjectCell class] forCellWithReuseIdentifier:@"HomeViewSubjectCell"];
        _collectionView.dataSource=self;
        _collectionView.delegate=self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor=[UIColor whiteColor];
        
    }
    return _collectionView;
}

-(void)setnavigation
{
    int count=[[RCIMClient sharedRCIMClient] getUnreadCount:@[@(ConversationType_SYSTEM)]];
    UIButton *  rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    if (count<=0) {
        [rightBtn setImage:[UIImage imageNamed:@"xiaoxi"]  forState:UIControlStateNormal];
    }
    else{
         [rightBtn setImage:[UIImage imageNamed:@"xiaoxi_select"]  forState:UIControlStateNormal];
    }
    [rightBtn addTarget:self action:@selector(setBtnClick) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.frame = CGRectMake(SCREEN_WIDTH, 25, 45, 45);
    [rightBtn setImageEdgeInsets:UIEdgeInsetsMake(7, 20, 7, 0)];
    UIBarButtonItem *right=[[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem=right;
}
#pragma mark
-(void)setBtnClick
{
    MessagetoremindWooViewController *contrl=[[MessagetoremindWooViewController alloc] init];
    [self.navigationController pushViewController:contrl animated:YES];
}
-(BaseTableView *)myTableView{
    if (!_myTableView) {
        _myTableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-TabbarHeight-StatusBarAndNavigationBarHeight) style:UITableViewStylePlain];
        //_myTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _myTableView.delegate=self;
        _myTableView.dataSource = self;
        _myTableView.showsVerticalScrollIndicator = NO;
        _myTableView.showsHorizontalScrollIndicator = NO;
        [_myTableView setTableFooterView:[UIView new]];
        _myTableView.separatorColor=CellBackgroundColor;
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
    if (section==0) {
        return self.titlearr.count;
    }
    else{
        return 1;
    }
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 55*KWidth_Scale;
    }
    return ScreenHeight-90*KWidth_Scale-24*KWidth_Scale-50*KWidth_Scale-TabbarHeight;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *mycellid=@"cellid";
    UITableViewCell *newcell=[tableView dequeueReusableCellWithIdentifier:mycellid];
    if (newcell==nil) {
        newcell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:mycellid];
    }
    if (indexPath.section==0) {
        newcell.textLabel.textColor=RGB(102, 102, 102);
        newcell.textLabel.font=DefleFuont;
    newcell.textLabel.text=self.titlearr[indexPath.row];
        newcell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else{
        [newcell addSubview:self.collectionView];
        //[self.collectionView reloadData];
    }
    newcell.selectionStyle = UITableViewCellSelectionStyleNone;
    return newcell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 1*KWidth_Scale;
    }
    else return 62*KWidth_Scale;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *backview=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1*KWidth_Scale)];
    backview.backgroundColor=RGB(238, 238, 238);
    
    UIView *backview1=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 62*KWidth_Scale)];
    backview1.backgroundColor=RGB(238, 238, 238);
    friendsectionview *headview=[[friendsectionview alloc] initWithFrame:CGRectMake(0, 12*KWidth_Scale, ScreenWidth, 50*KWidth_Scale)];
    headview.titlelable.text=@"热门社群";
    [backview1 addSubview:headview];
    if (section==0) {
        return backview;
    }
    return backview1;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MyfriendlistViewController *push=[[MyfriendlistViewController alloc] init];
    WOOGroupListViewController *group=[[WOOGroupListViewController alloc] init];
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            [self.navigationController pushViewController:push animated:YES];
        }
        else{
            [self.navigationController pushViewController:group animated:YES];
        }
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark---加载UICollectionViewDataSource
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifierOne=@"HomeViewSubjectCell";
    HomeViewSubjectCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifierOne forIndexPath:indexPath];
    RCDGroupInfo *model=self.dataArray[indexPath.row];
    cell.groupmodel=model;
    cell.backgroundColor=[UIColor whiteColor];
    return cell;
}
#pragma mark-section
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
#pragma mark-item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    RCDGroupInfo *group =  self.dataArray[indexPath.row];
    [self getgroupnvate:group.groupId model:group];
}
-(void)getgroupnvate:(NSString *)groupid model:(RCDGroupInfo *)model
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
    }];
}
//这个是两行cell之间的间距（上下行cell的间距）
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section;
{
    return 0*KWidth_Scale;
}

//两个cell之间的间距（同一行的cell的间距）
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 1*KWidth_Scale;
}
//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(SCREEN_WIDTH/3.0-3, SCREEN_WIDTH/3.0-3-20*KWidth_Scale);
}
#pragma mark SelectContactViewDelegate
-(void)sendThecontacts:(NSMutableArray *)selectedcontacts
{
    [[ChatmangerObject ShareManger] cgreatGroupwith:selectedcontacts fromview:self];
}
#pragma mark - UISearchBarDelegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [self tosearchview:Seatch_self_allviews];
}
-(void)tosearchview:(SearchType)type
{
    [self.navigationController setNavigationBarHidden:YES animated:NO];
     [[WooSearchmanger shareInstance] begintosearch:self navi:self.searchNavigationController search:type];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.searchBar resignFirstResponder];
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
