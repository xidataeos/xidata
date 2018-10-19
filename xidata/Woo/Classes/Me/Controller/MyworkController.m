
//
//  MyworkController.m
//  Woo
//
//  Created by 王起锋 on 2018/10/14.
//  Copyright © 2018年 杭州蜂布式. All rights reserved.
//

#import "MyworkController.h"
#import "madecollectionViewCell.h"
#import "MoreCollectionReusableView.h"
#import "MyWorkcollectionCell.h"
#import "MygraphicController.h"
@interface MyworkController ()
<UICollectionViewDelegate,UICollectionViewDataSource,GGActionSheetDelegate>
@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic, strong)NSMutableDictionary *cellDic;
@property(nonatomic,strong) GGActionSheet *actionSheetImg;
@end

@implementation MyworkController

-(UICollectionView *)collectionView
{
    if (_collectionView==nil) {
        UICollectionViewFlowLayout *fallLayout=[[UICollectionViewFlowLayout alloc]init];
        fallLayout.scrollDirection=  UICollectionViewScrollDirectionVertical;
        fallLayout.minimumInteritemSpacing=0;
        fallLayout.minimumLineSpacing=0;
        fallLayout.sectionInset = UIEdgeInsetsMake(1*KWidth_Scale, 1*KWidth_Scale, 1*KWidth_Scale, 1*KWidth_Scale);
        _collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT-StatusBarAndNavigationBarHeight) collectionViewLayout:fallLayout];
        // 注册header
        [_collectionView registerClass:[MoreCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MoreCollectionReusableView"];
        _collectionView.dataSource=self;
        _collectionView.delegate=self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor=[UIColor whiteColor];
        
    }
    return _collectionView;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
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
-(void)addAction
{
    [self.actionSheetImg showGGActionSheet];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setnavitionright];
    self.title=@"我的作品";
    [self.view addSubview:self.collectionView];
}

#pragma mark-表尾尺寸
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayou referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeZero;
}
#pragma mark-表头尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section==1) {
        return CGSizeMake(SCREEN_WIDTH,44*KWidth_Scale);
    }
    else{
        return CGSizeZero;
    }
    
}
#pragma mark---加载UICollectionViewDataSource
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *CellIdentifierOne = [_cellDic objectForKey:[NSString stringWithFormat:@"%@", indexPath]];
    // 如果取出的唯一标示符不存在，则初始化唯一标示符，并将其存入字典中，对应唯一标示符注册Cell
    if (indexPath.section==0) {
        if (CellIdentifierOne == nil) {
            CellIdentifierOne = [NSString stringWithFormat:@"MyWorkcollectionCell%@", [NSString stringWithFormat:@"%@", indexPath]];
            [_cellDic setValue:CellIdentifierOne forKey:[NSString stringWithFormat:@"%@", indexPath]];
            // 注册Cell
            [self.collectionView registerClass:[MyWorkcollectionCell class]  forCellWithReuseIdentifier:CellIdentifierOne];
        }
        MyWorkcollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifierOne forIndexPath:indexPath];
        return cell;
    }
    else{
        WEAKSELF;
        if (CellIdentifierOne == nil) {
            CellIdentifierOne = [NSString stringWithFormat:@"madecollectionViewCell%@", [NSString stringWithFormat:@"%@", indexPath]];
            [_cellDic setValue:CellIdentifierOne forKey:[NSString stringWithFormat:@"%@", indexPath]];
            // 注册Cell
            [self.collectionView registerClass:[madecollectionViewCell class]  forCellWithReuseIdentifier:CellIdentifierOne];
        }
        madecollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifierOne forIndexPath:indexPath];
        __strong typeof(madecollectionViewCell *) strongcell=cell;
        [cell setMoreblock:^{
            [weakSelf showActionsheet:strongcell];
        }];
        return cell;
    }
}
#pragma mark - GGActionSheet代理方法
-(void)GGActionSheetClickWithIndex:(int)index{
    NSLog(@"--------->点击了第%d个按钮<----------",index);
}
-(GGActionSheet *)actionSheetImg{
    if (!_actionSheetImg) {
        _actionSheetImg = [GGActionSheet ActionSheetWithImageArray:@[@"up_icon",@"up_icon"] delegate:self];
        _actionSheetImg.cancelDefaultColor = [UIColor redColor];
    }
    return _actionSheetImg;
}
-(void)showActionsheet:(madecollectionViewCell *)cell
{
     [self.actionSheetImg showGGActionSheet];
}
#pragma mark-section
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}
#pragma mark-item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section==0) {
        return 2;
    }
    return 3;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    if (indexPath.section==0) {
        MygraphicController *myg=[[MygraphicController alloc] init];
        if (indexPath.row==0) {
            myg.selftitle=@"我的图文";
        }
        else{
            myg.selftitle=@"我的声音";
        }
        [self.navigationController pushViewController:myg animated:YES];
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
        return CGSizeMake(SCREEN_WIDTH,50*KWidth_Scale);
    }
    return CGSizeMake(SCREEN_WIDTH,80*KWidth_Scale);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark---加载UICollectionView表头
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([collectionView isEqual:_collectionView]) {
        if ([kind isEqualToString:UICollectionElementKindSectionHeader]) { // header
            if (indexPath.section==1) {
                MoreCollectionReusableView *morereusableView=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"MoreCollectionReusableView" forIndexPath:indexPath];
                morereusableView.titlelabel.text=@"购买的专辑(3)";
                [morereusableView setMyblock:^{
                    ZKLog(@"点击了更多");
                }];
                return morereusableView;
            }
            else{
                return nil;
            }
        }
    }
    return nil;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
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
