
//
//  ReceiveRedWooViewController.m
//  Woo
//
//  Created by 王起锋 on 2018/8/24.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//收到的红包

#import "ReceiveRedWooViewController.h"
#import "ReddetailWooViewController.h"
#import "RedWooTableViewCell.h"
@interface ReceiveRedWooViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)  BaseTableView * myTableView;
@property(nonatomic,strong)UIImageView *imagevew;
@property(nonatomic,strong)UILabel *countlabel;
@property(nonatomic,strong)UILabel *allcountlabel;
@end

@implementation ReceiveRedWooViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"红包记录";
    [self settableviewheadview];
    // Do any additional setup after loading the view.
}
-(BaseTableView *)myTableView{
    if (!_myTableView) {
        _myTableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-TabbarHeight) style:UITableViewStyleGrouped];
        //_myTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _myTableView.allowsSelection=NO;
        _myTableView.separatorColor=CellBackgroundColor;
        _myTableView.delegate=self;
        _myTableView.dataSource = self;
        _myTableView.showsVerticalScrollIndicator = NO;
        _myTableView.showsHorizontalScrollIndicator = NO;
        [_myTableView setTableFooterView:[UIView new]];
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
-(void)settableviewheadview
{
    CGFloat height;
    height=180*KWidth_Scale;
    UIView *headview=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, height)];
    self.imagevew=[[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-70*KWidth_Scale)/2.0, 20*KWidth_Scale, 70*KWidth_Scale, 70*KWidth_Scale)];
    [_imagevew sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1535114897928&di=ccbbc4085e30c250547e5b635b3aac21&imgtype=0&src=http%3A%2F%2Fa.hiphotos.baidu.com%2Fzhidao%2Fpic%2Fitem%2F21a4462309f79052782f28490ff3d7ca7bcbd591.jpg"] placeholderImage:[UIImage imageNamed:@"photo_boy"]];
    _imagevew.userInteractionEnabled=YES;
    _imagevew.layer.cornerRadius=35*KWidth_Scale;
    _imagevew.clipsToBounds=YES;
    [headview addSubview:_imagevew];
    

    UILabel *signature=[[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.imagevew.frame)+8*KWidth_Scale,SCREEN_WIDTH, 15)];
    signature.textColor=WordsofcolorColor;
    signature.font=UIFont(14);
    signature.textAlignment=NSTextAlignmentCenter;
    signature.text=@"我的名字";
    [headview addSubview:signature];
    [self.myTableView setTableHeaderView:headview];
    
    self.countlabel=[[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(signature.frame)+10*KWidth_Scale, SCREEN_WIDTH/2.0, 15*KWidth_Scale)];
    self.countlabel.textAlignment=NSTextAlignmentCenter;
    self.countlabel.textColor=NaviBackgroundColor;
    self.countlabel.font=UIFont(15);
    self.countlabel.text=@"100";
    [headview addSubview:self.countlabel];
    UILabel*countin=[[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.countlabel.frame)+5*KWidth_Scale, SCREEN_WIDTH/2.0, 15*KWidth_Scale)];
    countin.textAlignment=NSTextAlignmentCenter;
    countin.textColor=[PublicFunction colorWithHexString:@"666666"];
    countin.font=UIFont(15);
    countin.text=@"收到红包";
    [headview addSubview:countin];
    
    self.allcountlabel=[[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2.0, CGRectGetMaxY(signature.frame)+10*KWidth_Scale, SCREEN_WIDTH/2.0, 15*KWidth_Scale)];
    self.allcountlabel.textAlignment=NSTextAlignmentCenter;
    self.allcountlabel.textColor=NaviBackgroundColor;
    self.allcountlabel.font=UIFont(15);
    self.allcountlabel.text=@"1000枚";
    [headview addSubview:self.allcountlabel];
    
    UILabel*caidan=[[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2.0, CGRectGetMaxY(self.countlabel.frame)+5*KWidth_Scale, SCREEN_WIDTH/2.0, 15*KWidth_Scale)];
    caidan.textAlignment=NSTextAlignmentCenter;
    caidan.textColor=[PublicFunction colorWithHexString:@"666666"];
    caidan.font=UIFont(15);
    caidan.text=@"收到彩蛋";
    [headview addSubview:caidan];
    
}
#pragma mark tableview的代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50*KWidth_Scale;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *mycellid=@"RedWooTableViewCell";
    RedWooTableViewCell *newcell=[tableView dequeueReusableCellWithIdentifier:mycellid];
    if (newcell==nil) {
        newcell=[[RedWooTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:mycellid];
    }
    newcell.textLabel.text=@"屈宝宝";
    newcell.textLabel.font=DefleFuont;
    newcell.textLabel.textColor=[PublicFunction colorWithHexString:@"666666"];
    newcell.accessoryType = UITableViewCellAccessoryNone;
    newcell.detailTextLabel.text=@"09-08";
    newcell.countlabel.text=@"100枚";
    return newcell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    return;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 12*KWidth_Scale;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headd=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 12*KWidth_Scale)];
    headd.backgroundColor=CellBackgroundColor;
    return headd;
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
