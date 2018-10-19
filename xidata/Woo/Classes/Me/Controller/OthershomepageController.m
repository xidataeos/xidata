//
//  OthershomepageController.m
//  Woo
//
//  Created by 王起锋 on 2018/10/11.
//  Copyright © 2018年 杭州蜂布式. All rights reserved.
//

#import "OthershomepageController.h"
#import "auditingViewController.h"
#import "madecollectionViewCell.h"
#import "MoreCollectionReusableView.h"
#import "OtherHomePageview.h"
#import "audioCollectionViewCell.h"
@interface OthershomepageController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic, strong)NSMutableDictionary *cellDic;
@property (nonatomic, strong) OtherHomePageview*topheadview;
@end

@implementation OthershomepageController

-(UICollectionView *)collectionView
{
    if (_collectionView==nil) {
        UICollectionViewFlowLayout *fallLayout=[[UICollectionViewFlowLayout alloc]init];
        fallLayout.scrollDirection=  UICollectionViewScrollDirectionVertical;
        fallLayout.minimumInteritemSpacing=0;
        fallLayout.minimumLineSpacing=0;
        fallLayout.sectionInset = UIEdgeInsetsMake(1*KWidth_Scale, 1*KWidth_Scale, 1*KWidth_Scale, 1*KWidth_Scale);
        _collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0,230*KWidth_Scale, SCREEN_WIDTH, SCREEN_HEIGHT-230*KWidth_Scale) collectionViewLayout:fallLayout];
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
    [self.navigationController setNavigationBarHidden:NO];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initheadview];
    [self.view addSubview:self.collectionView];
}
-(void)initheadview
{
    WEAKSELF;
    self.topheadview=[[OtherHomePageview alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 230*KWidth_Scale)];
    [self.topheadview setBackBlock:^{
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    }];
    [self.topheadview setClickblock:^(UIImageView *headimage) {
        [weakSelf tapclick:headimage];
    }];
    [self.topheadview setPublickblock:^(NSInteger indexrow) {
        
    }];
    [self.view addSubview:self.topheadview];
}
-(void)tapclick:(UIImageView *)image
{
    CYPhotoPreviewer *previewer = [[CYPhotoPreviewer alloc] init];
    [previewer previewFromImageView:image inContainer:self.view];
}
#pragma mark-表尾尺寸
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayou referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeZero;
}
#pragma mark-表头尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(SCREEN_WIDTH,44*KWidth_Scale);
}
#pragma mark---加载UICollectionViewDataSource
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *CellIdentifierOne = [_cellDic objectForKey:[NSString stringWithFormat:@"%@", indexPath]];
    // 如果取出的唯一标示符不存在，则初始化唯一标示符，并将其存入字典中，对应唯一标示符注册Cell
    
    if (indexPath.section==1) {
        if (CellIdentifierOne == nil) {
            CellIdentifierOne = [NSString stringWithFormat:@"audioCollectionViewCell%@", [NSString stringWithFormat:@"%@", indexPath]];
            [_cellDic setValue:CellIdentifierOne forKey:[NSString stringWithFormat:@"%@", indexPath]];
            // 注册Cell
            [self.collectionView registerClass:[audioCollectionViewCell class]  forCellWithReuseIdentifier:CellIdentifierOne];
        }
        audioCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifierOne forIndexPath:indexPath];
        return cell;
    }
    else{
        if (CellIdentifierOne == nil) {
            CellIdentifierOne = [NSString stringWithFormat:@"ContentCollectionViewCell%@", [NSString stringWithFormat:@"%@", indexPath]];
            [_cellDic setValue:CellIdentifierOne forKey:[NSString stringWithFormat:@"%@", indexPath]];
            // 注册Cell
            [self.collectionView registerClass:[madecollectionViewCell class]  forCellWithReuseIdentifier:CellIdentifierOne];
        }
        madecollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifierOne forIndexPath:indexPath];
        return cell;
    }
}
#pragma mark-section
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}
#pragma mark-item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 3;
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
    if (indexPath.section==1) {
        return CGSizeMake(SCREEN_WIDTH,60*KWidth_Scale);
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
            
            MoreCollectionReusableView *morereusableView=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"MoreCollectionReusableView" forIndexPath:indexPath];
            morereusableView.titlelabel.text=@"专辑(3)";
            [morereusableView setMyblock:^{
                ZKLog(@"点击了更多");
            }];
            return morereusableView;
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