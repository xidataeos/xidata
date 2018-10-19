
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
{
    int pagenum;
}
@property (nonatomic, strong)  BaseTableView * myTableView;
@property(nonatomic,strong)UIImageView *imagevew;
@property(nonatomic,strong)UILabel *countlabel;
@property(nonatomic,strong)UILabel *allcountlabel;
@end

@implementation ReceiveRedWooViewController
- (void)viewDidLoad {
    pagenum=1;
    [super viewDidLoad];
    self.title=@"红包记录";
    [self loadrequest];
    [self settableviewheadview];
    // Do any additional setup after loading the view.
}
-(void)loadrequest
{
    WEAKSELF;
    [self showWithStatus:@"数据加载中..."];
    NSMutableDictionary *parametDic = [NSMutableDictionary dictionaryWithCapacity:9];
    [parametDic setObject:RCLOUD_ID forKey:@"userId"];
    [parametDic setObject:@"002" forKey:@"tradeType"];
    [parametDic setObject:@"1" forKey:@"isIncome"];
    [parametDic setObject:[NSString stringWithFormat:@"%d",pagenum] forKey:@"pageNum"];
    [UserRequestToo shareInstance].rquesturl=TradeUrl;
    [UserRequestToo shareInstance].params=parametDic;
    [[UserRequestToo shareInstance] statrrequestgetwith:MHAsiNetWorkGET successBlock:^(id returnData) {
        [weakSelf.myTableView.mj_header endRefreshing];
        [weakSelf dismiss];
        if (returnData[@"success"]) {
            NSMutableArray *data=returnData[@"data"];
            pagenum++;
            if (data.count>0) {
                for (int i=0; i<data.count; i++) {
                    NSDictionary *dic =data[i];
                    [self.dataArray addObject:dic];
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
            [self showErrorWithStatus:@"数据获取失败"];
        }
    } failureBlock:^(NSError *error) {
        [weakSelf.myTableView.mj_header endRefreshing];
        [self dismiss];
        [self showErrorWithStatus:@"数据获取失败"];
    }];
    
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
    height=150*KWidth_Scale;
    UIView *headview=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, height)];
    self.imagevew=[[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-70*KWidth_Scale)/2.0, 20*KWidth_Scale, 70*KWidth_Scale, 70*KWidth_Scale)];
    [_imagevew sd_setImageWithURL:[NSURL URLWithString:[UserDefaults objectForKey:@"photo"]] placeholderImage:[UIImage imageNamed:@"photo_boy"]];
    _imagevew.userInteractionEnabled=YES;
    _imagevew.layer.cornerRadius=35*KWidth_Scale;
    _imagevew.clipsToBounds=YES;
    [headview addSubview:_imagevew];
    

    UILabel *signature=[[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.imagevew.frame)+8*KWidth_Scale,SCREEN_WIDTH, 15)];
    signature.textColor=WordsofcolorColor;
    signature.font=UIFont(17);
    signature.textAlignment=NSTextAlignmentCenter;
    signature.text=[UserDefaults objectForKey:@"name"];
    [headview addSubview:signature];
    [self.myTableView setTableHeaderView:headview];
    
    self.countlabel=[[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(signature.frame)+10*KWidth_Scale, SCREEN_WIDTH/2.0, 15*KWidth_Scale)];
    self.countlabel.textAlignment=NSTextAlignmentCenter;
    self.countlabel.textColor=NaviBackgroundColor;
    self.countlabel.font=UIFont(15);
    self.countlabel.text=@"100";
    //[headview addSubview:self.countlabel];
    UILabel*countin=[[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.countlabel.frame)+5*KWidth_Scale, SCREEN_WIDTH/2.0, 15*KWidth_Scale)];
    countin.textAlignment=NSTextAlignmentCenter;
    countin.textColor=[PublicFunction colorWithHexString:@"666666"];
    countin.font=UIFont(15);
    countin.text=@"收到红包";
   // [headview addSubview:countin];
    
    self.allcountlabel=[[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2.0, CGRectGetMaxY(signature.frame)+10*KWidth_Scale, SCREEN_WIDTH/2.0, 15*KWidth_Scale)];
    self.allcountlabel.textAlignment=NSTextAlignmentCenter;
    self.allcountlabel.textColor=NaviBackgroundColor;
    self.allcountlabel.font=UIFont(15);
    self.allcountlabel.text=@"1000枚";
   // [headview addSubview:self.allcountlabel];
    
    UILabel*caidan=[[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2.0, CGRectGetMaxY(self.countlabel.frame)+5*KWidth_Scale, SCREEN_WIDTH/2.0, 15*KWidth_Scale)];
    caidan.textAlignment=NSTextAlignmentCenter;
    caidan.textColor=[PublicFunction colorWithHexString:@"666666"];
    caidan.font=UIFont(15);
    caidan.text=@"收到彩蛋";
    //[headview addSubview:caidan];
    
}
#pragma mark tableview的代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
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
    NSDictionary *dic=self.dataArray[indexPath.row];
    newcell.textLabel.font=DefleFuont;
    newcell.textLabel.textColor=[PublicFunction colorWithHexString:@"666666"];
    newcell.accessoryType = UITableViewCellAccessoryNone;
    newcell.detailTextLabel.text=[NSString stringWithFormat:@"%@",dic[@"tradeTime"]];
    newcell.countlabel.text=[NSString stringWithFormat:@"%@枚",dic[@"asset"]];
    [self getFriendRelationship:dic[@"otherSide"] cell:newcell];
    return newcell;
}

-(void)getFriendRelationship:(NSString *)fid cell:(RedWooTableViewCell *)cell
{
    [[ChatmangerObject ShareManger] getFriendRelationship:fid successBlock:^(id returnData) {
        RCDUserInfo *userinfomodel=(RCDUserInfo *)returnData;
        cell.textLabel.text=userinfomodel.name;
    } failureBlock:^(NSError *error) {
        
    }];
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
