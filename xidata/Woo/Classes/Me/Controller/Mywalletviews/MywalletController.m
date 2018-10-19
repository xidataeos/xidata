//
//  MywaooetController.m
//  Woo
//
//  Created by 王起锋 on 2018/10/11.
//  Copyright © 2018年 杭州蜂布式. All rights reserved.
//

#import "MywalletController.h"
#import "MywalletCell.h"
#import "BalanceController.h"
#import "AccountSettingsController.h"
#import "WithdrawaController.h"
@interface MywalletController ()
<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) UILabel *incomeLabel;
@end

@implementation MywalletController
-(UILabel *)incomeLabel
{
    if (_incomeLabel==nil) {
        _incomeLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 25*KWidth_Scale, SCREEN_WIDTH, 40*KWidth_Scale)];
        _incomeLabel.textColor=WordsofcolorColor;
        _incomeLabel.font=UIFont(40);
        _incomeLabel.textAlignment=NSTextAlignmentCenter;
        _incomeLabel.text=@"2989.00";
    }
    return _incomeLabel;
}
-(UITableView *)myTableView{
    if (!_myTableView) {
        _myTableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-StatusBarAndNavigationBarHeight) style:UITableViewStyleGrouped];
    _myTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        //_myTableView.allowsSelection=NO;
        _myTableView.delegate=self;
        _myTableView.dataSource = self;
        _myTableView.showsVerticalScrollIndicator = NO;
        _myTableView.showsHorizontalScrollIndicator = NO;
        [_myTableView setTableFooterView:[UIView new]];
        _myTableView.separatorColor=CellBackgroundColor;
        _myTableView.backgroundColor=[UIColor whiteColor];
        if (@available(iOS 11.0, *)) {
            _myTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _myTableView.estimatedRowHeight = 0;
            _myTableView.estimatedSectionFooterHeight = 0;
            _myTableView.estimatedSectionHeaderHeight = 0;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        [self.view  addSubview:_myTableView];
    }
    return _myTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"我的钱包";
    [self.view addSubview:self.myTableView];
    UIView *heaview=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 130*KWidth_Scale)];
    UIView *cell=[[UIView alloc] initWithFrame:CGRectMake(0, 115*KWidth_Scale, SCREEN_WIDTH, 15*KWidth_Scale)];
    cell.backgroundColor=[UIColor whiteColor];
    [heaview addSubview:cell];
    [heaview addSubview:self.incomeLabel];
    UILabel *leiji=[[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.incomeLabel.frame), SCREEN_WIDTH, 50*KWidth_Scale)];
    leiji.textAlignment=NSTextAlignmentCenter;
    leiji.textColor=WordsofcolorColor;
    leiji.font=UIFont(13);
    leiji.text=@"累计收入 (元)";
    heaview.backgroundColor=[UIColor whiteColor];
    [heaview addSubview:leiji];
    [self.myTableView setTableHeaderView:heaview];
    [self loadata];
}
-(void)loadata
{
    [self.myTableView reloadData];
}
#pragma mark - <UITableViewDelegate, UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *onecellid=@"Guanzhucell";
    MywalletCell *Commentcell=[tableView dequeueReusableCellWithIdentifier:onecellid];
    Commentcell=[[MywalletCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:onecellid indexpath:indexPath];
    Commentcell.selectionStyle=UITableViewCellSelectionStyleNone;
    if (indexPath.row==1) {
        Commentcell.titllabel.text=@"收支明细";
    }
    else if(indexPath.row==2){
        Commentcell.titllabel.text=@"提现账户";
    }
    WEAKSELF;
    [Commentcell setWithdrawalBlock:^{
        WithdrawaController *Withd=[[WithdrawaController alloc] init];
        [weakSelf.navigationController pushViewController:Withd animated:YES];
    }];
    return Commentcell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row==0) {
        return 135*KWidth_Scale;
    }
    return 65*KWidth_Scale;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row==1) {
        BalanceController *Balance=[[BalanceController alloc] init];
        [self.navigationController pushViewController:Balance animated:YES];
    }
   else  if (indexPath.row==2) {
       AccountSettingsController *Balance=[[AccountSettingsController alloc] init];
       [self.navigationController pushViewController:Balance animated:YES];
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
