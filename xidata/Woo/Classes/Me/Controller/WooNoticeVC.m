//
//  WooNoticeVC.m
//  Woo
//
//  Created by 风外杏林香 on 2018/9/3.
//  Copyright © 2018年 杭州蜂布式. All rights reserved.
//

#import "WooNoticeVC.h"
#import "Guanzhucell.h"
#import "WooHMeetingModel.h"
#import "CopyrightViewController.h"
@interface WooNoticeVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)UITableView *dataTableView;
@end

@implementation WooNoticeVC
#pragma mark -- 请求数据
- (void)requestData
{
    WEAKSELF;
    [self showWithStatus:@"加载中..."];
    [UserRequestToo shareInstance].rquesturl = myappleMeeting;
    NSDictionary *dict = @{@"userId" : RCLOUD_ID};
    [UserRequestToo shareInstance].params = dict;
    [[UserRequestToo shareInstance] statrrequestgetwith:(MHAsiNetWorkGET) successBlock:^(id returnData) {
        [weakSelf dismiss];
        [self.dataTableView.mj_footer endRefreshing];
        ZKLog(@"returnData -- %@", returnData);
        if ([returnData[@"success"] intValue] == 1) {
            if ([returnData[@"data"] count] > 0) {
                for (NSDictionary *dict110 in returnData[@"data"]) {
                    WooHMeetingModel *model = [WooHMeetingModel mj_objectWithKeyValues:dict110];
                    [weakSelf.dataArray addObject:model];
                }
            }
        }
        if (weakSelf.dataArray.count != 0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.dataTableView reloadData];
            });
        }
        
    } failureBlock:^(NSError *error) {
        [weakSelf dismiss];
        ZKLog(@"error -- %@", error);
        [self.dataTableView.mj_footer endRefreshing];
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestData];
    // Do any additional setup after loading the view.
    self.title = @"消息提醒";
    [self.view addSubview:self.dataTableView];
}
- (UITableView *)dataTableView
{
    if (!_dataTableView) {
        _dataTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - StatusBarAndNavigationBarHeight) style:(UITableViewStyleGrouped)];
        _dataTableView.separatorColor=CellBackgroundColor;
        _dataTableView.delegate = self;
        _dataTableView.dataSource = self;
        if (@available(iOS 11.0, *)) {
            //当有heightForHeader delegate时设置
            _dataTableView.estimatedSectionHeaderHeight = 0;
            //当有heightForFooter delegate时设置
            _dataTableView.estimatedSectionFooterHeight = 0;
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
    }
    Guanzhucell *noticeCell = [[Guanzhucell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    WooHMeetingModel *model = [self.dataArray objectAtIndex:indexPath.row];
    CopyrightViewController *singVC = [[CopyrightViewController alloc]init];
    singVC.mId = [NSString stringWithFormat:@"%@", model.mId];
    [self.navigationController pushViewController:singVC animated:YES];
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
