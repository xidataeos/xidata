
//
//  MeetingissuedViewController.m
//  Woo
//
//  Created by 王起锋 on 2018/8/2.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//会议发布页面

#import "allcontentViewController.h"
#import "CBSegmentView.h"
#import "cusetselectview.h"
#import "ContentCollectionViewCell.h"
#import "MusicIndicator.h"
#import "AlbumdetailsController.h"
#import "TuwendtailViewController.h"
@interface allcontentViewController ()<UISearchBarDelegate,UICollectionViewDelegate,UICollectionViewDataSource,audioViewControllerDelegate>
{
    int pageNum;
}
@property (nonatomic, strong)UICollectionView *CollectionView ;
@property (nonatomic, strong)RCDSearchBar *searchBar;
@property (nonatomic, strong)UIView *topview;
@property (nonatomic, strong)UIView *nexttopview;
@property(nonatomic,strong)CBSegmentView *sliderSegmentView;
@property(nonatomic,strong)CBSegmentView *secondSegmentView;
@property(nonatomic,strong)UIButton *selctBtn;
@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableDictionary *cellDic;
@property(nonatomic,assign)UpdataType selfType;//图文或者音频
@property(nonatomic,assign)SelectType payType;//免费
@property(nonatomic,assign)screeningType screeningYp;//最新

@end

@implementation allcontentViewController
-(UICollectionView *)collectionView
{
    CGFloat offy=35;
    if (self.style==contentStyleall) {
        offy=35;
    }
    if (_collectionView==nil) {
        UICollectionViewFlowLayout *fallLayout=[[UICollectionViewFlowLayout alloc]init];
        fallLayout.scrollDirection=  UICollectionViewScrollDirectionVertical;
        fallLayout.minimumInteritemSpacing=0;
        fallLayout.minimumLineSpacing=0;
        fallLayout.sectionInset = UIEdgeInsetsMake(1*KWidth_Scale, 1*KWidth_Scale, 1*KWidth_Scale, 1*KWidth_Scale);
        _collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0,offy, SCREEN_WIDTH, SCREEN_HEIGHT-offy-StatusBarAndNavigationBarHeight) collectionViewLayout:fallLayout];
        // 注册header
        _collectionView.dataSource=self;
        _collectionView.delegate=self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor=[UIColor whiteColor];
        
    }
    return _collectionView;
}

-(UIButton *)selctBtn
{
    if (_selctBtn==nil) {
        _selctBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _selctBtn.frame=CGRectMake(SCREEN_WIDTH-10*KWidth_Scale-55*KWidth_Scale,5, 55*KWidth_Scale, 24);
        _selctBtn.layer.borderColor=NaviBackgroundColor.CGColor;
        _selctBtn.layer.borderWidth=0.7;
        _selctBtn.layer.cornerRadius=12;
       
       [_selctBtn setImage:[UIImage imageNamed:@"back_Image"] forState:UIControlStateNormal];
       [_selctBtn setImage:[UIImage imageNamed:@"back_Image"] forState:UIControlStateSelected];
        [_selctBtn setImageEdgeInsets:UIEdgeInsetsMake(2, 2, 2, 35*KWidth_Scale)];
        [_selctBtn setTitle:@"筛选" forState:UIControlStateNormal];
        [_selctBtn setTitle:@"收起" forState:UIControlStateSelected];
        _selctBtn.titleLabel.font=UIFont(11);
        [_selctBtn setTitleColor:WordsofcolorColor forState:UIControlStateNormal];
        [_selctBtn setTitleEdgeInsets:UIEdgeInsetsMake(0,0, 0, 8*KWidth_Scale)];
        _selctBtn.selected=NO;
        [_selctBtn addTarget:self action:@selector(clickbtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selctBtn;
}
-(void)clickbtn:(UIButton *)sender
{
    sender.selected=!sender.selected;
    dispatch_async(dispatch_get_main_queue(), ^{
        if (sender.selected) {
            CGFloat offy;
            if (self.style==contentStyleall) {
                offy=105;
            }
            else{
                offy=70;
            }
            [UIView animateWithDuration:0.2 animations:^{
                self.topview.hidden=NO;
                _collectionView.frame=CGRectMake(0,offy, SCREEN_WIDTH, SCREEN_HEIGHT-offy-StatusBarAndNavigationBarHeight);
            }];
        }
        else{
            [UIView animateWithDuration:0.2 animations:^{
                _collectionView.frame=CGRectMake(0,35, SCREEN_WIDTH, SCREEN_HEIGHT-35-StatusBarAndNavigationBarHeight);
                self.topview.hidden=YES;
            }];
            
        }
    });
}
-(UIView *)nexttopview
{
    CGFloat offy=0;
    if (self.style==contentStyleall) {
        offy=0;
    }
    if (_nexttopview==nil) {
        _nexttopview=[[UIView alloc] initWithFrame:CGRectMake(0, offy, SCREEN_WIDTH, 35)];
        _nexttopview.backgroundColor=[UIColor whiteColor];
        [self.view addSubview:self.nexttopview];
    }
    return _nexttopview;
}
-(UIView *)topview
{
    WEAKSELF;
    CGFloat offy=35;
    if (self.style==contentStyleall) {
        offy=70;
    }
    if (_topview==nil) {
        _topview=[[UIView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(self.nexttopview.frame)-3, SCREEN_WIDTH, offy)];
        _topview.hidden=YES;
        cusetselectview *alview=[[cusetselectview alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 35) withdata:[[NSMutableArray alloc] initWithObjects:@"综合排序",@"流行",@"最新",@"热门" ,nil]];
        [alview setMyblock:^(NSInteger indexrow) {
            if (indexrow==0) {
                weakSelf.screeningYp=screening_all;
            }
            else if (indexrow==1)
            {
                weakSelf.screeningYp=screening_popular;
            }
            else if (indexrow==2)
            {
                weakSelf.screeningYp=screening_new;
            }
            else
            {
                weakSelf.screeningYp=screening_hot;
            }
            if (weakSelf.selfType==all_album) {
                [weakSelf getList];
            }
            else{
                [weakSelf getAllsingleList];
            }
        }];
        [_topview addSubview:alview];
        if (self.style==contentStyleall) {
            cusetselectview *twoalview=[[cusetselectview alloc] initWithFrame:CGRectMake(0, 35, SCREEN_WIDTH, 35) withdata:[[NSMutableArray alloc] initWithObjects:@"不限",@"付费",@"免费" ,nil]];
            [twoalview setMyblock:^(NSInteger indexrow) {
               
                if (indexrow==0) {
                    weakSelf.payType=payAndfree_type;
                }
                else if (indexrow==1)
                {
                    weakSelf.payType=pay_type;
                }
                else{
                    weakSelf.payType=free_type;
                }
                if (self.selfType==all_album) {
                    [weakSelf getList];
                }
                else{
                    [weakSelf getAllsingleList];
                }
            }];
            
          [_topview addSubview:twoalview];
        }
    }
    _topview.backgroundColor=[UIColor whiteColor];
    return _topview;
}
- (RCDSearchBar *)searchBar
{
    if (!_searchBar) {
        _searchBar = [[RCDSearchBar alloc] initWithFrame:CGRectMake(40*KWidth_Scale,5*KWidth_Scale, ScreenWidth-70*KWidth_Scale, 30)];
        _searchBar.tintColor=[UIColor clearColor];
        _searchBar.backgroundImage = [_searchBar getImageWithColor:NaviBackgroundColor andHeight:35.0f];
        _searchBar.backgroundColor =NaviBackgroundColor;
        _searchBar.delegate = self;
        UITextField *searchField = [_searchBar valueForKey:@"_searchField"];
        searchField.backgroundColor=[UIColor clearColor];
        searchField.layer.borderWidth = 0.5f;
        searchField.layer.borderColor = [PublicFunction colorWithHexString:@"0xdfdfdf"].CGColor;
        searchField.layer.cornerRadius = 20.f;
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
    self.changestatuscolor=YES;
    [[WooSearchmanger shareInstance] begintosearch:self navi:self.searchNavigationController search:type];
    [[WooSearchmanger shareInstance] setSearchcanleblock:^{
        [self.searchBar becomeFirstResponder];
        [self.searchBar resignFirstResponder];
    }];
}
-(void)nextsetselectview
{
    WEAKSELF;
    NSArray *array=@[
                     @"专辑",
                     @"音频",
                     @"图文",
                     ];
    self.secondSegmentView = [[CBSegmentView alloc]initWithFrame:CGRectMake(10*KWidth_Scale,0,SCREEN_WIDTH*0.5, 35)];
    self.secondSegmentView.backgroundColor=[UIColor whiteColor];
    [self.nexttopview addSubview:_secondSegmentView];
    _secondSegmentView.layer.borderColor=[UIColor clearColor].CGColor;
    [_secondSegmentView setTitleArray:array withStyle:CBSegmentStyleZoom];
    _secondSegmentView.titleChooseReturn = ^(NSInteger x) {
        ZKLog(@"点击了第%ld个按钮",x+1);
        if (x==0) {
            weakSelf.selfType=all_album;
            [weakSelf getList];
        }
        else if (x==1)
        {
            weakSelf.selfType=audio_type;
            [weakSelf getAllsingleList];
        }
        else{
            weakSelf.selfType=graphic_type;
            [weakSelf getAllsingleList];
        }
    };
    [self.nexttopview addSubview:self.selctBtn];
}
-(void)setselectview
{
    NSArray *array=@[
                     @"全部",
                     @"付费精选",
                     @"微版权",
                     @"电台直播",
                     @"恋爱",
                     ];
    self.sliderSegmentView = [[CBSegmentView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 45)];
    [self.view addSubview:_sliderSegmentView];
    [_sliderSegmentView setTitleArray:array withStyle:CBSegmentStyleSlider];
    _sliderSegmentView.titleChooseReturn = ^(NSInteger x) {
        ZKLog(@"点击了第%ld个按钮",x+1);
    };
}
-(void)viewWillDisappear:(BOOL)animated
{
    [self.searchBar removeFromSuperview];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
}
- (void)createIndicatorView {
    MusicIndicator *indicator = [MusicIndicator sharedInstance];
    indicator.hidesWhenStopped = NO;
    indicator.tintColor = [UIColor redColor];
    
    if (indicator.state != NAKPlaybackIndicatorViewStatePlaying) {
        indicator.state = NAKPlaybackIndicatorViewStatePlaying;
        indicator.state = NAKPlaybackIndicatorViewStateStopped;
    } else {
        indicator.state = NAKPlaybackIndicatorViewStatePlaying;
    }
    
    //[self.navigationController.navigationBar addSubview:indicator];
    
    UITapGestureRecognizer *tapInditator = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapIndicator)];
    tapInditator.numberOfTapsRequired = 1;
    [indicator addGestureRecognizer:tapInditator];
}
- (void)handleTapIndicator {
    audioViewController *musicVC = [audioViewController sharedInstance];
    //设置模式展示风格
    musicVC.modalPresentationStyle = UIModalPresentationOverCurrentContext|UIModalPresentationFullScreen;
    //musicVC.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    //必要配置
    self.modalPresentationStyle = UIModalPresentationCurrentContext;
    self.providesPresentationContextTransitionStyle = YES;
    self.definesPresentationContext = YES;
    if (musicVC.musicEntities.count == 0) {
        [self showErrorWithStatus:@"暂无正在播放的歌曲"];
        return;
    }
    [self presentaudioview];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.selfType=all_album;
    self.payType=payAndfree_type;
    self.screeningYp=screening_all;
    if (self.style==contentStylesingle) {
      self.payType=pay_type;
    }
    [self createIndicatorView];
    [self.navigationController.navigationBar addSubview:self.searchBar];
    if (self.style==contentStyleall) {
        //[self setselectview];
    }
    [self nextsetselectview];
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.topview];
    [self getList];
}
#pragma mark-表尾尺寸
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayou referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeZero;
}
#pragma mark-表头尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeZero;
}
#pragma mark---加载UICollectionViewDataSource
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *CellIdentifierOne = [_cellDic objectForKey:[NSString stringWithFormat:@"%@", indexPath]];
    // 如果取出的唯一标示符不存在，则初始化唯一标示符，并将其存入字典中，对应唯一标示符注册Cell
    if (CellIdentifierOne == nil) {
        if (self.selfType==all_album) {
            CellIdentifierOne = [NSString stringWithFormat:@"ContentCollectionViewCell%@", [NSString stringWithFormat:@"%@", indexPath]];
            [_cellDic setValue:CellIdentifierOne forKey:[NSString stringWithFormat:@"%@", indexPath]];
            // 注册Cell
            [self.collectionView registerClass:[ContentCollectionViewCell class]  forCellWithReuseIdentifier:CellIdentifierOne];
        }
        else{
            CellIdentifierOne = [NSString stringWithFormat:@"madecollectionViewCell%@", [NSString stringWithFormat:@"%@", indexPath]];
            [_cellDic setValue:CellIdentifierOne forKey:[NSString stringWithFormat:@"%@", indexPath]];
            // 注册Cell
            [self.collectionView registerClass:[madecollectionViewCell class]  forCellWithReuseIdentifier:CellIdentifierOne];
        }
    }
    ContentCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifierOne forIndexPath:indexPath];
    if (self.selfType==all_album) {
        cell.model=self.dataArray[indexPath.row];
          return cell;
    }
    else{
        madecollectionViewCell *lastcell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifierOne forIndexPath:indexPath];
            [lastcell setmoreBtnHide];
            lastcell.submitBtn.hidden=YES;
            lastcell.model=self.dataArray[indexPath.row];
            return lastcell;
    }
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
-(void)presentaudioview
{
    audioViewController *audio = [audioViewController sharedInstance];
    audio.musicTitle = @"我是歌手";
    audio.specialIndex =0;
    audio.delegate = self;
    //必要配置
    self.providesPresentationContextTransitionStyle = YES;
    self.definesPresentationContext = YES;
    WooBaseNavigationViewController *navigationController = [[WooBaseNavigationViewController alloc] initWithRootViewController:audio];
    navigationController.view.backgroundColor = [UIColor clearColor];
     navigationController.modalPresentationStyle = UIModalPresentationOverCurrentContext;//
    [self.navigationController presentViewController:navigationController animated:YES completion:^{
    }];
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.selfType==all_album) {
        AlbumdetailsController *albu=[[AlbumdetailsController alloc] init];
        albu.AlbumModel=self.dataArray[indexPath.row];
        [self.navigationController pushViewController:albu animated:YES];
    }
    else if (self.selfType==graphic_type) {
        TuwendtailViewController *Tuwendtail=[[TuwendtailViewController alloc] init];
        Tuwendtail.tuwModel=self.dataArray[indexPath.row];
        [self.navigationController pushViewController:Tuwendtail animated:YES];
    }
    else{
        [self presentaudioview];
    }
}
//两个cell之间的间距（同一行的cell的间距）
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 1*KWidth_Scale;
}
//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.selfType==all_album) {
        return CGSizeMake(SCREEN_WIDTH/2.0-3,SCREEN_WIDTH/2.0);
    }
    else{
       return CGSizeMake(SCREEN_WIDTH,81*KWidth_Scale);
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.searchBar resignFirstResponder];
}
#pragma mark 获取全部列表
-(void)getList
{
    [self.dataArray removeAllObjects];
    NSString *rankChoose=@"0";
    NSString *priceChoose=@"0";
    if (self.payType==pay_type) {
        //付费
        priceChoose=@"1";
    }
    else if (self.payType==free_type) {
        //免费
        priceChoose=@"2";
    }
    if (self.screeningYp==screening_popular) {
        rankChoose=@"2";
    }
     else if (self.payType==screening_new) {
          rankChoose=@"3";
     }
    else if (self.payType==screening_hot)
    {
         rankChoose=@"1";
    }
    NSMutableDictionary *parametDic = [NSMutableDictionary dictionaryWithCapacity:9];
    if (self.classid) {
    [parametDic setObject:self.classid forKey:@"classifyId"];
    }
    [parametDic setObject:priceChoose forKey:@"priceChoose"];
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
                    [self.dataArray addObject:model];
                }
                [self.collectionView reloadData];
            }
        }
    } failureBlock:^(NSError *error) {
        //[self dismiss];
    }];
}
#pragma mark 更多推荐
-(void)getAllsingleList
{
    NSString *rankChoose=@"0";
    NSString *priceChoose=@"0";
    NSString *queryTyoe=@"0";
    if (self.selfType==graphic_type) {
        queryTyoe=@"1";
    }
    if (self.payType==pay_type) {
        //付费
        priceChoose=@"1";
    }
    else if (self.payType==free_type) {
        //免费
        priceChoose=@"2";
    }
    if (self.screeningYp==screening_popular) {
        rankChoose=@"2";
    }
    else if (self.payType==screening_new) {
        rankChoose=@"3";
    }
    else if (self.payType==screening_hot)
    {
        rankChoose=@"1";
    }
    [self.dataArray removeAllObjects];
    NSMutableDictionary *parametDic = [NSMutableDictionary dictionaryWithCapacity:9];
    [parametDic setObject:RCLOUD_ID forKey:@"userId"];
    [parametDic setObject:priceChoose forKey:@"priceChoose"];
    [parametDic setObject:rankChoose forKey:@"rankChoose"];
    [parametDic setObject:queryTyoe forKey:@"type"];
    if (self.classid) {
        [parametDic setObject:self.classid forKey:@"classifyId"];
    }
    [parametDic setObject:priceChoose forKey:@"priceChoose"];
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
                    [self.dataArray addObject:model];
                }
                [self.collectionView reloadData];
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
