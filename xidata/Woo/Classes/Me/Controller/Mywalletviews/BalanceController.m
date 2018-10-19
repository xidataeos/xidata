

//
//  BalanceController.m
//  Woo
//
//  Created by 王起锋 on 2018/10/11.
//  Copyright © 2018年 杭州蜂布式. All rights reserved.
//

#import "BalanceController.h"
#import "BalanceViewCell.h"
#import "FullTimeView.h"
@interface BalanceController ()
<UITableViewDelegate, UITableViewDataSource,FinishPickView>
{
    NSString *currentDate;
    UIView *topView;
    NSDate *currdate;
    
}
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) UILabel *incomeLabel;
@property (nonatomic, strong) UILabel *outLabel;
@property (nonatomic, strong) UILabel *dataLabel;
@property (nonatomic, strong) UIButton *selectdataBtn;
@end

@implementation BalanceController
-(UIButton *)selectdataBtn
{
    if (_selectdataBtn==nil) {
        _selectdataBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _selectdataBtn.frame=CGRectMake(SCREEN_WIDTH-65*KWidth_Scale,0, 50*KWidth_Scale, 50*KWidth_Scale);
        [_selectdataBtn setImage:[UIImage imageNamed:@"yaoqingjiangli_Image"] forState:UIControlStateNormal];
        [_selectdataBtn setImageEdgeInsets:UIEdgeInsetsMake(0*KWidth_Scale, 25*KWidth_Scale, 12*KWidth_Scale, 0)];
        [_selectdataBtn addTarget:self action:@selector(selectdataclick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectdataBtn;
}
-(void)cancleBtnClick{
    [topView removeFromSuperview];
}
-(void)okBtnClick{
    [topView removeFromSuperview];
    //获取当前时间
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM"];
    NSString *DateTime = [formatter stringFromDate:currdate];
    currentDate=DateTime;
    //判断 进来时currentDate是否==nil 如果是空 赋值当前时间 如果不是就拿从currentDate获取到的值进行赋值
    if (DateTime.length!=0) {
        self.dataLabel.text=DateTime;
    }
}
-(void)didFinishPickView:(NSDate *)date
{
    currdate=date;
}
-(void)selectdataclick
{
    topView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-256, self.view.frame.size.width, 256)];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    
    UIView *selectView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,40)];
    selectView.backgroundColor = [[UIColor alloc]initWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    [topView addSubview:selectView];
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(10, 0, 50, 40);
    [leftBtn setTitle:@"取消" forState:UIControlStateNormal];
    [leftBtn setTitleColor:NaviBackgroundColor forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(cancleBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [selectView addSubview:leftBtn];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(self.view.frame.size.width-60, 0, 50, 40);
    [rightBtn setTitle:@"确定" forState:UIControlStateNormal];
    [rightBtn setTitleColor:NaviBackgroundColor forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(okBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [selectView addSubview:rightBtn];
    
    FullTimeView *fullTimePicker = [[FullTimeView alloc]initWithFrame:CGRectMake(0, 40, self.view.frame.size.width, 216)];
    fullTimePicker.curDate = [NSDate date];
    fullTimePicker.delegate = self;
    [topView addSubview:fullTimePicker];
}
-(UILabel *)dataLabel
{
    if (_dataLabel==nil) {
        _dataLabel=[[UILabel alloc] initWithFrame:CGRectMake(15*KWidth_Scale, 0*KWidth_Scale, SCREEN_WIDTH*0.6, 25*KWidth_Scale)];
        _dataLabel.textColor=WordsofcolorColor;
        _dataLabel.font=UIFont(15);
        _dataLabel.text=@"9月";
    }
    return _dataLabel;
}
-(UILabel *)incomeLabel
{
    if (_incomeLabel==nil) {
        _incomeLabel=[[UILabel alloc] initWithFrame:CGRectMake(10*KWidth_Scale, 25*KWidth_Scale, 120*KWidth_Scale, 20*KWidth_Scale)];
        _incomeLabel.textColor=RGB(102, 102, 102);
        _incomeLabel.font=UIFont(12);
        _incomeLabel.textAlignment=NSTextAlignmentCenter;
        _incomeLabel.text=@"本月收:入2989.00";
    }
    return _incomeLabel;
}
-(UILabel *)outLabel
{
    if (_outLabel==nil) {
        _outLabel=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.incomeLabel.frame), 25*KWidth_Scale, 90*KWidth_Scale, 20*KWidth_Scale)];
        _outLabel.textColor=RGB(102, 102, 102);
        _outLabel.font=UIFont(12);
        _outLabel.textAlignment=NSTextAlignmentCenter;
        _outLabel.text=@"支出:2989.00";
    }
    return _outLabel;
}
-(UITableView *)myTableView{
    if (!_myTableView) {
        _myTableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-StatusBarAndNavigationBarHeight) style:UITableViewStyleGrouped];
        //_myTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
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
    UIView *heaview=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50*KWidth_Scale)];
    heaview.backgroundColor=[UIColor whiteColor];
    [heaview addSubview:self.dataLabel];
    [heaview addSubview:self.incomeLabel];
    [heaview addSubview:self.outLabel];
    [heaview addSubview:self.selectdataBtn];
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
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *onecellid=@"BalanceViewCell";
    BalanceViewCell *Commentcell=[tableView dequeueReusableCellWithIdentifier:onecellid];
    Commentcell=[[BalanceViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:onecellid];
    Commentcell.titllabel.text=@"收支明细";
    Commentcell.detailcellLabel.text=@"今天 09:30";
    Commentcell.cellLabel.text=@"+100";
    return Commentcell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55*KWidth_Scale;
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
