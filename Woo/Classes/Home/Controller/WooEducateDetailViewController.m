//
//  WooEducateDetailViewController.m
//  Woo
//
//  Created by 风外杏林香 on 2018/8/27.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import "WooEducateDetailViewController.h"
#import "SAPlayVideo.h"
#import "AppDelegate.h"
#import "WooEducationCell.h"
@interface WooEducateDetailViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong)SAPlayVideo *player;
@property (nonatomic, strong)UICollectionView *dataCollectionView;
@property (nonatomic, strong)NSDictionary *dataDictionary;
@end

@implementation WooEducateDetailViewController

- (NSDictionary *)dataDictionary
{
    if (!_dataDictionary) {
        _dataDictionary = [NSDictionary dictionary];
    }
    return _dataDictionary;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.allowRotation = 1;
    [self requestFindEducation];
    [self initWithUI];
    [self.view addSubview:self.dataCollectionView];

    WEAKSELF;
    self.dataCollectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (self.dataArray.count > 0) {
            [self.dataArray removeAllObjects];
        }
        [weakSelf requestEducateRecommendUrl];
    }];
    [self.dataCollectionView.mj_header beginRefreshing];
}

- (UICollectionView *)dataCollectionView
{
    if (!_dataCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        _dataCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.player.frame), ScreenWidth, ScreenHeight - CGRectGetHeight(self.player.frame) - StatusBarHeight) collectionViewLayout:flowLayout];
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
        
        UIView *backgroundView = [[UIView alloc]initWithFrame:CGRectMake(10, 0, ScreenWidth - 20, 170)];
        backgroundView.backgroundColor = [UIColor whiteColor];
        [headerView addSubview:backgroundView];
        
        UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, ScreenWidth - 20, 30)];
        label1.textAlignment = NSTextAlignmentLeft;
        label1.font = UIFont(18);
        label1.adjustsFontSizeToFitWidth = YES;
        [backgroundView addSubview:label1];
        
        UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(label1.frame), ScreenWidth - 20, 30)];
        label2.textAlignment = NSTextAlignmentLeft;
        label2.font = UIFont(12);
        label2.textColor = RGB(102, 102, 102);
        [backgroundView addSubview:label2];
        
        UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(label2.frame), ScreenWidth - 20, 30)];
        label3.textAlignment = NSTextAlignmentLeft;
        label3.font = UIFont(18);
        label3.adjustsFontSizeToFitWidth = YES;
        label3.text = @"简介";
        [backgroundView addSubview:label3];
        
        UILabel *label4 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(label3.frame), ScreenWidth - 20, 30)];
        label4.textAlignment = NSTextAlignmentLeft;
        label4.font = UIFont(15);
        label4.textColor = RGB(102, 102, 102);
        label4.numberOfLines = 0;
        [backgroundView addSubview:label4];
        
        UILabel *label5 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(label4.frame), ScreenWidth - 20, 30)];
        label5.textAlignment = NSTextAlignmentLeft;
        label5.font = UIFont(15);
        label5.text = @"为你推荐";
        [backgroundView addSubview:label5];
        
        UIButton *button1 = [UIButton buttonWithType:(UIButtonTypeCustom)];
        button1.frame = CGRectMake(ScreenWidth - 60, CGRectGetMinY(label3.frame), 40, 30);
        [button1 setImage:[UIImage imageNamed:@"zhuanfa_Image"] forState:(UIControlStateNormal)];
        [button1 addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
        button1.tag = 1;
        [backgroundView addSubview:button1];
        
        UIButton *button2 = [UIButton buttonWithType:(UIButtonTypeCustom)];
        button2.frame = CGRectMake(CGRectGetMinX(button1.frame) - 40, CGRectGetMinY(label3.frame), 40, 30);
        [button2 setImage:[UIImage imageNamed:@"down_Image"] forState:(UIControlStateNormal)];
        [button2 addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
        button2.tag = 2;
        [backgroundView addSubview:button2];
        
        if (self.dataDictionary.count > 0) {
            label1.text = [NSString stringWithFormat:@"%@", self.dataDictionary[@"eTitle"]];
            label2.text = [NSString stringWithFormat:@"%@次播放", self.dataDictionary[@"ePageview"]];
//            label4.text = [NSString stringWithFormat:@"%@", self.dataDictionary[@"eXqIntro"]];
            NSDictionary *dict110 = @{NSFontAttributeName : [UIFont systemFontOfSize:13.0]};
            NSString *contentStr= [NSString stringWithFormat:@"%@", self.dataDictionary[@"eXqIntro"]];
            CGSize size = [contentStr boundingRectWithSize:CGSizeMake(200, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict110 context:nil].size;
            label4.text = contentStr;
            label4.frame = CGRectMake(0, CGRectGetMaxY(label3.frame), ScreenWidth - 20, size.height);
            label5.frame = CGRectMake(0, CGRectGetMaxY(label4.frame), ScreenWidth - 20, 30);
        } else {
            
        }
        reusableview = headerView;
    } else {
        // 底部
        
    }
    return  reusableview;
}

/** 头部的尺寸*/
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (self.dataDictionary.count > 0) {
        NSDictionary *dict110 = @{NSFontAttributeName : [UIFont systemFontOfSize:13.0]};
        NSString *contentStr= [NSString stringWithFormat:@"%@", self.dataDictionary[@"eXqIntro"]];
        CGSize size = [contentStr boundingRectWithSize:CGSizeMake(200, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict110 context:nil].size;
        return CGSizeMake(ScreenWidth, 140 + size.height);
    } else {
        return CGSizeMake(ScreenWidth, 170);
    }
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
    //并不知道跳哪里
    WooHEducateModel *model = self.dataArray[indexPath.row];
    ZKLog(@"eId -- %@", model.eId);
}
- (void)initWithUI
{
    WEAKSELF;
    self.player = [[SAPlayVideo alloc]initWithFrame:CGRectMake(0, StatusBarHeight, ScreenWidth, 200)];
    self.player.backgroundColor = [UIColor blackColor];
    UIButton *button = [self.player viewWithTag:110];
    button.hidden = YES;
    //    self.player.videoUrlStr = @"http://220.249.115.46:18080/wav/no.9.mp4";//此处只能真机测试
    self.player.ButtonAction = ^(UIButton *backBtn) {
        NSLog(@"backBtn -- %ld", backBtn.tag);
        if (backBtn.tag == 110) {
            NSLog(@"分享");
//            [weakSelf shareAction];
            UIButton *button = [weakSelf.player viewWithTag:110];
            button.hidden = YES;
        } else if (backBtn.tag == 1){
            NSLog(@"横竖屏");
            UIInterfaceOrientation sataus = [UIApplication sharedApplication].statusBarOrientation;
            NSLog(@"status -- %ld", (long)sataus);
            if (!IsPortrait) {
                weakSelf.dataCollectionView.hidden = YES;
            } else {
                weakSelf.dataCollectionView.hidden = NO;
            }
        } else if (backBtn.tag == 2){
            if (!IsPortrait) {
                weakSelf.dataCollectionView.hidden = YES;
            } else {
                weakSelf.dataCollectionView.hidden = NO;
            }
            if (IsPortrait) {
                [weakSelf.navigationController popToRootViewControllerAnimated:YES];
            }
        } else {
            
        }
    };
    [self.view addSubview:self.player];
}

- (void)requestFindEducation
{
    WEAKSELF;
    [self showhudmessage:@"数据加载中..." offy:-100];
    [UserRequestToo shareInstance].rquesturl = EducateDetailUrl;
    [UserRequestToo shareInstance].params = @{@"eId" : self.eId};
    [[UserRequestToo shareInstance] statrrequestgetwith:(MHAsiNetWorkGET) successBlock:^(id returnData) {
        [weakSelf hideHud];
        ZKLog(@"returnData -- %@", returnData);
        if ([returnData[@"success"] intValue] == 1) {
            //加载播放器
            weakSelf.player.videoUrlStr = [NSString stringWithFormat:@"%@", returnData[@"data"][@"eVideolink"]];
//            weakSelf.player.videoUrlStr = @"http://220.249.115.46:18080/wav/no.9.mp4";
            weakSelf.dataDictionary = [NSDictionary dictionaryWithDictionary:returnData[@"data"]];
            
        } else {
            
        }
    } failureBlock:^(NSError *error) {
        [weakSelf hideHud];
        ZKLog(@"error -- %@", error);
    }];
}
- (void)requestEducateRecommendUrl
{
    WEAKSELF;
    [UserRequestToo shareInstance].rquesturl = EducateRecommendUrl;
    [UserRequestToo shareInstance].params = @{@"eId" : self.eId};
    [[UserRequestToo shareInstance] statrrequestgetwith:(MHAsiNetWorkGET) successBlock:^(id returnData) {
        [self.dataCollectionView.mj_header endRefreshing];
        ZKLog(@"returnData -- %@", returnData);
        if ([returnData[@"success"] intValue] == 1) {
            if ([returnData[@"success"] intValue] == 1) {
                ZKLog(@"cg");
                if ([returnData[@"data"] count] > 0) {
                    for (NSDictionary *dict110 in returnData[@"data"]) {
                        WooHEducateModel *model = [WooHEducateModel mj_objectWithKeyValues:dict110];
                        [weakSelf.dataArray addObject:model];
                    }
                }
            }
            if (weakSelf.dataArray.count != 0) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf.dataCollectionView reloadData];
                });
            }
        } else {
            
        }
    } failureBlock:^(NSError *error) {
        [self.dataCollectionView.mj_header endRefreshing];
        ZKLog(@"error -- %@", error);
    }];
}

- (void)buttonAction:(UIButton *)sender
{
    switch (sender.tag) {
        case 1:
        {
            ZKLog(@"下载");
        }
            break;
        case 2:
        {
            ZKLog(@"转发");
        }
        default:
            break;
    }
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
