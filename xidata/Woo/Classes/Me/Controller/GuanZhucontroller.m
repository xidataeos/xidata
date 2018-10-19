//
//  WooYaoQingVC.m
//  Woo
//
//  Created by 风外杏林香 on 2018/8/10.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import "GuanZhucontroller.h"
#import "Guanzhucell.h"
#import "OthershomepageController.h"
@interface GuanZhucontroller ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *myTableView;
@end

@implementation GuanZhucontroller

-(UITableView *)myTableView{
    if (!_myTableView) {
        _myTableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-StatusBarAndNavigationBarHeight) style:UITableViewStyleGrouped];
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
    UIView *heaview=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 8*KWidth_Scale)];
    heaview.backgroundColor=CellBackgroundColor;
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
        Guanzhucell *Commentcell=[tableView dequeueReusableCellWithIdentifier:onecellid];
        Commentcell=[[Guanzhucell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:onecellid];
        return Commentcell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60*KWidth_Scale;
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
    OthershomepageController *homepage=[[OthershomepageController alloc] init];
    WooBaseNavigationViewController *navi=[[WooBaseNavigationViewController alloc] initWithRootViewController:homepage];
    [self.navigationController presentViewController:navi animated:YES completion:nil];
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
