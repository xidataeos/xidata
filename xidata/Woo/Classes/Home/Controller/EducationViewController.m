
//
//  EducationViewController.m
//  Woo
//
//  Created by 王起锋 on 2018/8/2.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//教育培训

#import "EducationViewController.h"
#import "WooEducateCell.h"
#import "WooEducationCell.h"
#import "WooHEducateModel.h"
#import "WooEducateDetailViewController.h"
@interface EducationViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>
{
    int pageNum;
}
@property(nonatomic,strong)WooHEducateModel *headmodel;
@property (nonatomic, strong)UICollectionView *dataCollectionView;
@end

@implementation EducationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.dataCollectionView];
    WEAKSELF;
    pageNum = 1;
    self.dataCollectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if (self.dataArray.count > 0) {
            //[self.dataArray removeAllObjects];
        }
        [weakSelf requestURL];
    }];
    [self.dataCollectionView.mj_footer beginRefreshing];
}


- (UICollectionView *)dataCollectionView
{
    if (!_dataCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        _dataCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 50 - 40 - TabbarHeight - StatusBarAndNavigationBarHeight) collectionViewLayout:flowLayout];
        _dataCollectionView.delegate = self;
        _dataCollectionView.dataSource = self;
        _dataCollectionView.backgroundColor = [UIColor whiteColor];
        [_dataCollectionView registerClass:[WooEducationCell class] forCellWithReuseIdentifier:@"cell"];
        [_dataCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView"];
        if (@available(iOS 11.0, *)) {
            _dataCollectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _dataCollectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
            _dataCollectionView.scrollIndicatorInsets = _dataCollectionView.contentInset;
        }
    }
    return _dataCollectionView;
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

#pragma mark---加载UICollectionViewDataSource
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifierOne=@"cell";
    WooEducationCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifierOne forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    if (self.dataArray.count > 0) {
        cell.model = self.dataArray[indexPath.row];
        
    }
    return cell;
}

/** 头部/底部*/
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        // 头部
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView" forIndexPath:indexPath];
        headerView.backgroundColor = [UIColor whiteColor];
        
        UIImageView *backgroundView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, ScreenWidth - 20, 150)];
        backgroundView.clipsToBounds=YES;
        backgroundView.contentMode=UIViewContentModeScaleAspectFill;
        [backgroundView sd_setImageWithURL:[NSURL URLWithString:self.headmodel.eImg]];
        UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappushidetail)];
        backgroundView.userInteractionEnabled=YES;
        [backgroundView addGestureRecognizer:tap];
//        backgroundView.backgroundColor = [UIColor greenColor];
        [headerView addSubview:backgroundView];
        reusableview = headerView;
    } else {
        // 底部

    }
    return  reusableview;
}
-(void)tappushidetail
{
    WooEducateDetailViewController *educateVC = [[WooEducateDetailViewController alloc]init];
    educateVC.eId = [NSString stringWithFormat:@"%@", self.headmodel.eId];
    [self.navigationController pushViewController:educateVC animated:YES];
}
/** 头部的尺寸*/
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(ScreenWidth, 150);
}
//这个是两行cell之间的间距（上下行cell的间距）
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section;
{
    return 10;
}

//两个cell之间的间距（同一行的cell的间距）
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((ScreenWidth - 30) / 2, 130);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZKLog(@"indexPath -- %ld", indexPath.row);
    WooHEducateModel *model = self.dataArray[indexPath.row];
    WooEducateDetailViewController *educateVC = [[WooEducateDetailViewController alloc]init];
    educateVC.eId = [NSString stringWithFormat:@"%@", model.eId];
    [self.navigationController pushViewController:educateVC animated:YES];
}

- (void)requestURL
{
    WEAKSELF;
    [UserRequestToo shareInstance].rquesturl = EducateListUrl;
    NSDictionary *dict = @{@"pageNum" : [NSNumber numberWithInt:pageNum]};
    [UserRequestToo shareInstance].params = dict;
    [[UserRequestToo shareInstance] statrrequestgetwith:(MHAsiNetWorkGET) successBlock:^(id returnData) {
        [self.dataCollectionView.mj_footer endRefreshing];
        ZKLog(@"returnData -- %@", returnData);
        if ([returnData[@"success"] intValue] == 1) {
            ZKLog(@"cg");
             pageNum++;
            if ([returnData[@"data"] count] > 0) {
                for (NSDictionary *dict110 in returnData[@"data"]) {
                    WooHEducateModel *model = [WooHEducateModel mj_objectWithKeyValues:dict110];
                    [self.dataArray addObject:model];
                }
            }
            else if ([returnData[@"data"] count]==0){
                [self showAlertHud:self.view.center withStr:@"我是有底线的" offy:-100];
            }
        }
        if (weakSelf.dataArray.count != 0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.headmodel=[self.dataArray firstObject];
                if (pageNum==1) {
                   [self.dataArray removeObjectAtIndex:0];
                }
                [weakSelf.dataCollectionView reloadData];
            });
        }
    } failureBlock:^(NSError *error) {
        [self.dataCollectionView.mj_footer endRefreshing];
    }];
    
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
