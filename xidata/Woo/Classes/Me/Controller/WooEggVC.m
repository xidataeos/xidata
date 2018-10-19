//
//  WooEggVC.m
//  Woo
//
//  Created by 风外杏林香 on 2018/9/4.
//  Copyright © 2018年 杭州蜂布式. All rights reserved.
//

#import "WooEggVC.h"
#import "WooEggCell1.h"
#import "WooEggCell2.h"
#import "WooEggCell3.h"
#import "WooEggCell4.h"
#import "WooEggDetailView.h"
#import "WooEggModel.h"
#import "WooDrawEggModel.h"
#import "WooJoinEggModel.h"
@interface WooEggVC ()<UITableViewDelegate, UITableViewDataSource, WooEggCell4Delegate>
{
    NSInteger isSelected;
    NSInteger pageSize;
    NSInteger pageNum;
}

@property (nonatomic, strong)UITableView *dataTableView;
@property (nonatomic, strong)NSMutableArray *indexPaths;//展开cell的index


@end

@implementation WooEggVC

- (NSMutableArray *)indexPaths
{
    if (!_indexPaths) {
        _indexPaths = [NSMutableArray array];
    }
    return _indexPaths;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    isSelected = 1;
    pageNum = 1;
    pageSize = 10;
    self.title = @"我的彩蛋";
    [self.view addSubview:self.dataTableView];
    WEAKSELF;
    self.dataTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//        if (weakSelf.dataArray.count > 0) {
//            [weakSelf.dataArray removeAllObjects];
//        }
        if (isSelected == 1) {
            [weakSelf requestTrade];
        } else if (isSelected == 2) {
            [weakSelf requestFindGame];
        } else {
            [weakSelf requestGameInfo];
        }
    }];
    [self.dataTableView.mj_footer beginRefreshing];
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    } else
        return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
    }
    
    if (indexPath.section == 0) {
        WooEggCell1 *cell1 = [[WooEggCell1 alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
        
        cell = cell1;
    } else if (indexPath.section == 1){
        if (isSelected == 1) {
            WooEggCell2 *cell2 = [[WooEggCell2 alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
            if (self.dataArray.count > 0) {
                cell2.model = self.dataArray[indexPath.row];
            }
            cell = cell2;
        }
        if (isSelected == 2) {
            WooEggCell3 *cell3 = [[WooEggCell3 alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
            if (self.dataArray.count > 0) {
                cell3.model = self.dataArray[indexPath.row];
            }
            cell = cell3;
        }
        if (isSelected == 3) {
            WooEggCell4 *cell4 = [[WooEggCell4 alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
            cell4.delegate = self;
            
            
            if (self.indexPaths.count > 0) {
                int n = 0;
                for (int i = 0; i < [self.indexPaths count]; i++) {
                    NSIndexPath *oneIndex = [self.indexPaths objectAtIndex:i];
                    if (oneIndex.row == indexPath.row & oneIndex.section == indexPath.section) {
                        n = 1;
                    }
                }
                if (n == 1) {
                    ZKLog(@"加载展开视图");
                    WooEggDetailView *detailView = [[WooEggDetailView alloc]initWithFrame:CGRectMake(0, 60, ScreenWidth, 164) model:self.dataArray[indexPath.row]];
                    [cell4.contentView addSubview:detailView];
                }
            }
            if (self.dataArray.count) {
                cell4.model = self.dataArray[indexPath.row];
            }
            cell = cell4;
        }
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark -- WooEggCell4Delegate
- (void)didClickButtonInCell:(WooEggCell4 *)cell
{
    NSIndexPath *index = [self.dataTableView indexPathForCell:cell];
    ZKLog(@"index -- %ld, section -- %ld", index.row, index.section);
    
    if ([self.indexPaths count]>0) {
        int n = 0;
        for (int i = 0; i < [self.indexPaths count]; i ++) {
            NSIndexPath *oneIndexPath = [self.indexPaths objectAtIndex:i];
            if (oneIndexPath.row == index.row && oneIndexPath.section == index.section) {
                [self.indexPaths removeObjectAtIndex:i];
                n = 1;
            }
        }
        if (n == 0) {
            [self.indexPaths addObject:index];
        }
    } else
        [self.indexPaths addObject:index];
    
    //刷新
    [self.dataTableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return CGFLOAT_MIN;
    } else
        return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 10;
    } else
        return CGFLOAT_MIN;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 150;
    } else if (indexPath.section == 1) {
        if (isSelected == 1 || isSelected == 2) {
            return 60;
        } else {
            if (self.indexPaths.count > 0) {
                int n = 0;
                for (int i = 0; i < [self.indexPaths count]; i++) {
                    NSIndexPath *oneIndex = [self.indexPaths objectAtIndex:i];
                    if (oneIndex.row == indexPath.row & oneIndex.section == indexPath.section) {
                        n = 1;
                    }
                }
                if (n == 1) {
                    return 224;
                } else
                    return 60;
            } else
            return 60;
        }
    } else {
        return 50;
    }
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc]init];
    if (section == 1) {
        headerView.backgroundColor = [UIColor whiteColor];
        headerView.frame = CGRectMake(0, 0, ScreenWidth, 40);
        NSArray *btnArr = @[@"账单明细", @"正在参与", @"已开奖"];
        CGFloat width = (ScreenWidth - 40) / 3;
        
        for (int i = 0; i < 3; i ++) {
            UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
            button.frame = CGRectMake(20 + width * i, 5, width, 30);
            [button setTitle:[NSString stringWithFormat:@"%@", btnArr[i]] forState:(UIControlStateNormal)];
            [button setTitleColor:RGB(153, 153, 153) forState:(UIControlStateNormal)];
            button.titleLabel.font = UIFont(15);
            button.tag = i + 1;
            if (isSelected == 1) {
                if (button.tag == 1) {
                    button.selected = YES;
                    button.layer.masksToBounds = YES;
                    button.layer.cornerRadius = 3;
                    [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateSelected)];
                    button.backgroundColor = RGB(255, 101, 0);
                }
            }
            if (isSelected == 2) {
                if (button.tag == 2) {
                    button.selected = YES;
                    button.layer.masksToBounds = YES;
                    button.layer.cornerRadius = 3;
                    [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateSelected)];
                    button.backgroundColor = RGB(255, 101, 0);
                }
            }
            if (isSelected == 3) {
                if (button.tag == 3) {
                    button.selected = YES;
                    button.layer.masksToBounds = YES;
                    button.layer.cornerRadius = 3;
                    [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateSelected)];
                    button.backgroundColor = RGB(255, 101, 0);
                }
            }
            [button addTarget: self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
            [headerView addSubview:button];
        }
    }
    return headerView;
}

- (void)buttonAction:(UIButton *)sender
{
    if (self.dataArray.count > 0) {
        [self.dataArray removeAllObjects];
    }
    
    for (int i = 0; i < 3; i ++) {
        UIButton *button = [self.dataTableView viewWithTag:i + 1];
        if (sender.tag == i + 1) {
            button.selected = YES;
            button.layer.masksToBounds = YES;
            button.layer.cornerRadius = 3;
            [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateSelected)];
            button.backgroundColor = RGB(255, 101, 0);
           
            if (sender.tag == 1) {
                isSelected = 1;
                pageNum = 1;
                [self requestTrade];
            }
            if (sender.tag == 2) {
                isSelected = 2;
                pageNum = 1;
                [self requestFindGame];
            }
            if (sender.tag == 3) {
                isSelected = 3;
                pageNum = 1;
                [self requestGameInfo];
            }
        } else {
            button.selected = NO;
            button.layer.borderWidth = 0;
            button.backgroundColor = [UIColor whiteColor];
            [button setTitleColor:RGB(153, 153, 153) forState:(UIControlStateNormal)];
        }
    }
}

- (void)requestTrade
{
    WEAKSELF;
    [UserRequestToo shareInstance].rquesturl = TradeUrl;
    [UserRequestToo shareInstance].params = @{@"userId" : [UserDefaults objectForKey:@"userId"],
                                              @"pageNum" : [NSNumber numberWithInteger:pageNum],
                                              @"pageSize" : [NSNumber numberWithInteger:pageSize]};
    [[UserRequestToo shareInstance] statrrequestgetwith:(MHAsiNetWorkGET) successBlock:^(id returnData) {
        [self.dataTableView.mj_footer endRefreshing];
        if ([returnData[@"success"] intValue] == 1) {
            pageNum ++;
            NSMutableArray *array = [returnData objectForKey:@"data"];
            if (array.count > 0) {
                for (NSDictionary *dict110 in array) {
                    WooEggModel *model = [WooEggModel new];
                    model.ids = [NSString stringWithFormat:@"%@", dict110[@"id"]];
                    model.asset = [NSString stringWithFormat:@"%@", dict110[@"asset"]];
                    model.coin = [NSString stringWithFormat:@"%@", dict110[@"coin"]];
                    model.isIncome = [NSString stringWithFormat:@"%@", dict110[@"isIncome"]];
                    model.isMulti = [NSString stringWithFormat:@"%@", dict110[@"isMulti"]];
                    model.otherSide = [NSString stringWithFormat:@"%@", dict110[@"otherSide"]];
                    model.payType = [NSString stringWithFormat:@"%@", dict110[@"payType"]];
                    model.refund = [NSString stringWithFormat:@"%@", dict110[@"refund"]];
                    model.scene = [NSString stringWithFormat:@"%@", dict110[@"scene"]];
                    model.tip = [NSString stringWithFormat:@"%@", dict110[@"tip"]];
                    model.tradeEntity = [NSString stringWithFormat:@"%@", dict110[@"tradeEntity"]];
                    model.tradeId = [NSString stringWithFormat:@"%@", dict110[@"tradeId"]];
                    model.tradeTime = [NSString stringWithFormat:@"%@", dict110[@"tradeTime"]];
                    model.tradeType = [NSString stringWithFormat:@"%@", dict110[@"tradeType"]];
                    [self.dataArray addObject:model];
                }
            } else if (array.count == 0) {
                [self showAlertHud:self.view.center withStr:@"我是有底线的" offy:-100];
            }
            
        } else {
            [PublicFunction showAlert:@"" message:[returnData objectForKey:@"message"]];
        }
        if (weakSelf.dataArray.count != 0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.dataTableView reloadData];
            });
        }
    } failureBlock:^(NSError *error) {
        [self.dataTableView.mj_footer endRefreshing];
        ZKLog(@"error -- %@", error);
    }];
}
#pragma maek -- 正在参与
- (void)requestFindGame
{
    WEAKSELF;
    [UserRequestToo shareInstance].rquesturl = FindGameByUserInfoUrl;
    [UserRequestToo shareInstance].params = @{@"userId" : [UserDefaults objectForKey:@"userId"],
                                              @"pageNum" : [NSNumber numberWithInteger:pageNum],
                                              @"pageSize" : [NSNumber numberWithInteger:pageSize]};
    [[UserRequestToo shareInstance] statrrequestgetwith:(MHAsiNetWorkGET) successBlock:^(id returnData) {
        ZKLog(@"returnData -- %@", returnData);
        [self.dataTableView.mj_footer endRefreshing];
        if ([returnData[@"success"] intValue] == 1) {
            pageNum ++;
            NSMutableArray *array = [returnData objectForKey:@"data"];
            if (array.count > 0) {
                for (NSDictionary *dict110 in array) {
                    WooJoinEggModel *model = [WooJoinEggModel mj_objectWithKeyValues:dict110];
                    [weakSelf.dataArray addObject:model];
                }
            } else if (array.count == 0) {
                [self showAlertHud:self.view.center withStr:@"我是有底线的" offy:-100];
            }
            
        } else {
            [PublicFunction showAlert:@"" message:[returnData objectForKey:@"message"]];
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
#pragma mark -- 已开奖
- (void)requestGameInfo
{
    WEAKSELF;
    [UserRequestToo shareInstance].rquesturl = GameInfoUrl;
    [UserRequestToo shareInstance].params = @{@"userId" : [UserDefaults objectForKey:@"userId"],
                                              @"pageNum" : [NSNumber numberWithInteger:pageNum],
                                              @"pageSize" : [NSNumber numberWithInteger:pageSize]};
    [[UserRequestToo shareInstance] statrrequestgetwith:(MHAsiNetWorkGET) successBlock:^(id returnData) {
        ZKLog(@"returnData -- %@", returnData);
        [self.dataTableView.mj_footer endRefreshing];
        if ([returnData[@"success"] intValue] == 1) {
            pageNum ++;
            NSMutableArray *array = [returnData objectForKey:@"data"];
            if (array.count > 0) {
                for (NSDictionary *dict110 in array) {
                    WooDrawEggModel *model = [WooDrawEggModel mj_objectWithKeyValues:dict110];
                    [weakSelf.dataArray addObject:model];
                }
                
            } else if (array.count == 1) {
                [self showAlertHud:self.view.center withStr:@"我是有底线的" offy:-100];
            }
            
        } else {
            [PublicFunction showAlert:@"" message:[returnData objectForKey:@"message"]];
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
