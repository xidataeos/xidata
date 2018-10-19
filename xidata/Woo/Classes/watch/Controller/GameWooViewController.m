
//
//  GameWooViewController.m
//  Woo
//
//  Created by 王起锋 on 2018/8/28.
//  Copyright © 2018年 杭州蜂布式. All rights reserved.
//

#import "GameWooViewController.h"
#import "GameHeadview.h"
#import "GameWooTableViewCell.h"
@interface GameWooViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong) UIView *headerView;
@property (nonatomic, strong)  BaseTableView * myTableView;
@property (nonatomic, strong)  GameHeadview * gameview;
@property (nonatomic, strong)  NSArray * titlearr;
@property(nonatomic,copy)NSString *gameId;
@property(nonatomic,strong)NSDictionary *mydic;
@end

@implementation GameWooViewController

- (UIView *)headerView {
    if (!_headerView) {
        _headerView =
        [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.myTableView.frame.size.width, 300*KWidth_Scale)];
    }
    return _headerView;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:YES];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [self.gameview canldountdown];
    [self.navigationController setNavigationBarHidden:NO];
}
-(void)setnavigation
{
    UIButton *  rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setImage:[UIImage imageNamed:@"whiteback"]  forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(setBtnClick) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.frame = CGRectMake(0*KWidth_Scale, StatusBarHeight, 45, 45);
    [rightBtn setImageEdgeInsets:UIEdgeInsetsMake(7, 20, 7, 0)];
    [self.gameview addSubview:rightBtn];
}
#pragma mark
-(void)setBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    WEAKSELF;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadrequest) name:GAME_POST object:nil];
    self.gameview=[[GameHeadview alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 300*KWidth_Scale)];
    [self.headerView addSubview:self.gameview];
    [self.gameview setMyblock:^(NSInteger indexrow) {
        [weakSelf showpasscustview];
    }];
    self.myTableView.tableHeaderView = self.headerView;
    [self setnavigation];
    [self loadrequest];
    self.titlearr=[[NSArray alloc] initWithObjects:@"本轮游戏数据",@"玩法与收益介绍",@"技术原理", nil];
    self.view.backgroundColor=[UIColor whiteColor];
    [self creatMjRefresh];
    [self.myTableView reloadData];
}
-(void)showpasscustview
{
    WEAKSELF;
    NSString *titletext=[NSString stringWithFormat:@"<font size=5 color='#333333'>当前需要投入彩蛋数 </font><font size=6 color='#ff8170'></font>"];
    PayCustView *pass=[[PayCustView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) title:titletext detailstr:[NSString stringWithFormat:@"%@",self.mydic[@"nowPrice"]]];
    [pass shareviewShow];
    [pass setMyblock:^(NSString *password) {
        [weakSelf Playeggs];
    }];
}
-(void)Playeggs
{
    WEAKSELF;
    [self showhudmessage:@"参与处理中..." offy:-100];
    NSMutableDictionary *parametDic = [NSMutableDictionary dictionaryWithCapacity:9];
    [parametDic setObject:[NSString stringWithFormat:@"%@",self.mydic[@"id"]] forKey:@"gameId"];
    [parametDic setObject:RCLOUD_ID forKey:@"userId"];
    [UserRequestToo shareInstance].rquesturl=playGamesUrl;
    [UserRequestToo shareInstance].params=parametDic;
    [[UserRequestToo shareInstance] statrrequestgetwith:MHAsiNetWorkPOST successBlock:^(id returnData) {
        [weakSelf.myTableView.mj_header endRefreshing];
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf hideHud];
        });
        if (returnData[@"success"]) {
            if ([returnData[@"status"] isEqualToString:@"200"]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf showAlertHud:self.view.center withStr:@"彩蛋投入成功" offy:-100];
                });
                return ;
            }
            else{
                [weakSelf.myTableView.mj_header endRefreshing];
                [self showAlertHud:self.view.center withStr:returnData[@"message"] offy:-100];
            }
        }
       
    } failureBlock:^(NSError *error) {
        [weakSelf.myTableView.mj_header endRefreshing];
        [weakSelf hideHud];
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf showAlertHud:self.view.center withStr:@"数据获取失败" offy:-100];
        });
    }];
}
-(void)loadrequest
{
    WEAKSELF;
    [self.dataArray removeAllObjects];
   // [self showhudmessage:@"数据加载中..." offy:-100];
    NSMutableDictionary *parametDic = [NSMutableDictionary dictionaryWithCapacity:9];
    [parametDic setObject:self.meetid forKey:@"meetingId"];
     [parametDic setObject:RCLOUD_ID forKey:@"userId"];
    [UserRequestToo shareInstance].rquesturl=GamepagedetailUrl;
    [UserRequestToo shareInstance].params=parametDic;
    [[UserRequestToo shareInstance] statrrequestgetwith:MHAsiNetWorkGET successBlock:^(id returnData) {
        [weakSelf.myTableView.mj_header endRefreshing];
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf hideHud];
        });
        //            [weakSelf showAlertHud:weakSelf.view.center withStr:@"已没有更多数据" offy:-100];
        //            return ;
        if (returnData[@"success"]) {
            self.mydic=returnData[@"data"];
            self.gameview.modeldic=self.mydic;
            NSIndexSet * indexnd=[[NSIndexSet alloc]initWithIndex:0];//刷新第二个section
            [self.myTableView reloadSections:indexnd withRowAnimation:UITableViewRowAnimationAutomatic];
        }
        else{
            [weakSelf.myTableView.mj_header endRefreshing];
            [self showAlertHud:self.view.center withStr:@"数据获取失败" offy:-100];
        }
    } failureBlock:^(NSError *error) {
        [weakSelf.myTableView.mj_header endRefreshing];
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf hideHud];
        });
        [self showAlertHud:self.view.center withStr:@"数据获取失败" offy:-100];
    }];
    
}

-(void)creatMjRefresh{
    
    MJRefreshNormalHeader *narmalHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadrequest];
        [self.myTableView reloadData];
    }];
    self.myTableView.mj_header = narmalHeader;
}
-(BaseTableView *)myTableView{
    if (!_myTableView) {
        _myTableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _myTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
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

#pragma mark tableview的代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
        if (indexPath.section==1) {
          return [GameWooTableViewCell getmyheight:@"玩彩蛋”游戏 分为组织者和参与者(彩蛋玩家)两种角色,组织者在游戏开始前负责为本轮游戏定价(个人彩蛋投入上限)，确定收益百分比和向前返还比。玩家根据当前彩蛋价格进行彩蛋投入，每轮游戏每位玩家可重复投入彩蛋。游戏以会议发布时间为开始时间，以会议结束时间为游戏结束时间。\n例如：\n本轮游戏组织者定价为1000个彩蛋，玩家向前返还比为35%，组织者收益60%，最后一位玩家收益5%。游戏开始后第一位玩家投入1个彩蛋。第二位玩家投入2个彩蛋，其中35%（0.7个彩蛋）返还给第一位玩家。第三位玩家投入4个彩蛋，其中35%(1.4个彩蛋)平均分给第一个位和第二位玩家。\n依此类推,当前玩家投入的彩蛋数量是上一位玩家投入数量的2倍。持平1000个彩蛋后，后续玩家的彩蛋投入量稳定在1000个彩蛋。玩家投入彩蛋数量的上限由组织者限定。当游戏结束时组织者获得所有参与者彩蛋总投入的60%(即奖池总数的60%)，而最后一位玩家可获得奖池总数的5%。"];
        }
        else if (indexPath.section==2){
            return [GameWooTableViewCell getmyheight:@"（1）“玩彩蛋”游戏是一种基于区块链技术，由智能合约控制全局流程的新兴游戏。\n（2）合约代码完全开源，开发团队不具有对智能合约的控制权限，合约代码无任何“后门”操作。\n（3）智能合约运行过程经过多轮严密内测和专业的安全审计，保证游戏的公平、公正、公开。\n（4）彩蛋投入过程采用更为快捷高效安全的钱包支付方式，由区块链技术保障交易的安全性和真实性。"];
        }
    
     return 200*KWidth_Scale;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *onecellid=@"GameWooTableViewCell";
    GameWooTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:onecellid];
        if (indexPath.section==0) {
          cell=[[GameWooTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:onecellid style:detail_style index:indexPath];
        }
        else{
            cell=[[GameWooTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:onecellid style:single_style index:indexPath];
        }
        if (indexPath.section==0) {
           if (self.mydic) {
            cell.jsionmodel=self.mydic;
          }
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
       return 44*KWidth_Scale;
    }
    return 52*KWidth_Scale;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CGFloat offy=8*KWidth_Scale;
    if (section==0) {
        offy=0;
    }
    UIView *line=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, offy)];
    line.backgroundColor=CellBackgroundColor;
    UIView *cell=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 52*KWidth_Scale)];
    [cell addSubview:line];
    UILabel *title=[[UILabel alloc] initWithFrame:CGRectMake(15*KWidth_Scale, offy, SCREEN_WIDTH-30*KWidth_Scale, 52*KWidth_Scale-offy)];
    title.textColor=NaviBackgroundColor;
    [title setFont:UIFont(17)];
    title.text=self.titlearr[section];
    [cell addSubview:title];
    cell.backgroundColor=[UIColor whiteColor];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
