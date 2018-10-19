
//
//  ContactViewController.m
//  Woo
//
//  Created by 王起锋 on 2018/8/6.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import "ContactdetailViewController.h"
#import "EditorbeizhuViewController.h"
@interface ContactdetailViewController ()<UITableViewDelegate,UITableViewDataSource,EditorbeizhuDelegate>
@property (nonatomic, strong)  BaseTableView * myTableView;
@property (nonatomic, strong)  UIButton * sendmessagebtn;
@property (nonatomic, strong)  UIButton * addfriendbtn;
@property (nonatomic, strong)  NSArray * titlearr;
@property (nonatomic, copy)  NSString * niecheng;
@property (nonatomic, copy)  NSString * beizhustr;
@property(nonatomic,strong)UIImageView *imagevew;
@end

@implementation ContactdetailViewController
-(UIButton *)sendmessagebtn
{
    NSString *title=@"发消息";
    if (self.ismyfriend) {
        title=@"备注编辑";
    }
    CGFloat offy=0;
    if (iPhoneX) {
        offy=44;
    }
    if (_sendmessagebtn==nil) {
        _sendmessagebtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _sendmessagebtn.frame=CGRectMake(15,ScreenHeight-20-44-15-44-44-15-offy, SCREEN_WIDTH-30, 44);
        _sendmessagebtn.backgroundColor=RGB(255, 70, 0);
        _sendmessagebtn.layer.cornerRadius=5;
        _sendmessagebtn.clipsToBounds=YES;
        [_sendmessagebtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_sendmessagebtn setTitle:title forState:UIControlStateNormal];
        [_sendmessagebtn addTarget:self action:@selector(sendmessage:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendmessagebtn;
}
-(void)sendmessage:(UIButton *)sender
{
    if (self.ismyfriend) {
        EditorbeizhuViewController *editor=[[EditorbeizhuViewController alloc] init];
        editor.usermodel=self.userinfo;
        editor.delegate=self;
        [self.navigationController pushViewController:editor animated:YES];
    }
    else{
        //发送消息添加好友
        [self tochat];
    }
}
-(UIButton *)addfriendbtn
{
    NSString *title=@"添加好友";
    if (self.ismyfriend) {
        title=@"删除好友";
    }
    CGFloat offy=0;
    if (iPhoneX) {
        offy=44;
    }
    if (_addfriendbtn==nil) {
        _addfriendbtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _addfriendbtn.frame=CGRectMake(15,ScreenHeight-20-44-15-44-offy, SCREEN_WIDTH-30, 44);
        _addfriendbtn.backgroundColor=RGB(242, 242, 242);
        _addfriendbtn.layer.cornerRadius=5;
        _addfriendbtn.clipsToBounds=YES;
        [_addfriendbtn setTitleColor:NaviBackgroundColor forState:UIControlStateNormal];
        [_addfriendbtn setTitle:title forState:UIControlStateNormal];
        [_addfriendbtn addTarget:self action:@selector(addfriend:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addfriendbtn;
}
-(void)addfriend:(UIButton *)sender
{
    WEAKSELF;
    NSString *title=@"确定要删除该好友?";
    if (self.ismyfriend) {
        CustAlertview *alert=[[CustAlertview alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) title:@"提示" detailstr:title];
        [alert shareviewShow];
        [alert setMyblock:^{
            [weakSelf deletefriend];
        }];
        return;
    }
    else{
        title=@"确定添加该好友?";
        CustAlertview *alert=[[CustAlertview alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) title:@"提示" detailstr:title];
        [alert shareviewShow];
        [alert setMyblock:^{
            [weakSelf addfriend];
        }];
        return;
    }
}
-(void)deletefriend
{
    WEAKSELF;
    [self.dataArray removeAllObjects];
    [self showWithStatus:@"请求处理中..."];
    NSMutableDictionary *parametDic = [NSMutableDictionary dictionaryWithCapacity:9];
    [parametDic setObject:RCLOUD_ID forKey:@"mid"];
    if (self.userinfo.userId) {
       [parametDic setObject:self.userinfo.userId forKey:@"fid"];
    }
    else{
        return;
    }
    [UserRequestToo shareInstance].rquesturl=deletefriendRelationshipRequrl;
    [UserRequestToo shareInstance].params=parametDic;
    [[UserRequestToo shareInstance] statrrequestgetwith:MHAsiNetWorkPOST successBlock:^(id returnData) {
        [weakSelf.myTableView.mj_header endRefreshing];
        [weakSelf dismiss];
        if (returnData[@"success"]) {
            if([returnData[@"status"] isEqualToString:@"200"]) {
                [self showSuccessWithStatus:@"删除好友成功" ];
                [[RCDataBaseManager shareInstance] deleteFriendFromDB:self.userinfo.userId];
                [self.navigationController popViewControllerAnimated:YES];
                return ;
            }
            else{
                [self showErrorWithStatus:returnData[@"message"] ];
            }
        }
        else{
           [self showErrorWithStatus:returnData[@"message"] ];
        }
    } failureBlock:^(NSError *error) {
        [self dismiss];
        [self showErrorWithStatus:@"删除好友失败" ];
    }];
}
-(void)addfriend
{
       [[ChatmangerObject ShareManger] addfriend:self.userinfo.userId frome:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"用户详情";
    if (self.ismyfriend) {
        [self setnavigation];
        if (![PublicFunction isEmpty:self.userinfo.name]) {
            self.niecheng=[NSString stringWithFormat:@"昵称: %@",self.userinfo.name];
        }
        else{
            self.niecheng=@"昵称:";
        }
        if (![PublicFunction isEmpty:self.userinfo.displayName]) {
           self.beizhustr=[NSString stringWithFormat:@"备注: %@",self.userinfo.displayName];
        }
        else{
           self.beizhustr=@"备注:";
        }
    }
    else{
       self.niecheng=[NSString stringWithFormat:@"昵称: %@",self.userinfo.name];
        if (![PublicFunction isEmpty:self.userinfo.displayName]) {
            self.beizhustr=[NSString stringWithFormat:@"备注: %@",self.userinfo.displayName];
        }
        else{
            self.beizhustr=@"备注:";
        }
    }
    [self.myTableView reloadData];
    [self settableviewheadview];
    [self.myTableView addSubview:self.sendmessagebtn];
    [self.myTableView addSubview:self.addfriendbtn];
    // Do any additional setup after loading the view.
}
-(void)setnavigation
{
    UIButton *  rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setTitle:@"聊天" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(tochat) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.frame = CGRectMake(SCREEN_WIDTH - 45, 25, 20, 20);
    UIBarButtonItem *right=[[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem=right;
}
-(void)tochat
{
     [[ChatmangerObject ShareManger] gotoChatViewtargetid:self.userinfo.userId convertitle:self.userinfo.displayName conversationModelType:ConversationType_PRIVATE fromview:self info:self.userinfo];
}
-(BaseTableView *)myTableView{
    if (!_myTableView) {
        _myTableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
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
    CGFloat height=120;
    CGFloat offy=0;
    if (self.ismyfriend) {
        height=140;
        offy=10;
    }
    UIView *headview=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, height)];
    self.imagevew=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    [_imagevew sd_setImageWithURL:[NSURL URLWithString:self.userinfo.portraitUri] placeholderImage:[UIImage imageNamed:@"photo_boy"]];
    CGPoint cent=headview.center;
    cent.y-=offy;
    _imagevew.center=cent;
    _imagevew.userInteractionEnabled=YES;
    _imagevew.layer.cornerRadius=30;
    _imagevew.clipsToBounds=YES;
    [headview addSubview:_imagevew];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapclick)];
    [_imagevew addGestureRecognizer:tap];
    
    CGPoint point=_imagevew.center;
    UIImageView *sex=[[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2.0+10,point.y-35, 16, 16)];
    if ([self.userinfo.sex isEqualToString:@"0"]) {
       sex.image=[UIImage imageNamed:@"girl"];
    }
    else{
        sex.image=[UIImage imageNamed:@"boy"];
    }
    [headview addSubview:sex];
    UILabel *signature=[[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.imagevew.frame)+10,SCREEN_WIDTH, 15)];
    signature.textColor=RGB(235, 106, 6);
    signature.font=UIFont(13);
    signature.textAlignment=NSTextAlignmentCenter;
    signature.text=self.userinfo.signature;
    if (self.ismyfriend) {
        [headview addSubview:signature];
    }
    [self.myTableView setTableHeaderView:headview];
}
-(void)tapclick
{
    CYPhotoPreviewer *previewer = [[CYPhotoPreviewer alloc] init];
    [previewer previewFromImageView:self.imagevew inContainer:self.view];
}
#pragma mark tableview的代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *mycellid=@"cellid";
    UITableViewCell *newcell=[tableView dequeueReusableCellWithIdentifier:mycellid];
    if (newcell==nil) {
        newcell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:mycellid];
    }
    if (indexPath.row==0) {
       newcell.textLabel.text=self.niecheng;
    }
    else{
         newcell.textLabel.text=self.beizhustr;
    }
    newcell.textLabel.font=DefleFuont;
    newcell.textLabel.textColor=[PublicFunction colorWithHexString:@"666666"];
    newcell.accessoryType = UITableViewCellAccessoryNone;
    
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
#pragma mark EditorbeizhuDelegate
-(void)savelabel:(NSString *)label
{
    self.userinfo.displayName=label;
    [[RCDataBaseManager shareInstance] insertFriendToDB:self.userinfo];
    self.beizhustr=label;
    self.beizhustr=[NSString stringWithFormat:@"备注: %@",label];
    [self.myTableView reloadData];
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
