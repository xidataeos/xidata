
//
//  MessagetoremindWooViewController.m
//  Woo
//
//  Created by 王起锋 on 2018/8/22.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import "MessagetoremindWooViewController.h"
#import "MessagetWooTableViewCell.h"
@interface MessagetoremindWooViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)  BaseTableView * myTableView;
@end

@implementation MessagetoremindWooViewController
-(BaseTableView *)myTableView{
    if (!_myTableView) {
        _myTableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-StatusBarAndNavigationBarHeight) style:UITableViewStyleGrouped];
        //_myTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _myTableView.separatorColor=CellBackgroundColor;
        _myTableView.delegate=self;
        _myTableView.dataSource = self;
        _myTableView.showsVerticalScrollIndicator = NO;
        _myTableView.showsHorizontalScrollIndicator = NO;
        [_myTableView setTableFooterView:[UIView new]];
        _myTableView.backgroundColor=RGB(255, 255, 255);
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
    self.title=@"系统消息";
    [self loadfriendChatlistdata];
    [self.myTableView reloadData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveMessageNotification:)name:RCKitDispatchMessageNotification object:nil];
    // Do any additional setup after loading the view.
}
-(void)loadfriendChatlistdata
{
    [self.dataArray removeAllObjects];
    NSArray *conversationList = [[RCIMClient sharedRCIMClient] getConversationList:@[@(ConversationType_SYSTEM)]];
    if (conversationList.count!=0) {
        for (RCConversation *conver in conversationList) {
            RCTextMessage *lasttext=(RCTextMessage *)conver.lastestMessage;
            if (![lasttext.content isEqualToString:@"彩蛋游戏"]) {
                [self.dataArray addObject:conver];
            }
        }
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if(self.dataArray.count==0)
        {
            [self.myTableView showEmptyViewWithType:1];
        }
        else{
            [self.myTableView removeEmptyView];
        }
        [self.myTableView reloadData];
    });
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
    return 70;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *groupmycellid=@"MessagetWooTableViewCell";
    MessagetWooTableViewCell *groupnewcell=[tableView dequeueReusableCellWithIdentifier:groupmycellid];
    if (groupnewcell==nil) {
        groupnewcell=[[MessagetWooTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:groupmycellid];
    }
    RCConversation *conver=self.dataArray[indexPath.row];
    groupnewcell.model=conver;
    RCTextMessage *lasttext=(RCTextMessage *)conver.lastestMessage;
    NSDictionary *seldic=[PublicFunction dictionaryWithJsonString:lasttext.extra];
    ZKLog(@"%@", seldic);
    [groupnewcell setMyblock:^{
        NSString  *title=@"确定要添加该好友?";
        if ([seldic[@"isGroup"] isEqualToString:@"1"])
        {
            title=@"确定要加入该群组?";
        }
        CustAlertview *alert=[[CustAlertview alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) title:@"提示" detailstr:title];
        [alert shareviewShow];
        [alert setMyblock:^{
            if ([seldic[@"isGroup"] isEqualToString:@"0"]) {
                [self addfriend:conver];
            }
            else{
              [self passaddGroup:conver];
            }
            return;
        }];
    }];
    return groupnewcell;
}
-(void)addfriend:(RCConversation *)conver
{
    WEAKSELF;
    [self.dataArray removeAllObjects];
    [self showWithStatus:@"数据加载中..." ];
    NSMutableDictionary *parametDic = [NSMutableDictionary dictionaryWithCapacity:9];
    [parametDic setObject:RCLOUD_ID forKey:@"mid"];
    [parametDic setObject:conver.targetId forKey:@"fid"];
    [parametDic setObject: [UserDefaults objectForKey:@"name"] forKey:@"myNickname"];
     [parametDic setObject:@"" forKey:@"fNickname"];//对方对我的备注名字
    [UserRequestToo shareInstance].rquesturl=addfriendlistRequrl;
    [UserRequestToo shareInstance].params=parametDic;
    [[UserRequestToo shareInstance] statrrequestgetwith:MHAsiNetWorkPOST successBlock:^(id returnData) {
        [weakSelf dismiss];
        if (returnData[@"success"]) {
            if([returnData[@"status"] isEqualToString:@"200"]) {
            [[RCIMClient sharedRCIMClient] clearMessagesUnreadStatus:conver.conversationType targetId:conver.targetId];
                [self showSuccessWithStatus:@"通过好友验证" ];
                [[NSNotificationCenter defaultCenter] postNotificationName:UPDATE_GROUP_FRIEND object:nil];
                [self loadfriendChatlistdata];
            }
        }
        else{
            [self showErrorWithStatus:returnData[@"message"] ];
        }
    } failureBlock:^(NSError *error) {
        [self dismiss];
        [self showErrorWithStatus:@"未通过好友验证" ];
    }];
}
-(void)passaddGroup:(RCConversation *)conver
{
    [self.dataArray removeAllObjects];
    [self showWithStatus:@"数据加载中..." ];
    NSMutableDictionary *parametDic = [NSMutableDictionary dictionaryWithCapacity:9];
    [parametDic setObject:RCLOUD_ID forKey:@"userId"];
    [parametDic setObject:conver.targetId forKey:@"crewId"];
    [UserRequestToo shareInstance].rquesturl=PassGroupInvateRequrl;
    [UserRequestToo shareInstance].params=parametDic;
    [[UserRequestToo shareInstance] statrrequestgetwith:MHAsiNetWorkPOST successBlock:^(id returnData) {
        if (returnData[@"success"]) {
            if([returnData[@"status"] isEqualToString:@"200"]) {
                [[RCIMClient sharedRCIMClient] clearMessagesUnreadStatus:conver.conversationType targetId:conver.targetId];
                [self.myTableView reloadData];
                [[NSNotificationCenter defaultCenter] postNotificationName:UPDATE_GROUP_FRIEND object:nil];
                [self showSuccessWithStatus:@"社群申请已通过" ];
            }
        }
        else{
            [self showErrorWithStatus:returnData[@"message"] ];
        }
    } failureBlock:^(NSError *error) {
        [self dismiss];
        [self showErrorWithStatus:@"社群申请失败" ];
    }];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [UIView new];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1*KWidth_Scale;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewCellEditingStyleDelete;
    
}
- (BOOL)tableView: (UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    RCConversation *conver=self.dataArray[indexPath.row];
    [[RCIMClient sharedRCIMClient] removeConversation:conver.conversationType targetId:conver.targetId];
    [self.dataArray removeObjectAtIndex:indexPath.row];
    dispatch_async(dispatch_get_main_queue(), ^{
        if(self.dataArray.count==0)
        {
            [self.myTableView showEmptyViewWithType:1];
        }
        else{
            [self.myTableView removeEmptyView];
        }
        [self.myTableView reloadData];
    });
}
#pragma mark - 收到消息监听
- (void)didReceiveMessageNotification:(NSNotification *)notification {
    __weak typeof(&*self) blockSelf_ = self;
    //处理好友请求
    RCMessage *message = notification.object;
    if ([message.content isMemberOfClass:[RCContactNotificationMessage class]]) {
        
        if (message.conversationType != ConversationType_SYSTEM) {
            NSLog(@"好友消息要发系统消息！！！");
#if DEBUG
            @throw [[NSException alloc] initWithName:@"error" reason:@"好友消息要发系统消息！！！" userInfo:nil];
#endif
        }
        RCContactNotificationMessage *_contactNotificationMsg = (RCContactNotificationMessage *)message.content;
        if (_contactNotificationMsg.sourceUserId == nil || _contactNotificationMsg.sourceUserId.length == 0) {
            return;
        }
        
    } else {
     //调用父类刷新未读消息数
    }
    [self loadfriendChatlistdata];
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
