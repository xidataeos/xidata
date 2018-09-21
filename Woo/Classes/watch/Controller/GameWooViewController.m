
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
    [self.navigationController setNavigationBarHidden:YES];
    [self.myTableView reloadData];
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
}
-(void)showpasscustview
{
    NSString *titletext=[NSString stringWithFormat:@"<font size=5 color='#333333'>当前需要投入彩蛋数: </font><font size=6 color='#ff8170'>%d</font>",1000];
    PayCustView *pass=[[PayCustView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) title:titletext detailstr:nil];
    [pass shareviewShow];
    [pass setMyblock:^(NSString *password) {
        
    }];
}
-(void)loadrequest
{
    WEAKSELF;
    [self.dataArray removeAllObjects];
    [self showhudmessage:@"数据加载中..." offy:-100];
    NSMutableDictionary *parametDic = [NSMutableDictionary dictionaryWithCapacity:9];
    [parametDic setObject:[NSNumber numberWithInt:@1] forKey:@"pageNum"];
    [UserRequestToo shareInstance].rquesturl=getWatcRequrl;
    [UserRequestToo shareInstance].params=parametDic;
    [[UserRequestToo shareInstance] statrrequestgetwith:MHAsiNetWorkGET successBlock:^(id returnData) {
        [weakSelf.myTableView.mj_header endRefreshing];
        [weakSelf hideHud];
        //            [weakSelf showAlertHud:weakSelf.view.center withStr:@"已没有更多数据" offy:-100];
        //            return ;
        if (returnData[@"success"]) {
            NSMutableArray *data=returnData[@"data"];
            if (data.count>0) {
                for (int i=0; i<data.count; i++) {
                    NSDictionary *dic =data[i];
                    Watchobject *object=[[Watchobject alloc] init];
                    [object setValuesForKeysWithDictionary:dic];
                    
                    [weakSelf.dataArray addObject:object];
                }
                if (weakSelf.dataArray.count!=0) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [weakSelf.myTableView reloadData];
                    });
                }
            }
        }
        else{
            [weakSelf.myTableView.mj_header endRefreshing];
            [self showAlertHud:self.view.center withStr:@"数据获取失败" offy:-100];
        }
    } failureBlock:^(NSError *error) {
        [weakSelf.myTableView.mj_header endRefreshing];
        [self hideHud];
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
    if (indexPath.section!=0) {
        return [GameWooTableViewCell getmyheight:@"得到彩蛋的那天，林觉的人生发生了翻天覆地的变化。噩梦一样的夜晚，整个校园的活人都变成了丧尸，除了拿到彩蛋的13个人。 不是因为生化病毒，而是一个残忍的游戏。 无法离开学校，却能在广场得到活下去的筹码。 黑暗中蠢蠢欲动的猎食者并不是最恐怖的对手，隐匿在幸存者中的“犹大”才是致命的危机。 活人一个个死去，幸存者挣扎着等待黎明。 [1]第二部简介：那是一场噩梦——被封闭的大学校园，得到彩蛋的13个人被困在这里，为了生存到次日黎明而挣扎。隐藏在玩家里的犹大，岌岌可危的信任，无处不在的敌人，心怀叵测的同伴，让这个夜晚危险而漫长。林觉醒来身上没有任何伤口，躺在寝室的床上，前一晚的一切都如同一场梦。但是，莉莉丝依旧在派发着她的彩蛋，而宋寒章和陆刃则早已站在那里。第二轮游戏即将开始。"];
    }
    return 200*KWidth_Scale;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *onecellid=@"GameWooTableViewCell";
    GameWooTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:onecellid];
    if (cell==nil) {
        if (indexPath.section==0) {
          cell=[[GameWooTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:onecellid style:detail_style];
        }
        else{
          cell=[[GameWooTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:onecellid style:single_style];
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
