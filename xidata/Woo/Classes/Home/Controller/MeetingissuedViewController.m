
//
//  MeetingissuedViewController.m
//  Woo
//
//  Created by 王起锋 on 2018/8/2.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//会议发布页面

#import "MeetingissuedViewController.h"
#import "WooMeetingCell.h"
#import "WooHMeetingModel.h"
#import "WooSingupViewController.h"
@interface MeetingissuedViewController ()<UITableViewDelegate, UITableViewDataSource, SDCycleScrollViewDelegate>
{
    int pageNum;
}
@property (nonatomic, strong)UITableView *dataTableView;
@property (nonatomic, strong)SDCycleScrollView *cycleScrollView;
@property (nonatomic, strong)NSMutableArray *bannerArray;;
@end

@implementation MeetingissuedViewController

- (NSMutableArray *)bannerArray
{
    if (!_bannerArray) {
        _bannerArray = [[NSMutableArray alloc] init];
    }
    return _bannerArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.dataTableView];
    pageNum = 1;
    WEAKSELF;
    [self requestCycleView];
    self.dataTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if (self.dataArray.count > 0) {
           //[self.dataArray removeAllObjects];
        }
        [weakSelf requestData];
    }];
    [self.dataTableView.mj_footer beginRefreshing];
    
}

- (UITableView *)dataTableView
{
    if (!_dataTableView) {
        _dataTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 50 - 40 - TabbarHeight - StatusBarAndNavigationBarHeight) style:(UITableViewStyleGrouped)];
        _dataTableView.delegate = self;
        _dataTableView.dataSource = self;
        if (@available(iOS 11.0, *)) {
            _dataTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _dataTableView.estimatedRowHeight = 0;
            _dataTableView.estimatedSectionFooterHeight = 0;
            _dataTableView.estimatedSectionHeaderHeight = 0;
        }
    }
    return _dataTableView;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    WooMeetingCell *meetCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (meetCell == nil) {
        meetCell = [[WooMeetingCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
    }
    if (self.dataArray.count != 0) {
        meetCell.model = self.dataArray[indexPath.row];
    }
    
    meetCell.selectionStyle = UITableViewCellSelectionStyleNone;
    self.dataTableView.separatorStyle = NO;
    return meetCell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return  220;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 235;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 220)];
    headerView.backgroundColor = [UIColor whiteColor];
    self.cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(10, 10, ScreenWidth - 20, 190) delegate:self placeholderImage:[UIImage imageNamed:@""]];
    self.cycleScrollView.layer.masksToBounds = YES;
    self.cycleScrollView.layer.cornerRadius = 5;
    NSMutableArray *appImage = [NSMutableArray array];
    for (int i = 0; i < self.bannerArray.count; i ++) {
        NSDictionary *dict = [NSDictionary dictionary];
        dict = [self.bannerArray objectAtIndex:i];
        [appImage addObject:[dict objectForKey:@"mImg"]];
    }
    self.cycleScrollView.imageURLStringsGroup =appImage;
    self.cycleScrollView.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:self.cycleScrollView];
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.cycleScrollView.frame) + 10, ScreenWidth, 10)];
    line.backgroundColor = RGB(235, 235, 235);
    [headerView addSubview:line];
    return headerView;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WooHMeetingModel *model = [self.dataArray objectAtIndex:indexPath.row];
    WooSingupViewController *singVC = [[WooSingupViewController alloc]init];
    singVC.mId = [NSString stringWithFormat:@"%@", model.mId];
    [self.navigationController pushViewController:singVC animated:YES];
    ZKLog(@"%@", model.mId);
}

#pragma mark  --  请求轮播图
- (void)requestCycleView
{
    WEAKSELF;
    [UserRequestToo shareInstance].rquesturl = HomeMeetingCycUrl;
    NSMutableDictionary *parametDic = [NSMutableDictionary dictionaryWithCapacity:9];
    [UserRequestToo shareInstance].params=parametDic;
    [[UserRequestToo shareInstance]statrrequestgetwith:(MHAsiNetWorkGET) successBlock:^(id returnData) {
        ZKLog(@"returnData -- %@", returnData);
        if ([returnData[@"success"] intValue] == 1) {
            self.bannerArray = [[NSMutableArray alloc] initWithArray:returnData[@"data"]];
        } else {
            
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.dataTableView reloadData];
        });
        
    } failureBlock:^(NSError *error) {
        ZKLog(@"error -- %@", error);
    }];
}
#pragma mark -- SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    ZKLog(@"index -- %ld", index);
    NSDictionary *dictionary = [self.bannerArray objectAtIndex:index];
    ZKLog(@"%@", dictionary[@"mId"]);
    WooSingupViewController *singVC = [[WooSingupViewController alloc]init];
    singVC.mId = [NSString stringWithFormat:@"%@", dictionary[@"mId"]];
    [self.navigationController pushViewController:singVC animated:YES];
}
#pragma mark -- 请求数据
- (void)requestData
{
    WEAKSELF;
    [UserRequestToo shareInstance].rquesturl = HomeMeetingUrl;
    NSDictionary *dict = @{@"pageNum" : [NSNumber numberWithInt:pageNum]};
    [UserRequestToo shareInstance].params = dict;
    [[UserRequestToo shareInstance] statrrequestgetwith:(MHAsiNetWorkGET) successBlock:^(id returnData) {
        [self.dataTableView.mj_footer endRefreshing];
        ZKLog(@"returnData -- %@", returnData);
        if ([returnData[@"success"] intValue] == 1) {
            pageNum++;
            if ([returnData[@"data"] count] > 0) {
                for (NSDictionary *dict110 in returnData[@"data"]) {
                    WooHMeetingModel *model = [WooHMeetingModel mj_objectWithKeyValues:dict110];
                    [weakSelf.dataArray addObject:model];
                }
            }
            else if ([returnData[@"data"] count]==0){
                [self showAlertHud:self.view.center withStr:@"我是有底线的" offy:-100];
            }
        }
        if (weakSelf.dataArray.count != 0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.dataTableView reloadData];
            });
        }
        
    } failureBlock:^(NSError *error) {
        ZKLog(@"error -- %@", error);
        [self.dataTableView.mj_footer endRefreshing];
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
