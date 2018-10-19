

//
//  dataDetailController.m
//  Woo
//
//  Created by 王起锋 on 2018/10/15.
//  Copyright © 2018年 杭州蜂布式. All rights reserved.
//

#import "dataDetailController.h"
#import "albumSelectview.h"
#import "Custtextview.h"
#import "CWNumberKeyboard.h"
#import "CertificationController.h"
@interface dataDetailController ()
<UITableViewDelegate,UITableViewDataSource>
{
    UIView *moreView;
    Theselectorview *selectview;
}
@property (strong, nonatomic) CWNumberKeyboard *numberKb;
@property(nonatomic,strong)Custtextview *mytextview;
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) UILabel *zhuanjititle;
@property (nonatomic, strong) UILabel *brieftitle;
@property (nonatomic, strong) UILabel *BelongsL;
@property (nonatomic, strong) UILabel *priceL;
@property (nonatomic, strong) UIButton *topBtn;
@property (nonatomic, strong) NSArray *titlearr;
@property(nonatomic,strong)Custtextview *inputextview;
@end

@implementation dataDetailController

-(UITableView *)myTableView{
    if (!_myTableView) {
        _myTableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-StatusBarAndNavigationBarHeight) style:UITableViewStylePlain];
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
    self.title = @"数据详情";
    [self.view addSubview:self.myTableView];
    self.titlearr=[[NSArray alloc] initWithObjects:@"标题",@"作者",@"登记时间",@"区块高度",@"文件MD5码",@"版权存证ID",@"区块链ID", nil];
    // Do any additional setup after loading the view.
}

#pragma mark - <UITableViewDelegate, UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titlearr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *onecellid=@"EditContentImgViewCell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:onecellid];
    cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:onecellid];
    cell.detailTextLabel.numberOfLines=0;
    
    cell.textLabel.font=UIFont(15);
    cell.textLabel.textColor=NaviBackgroundColor;
    cell.textLabel.text=self.titlearr[indexPath.row];
    cell.detailTextLabel.text=@"w我是待等待的名字";
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40.f;

}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01*KWidth_Scale;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *cellview=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40*KWidth_Scale)];
    cellview.backgroundColor=[UIColor whiteColor];
    UILabel *headtitle=[[UILabel alloc] initWithFrame:CGRectMake(15*KWidth_Scale,0,  SCREEN_WIDTH*0.7,40*KWidth_Scale)];
    headtitle.textColor=WordsofcolorColor;
    headtitle.font=UIFont(15);
    headtitle.textAlignment=NSTextAlignmentLeft;
    [cellview addSubview:headtitle];
    
    headtitle.text=@"登记数据";
    return cellview;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    return [UIView new];
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
