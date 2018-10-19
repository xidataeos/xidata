
//
//  AboutViewController.m
//  Woo
//
//  Created by 王起锋 on 2018/10/11.
//  Copyright © 2018年 杭州蜂布式. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *myTableView;
@end

@implementation AboutViewController

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
    self.title=@"关于我们";
    [self.view addSubview:self.myTableView];
    UIView *heaview=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 210*KWidth_Scale)];
    heaview.backgroundColor=[UIColor whiteColor];
    UIView *cell=[[UIView alloc] initWithFrame:CGRectMake(0, 200*KWidth_Scale, SCREEN_WIDTH, 10*KWidth_Scale)];
    cell.backgroundColor=CellBackgroundColor;
    [heaview addSubview:cell];
    UIImageView *logo=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80*KWidth_Scale, 80*KWidth_Scale)];
    logo.layer.cornerRadius=40*KWidth_Scale;
    logo.clipsToBounds=YES;
    logo.center=heaview.center;
    logo.image=[UIImage imageNamed:@"logo_icon"];
    [heaview addSubview:logo];
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
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *onecellid=@"Guanzhucell";
    UITableViewCell *Commentcell=[tableView dequeueReusableCellWithIdentifier:onecellid];
    Commentcell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:onecellid];
    Commentcell.textLabel.font=UIFont(15);
    if (indexPath.row==0) {
        Commentcell.textLabel.text=@"联系我们";
    }
    else{
        Commentcell.textLabel.text=@"服务协议";
    }
 Commentcell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return Commentcell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50*KWidth_Scale;
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
        [self setMyServiceVC];
    }
}
-(void)setMyServiceVC{
    /**
     拨打400电话
     */
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"联系客服" message:[NSString stringWithFormat:@"拨打 0571-0236985"] preferredStyle:UIAlertControllerStyleAlert];//UIAlertControllerStyleAlert视图在中央
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString *callPhone = [NSString stringWithFormat:@"tel://0571-0236985"];
        CGFloat version = [[[UIDevice currentDevice]systemVersion]floatValue];
        if (version >= 10.0) {
            /// 大于等于10.0系统使用此openURL方法
            if (@available(iOS 10.0, *)) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone] options:@{} completionHandler:nil];
            } else {
                // Fallback on earlier versions
            }
        } else {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone]];
        }
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
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
