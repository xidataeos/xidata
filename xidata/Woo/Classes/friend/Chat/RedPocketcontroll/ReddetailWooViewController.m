
//
//  ReddetailWooViewController.m
//  Woo
//
//  Created by 王起锋 on 2018/8/24.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import "ReddetailWooViewController.h"
#import "RedWooTableViewCell.h"
#import "ReceiveRedWooViewController.h"
@interface ReddetailWooViewController ()
@property(nonatomic,strong)RedmessageModle *sendmodle;
@end

@implementation ReddetailWooViewController
-(void)setnavigation
{
    UIButton *  rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setTitle:@"红包记录" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(setBtnClick) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.frame = CGRectMake(SCREEN_WIDTH - 45, 25, 20, 20);
    UIBarButtonItem *right=[[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem=right;
}
-(void)setBtnClick
{
    ReceiveRedWooViewController *con=[[ReceiveRedWooViewController alloc] init];
    [self.navigationController pushViewController:con animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"红包详情";
    [self setnavigation];
    [self settableviewheadview];
    // Do any additional setup after loading the view.
}
-(BaseTableView *)myTableView{
    if (!_myTableView) {
        _myTableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH, SCREEN_HEIGHT-TabbarHeight) style:UITableViewStyleGrouped];
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
    if (self.type==ConversationType_PRIVATE) {
        self.sendmodle=self.redmodle;
    }
    else{
        self.sendmodle=[[RedmessageModle alloc] init];
        [self.sendmodle setValuesForKeysWithDictionary:self.redmodle.redMultiDetail];
        self.sendmodle.asset=[NSString stringWithFormat:@"%@",self.redmodle.redMultiDetail[@"asset"]];
        self.sendmodle.balance=[NSString stringWithFormat:@"%@",self.redmodle.redMultiDetail[@"balance"]];
        self.sendmodle.size=[NSString stringWithFormat:@"%@",self.redmodle.redMultiDetail[@"size"]];
    }
    CGFloat height;
    height=200*KWidth_Scale;
    UIView *headview=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, height)];
    self.imagevew=[[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-70*KWidth_Scale)/2.0, 20*KWidth_Scale, 70*KWidth_Scale, 70*KWidth_Scale)];
    if (self.type==ConversationType_PRIVATE) {
        [_imagevew sd_setImageWithURL:[NSURL URLWithString:self.sendmodle.fromPhoto] placeholderImage:[UIImage imageNamed:@"photo_boy"]];
    }
    else{
        [_imagevew sd_setImageWithURL:[NSURL URLWithString:self.sendmodle.photo] placeholderImage:[UIImage imageNamed:@"photo_boy"]];
    }
    _imagevew.userInteractionEnabled=YES;
    _imagevew.layer.cornerRadius=35*KWidth_Scale;
    _imagevew.clipsToBounds=YES;
    [headview addSubview:_imagevew];
    
    
    UILabel *signature=[[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.imagevew.frame)+8*KWidth_Scale,SCREEN_WIDTH, 15)];
    signature.textColor=WordsofcolorColor;
    signature.font=UIFont(14);
    signature.textAlignment=NSTextAlignmentCenter;
    if (self.type==ConversationType_PRIVATE) {
        signature.text=self.sendmodle.fromName;
    }
    else{
        signature.text=self.sendmodle.name;
    }
    [headview addSubview:signature];
    [self.myTableView setTableHeaderView:headview];
    UILabel*tipslabel=[[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(signature.frame)+6*KWidth_Scale, SCREEN_WIDTH, 15*KWidth_Scale)];
    tipslabel.textAlignment=NSTextAlignmentCenter;
    tipslabel.textColor=NaviBackgroundColor;
    tipslabel.font=UIFont(15);
    tipslabel.text=self.sendmodle.tip;
    [headview addSubview:tipslabel];
    
    
    self.countlabel=[[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(tipslabel.frame)+15*KWidth_Scale, SCREEN_WIDTH, 15*KWidth_Scale)];
    self.countlabel.textAlignment=NSTextAlignmentCenter;
    self.countlabel.textColor=WordsofcolorColor;
    self.countlabel.font=UIFont(18);
    if (self.type==ConversationType_PRIVATE) {
        self.countlabel.text=[NSString stringWithFormat:@"%@ 枚",self.sendmodle.asset];
    }
    else{
        if (self.redmodle.redMultiRecv) {
            self.countlabel.text=[NSString stringWithFormat:@"%@ 枚",self.redmodle.redMultiRecv[@"asset"]];
        }
       
    }
    [headview addSubview:self.countlabel];
    
    UILabel*caidan=[[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.countlabel.frame)+5*KWidth_Scale, SCREEN_WIDTH, 15*KWidth_Scale)];
    caidan.textAlignment=NSTextAlignmentCenter;
    caidan.textColor=NaviBackgroundColor;
    caidan.font=UIFont(12);
    caidan.text=@"已存入钱包";
    [headview addSubview:caidan];
    
}
#pragma mark tableview的代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     if (self.type==ConversationType_PRIVATE) {
         return 1;
     }
    return self.redmodle.list.count;
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
    if (self.type==ConversationType_PRIVATE) {
        [newcell setModel:self.sendmodle];
    }
    else{
        RedmessageModle *model=[[RedmessageModle alloc] init];
        [model setValuesForKeysWithDictionary:self.redmodle.list[indexPath.row]];
        model.asset=[NSString stringWithFormat:@"%@",self.redmodle.list[indexPath.row][@"asset"]];
        model.balance=[NSString stringWithFormat:@"%@",self.redmodle.list[indexPath.row][@"balance"]];
        model.size=[NSString stringWithFormat:@"%@",self.redmodle.list[indexPath.row][@"size"]];
        [newcell setModel:model];
    }
    return newcell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    return;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 62*KWidth_Scale;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headself=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 62*KWidth_Scale)];
    headself.backgroundColor=[UIColor whiteColor];
    UIView *headd=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 12*KWidth_Scale)];
    headd.backgroundColor=CellBackgroundColor;
    [headself addSubview:headd];
    UILabel *title=[[UILabel alloc] initWithFrame:CGRectMake(15*KWidth_Scale, 22*KWidth_Scale, SCREEN_WIDTH-30*KWidth_Scale, 40*KWidth_Scale)];
    title.textColor=[PublicFunction colorWithHexString:@"666666"];
    title.font=UIFont(14);
    if (self.type==ConversationType_PRIVATE) {
        title.text =  [NSString stringWithFormat:@"已领取%d/%d,共%@/%@枚",1,1,self.sendmodle.asset,self.sendmodle.asset];
    }
    else{
        title.text = [NSString stringWithFormat:@"已领取%@/%@,共%@/%@枚",[NSString stringWithFormat:@"%.0f",[self.sendmodle.size doubleValue]-[self.sendmodle.remain doubleValue]],self.sendmodle.size,[NSString stringWithFormat:@"%.4f",[self.sendmodle.asset doubleValue]-[self.sendmodle.balance doubleValue]],self.sendmodle.asset];
    }
    [headself addSubview:title];
    return headself;
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
