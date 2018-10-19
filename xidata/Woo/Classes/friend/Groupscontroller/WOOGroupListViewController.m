
//
//  RCDChatListViewController.m
//  Woo
//
//  Created by 王起锋 on 2018/8/2.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import "WOOGroupListViewController.h"
#import "GroupTableViewCell.h"
#import "MycreatGroupdetailViewController.h"
#import "CreatGroupAvatar.h"
#import "BaseTableView.h"
@interface WOOGroupListViewController ()<UITableViewDelegate,UITableViewDataSource,SelectContactViewDelegate>
@property (nonatomic, strong)  BaseTableView * myTableView;
@property (nonatomic, strong)  NSMutableArray * titlearr;
@property (nonatomic, strong)  NSMutableArray *imageicomarr;
@property(nonatomic, assign) BOOL isClick;
@end

@implementation WOOGroupListViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self loadfriendChatlistdata];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"社群";
    self.imageicomarr=[[NSMutableArray alloc] initWithObjects:@"jianqun",@"shequn", nil];
    self.titlearr=[[NSMutableArray alloc] initWithObjects:@"创建社群",@"我的社群", nil];
    [self.myTableView reloadData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveMessageNotification:)name:RCKitDispatchMessageNotification object:nil];
}
-(BaseTableView *)myTableView{
    if (!_myTableView) {
        _myTableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-TabbarHeight) style:UITableViewStyleGrouped];
        //_myTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _myTableView.separatorColor=CellBackgroundColor;
        _myTableView.delegate=self;
        _myTableView.dataSource = self;
        _myTableView.showsVerticalScrollIndicator = NO;
        _myTableView.showsHorizontalScrollIndicator = NO;
        [_myTableView setTableFooterView: [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)]];
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
-(void)loadfriendChatlistdata
{
    [self.dataArray removeAllObjects];
    /*
     , @(ConversationType_DISCUSSION), @(ConversationType_APPSERVICE),
     @(ConversationType_PUBLICSERVICE), @(ConversationType_GROUP), @(ConversationType_SYSTEM)
     */
    NSArray *conversationList = [[RCIMClient sharedRCIMClient] getConversationList:@[ @(ConversationType_GROUP)]];
    [self.dataArray addObjectsFromArray:conversationList];
    dispatch_async(dispatch_get_main_queue(), ^{
        if(self.dataArray.count==0)
        {
            [self.myTableView reloadData];
            [self.myTableView showEmptyViewWithType:1];
        }
        else{
            [self.myTableView removeEmptyView];
            [self.myTableView reloadData];
        }
    });
}
#pragma mark tableview的代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section!=2) {
        return 1;
    }
    else{
        return self.dataArray.count;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section!=2) {
        return 55*KWidth_Scale;
    }
    return 70;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *mycellid=@"GroupTableViewCell";
    GroupTableViewCell *newcell=[tableView dequeueReusableCellWithIdentifier:mycellid];
    
    static NSString *chatmycellid=@"UITableViewCell";
    UITableViewCell *chatnewcell=[tableView dequeueReusableCellWithIdentifier:chatmycellid];
    if (chatnewcell==nil) {
        chatnewcell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:chatmycellid];
    }
    if (newcell==nil) {
        newcell=[[GroupTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:mycellid];
    }
    if (indexPath.section!=2) {
        //取消点击效果
        chatnewcell.imageView.image=[UIImage imageNamed:self.imageicomarr[indexPath.section]];
        chatnewcell.textLabel.textColor=RGB(51, 51, 51);
        chatnewcell.textLabel.font=DefleFuont;
    chatnewcell.textLabel.text=self.titlearr[indexPath.section];
        chatnewcell.selectionStyle=UITableViewCellSelectionStyleNone;
        return chatnewcell;
    }
    else{
        RCConversation *conver=self.dataArray[indexPath.row];
        newcell.model=conver;
        return newcell;
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.section==0) {
        SelectContactViewController *push=[[SelectContactViewController alloc] init];
        push.delegate=self;
        push.type=CREAT_GROUP;
        [self.navigationController pushViewController:push animated:YES];
    }
    else if (indexPath.section==1){
        MyfriendsViewController *push=[[MyfriendsViewController alloc] init];
        push.chatype=Group_chat;
        [self.navigationController pushViewController:push animated:YES];
    }
    else{
        RCConversation *conver=self.dataArray[indexPath.row];
         [[ChatmangerObject ShareManger] gotoChatViewtargetid:conver.targetId convertitle:conver.conversationTitle conversationModelType:conver.conversationType fromview:self info:nil];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 8*KWidth_Scale;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return CGFLOAT_MIN;
    }
    else if (section==1){
        return CGFLOAT_MIN;
    }
    return 50*KWidth_Scale;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footview=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 8*KWidth_Scale)];
    footview.backgroundColor=CellBackgroundColor;
    if (section!=2) {
        return footview;
    }
    return [UIView new];
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *backview=[[UIView alloc] initWithFrame:CGRectMake(0, 0*KWidth_Scale, SCREEN_WIDTH, 50*KWidth_Scale)];
    backview.backgroundColor=[UIColor whiteColor];
    UILabel *nametitle=[PublicFunction getlabelwithtexttitle:@"群聊" fram:CGRectMake(15*KWidth_Scale,0, SCREEN_WIDTH*0.5, 50*KWidth_Scale) cornerRadius:0 textcolor:WordsofcolorColor textfont:DefleFuont backcolor:[UIColor whiteColor] textAlignment:NSTextAlignmentLeft];
    [backview
     addSubview:nametitle];
    UIView *cellview=[[UIView alloc] initWithFrame:CGRectMake(0, 50*KWidth_Scale, SCREEN_WIDTH, 0.7*KWidth_Scale)];
    cellview.backgroundColor=CellBackgroundColor;
    [backview addSubview:cellview];
    if (section==0) {
        return [UIView new];
    }
    else if (section==1){
        return [UIView new];
    }
    else return backview;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section!=2) {
        return NO;
    }
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
-(void)sendThecontacts:(NSMutableArray *)selectedcontacts
{
    [[ChatmangerObject ShareManger] cgreatGroupwith:selectedcontacts fromview:self];
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
