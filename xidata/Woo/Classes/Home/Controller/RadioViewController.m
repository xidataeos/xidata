
//
//  EducationViewController.m
//  Woo
//
//  Created by 王起锋 on 2018/8/2.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//教育培训

#import "RadioViewController.h"
#import "WooEducateCell.h"
#import "WooEducationCell.h"
#import "WooHEducateModel.h"
#import "CopyrigDetailViewController.h"
#import "CBSegmentView.h"
#import "RadioCollectionViewCell.h"
@interface RadioViewController ()<UICollectionViewDataSource, UICollectionViewDelegate,UISearchBarDelegate>
{
    int pageNum;
}
@property (nonatomic, strong)UIView *topview;
@property (nonatomic, strong)UIView *nexttopview;
@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic, strong)RCDSearchBar *searchBar;
@property(nonatomic,strong)CBSegmentView *secondSegmentView;
@property(nonatomic,strong)UIButton *selctBtn;//我要直播按钮
@property (nonatomic, strong) NSMutableDictionary *cellDic;
@end

@implementation RadioViewController
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
-(UICollectionView *)collectionView
{
    if (_collectionView==nil) {
        UICollectionViewFlowLayout *fallLayout=[[UICollectionViewFlowLayout alloc]init];
        fallLayout.scrollDirection=  UICollectionViewScrollDirectionVertical;
        fallLayout.minimumInteritemSpacing=0;
        fallLayout.minimumLineSpacing=0;
        fallLayout.sectionInset = UIEdgeInsetsMake(1*KWidth_Scale, 1*KWidth_Scale, 1*KWidth_Scale, 1*KWidth_Scale);
        _collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0,40, SCREEN_WIDTH, SCREEN_HEIGHT-40-StatusBarAndNavigationBarHeight) collectionViewLayout:fallLayout];
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
        _selctBtn.frame=CGRectMake(SCREEN_WIDTH-10*KWidth_Scale-60*KWidth_Scale,5, 60*KWidth_Scale, 24);
        _selctBtn.backgroundColor=NaviBackgroundColor;
        _selctBtn.layer.cornerRadius=12;
        [_selctBtn setTitle:@"我要直播" forState:UIControlStateNormal];
        _selctBtn.titleLabel.font=UIFont(11);
        [_selctBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_selctBtn addTarget:self action:@selector(clickbtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selctBtn;
}
-(void)clickbtn:(UIButton *)sender
{
   
}
-(UIView *)nexttopview
{
    if (_nexttopview==nil) {
        _nexttopview=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
        _nexttopview.backgroundColor=[UIColor whiteColor];
        [self.view addSubview:self.nexttopview];
    }
    return _nexttopview;
}
-(void)nextsetselectview
{
    NSArray *array=@[
                     @"热门",
                     @"恋爱",
                     @"游途",
                     @"时尚",
                     @"婚姻"
                     ];
    self.secondSegmentView = [[CBSegmentView alloc]initWithFrame:CGRectMake(10,0,SCREEN_WIDTH*0.75, 35)];
    self.secondSegmentView.backgroundColor=[UIColor whiteColor];
    [self.nexttopview addSubview:_secondSegmentView];
    _secondSegmentView.layer.borderColor=[UIColor clearColor].CGColor;
    [_secondSegmentView setTitleArray:array withStyle:CBSegmentStyleZoom];
    _secondSegmentView.titleChooseReturn = ^(NSInteger x) {
        ZKLog(@"点击了第%ld个按钮",x+1);
    };
    [self.nexttopview addSubview:self.selctBtn];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.searchBar removeFromSuperview];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar addSubview:self.searchBar];
    [self nextsetselectview];
    [self.view addSubview:self.collectionView];
    [self getlivelistUrl:@"1"];
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
        CellIdentifierOne = [NSString stringWithFormat:@"RadioCollectionViewCell%@", [NSString stringWithFormat:@"%@", indexPath]];
        [_cellDic setValue:CellIdentifierOne forKey:[NSString stringWithFormat:@"%@", indexPath]];
        // 注册Cell
        [self.collectionView registerClass:[RadioCollectionViewCell class]  forCellWithReuseIdentifier:CellIdentifierOne];
    }
    RadioCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifierOne forIndexPath:indexPath];
    cell.model=self.dataArray[indexPath.row];
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
}
//两个cell之间的间距（同一行的cell的间距）
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 1*KWidth_Scale;
}
//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(SCREEN_WIDTH/2.0-3,SCREEN_WIDTH/2.0);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.searchBar resignFirstResponder];
}
#pragma mark 获取电台直播列表
-(void)getlivelistUrl:(NSString *)classify
{
    NSMutableDictionary *parametDic = [NSMutableDictionary dictionaryWithCapacity:9];
    [parametDic setObject:RCLOUD_ID forKey:@"userId"];
    [parametDic setObject:classify forKey:@"classifyId"];
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
