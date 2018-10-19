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
#import "VideoWooViewController.h"
@interface WooEducateDetailViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong)SAPlayVideo *player;
@property (nonatomic, strong)UICollectionView *dataCollectionView;
@property (nonatomic, strong)NSMutableDictionary *dataDictionary;

@property (nonatomic, strong) ZFPlayerController *player1;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) ZFPlayerControlView *controlView;
@property (nonatomic, strong) UIButton *playBtn;
@property (nonatomic, strong) ZFAVPlayerManager *playerManager;
@property(nonatomic,copy)NSString *playurl;
@property(nonatomic,copy)NSString *sharetitle;
@end

@implementation WooEducateDetailViewController

- (NSMutableDictionary *)dataDictionary
{
    if (!_dataDictionary) {
        _dataDictionary = [NSMutableDictionary dictionary];
    }
    return _dataDictionary;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    self.player=nil;
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
    [self requestFindEducation:self.eId];
    [self initWithUI];
    [self.view addSubview:self.dataCollectionView];

    WEAKSELF;
    self.dataCollectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (self.dataArray.count > 0) {
            [self.dataArray removeAllObjects];
        }
        [weakSelf requestEducateRecommendUrl:self.eId];
    }];
    [self.dataCollectionView.mj_header beginRefreshing];
}

- (UICollectionView *)dataCollectionView
{
    if (!_dataCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        _dataCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.containerView.frame), ScreenWidth, ScreenHeight - CGRectGetHeight(self.containerView.frame) - StatusBarHeight) collectionViewLayout:flowLayout];
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
        for (UIView *view in [headerView subviews]) {
            if (view != nil) {
                [view removeFromSuperview];
            }
        }
        
        UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, ScreenWidth - 20, 30)];
        label1.textAlignment = NSTextAlignmentLeft;
        label1.font = UIFont(18);
        label1.adjustsFontSizeToFitWidth = YES;
        [headerView addSubview:label1];
        
        UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(label1.frame), ScreenWidth - 20, 30)];
        label2.textAlignment = NSTextAlignmentLeft;
        label2.font = UIFont(12);
        label2.textColor = RGB(102, 102, 102);
        [headerView addSubview:label2];
        
        UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(label2.frame), ScreenWidth - 20, 30)];
        label3.textAlignment = NSTextAlignmentLeft;
        label3.font = UIFont(18);
        label3.adjustsFontSizeToFitWidth = YES;
        label3.text = @"简介";
        [headerView addSubview:label3];
        
        UILabel *label4 = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(label3.frame), ScreenWidth - 20, 30)];
        label4.textAlignment = NSTextAlignmentLeft;
        label4.font = UIFont(15);
        label4.textColor = RGB(102, 102, 102);
        label4.numberOfLines = 0;
        [headerView addSubview:label4];
        
        UILabel *label5 = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(label4.frame), ScreenWidth - 20, 30)];
        label5.textAlignment = NSTextAlignmentLeft;
        label5.font = UIFont(15);
        label5.text = @"为你推荐";
        [headerView addSubview:label5];
        
        UIButton *button1 = [UIButton buttonWithType:(UIButtonTypeCustom)];
        button1.frame = CGRectMake(ScreenWidth - 60, CGRectGetMinY(label3.frame), 40, 30);
        [button1 setImage:[UIImage imageNamed:@"zhuanfa_Image"] forState:(UIControlStateNormal)];
        [button1 addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
        button1.tag = 1;
        [headerView addSubview:button1];
        
        UIButton *button2 = [UIButton buttonWithType:(UIButtonTypeCustom)];
        button2.frame = CGRectMake(CGRectGetMinX(button1.frame) - 40, CGRectGetMinY(label3.frame), 40, 30);
        [button2 setImage:[UIImage imageNamed:@"down_Image"] forState:(UIControlStateNormal)];
        [button2 addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
        button2.tag = 2;
        [headerView addSubview:button2];
        
        if (self.dataDictionary.count > 0) {
            
            label1.text = [NSString stringWithFormat:@"%@", self.dataDictionary[@"eTitle"]];
            label2.text = [NSString stringWithFormat:@"%@次播放", self.dataDictionary[@"ePageview"]];
            NSDictionary *dict110 = @{NSFontAttributeName : [UIFont systemFontOfSize:13.0]};
            NSString *contentStr= [NSString stringWithFormat:@"%@", self.dataDictionary[@"eXqIntro"]];
            CGSize size = [contentStr boundingRectWithSize:CGSizeMake(200, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict110 context:nil].size;
            label4.text = contentStr;
            label4.frame = CGRectMake(10, CGRectGetMaxY(label3.frame), ScreenWidth - 20, size.height);
            label5.frame = CGRectMake(10, CGRectGetMaxY(label4.frame), ScreenWidth - 20, 30);
            
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
    WEAKSELF;
    WooHEducateModel *model = self.dataArray[indexPath.row];
    ZKLog(@"eId -- %@", model.eId);
    
    self.dataCollectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (weakSelf.dataArray.count > 0) {
            [weakSelf.dataArray removeAllObjects];
        }
        [self requestFindEducation:model.eId];

        [weakSelf requestEducateRecommendUrl:model.eId];
    }];
    [self.dataCollectionView.mj_header beginRefreshing];
    
    
}
- (void)initWithUI
{
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, StatusBarHeight)];
    view1.backgroundColor = [UIColor blackColor];
    [self.view addSubview:view1];
    
    self.containerView = [UIView new];
    self.containerView.backgroundColor = [UIColor whiteColor];
    self.controlView = [ZFPlayerControlView new];
    self.playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.playBtn setImage:[UIImage imageNamed:@"new_allPlay_44x44_"] forState:UIControlStateNormal];
    CGFloat x = 0;
    CGFloat y = StatusBarHeight;
    CGFloat w = CGRectGetWidth(self.view.frame);
    CGFloat h = w*9/16;
    self.containerView.frame = CGRectMake(x, y, w, h);
    
    w = 200;
    h = 35;
    x = (self.containerView.frame.size.width - w)/2;
    y = (self.containerView.frame.size.height - h)/2;
    
    w = 44;
    h = w;
    x = (CGRectGetWidth(self.containerView.frame)-w)/2;
    y = (CGRectGetHeight(self.containerView.frame)-h)/2;
    self.playBtn.frame = CGRectMake(x, y, w, h);
    [self.view addSubview:self.containerView];
    [self.containerView addSubview:self.playBtn];
    
    self.playerManager = [[ZFAVPlayerManager alloc] init];
    /// 播放器相关
    self.player1 = [[ZFPlayerController alloc] initWithPlayerManager:self.playerManager containerView:self.containerView];
    
    self.player1.controlView = self.controlView;
    @weakify(self)
    self.player1.orientationWillChange = ^(ZFPlayerController * _Nonnull player, BOOL isFullScreen) {
        @strongify(self)
        [self setNeedsStatusBarAppearanceUpdate];
    };
    NSString *URLString = [@"http://47.92.53.135:8080/video/20180902/e4daa10b4d9a4f079415518c68408ab3.mp4" stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    self.playerManager.assetURL = [NSURL URLWithString:URLString];
    
    UIButton *btn1 = [UIButton buttonWithType:(UIButtonTypeCustom)];
    btn1.frame = CGRectMake(20, StatusBarHeight, 40, 40);
    //    btn1.backgroundColor = [UIColor redColor];
    [btn1 setImage:[UIImage imageNamed:@"playBack_Image"] forState:(UIControlStateNormal)];
    [btn1 addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    btn1.tag = 5;
    [self.view addSubview:btn1];
    
//    self.player = [[SAPlayVideo alloc]initWithFrame:CGRectMake(0, StatusBarHeight, ScreenWidth, 200)];
//    self.player.backgroundColor = [UIColor blackColor];
//    UIButton *button = [self.player viewWithTag:110];
//    button.hidden = YES;
//    //    self.player.videoUrlStr = @"http://220.249.115.46:18080/wav/no.9.mp4";//此处只能真机测试
//    self.player.ButtonAction = ^(UIButton *backBtn) {
//        NSLog(@"backBtn -- %ld", backBtn.tag);
//        if (backBtn.tag == 110) {
//            NSLog(@"分享");
////            [weakSelf shareAction];
//            UIButton *button = [weakSelf.player viewWithTag:110];
//            button.hidden = YES;
//        } else if (backBtn.tag == 1){
//            NSLog(@"横竖屏");
//            UIInterfaceOrientation sataus = [UIApplication sharedApplication].statusBarOrientation;
//            NSLog(@"status -- %ld", (long)sataus);
//            if (!IsPortrait) {
//                weakSelf.dataCollectionView.hidden = YES;
//            } else {
//                weakSelf.dataCollectionView.hidden = NO;
//            }
//        } else if (backBtn.tag == 2){
//            if (!IsPortrait) {
//                weakSelf.dataCollectionView.hidden = YES;
//            } else {
//                weakSelf.dataCollectionView.hidden = NO;
//            }
//            if (IsPortrait) {
//                [weakSelf.navigationController popToRootViewControllerAnimated:YES];
//            }
//        } else {
//            
//        }
//    };
//    [self.view addSubview:self.player];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    if (self.player1.isFullScreen) {
        return UIStatusBarStyleLightContent;
    }
    return UIStatusBarStyleDefault;
}

- (BOOL)prefersStatusBarHidden {
    return self.player1.isStatusBarHidden;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationSlide;
}

- (BOOL)shouldAutorotate {
    return self.player1.shouldAutorotate;
}


- (void)requestFindEducation:(NSString *)eIds
{
    WEAKSELF;
    [self showhudmessage:@"数据加载中..." offy:-100];
    [UserRequestToo shareInstance].rquesturl = EducateDetailUrl;
    [UserRequestToo shareInstance].params = @{@"eId" : eIds};
    [[UserRequestToo shareInstance] statrrequestgetwith:(MHAsiNetWorkGET) successBlock:^(id returnData) {
        [weakSelf hideHud];
        ZKLog(@"returnData -- %@", returnData);
        if ([returnData[@"success"] intValue] == 1) {
            NSString *urlstr=@"www";
            if ([returnData[@"data"][@"eVideolink"]  rangeOfString:urlstr].location != NSNotFound) {
                VideoWooViewController *webview=[[VideoWooViewController alloc] init];
                webview.urlstr=@"https://www.huajiao.com/l/243334116?hd=1";
                [self.navigationController presentViewController:webview animated:NO completion:^{
                    [self.playerManager stop];
                }];
                return;
            }
            if ([returnData[@"data"][@"eVideolink"] length] > 0) {
                weakSelf.playerManager.assetURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@", returnData[@"data"][@"eVideolink"]]];
            } else {
                NSString *URLString = [@"http://47.92.53.135:8080/video/20180902/e4daa10b4d9a4f079415518c68408ab3.mp4" stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
                weakSelf.playerManager.assetURL = [NSURL URLWithString:URLString];
            }
            if (weakSelf.dataDictionary.count > 0) {
                [weakSelf.dataDictionary removeAllObjects];
            }
            weakSelf.dataDictionary = [NSMutableDictionary dictionaryWithDictionary:returnData[@"data"]];
           
            
        } else {
            
        }
    } failureBlock:^(NSError *error) {
        [weakSelf hideHud];
        ZKLog(@"error -- %@", error);
    }];
}
- (void)requestEducateRecommendUrl:(NSString *)eIds
{
    WEAKSELF;
    [UserRequestToo shareInstance].rquesturl = EducateRecommendUrl;
    [UserRequestToo shareInstance].params = @{@"eId" : eIds};
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
        case 2:
        {
            ZKLog(@"下载");
        }
            break;
        case 1:
        {
            [self shareAction];
            ZKLog(@"转发");
        }
            break;
        case 5:
        {
            [self.playerManager stop];
            [self.navigationController popViewControllerAnimated:YES];
        }
            
        default:
            break;
    }
}
#pragma mark -- 分享事件
- (void)shareAction
{
    Sharemangerview *share=[[Sharemangerview alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, ScreenHeight) withtype:shar_type_watch];
    [share setMyblock:^(NSInteger indexrow) {
        SharePlatfrom  mshareToPlatfrom;
        if (indexrow==0) {
            mshareToPlatfrom=share_QQFriend;
        }
        else if (indexrow==1){
            mshareToPlatfrom=share_Qzone;
        }
        else if (indexrow==2){
            mshareToPlatfrom=share_weChat;
        }
        else {
            mshareToPlatfrom=share_timeline;
        }
        NSString *shareurl=@"http://ivi.bupt.edu.cn/hls/cctv6hd.m3u8";
        self.playurl=self.dataDictionary[@"eVideolink"];
        self.sharetitle=self.dataDictionary[@"eTitle"];
        if (self.playurl.length!=0) {
            shareurl=self.playurl;
        }
        [[ShareObject defaultShare] addShareImageUrl:@"http://47.92.53.135:8080/meeting/20180907/d8d53dd600d04628a23dfdcc3c77db46.jpg" shareText: self.sharetitle shareTitle:WOWOInvitationCode shareUrl:shareurl shareCompletionBlcok:^(SSDKResponseState state) {
            
        }];
        [[ShareObject defaultShare] shareToPlatfrom:mshareToPlatfrom fromecontroller:self ContentType:SSDKContentTypeWebPage];
    }];
    [share shareviewShow];
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
