//
//  WooHomeViewController.m
//  Woo
//
//  Created by 风外杏林香 on 2018/7/25.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import "WooHomeViewController.h"
#import "allcontentViewController.h"
#import "RadioViewController.h"
#import "TBSegementControl.h"
#import "StrangecommunityViewController.h"
#import "MycreatGroupdetailViewController.h"
#import "GroupsdetailViewController.h"
#import "HomeViewSubjectCell.h"
#import "friendsectionview.h"
#import "HeaderCollectionReusableView.h"
#import "MoreCollectionReusableView.h"
#import "FootCollectionReusableView.h"
#import "allcontentViewController.h"
#import "changCollectionReusableView.h"
#import "CopyrightViewController.h"
#import "madecollectionViewCell.h"
#import "TuwendtailViewController.h"
typedef enum {
    daily_type= 1, //每日精选
    album_tuijian_type //专辑推荐
} PostType;
@interface WooHomeViewController ()<SelectContactViewDelegate,UIScrollViewDelegate,TBSegementControlDelegate, UISearchBarDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
{
    UIScrollView *scroll;
    UIView *view_bar;
    PostType posturltype;
}
@property (nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)NSMutableArray  *cllectionlist;
@property (strong, nonatomic)TBSegementControl *segementView;
@property (nonatomic, strong)RCDSearchBar *searchBar;
@property (nonatomic, strong) NSMutableDictionary *cellDic;
@property (nonatomic, strong) NSMutableArray *everydaylist;
@property (nonatomic, strong) NSMutableArray *tuijianlist;
@property (nonatomic, strong) NSMutableArray *liveList;
@property (nonatomic, strong) NSMutableArray *singlelist;
@property (nonatomic, strong) NSMutableArray *topTitlelist;
@property (nonatomic, strong) NSMutableArray *AlbunClass;
@end

@implementation WooHomeViewController
-(NSMutableArray *)AlbunClass
{
    if (_AlbunClass==nil) {
        _AlbunClass=[[NSMutableArray alloc] init];
    }
    return _AlbunClass;
}
-(NSMutableArray *)topTitlelist
{
    if (_topTitlelist==nil) {
        _topTitlelist=[[NSMutableArray alloc] init];
    }
    return _topTitlelist;
}
-(NSMutableArray *)everydaylist
{
    if (_everydaylist==nil) {
        _everydaylist=[[NSMutableArray alloc] init];
    }
    return _everydaylist;
}
-(NSMutableArray *)tuijianlist
{
    if (_tuijianlist==nil) {
        _tuijianlist=[[NSMutableArray alloc] init];
    }
    return _tuijianlist;
}
-(NSMutableArray *)liveList
{
    if (_liveList==nil) {
        _liveList=[[NSMutableArray alloc] init];
    }
    return _liveList;
}
-(NSMutableArray *)singlelist
{
    if (_singlelist==nil) {
        _singlelist=[[NSMutableArray alloc] init];
    }
    return _singlelist;
}
-(UICollectionView *)collectionView
{
    if (_collectionView==nil) {
        UICollectionViewFlowLayout *fallLayout=[[UICollectionViewFlowLayout alloc]init];
        fallLayout.scrollDirection=  UICollectionViewScrollDirectionVertical;
        fallLayout.minimumInteritemSpacing=0;
        fallLayout.minimumLineSpacing=0;
        fallLayout.sectionInset = UIEdgeInsetsMake(1*KWidth_Scale, 1*KWidth_Scale, 1*KWidth_Scale, 1*KWidth_Scale);
        _collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0,40, SCREEN_WIDTH, SCREEN_HEIGHT-50-TabbarHeight) collectionViewLayout:fallLayout];
        // 注册header
        [_collectionView registerClass:[FootCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FootCollectionReusableView"];
        
        [_collectionView registerClass:[changCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"changCollectionReusableView"];
        
        [_collectionView registerClass:[HeaderCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderCollectionReusableView"];
        [_collectionView registerClass:[MoreCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MoreCollectionReusableView"];
        
        _collectionView.dataSource=self;
        _collectionView.delegate=self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor=[UIColor whiteColor];
        
    }
    return _collectionView;
}

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
    [self tosearchview:Seatch_self_allviews];
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
    self.cellDic = [[NSMutableDictionary alloc] init];
    [super viewDidLoad];
    self.title=@"首页";
    [self setnavitionright];
    [self badgeValue];
    [self.view addSubview:self.collectionView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveMessageNotification:)name:RCKitDispatchMessageNotification
        object:nil];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.searchBar];
    [self gettitleBarUrl];
    [self getList:daily_type];
    [self getList:album_tuijian_type];
    [self getlivelistUrl];
    [self getAllsingleTuijian];
}

- (void)didReceiveMessageNotification:(NSNotification *)notification {
    [self badgeValue];
}
-(void)badgeValue
{
    //初始化配置信息
    JMConfig *config = [JMConfig config];
    //因为config是单例,在demo工程中需要重新设置图片大小, 在实际应用中不用设置该属性(因为尺寸会有默认值)
    
    dispatch_async(dispatch_get_main_queue(), ^{
        int count=[[RCIMClient sharedRCIMClient] getUnreadCount:@[ @(ConversationType_GROUP),@(ConversationType_PRIVATE)]];
        if (count<=0) {
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
    NSArray *titles = @[@"扫一扫",@"创建社群",@"找人/找群"];
    
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
                if(![QRCodeInfo containsString:@"wowo"]) {
                    return ;
                }
                NSArray *arr=[QRCodeInfo componentsSeparatedByString:@","];
                if ([arr[1] isEqualToString:@"0"]) {
                    [self getFriendRelationship:arr[2] scan:scan];
                }
                else{
                    [self getgroupnvate:arr[2] scan:scan];
                }
                return ;
            }];
            [self.navigationController pushViewController:scan animated:YES];
        } else if (index == 1) {
            ZKLog(@"创建社群");
            SelectContactViewController *control=[[SelectContactViewController alloc] init];
            control.delegate=self;
            [self.navigationController pushViewController:control animated:YES];
        } else {
            [self ttosearchview:Seatch_self_addsomeone];
            ZKLog(@"找人/找群");
        }
//        ZKLog(@"%zd",index);
    };
    [menuView showMenuEnterAnimation:MLAnimationStyleNone];
}
-(void)ttosearchview:(SearchType)type
{
    self.changestatuscolor=YES;
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [[WooSearchmanger shareInstance] begintosearch:self navi:self.searchNavigationController search:type];
}
-(void)getFriendRelationship:(NSString *)fid scan:(HCScanQRViewController *)scan
{
    WEAKSELF;
    [[ChatmangerObject ShareManger] getFriendRelationship:fid successBlock:^(id returnData) {
        ContactdetailViewController *contact=[[ContactdetailViewController alloc] init];
        RCDUserInfo *userinfomodel=(RCDUserInfo *)returnData;
        contact.userinfo=userinfomodel;
        if ([userinfomodel.status isEqualToString:@"1"]) {
            contact.ismyfriend=YES;
            [scan popoview];
            [weakSelf.navigationController pushViewController:contact animated:NO];
            return ;
        }
        else{
            [scan popoview];
            contact.ismyfriend=NO;
            [weakSelf.navigationController pushViewController:contact animated:NO];
            return;
        }
    } failureBlock:^(NSError *error) {
        
    }];
}
-(void)getgroupnvate:(NSString *)groupid scan:(HCScanQRViewController *)scan
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
                    [scan popoview];
                    [self.navigationController pushViewController:pushview animated:NO];
                }
                else{
                    GroupsdetailViewController *pushview=[[GroupsdetailViewController alloc] init];
                    pushview.GroupInfo=groups;
                     [scan popoview];
                    [self.navigationController pushViewController:pushview animated:NO];
                }
                
            }
            else{
                StrangecommunityViewController *push=[[StrangecommunityViewController alloc] init];
                push.groups=groups;
                [self.navigationController pushViewController:push animated:NO];
            }
        }
    } failureBlock:^(NSError *error) {
    }];
}

#pragma mark SelectContactViewDelegate
-(void)sendThecontacts:(NSMutableArray *)selectedcontacts
{
    [[ChatmangerObject ShareManger] cgreatGroupwith:selectedcontacts fromview:self];
}
-(void)dealloc{
    //[[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
#pragma mark-表尾尺寸
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayou referenceSizeForFooterInSection:(NSInteger)section
{
    if (section==0) {
        return CGSizeMake(SCREEN_WIDTH, 35*KWidth_Scale);
    }
//    else if (section==1)
//    {
//        return CGSizeMake(SCREEN_WIDTH, 30*KWidth_Scale);
//    }
    else  return CGSizeZero;
}
#pragma mark-表头尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if ([collectionView isEqual:_collectionView]) {
        if (section==0) {
            return CGSizeMake(SCREEN_WIDTH, 200*KWidth_Scale);
        }
        return CGSizeMake(SCREEN_WIDTH,44*KWidth_Scale);
    }
    return CGSizeZero;
}
#pragma mark---加载UICollectionViewDataSource
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *CellIdentifierOne = [_cellDic objectForKey:[NSString stringWithFormat:@"%@", indexPath]];
    // 如果取出的唯一标示符不存在，则初始化唯一标示符，并将其存入字典中，对应唯一标示符注册Cell
    if (CellIdentifierOne == nil) {
        if (indexPath.section!=4) {
            CellIdentifierOne = [NSString stringWithFormat:@"HomeViewSubjectCell%@", [NSString stringWithFormat:@"%@", indexPath]];
            [_cellDic setValue:CellIdentifierOne forKey:[NSString stringWithFormat:@"%@", indexPath]];
            // 注册Cell
            [self.collectionView registerClass:[HomeViewSubjectCell class]  forCellWithReuseIdentifier:CellIdentifierOne];
        }
        else{
            CellIdentifierOne = [NSString stringWithFormat:@"madecollectionViewCell%@", [NSString stringWithFormat:@"%@", indexPath]];
            [_cellDic setValue:CellIdentifierOne forKey:[NSString stringWithFormat:@"%@", indexPath]];
            // 注册Cell
            [self.collectionView registerClass:[madecollectionViewCell class]  forCellWithReuseIdentifier:CellIdentifierOne];
        }
        
    }
    HomeViewSubjectCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifierOne forIndexPath:indexPath];
    if (indexPath.section!=4) {
        cell.index=indexPath;
        if (indexPath.section==0) {
            cell.model=self.topTitlelist[indexPath.row];
        }
        else if (indexPath.section==1)
        {
            cell.model=self.everydaylist[indexPath.row];
        }
        else if (indexPath.section==2)
        {
            cell.model=self.tuijianlist[indexPath.row];
        }
        else if (indexPath.section==3)
        {
            cell.model=self.liveList[indexPath.row];
        }
    }
    madecollectionViewCell *lastcell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifierOne forIndexPath:indexPath];
    if (indexPath.section==4) {
         [lastcell setmoreBtnHide];
        lastcell.submitBtn.hidden=YES;
        lastcell.model=self.singlelist[indexPath.row];
        return lastcell;
    }
    return cell;
}
#pragma mark-section
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 5;
}
#pragma mark-item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section==0) {
        if (self.topTitlelist.count!=0) {
            if (self.topTitlelist.count<8) {
                return self.everydaylist.count;
            }
            return 8;
        }
        return 0;
    }
    else if (section==1){
        if (self.everydaylist.count!=0) {
            if (self.everydaylist.count<4) {
                return self.everydaylist.count;
            }
           return 4;
        }
        return 0;
    }
    else if (section==2){
        if (self.tuijianlist.count!=0) {
            if (self.tuijianlist.count<4) {
                return self.tuijianlist.count;
            }
            return 4;
        }
        return 0;
    }
    else if (section==3){
        if (self.liveList.count!=0) {
            if (self.tuijianlist.count<6) {
                return self.tuijianlist.count;
            }
            return 6;
        }
        return 0;
        
    }
    else{
        if (self.singlelist.count!=0) {
            if (self.singlelist.count<10) {
                return self.singlelist.count;
            }
            return 10;
        }
        return 0;
        
    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    allcontentViewController *allcontent=[[allcontentViewController alloc] init];
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            allcontent.style=contentStyleall;
          [self.navigationController pushViewController:allcontent animated:YES];
        }
        else if (indexPath.row==1)
        {
            allcontent.style=contentStylesingle;
            [self.navigationController pushViewController:allcontent animated:YES];
        }
        else if (indexPath.row==2)
        {
            CopyrightViewController *Radio=[[CopyrightViewController alloc] init];
            [self.navigationController pushViewController:Radio animated:YES];
        }
        else if (indexPath.row==3)
        {
            RadioViewController *Radio=[[RadioViewController alloc] init];
            [self.navigationController pushViewController:Radio animated:YES];
        }
        else{
            HomeModel *model=self.topTitlelist[indexPath.row];
            allcontent.style=contentStyleall;
            allcontent.classid=model.classifyId;
            [self.navigationController pushViewController:allcontent animated:YES];
        }
    }
    else if (indexPath.section==1||indexPath.section==2)
    {
        AlbumdetailsController *albu=[[AlbumdetailsController alloc] init];
        if (indexPath.section==1) {
            albu.AlbumModel=self.everydaylist[indexPath.row];
        }
        else{
            albu.AlbumModel=self.tuijianlist[indexPath.row];
        }
        
        [self.navigationController pushViewController:albu animated:YES];
    }
    else if (indexPath.section==3){
        return;
    }
    else{
        TuwendtailViewController *Tuwendtail=[[TuwendtailViewController alloc] init];
        Tuwendtail.tuwModel=self.singlelist[indexPath.row];
        [self.navigationController pushViewController:Tuwendtail animated:YES];
    }
}
//两个cell之间的间距（同一行的cell的间距）
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 1*KWidth_Scale;
}
//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
       return CGSizeMake(SCREEN_WIDTH/4.0-4, SCREEN_WIDTH/4.0-4+21*KWidth_Scale);
    }
    else if (indexPath.section==1)
    {
       return CGSizeMake(SCREEN_WIDTH/2.0-2, 211*KWidth_Scale);
    }
    else if (indexPath.section==2)
    {
        return CGSizeMake(SCREEN_WIDTH/2.0-2,131*KWidth_Scale);
    }
    else if (indexPath.section==3)
    {
        return CGSizeMake(SCREEN_WIDTH/3.0-3, SCREEN_WIDTH/3.0-3+20*KWidth_Scale);
    }
    return CGSizeMake(SCREEN_WIDTH,80*KWidth_Scale);
}
#pragma mark---加载UICollectionView表头
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([collectionView isEqual:_collectionView]) {
        if ([kind isEqualToString:UICollectionElementKindSectionHeader]) { // header
            NSMutableArray *arr=[[NSMutableArray alloc] initWithObjects:@"https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=751451393,1541025563&fm=27&gp=0.jpg",@"https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=751451393,1541025563&fm=27&gp=0.jpg",@"https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=751451393,1541025563&fm=27&gp=0.jpg", nil];
            if (indexPath.section==0) {
                HeaderCollectionReusableView *reusableView=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"HeaderCollectionReusableView" forIndexPath:indexPath];
                reusableView.data=arr;
               return reusableView;
            }
            else{
                MoreCollectionReusableView *morereusableView=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"MoreCollectionReusableView" forIndexPath:indexPath];
                if (indexPath.section==1) {
                    morereusableView.titlelabel.text=@"每日精选";
                }
                else if (indexPath.section==2)
                {
                    morereusableView.titlelabel.text=@"专辑画推荐";
                }
                else if (indexPath.section==3)
                {
                    morereusableView.titlelabel.text=@"电台直播";
                }
                else if (indexPath.section==4)
                {
                    morereusableView.titlelabel.text=@"更多推荐";
                }
                morereusableView.MoretapBtn.hidden=YES;
                return morereusableView;
            }
        }
        else if ([kind isEqualToString:UICollectionElementKindSectionFooter])
        {
            if (indexPath.section==0) {
                FootCollectionReusableView *reusableView=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"FootCollectionReusableView" forIndexPath:indexPath];
                return reusableView;
            }
            else if (indexPath.section==1){
                changCollectionReusableView *reusableView=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"changCollectionReusableView" forIndexPath:indexPath];
                [reusableView setMyblock:^{
                    ZKLog(@"点击换一批按钮");
                }];
                return reusableView;

            }
        }
    }
    return nil;
}
-(void)getList:(PostType)type
{
    NSString *rankChoose=@"1";
    if (type==daily_type) {
        rankChoose=@"3";
    }
    NSMutableDictionary *parametDic = [NSMutableDictionary dictionaryWithCapacity:9];
    [parametDic setObject:rankChoose forKey:@"rankChoose"];
    [parametDic setObject:RCLOUD_ID forKey:@"userId"];
    [UserRequestToo shareInstance].rquesturl=GetAllAlbumUrl;
    [UserRequestToo shareInstance].params=parametDic;
    [[UserRequestToo shareInstance] statrrequestgetwith:MHAsiNetWorkGET successBlock:^(id returnData) {
        if (returnData[@"success"]) {
            if([returnData[@"status"] isEqualToString:@"200"]) {
                NSArray *list=returnData[@"data"];
                for (NSDictionary *dic in list) {
                    HomeModel *model=[[HomeModel alloc] init];
                    model.alid=dic[@"id"];
                    [model setValuesForKeysWithDictionary:dic];
                    if (type==daily_type) {
                        [self.everydaylist addObject:model];
                    }
                    else{
                        [self.tuijianlist addObject:model];
                    }
                }
                if (type==daily_type) {
                    if (self.everydaylist.count!=0) {
                        NSIndexSet *indexset=[NSIndexSet indexSetWithIndex:1];
                        [self.collectionView performBatchUpdates:^{
                            [self.collectionView reloadSections:indexset];
                        } completion:^(BOOL finished) {
                            [self.collectionView reloadSections:indexset];
                        }];
                    }
                }
                else{
                     if (self.tuijianlist.count!=0) {
                         NSIndexSet *indexset=[NSIndexSet indexSetWithIndex:2];
                         [self.collectionView performBatchUpdates:^{
                             [self.collectionView reloadSections:indexset];
                         } completion:^(BOOL finished) {
                             [self.collectionView reloadSections:indexset];
                         }];
                     }
                }
            }
        }
    } failureBlock:^(NSError *error) {
        //[self dismiss];
    }];
}
#pragma mark 获取8个标题列标题
-(void)gettitleBarUrl
{
    NSMutableDictionary *parametDic = [NSMutableDictionary dictionaryWithCapacity:9];
    [self showWithStatus:@"数据加载中..."];
    [parametDic setObject:@"RCLOUD_ID" forKey:@"userId"];
    [UserRequestToo shareInstance].rquesturl=gettitleBarUrl;
    [UserRequestToo shareInstance].params=parametDic;
    [[UserRequestToo shareInstance] statrrequestgetwith:MHAsiNetWorkGET successBlock:^(id returnData) {
        if (returnData[@"success"]) {
            if([returnData[@"status"] isEqualToString:@"200"]) {
                NSArray *list=returnData[@"data"];
                for (NSDictionary *dic in list) {
                    HomeModel *model=[[HomeModel alloc] init];
                    model.alid=dic[@"id"];
                    [model setValuesForKeysWithDictionary:dic];
                    [self.topTitlelist addObject:model];
                }
                if (self.topTitlelist.count!=0) {
                    NSIndexSet *indexset=[NSIndexSet indexSetWithIndex:0];
                    [self.collectionView performBatchUpdates:^{
                         [self.collectionView reloadSections:indexset];
                    } completion:^(BOOL finished) {
                        [self.collectionView reloadSections:indexset];
                    }];
                }
            }
        }
    } failureBlock:^(NSError *error) {
    }];
}
#pragma mark 获取直播列表
-(void)getlivelistUrl
{
    NSMutableDictionary *parametDic = [NSMutableDictionary dictionaryWithCapacity:9];
    [parametDic setObject:RCLOUD_ID forKey:@"userId"];
    [UserRequestToo shareInstance].rquesturl=GetlivelistUrl;
    [UserRequestToo shareInstance].params=parametDic;
    [[UserRequestToo shareInstance] statrrequestgetwith:MHAsiNetWorkGET successBlock:^(id returnData) {
        if (returnData[@"success"]) {
            if([returnData[@"status"] isEqualToString:@"200"]) {
                NSArray *list=returnData[@"data"];
                for (NSDictionary *dic in list) {
                    HomeModel *model=[[HomeModel alloc] init];
                    model.alid=dic[@"id"];
                    [model setValuesForKeysWithDictionary:dic];
                    [self.liveList addObject:model];
                }
                if (self.liveList.count!=0) {
                    NSIndexSet *indexset=[NSIndexSet indexSetWithIndex:3];
                    [self.collectionView performBatchUpdates:^{
                        [self.collectionView reloadSections:indexset];
                    } completion:^(BOOL finished) {
                        [self.collectionView reloadSections:indexset];
                    }];
                }
            }
        }
    } failureBlock:^(NSError *error) {
        [self dismiss];
    }];
}
#pragma mark 更多推荐
-(void)getAllsingleTuijian
{
    NSMutableDictionary *parametDic = [NSMutableDictionary dictionaryWithCapacity:9];
    [parametDic setObject:RCLOUD_ID forKey:@"userId"];
    [UserRequestToo shareInstance].rquesturl=GetAllAlbumaudioUrl;
    [UserRequestToo shareInstance].params=parametDic;
    [[UserRequestToo shareInstance] statrrequestgetwith:MHAsiNetWorkGET successBlock:^(id returnData) {
        [self dismiss];
        if (returnData[@"success"]) {
           if([returnData[@"status"] isEqualToString:@"200"])
           {
               NSArray *list=returnData[@"data"];
               for (NSDictionary *dic in list) {
                   HomeModel *model=[[HomeModel alloc] init];
                   model.alid=dic[@"id"];
                   [model setValuesForKeysWithDictionary:dic];
                   [self.singlelist addObject:model];
               }
               if (self.singlelist.count!=0) {
                   NSIndexSet *indexset=[NSIndexSet indexSetWithIndex:4];
                   [self.collectionView performBatchUpdates:^{
                       [self.collectionView reloadSections:indexset];
                   } completion:^(BOOL finished) {
                       [self.collectionView reloadSections:indexset];
                   }];
               }
          }
        }
    } failureBlock:^(NSError *error) {
        [self dismiss];
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
