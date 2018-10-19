
//
//  HaveSumitController.m
//  Woo
//
//  Created by 王起锋 on 2018/10/14.
//  Copyright © 2018年 杭州蜂布式. All rights reserved.
//

#import "HaveSumitController.h"
#import "MygraphicTableViewCell.h"
@interface HaveSumitController ()
<UITableViewDelegate, UITableViewDataSource,GGActionSheetDelegate>
@property(nonatomic,strong) GGActionSheet *actionSheetImg;
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) UILabel *tableviewtitle;
@end

@implementation HaveSumitController
-(UILabel *)tableviewtitle
{
    if (_tableviewtitle==nil) {
        _tableviewtitle=[[UILabel alloc] initWithFrame:CGRectMake(10*KWidth_Scale,0,SCREEN_WIDTH*0.8, 40*KWidth_Scale)];
        _tableviewtitle.font=UIFont(12);
        _tableviewtitle.textColor=WordsofcolorColor;
    }
    return _tableviewtitle;
}
-(UITableView *)myTableView{
    if (!_myTableView) {
        _myTableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-StatusBarAndNavigationBarHeight-50) style:UITableViewStyleGrouped];
        //_myTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
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
    [self.view addSubview:self.myTableView];
    UIView *headview=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40*KWidth_Scale)];
    headview.backgroundColor=CellBackgroundColor;
    self.tableviewtitle.text=@"共有2篇文章";
    [headview addSubview:self.tableviewtitle];
    [self.myTableView setTableHeaderView:headview];
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
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *onecellid=@"Guanzhucell";
    MygraphicTableViewCell *Commentcell=[tableView dequeueReusableCellWithIdentifier:onecellid];
    Commentcell=[[MygraphicTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:onecellid];
    Commentcell.textLabel.font=UIFont(15);
    __strong typeof(MygraphicTableViewCell *) strongcell=Commentcell;
    WEAKSELF;
    [Commentcell setMoreblock:^{
        [weakSelf showActionsheet:strongcell];
    }];
    return Commentcell;
}
#pragma mark - GGActionSheet代理方法
-(void)GGActionSheetClickWithIndex:(int)index{
    NSLog(@"--------->点击了第%d个按钮<----------",index);
}
-(GGActionSheet *)actionSheetImg{
    if (!_actionSheetImg) {
        _actionSheetImg = [GGActionSheet ActionSheetWithImageArray:@[@"alipay233",@"wechatpay233"] delegate:self];
        _actionSheetImg.cancelDefaultColor = [UIColor redColor];
    }
    return _actionSheetImg;
}
-(void)showActionsheet:(MygraphicTableViewCell *)cell
{
    [self.actionSheetImg showGGActionSheet];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80*KWidth_Scale;
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
    if (indexPath.row==0) {
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
