
//
//  WOOConversationViewController.m
//  Woo
//
//  Created by 王起锋 on 2018/8/2.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import "WOOConversationViewController.h"
#import "GroupsdetailViewController.h"
#import "RealTimeLocationStartCell.h"
#import "RealTimeLocationEndCell.h"
#import "RealTimeLocationStatusView.h"
#import "RedMessage.h"
#import "WooRedCustcell.h"
#import "TransferMessage.h"
#import "TransFercell.h"
#import "ContactdetailViewController.h"
#import "SendRedpocketWooViewController.h"
#import "ReceiveRedWooViewController.h"
#import "ReadPocketview.h"
#import "ReddetailWooViewController.h"
#import "TransFerWooViewController.h"
#import "RCDUIBarButtonItem.h"
@interface WOOConversationViewController ()<UIActionSheetDelegate, RCRealTimeLocationObserver,
RealTimeLocationStatusViewDelegate,UIAlertViewDelegate,SendRedpocketDelegate,TransFerDelegate,MBProgressHUDDelegate>
@property(nonatomic, strong) RealTimeLocationStatusView *realTimeLocationStatusView;
@property(nonatomic, weak) id<RCRealTimeLocationProxy> realTimeLocation;
@property(nonatomic,strong)RCDUserInfo *chatuserinfo;
@property(nonatomic,strong)ReadPocketview *red;
@property(nonatomic,strong)UIImageView *xuanzhuanimage;
@end
NSMutableDictionary *userInputStatus;
@implementation WOOConversationViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
     self.defaultInputType = RCChatSessionInputBarInputExtention;
    NSString *userInputStatusKey =
    [NSString stringWithFormat:@"%lu--%@", (unsigned long)self.conversationType, self.targetId];
    if (userInputStatus && [userInputStatus.allKeys containsObject:userInputStatusKey]) {
        KBottomBarStatus inputType = (KBottomBarStatus)[userInputStatus[userInputStatusKey] integerValue];
        //输入框记忆功能，如果退出时是语音输入，再次进入默认语音输入
        if (inputType == KBottomBarRecordStatus) {
            self.defaultInputType = RCChatSessionInputBarInputVoice;
        } else if (inputType == KBottomBarPluginStatus) {
                  self.defaultInputType = RCChatSessionInputBarInputExtention;
        }
    }
    
     self.defaultInputType = RCChatSessionInputBarInputExtention;
    [self.chatSessionInputBarControl setInputBarType:RCChatSessionInputBarControlDefaultType style:RC_CHAT_INPUT_BAR_STYLE_SWITCH_CONTAINER_EXTENTION];
//    [self refreshTitle];
//        [self.chatSessionInputBarControl updateStatus:self.chatSessionInputBarControl.currentBottomBarStatus
//        animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    KBottomBarStatus inputType = self.chatSessionInputBarControl.currentBottomBarStatus;
    if (!userInputStatus) {
        userInputStatus = [NSMutableDictionary new];
    }
    NSString *userInputStatusKey =
    [NSString stringWithFormat:@"%lu--%@", (unsigned long)self.conversationType, self.targetId];
    [userInputStatus setObject:[NSString stringWithFormat:@"%ld", (long)inputType] forKey:userInputStatusKey];
}
- (void)setLeftNavigationItem
{
    RCDUIBarButtonItem *leftButton = [[RCDUIBarButtonItem alloc] initWithLeftBarButton:@"返回" target:self                        action:@selector(leftBarButtonItemPressed:)];
    [self.navigationItem setLeftBarButtonItem:leftButton];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftNavigationItem];
    //设置会话列表头像和会话页面头像
    if (self.conversationType==ConversationType_PRIVATE) {
        [[RCIM sharedRCIM] setUserInfoDataSource:self];
    }
    else{
        [[RCIM sharedRCIM] setGroupInfoDataSource:self];
    }
    NSArray *viewControllers = self.navigationController.viewControllers;//获取当前的视图控制其
    if ([viewControllers indexOfObject:self] == NSNotFound) {
        //当前视图控制器不在栈中，故为pop操作
        [self.realTimeLocation removeRealTimeLocationObserver:self];
        self.realTimeLocation = nil;
    }
    //默认输入类型为语音,这里修改为默认显示加号区域
   // self.defaultInputType = RCChatSessionInputBarInputExtention;
    //[self setnavigation];
    WEAKSELF
    /*******************实时地理位置共享***************/
    [self registerClass:[RealTimeLocationStartCell class] forMessageClass:[RCRealTimeLocationStartMessage class]];
    [self registerClass:[RealTimeLocationEndCell class] forMessageClass:[RCRealTimeLocationEndMessage class]];
    
    [[RCRealTimeLocationManager sharedManager] getRealTimeLocationProxy:self.conversationType
                                                               targetId:self.targetId
                                                                success:^(id<RCRealTimeLocationProxy> realTimeLocation) {
                                                                    weakSelf.realTimeLocation = realTimeLocation;
                                                                    [weakSelf.realTimeLocation addRealTimeLocationObserver:weakSelf];
                                                                    [weakSelf updateRealTimeLocationStatus];
                                                                }
                                                                  error:^(RCRealTimeLocationErrorCode status) {
                                                                      NSLog(@"get location share failure with code %d", (int)status);
                                                                  }];

    
    ///注册自定义红包消息和Cell
    [self registerClass:[WooRedCustcell class] forMessageClass:[RedMessage class]];
    
    //注册自定义转账消息
     [self registerClass:[TransFercell class] forMessageClass:[TransferMessage class]];
    // Do any additional setup after loading the view.
    if (self.conversationType == ConversationType_GROUP) {
        //群组改名之后，更新当前页面的Title
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTitleForGroup:)name:@"UpdeteGroupInfo"object:nil];
    }
    
    //清除历史消息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clearHistoryMSG:)name:@"ClearHistoryMsg"object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
    selector:@selector(updateForSharedMessageInsertSuccess:)name:@"RCDSharedMessageInsertSuccess"
object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
    selector:@selector(keyboardWillShowNotification:)
    name:UIKeyboardWillShowNotification
    object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
 selector:@selector(onEndForwardMessage:)name:@"RCDForwardMessageEnd"object:nil];
    RCPluginBoardView *pluginBoardView = self.chatSessionInputBarControl.pluginBoardView;
    //if (self.conversationType==ConversationType_PRIVATE) {
        [pluginBoardView removeItemWithTag:PLUGIN_BOARD_ITEM_TRANSFER_TAG];
    //[self getFriendRelationship:self.targetId istapPortrait:NO];
    //}
    [pluginBoardView removeItemWithTag:PLUGIN_BOARD_ITEM_RED_PACKET_TAG];
   // [pluginBoardView insertItemWithImage:[RCKitUtility imageNamed:@"ic_hongbao" ofBundle:@"JResource.bundle"] title:@"红包" atIndex:0 tag:PLUGIN_BOARD_ITEM_RED_PACKET_TAG];
    [self notifyUpdateUnreadMessageCount];
    [self addToolbarItems];
}
-(void)setnavigation
{
    UIButton *  rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setTitle:@"详情" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(setBtnClick) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.frame = CGRectMake(SCREEN_WIDTH - 45, 25, 20, 20);
    UIBarButtonItem *right=[[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem=right;
}
-(void)setBtnClick
{
    GroupsdetailViewController *push=[[GroupsdetailViewController alloc] init];
    [self.navigationController pushViewController:push animated:YES];
}
- (void)updateRealTimeLocationStatus {
    if (self.realTimeLocation) {
        [self.realTimeLocationStatusView updateRealTimeLocationStatus];
        __weak typeof(&*self) weakSelf = self;
        NSArray *participants = nil;
        switch ([self.realTimeLocation getStatus]) {
            case RC_REAL_TIME_LOCATION_STATUS_OUTGOING:
                [self.realTimeLocationStatusView updateText:@"你正在共享位置"];
                break;
            case RC_REAL_TIME_LOCATION_STATUS_CONNECTED:
            case RC_REAL_TIME_LOCATION_STATUS_INCOMING:
                participants = [self.realTimeLocation getParticipants];
                if (participants.count == 1) {
                    NSString *userId = participants[0];
                    [weakSelf.realTimeLocationStatusView
                     updateText:[NSString stringWithFormat:@"user<%@>正在共享位置", userId]];
                    [[RCIM sharedRCIM].userInfoDataSource
                     getUserInfoWithUserId:userId
                     completion:^(RCUserInfo *userInfo) {
                         if (userInfo.name.length) {
                             dispatch_async(dispatch_get_main_queue(), ^{
                                 [weakSelf.realTimeLocationStatusView
                                  updateText:[NSString stringWithFormat:@"%@正在共享位置", userInfo.name]];
                             });
                         }
                     }];
                } else {
                    if (participants.count < 1)
                        [self.realTimeLocationStatusView removeFromSuperview];
                    else
                        [self.realTimeLocationStatusView
                         updateText:[NSString stringWithFormat:@"%d人正在共享地理位置", (int)participants.count]];
                }
                break;
            default:
                break;
        }
    }
}
/******************消息多选功能:转发、删除**********************/
- (void)addToolbarItems{
    //转发按钮
    UIButton *forwardBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 40)];
    [forwardBtn setImage:[UIImage imageNamed:@"forward_message"] forState:UIControlStateNormal];
    [forwardBtn addTarget:self action:@selector(forwardMessage) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *forwardBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:forwardBtn];
    //删除按钮
    UIButton *deleteBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 40)];
    [deleteBtn setImage:[RCKitUtility imageNamed:@"delete_message" ofBundle:@"RongCloud.bundle"] forState:UIControlStateNormal];
    [deleteBtn addTarget:self action:@selector(deleteMessages) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *deleteBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:deleteBtn];
    //按钮间 space
    UIBarButtonItem *spaceItem =
    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [self.messageSelectionToolbar setItems:@[spaceItem,forwardBarButtonItem,spaceItem,deleteBarButtonItem,spaceItem] animated:YES];
}
- (void)deleteMessages{
    for (int i = 0; i < self.selectedMessages.count; i++) {
        [self deleteMessage:self.selectedMessages[i]];
    }
    //置为 NO,将消息 cell 重置为初始状态
    self.allowsMessageCellSelection = NO;
}
/**
 *  打开大图。开发者可以重写，自己下载并且展示图片。默认使用内置controller
 *
 *  @param model 图片消息内容
 */
- (void)presentImagePreviewController:(RCMessageModel *)model {
    RCImageSlideController *previewController = [[RCImageSlideController alloc] init];
    previewController.messageModel = model;
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:previewController];
    [self.navigationController presentViewController:nav animated:YES completion:nil];
}
- (void)pluginBoardView:(RCPluginBoardView *)pluginBoardView clickedItemWithTag:(NSInteger)tag {
    switch (tag) {
            case PLUGIN_BOARD_ITEM_LOCATION_TAG: {
//                if (self.realTimeLocation) {
//                    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil
//                        otherButtonTitles:@"发送位置", @"位置实时共享", nil];
//                    [actionSheet showInView:self.view];
//                } else {
                    [super pluginBoardView:pluginBoardView clickedItemWithTag:tag];
                //}
            } break;
            case PLUGIN_BOARD_ITEM_RED_PACKET_TAG:
        {
            SendRedpocketWooViewController *control=[[SendRedpocketWooViewController alloc] init];
            control.delegate=self;
            control.convertype=self.conversationType;
            control.selfcount=@"10";
            [self.navigationController pushViewController:control animated:YES];
            return;
        }
            case PLUGIN_BOARD_ITEM_ZhuanZhang_TAG:
        {
            TransFerWooViewController *control=[[TransFerWooViewController alloc] init];
            control.delegate=self;
            control.userinfo=self.chatuserinfo;
            [self.navigationController pushViewController:control animated:YES];
            return;
        }
        default:
            [super pluginBoardView:pluginBoardView clickedItemWithTag:tag];
            break;
    }
}
#pragma mark override
//点击 cell
- (void)didTapMessageCell:(RCMessageModel *)model {
    WEAKSELF;
    [super didTapMessageCell:model];
    RedMessage *redmodel = (RedMessage *)model.content;
    if ([model.content isKindOfClass:[RCRealTimeLocationStartMessage class]]) {
    }
    else if ([model.content isKindOfClass:[RedMessage class]])
    {
            if (weakSelf.conversationType==ConversationType_PRIVATE) {
                [self getaredenvelope:redmodel redmodle:model];
            }
            else{
                [self getGroupelope:redmodel redmodle:model receiveid:RCLOUD_ID];
            }
            
       
    }
}
#pragma mark 接受单人红包
-(void)getaredenvelope:(RedMessage *)model redmodle:(RCMessageModel*)redmodle
{
    if ([redmodle.senderUserId isEqualToString:RCLOUD_ID])
    {
        [self showAlertHud:self.view.center withStr:@"您的红包等待对方领取" offy:-100];
        return;
    }
    WEAKSELF;
    NSMutableDictionary *parametDic = [NSMutableDictionary dictionaryWithCapacity:9];
    [parametDic setObject:model.redId forKey:@"redSingleId"];
    [UserRequestToo shareInstance].rquesturl=receiveSingleredRequesturl;
    [UserRequestToo shareInstance].params=parametDic;
    [[UserRequestToo shareInstance] statrrequestgetwith:MHAsiNetWorkPOST successBlock:^(id returnData) {
        [self.xuanzhuanimage removeFromSuperview];
        if (returnData[@"success"]) {
            if([returnData[@"status"] isEqualToString:@"200"])
            {
                self.red=[[ReadPocketview alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) retype:red_type_have withtips:@"" target:redmodle.senderUserId isgroup:NO];
                [self.red shareviewShow];
                [self.red setMyblock:^{
                    [weakSelf pushRedmessageview:returnData[@"data"]];
                }];
            }
            else{
                NSString *tips;
                if ([returnData[@"status"] isEqualToString:@"5001"]) {
                    tips=@"你已领取过该红包,不能贪心哦!";
                }
                else if ([returnData[@"status"] isEqualToString:@"5002"]){
                    tips=@"手慢了,红包被领完了!";
                }
                else{
                    tips=returnData[@"message"];
                }
                self.red=[[ReadPocketview alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) retype:red_type_no withtips:tips target:redmodle.senderUserId isgroup:NO];
               // _selftitleLable.text=redmodle.
                [self.red setMyblock:^{
                    [weakSelf receiveRedmessage:redmodle isgroup:NO];
                }];
                [self.red shareviewShow];
            }
            
        }
    } failureBlock:^(NSError *error) {
        [self.xuanzhuanimage removeFromSuperview];
        [weakSelf showAlertHud:self.view.center withStr:error.description offy:-100];
    }];
}
#pragma mark 接受群组人红包
-(void)getGroupelope:(RedMessage *)model redmodle:(RCMessageModel*)redmodle receiveid:(NSString *)receiveid
{
    WEAKSELF;
    NSMutableDictionary *parametDic = [NSMutableDictionary dictionaryWithCapacity:9];
    [parametDic setObject:RCLOUD_ID forKey:@"recvId"];
    [parametDic setObject:model.redId forKey:@"redMultiId"];
    [UserRequestToo shareInstance].rquesturl=ReceiveGroupredRequesturl;
    [UserRequestToo shareInstance].params=parametDic;
    [[UserRequestToo shareInstance] statrrequestgetwith:MHAsiNetWorkPOST successBlock:^(id returnData) {
        [self.xuanzhuanimage removeFromSuperview];
        if (returnData[@"success"]) {
            if([returnData[@"status"] isEqualToString:@"200"])
            {
                self.red=[[ReadPocketview alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) retype:red_type_have withtips:@"" target:redmodle.senderUserId isgroup:YES];
                [self.red shareviewShow];
                [self.red setMyblock:^{
                    [weakSelf pushRedmessageview:returnData[@"data"]];
                }];
            }
            else{
                NSString *tips;
                if ([returnData[@"status"] isEqualToString:@"5001"]) {
                    tips=@"你已领取过该红包,不能贪心哦!";
                }
                else if ([returnData[@"status"] isEqualToString:@"5002"]){
                    tips=@"手慢了,红包被领完了!";
                }
                self.red=[[ReadPocketview alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) retype:red_type_no withtips:tips target:redmodle.senderUserId isgroup:YES];
                [self.red setMyblock:^{
                    [weakSelf receiveRedmessage:redmodle isgroup:YES];
                }];
                [self.red shareviewShow];
            }
        }
    } failureBlock:^(NSError *error) {
         [self.xuanzhuanimage removeFromSuperview];
        [weakSelf showAlertHud:self.view.center withStr:error.description offy:-100];
    }];
}
#pragma mark 获取红包详情
-(void)receiveRedmessage:(RCMessageModel *)remodel isgroup:(BOOL)isgroup
{
     RedMessage *redmodel = (RedMessage *)remodel.content;
    NSString *urlstr;
    NSMutableDictionary *parametDic = [NSMutableDictionary dictionaryWithCapacity:9];
    if (isgroup) {
        urlstr=SeeGroupredRequesturl;
        [parametDic setObject:redmodel.recv forKey:@"recvId"];
        [parametDic setObject:redmodel.redId forKey:@"redMultiId"];
    }
    else{
        urlstr=ReceivesingleredRequesturl;
        [parametDic setObject:redmodel.redId forKey:@"redSingleId"];
    }
    WEAKSELF;
    [UserRequestToo shareInstance].rquesturl=urlstr;
    [UserRequestToo shareInstance].params=parametDic;
    [[UserRequestToo shareInstance] statrrequestgetwith:MHAsiNetWorkGET successBlock:^(id returnData) {
        if (returnData[@"success"]) {
            if([returnData[@"status"] isEqualToString:@"200"])
            {
              [weakSelf pushRedmessageview:returnData[@"data"]];
            }
        }
    } failureBlock:^(NSError *error) {
        [weakSelf showAlertHud:self.view.center withStr:error.description offy:-100];
    }];
    
}
#pragma mark 跳转红包详情页面
-(void)pushRedmessageview:(NSDictionary *)retudedate
{
    [self.red canleclick];
    RedmessageModle *redmodle=[[RedmessageModle alloc] init];
    [redmodle setValuesForKeysWithDictionary:retudedate];
    redmodle.asset=[NSString stringWithFormat:@"%@",retudedate[@"asset"]];
    redmodle.balance=[NSString stringWithFormat:@"%@",retudedate[@"balance"]];
    redmodle.size=[NSString stringWithFormat:@"%@",retudedate[@"size"]];
    ReddetailWooViewController *control=[[ReddetailWooViewController alloc] init];
    control.type=self.conversationType;
    control.redmodle=redmodle;
    [self.navigationController pushViewController:control animated:YES];
}
- (void)didTapCellPortrait:(NSString *)userId {
    if (self.conversationType==ConversationType_PRIVATE) {
        if ([userId isEqualToString:RCLOUD_ID]) {
            return;
        }
    }
    [self getFriendRelationship:userId istapPortrait:YES];
}
//查看好友关系
-(void)getFriendRelationship:(NSString *)userId istapPortrait:(BOOL)istapPortrait
{
    [[ChatmangerObject ShareManger] getFriendRelationship:userId successBlock:^(id returnData) {
        ContactdetailViewController *contact=[[ContactdetailViewController alloc] init];
        RCDUserInfo *userinfomodel=(RCDUserInfo *)returnData;
        contact.userinfo=userinfomodel;
        self.chatuserinfo=userinfomodel;
        if ([userinfomodel.status isEqualToString:@"1"]) {
            contact.ismyfriend=YES;
            if (istapPortrait) {
                [self.navigationController pushViewController:contact animated:YES];
            }
            else{
                RCPluginBoardView *pluginBoardView = self.chatSessionInputBarControl.pluginBoardView;
                [pluginBoardView insertItemWithImage:[RCKitUtility imageNamed:@"ic_transfer" ofBundle:@"JResource.bundle"] title:@"转账" atIndex:1 tag:PLUGIN_BOARD_ITEM_ZhuanZhang_TAG];
            }
            return ;
        }
        else{
            contact.ismyfriend=NO;
            if (istapPortrait) {
                [self.navigationController pushViewController:contact animated:YES];
            }
            else{
                
            }
        }
    } failureBlock:^(NSError *error) {
        
    }];

}
//可以在这里修改将要发送的消息
- (RCMessageContent *)willSendMessage:(RCMessageContent *)messageContent {
    //可以在这里修改将要发送的消息
//    WooRedMessage *message=[WooRedMessage messageWithredZize:@"10" redCount:@"5" content:@"恭喜发财"];
    return messageContent;
}
#pragma mark 单聊发红包调用
-(void)sendRedmessage:(NSString *)redSize leavemessage:(NSString *)leavemessage
{
    [self sendRedmess:redSize leavemessage:leavemessage];
}
-(void)sendRedmess:(NSString*)redSize leavemessage:(NSString *)leavemessage
{
    WEAKSELF;
    NSMutableDictionary *parametDic = [NSMutableDictionary dictionaryWithCapacity:9];
    [parametDic setObject:RCLOUD_ID forKey:@"fromId"];
    [parametDic setObject:self.targetId forKey:@"toId"];
    [parametDic setObject:leavemessage forKey:@"tip"];
    [parametDic setObject:redSize forKey:@"asset"];
    [UserRequestToo shareInstance].rquesturl=sendSingleredRequesturl;
    [UserRequestToo shareInstance].params=parametDic;
    [[UserRequestToo shareInstance] statrrequestgetwith:MHAsiNetWorkPOST successBlock:^(id returnData) {
        if (returnData[@"success"]) {
            if([returnData[@"status"] isEqualToString:@"200"])
            {
//              RedMessage *message=[RedMessage messageWithredZize:@"9" tip:@"恭喜发财,大吉大利" redId:@"6266" recv:@"rece" mode:@"1"];
//             [self sendMessage:message pushContent:nil];
            }
            else{
                [weakSelf showAlertHud:self.view.center withStr:returnData[@"message"] offy:-100];
            }
        }
    } failureBlock:^(NSError *error) {
        [weakSelf showAlertHud:self.view.center withStr:error.description offy:-100];
    }];
}
#pragma mark 转账
-(void)TransFerDelegatemessage:(NSString *)Size leavemessage:(NSString *)leavemessage
{
    [self Redtransfer:Size leavemessage:leavemessage];
}
-(void)Redtransfer:(NSString *)Size leavemessage:(NSString *)leavemessage
{
    WEAKSELF;
    NSMutableDictionary *parametDic = [NSMutableDictionary dictionaryWithCapacity:9];
    [parametDic setObject:RCLOUD_ID forKey:@"fromId"];
    [parametDic setObject:self.targetId forKey:@"toId"];
    [parametDic setObject:leavemessage forKey:@"tip"];
    [parametDic setObject:Size forKey:@"asset"];
    [UserRequestToo shareInstance].rquesturl=transferRequesturl;
    [UserRequestToo shareInstance].params=parametDic;
    [[UserRequestToo shareInstance] statrrequestgetwith:MHAsiNetWorkPOST successBlock:^(id returnData) {
        if (returnData[@"success"]) {
            if([returnData[@"status"] isEqualToString:@"200"])
            {
//            TransferMessage *message=[TransferMessage messageWithredZize:Size content:leavemessage TranSingleId:returnData[@"TranSingleId"]];
                    // 调用RCIMClient的sendMessage方法进行发送，结果会通过回调进行反馈。
            //[self sendMessage:message pushContent:nil];
           }
            else{
                [weakSelf showAlertHud:self.view.center withStr:returnData[@"message"] offy:-100];
            }
    }
    } failureBlock:^(NSError *error) {
         [weakSelf showAlertHud:self.view.center withStr:error.description offy:-100];
    }];
    
}
#pragma mark 群组发红包调用
-(void)GroupsendRedmessage:(NSString *)redSize redcount:(NSString *)redcount leavemessage:(NSString *)leavemessage
{
    WEAKSELF;
    NSMutableDictionary *parametDic = [NSMutableDictionary dictionaryWithCapacity:9];
    [parametDic setObject:RCLOUD_ID forKey:@"fromId"];
    [parametDic setObject:self.targetId forKey:@"toId"];
    [parametDic setObject:redcount forKey:@"size"];
    [parametDic setObject:redSize forKey:@"asset"];
    [parametDic setObject:leavemessage forKey:@"tip"];
    [UserRequestToo shareInstance].rquesturl=sendGroupredRequesturl;
    [UserRequestToo shareInstance].params=parametDic;
    [[UserRequestToo shareInstance] statrrequestgetwith:MHAsiNetWorkPOST successBlock:^(id returnData) {
        if (returnData[@"success"]) {
            if([returnData[@"status"] isEqualToString:@"200"])
            {
               
            }
            else{
                [weakSelf showAlertHud:self.view.center withStr:returnData[@"message"] offy:-100];
            }
        }
    } failureBlock:^(NSError *error) {
        [weakSelf showAlertHud:self.view.center withStr:error.description offy:-100];
    }];
    
}

/*点击系统键盘的语音按钮，导致输入工具栏被遮挡*/
- (void)keyboardWillShowNotification:(NSNotification *)notification {
    if(!self.chatSessionInputBarControl.inputTextView.isFirstResponder)
    {
        [self.chatSessionInputBarControl.inputTextView becomeFirstResponder];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)showAlertHud:(CGPoint)point withStr:(NSString *)message offy:(CGFloat)offy
{
    MBProgressHUD *hudP = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hudP.mode = MBProgressHUDModeText;
    hudP.margin = 15.f;
    hudP.bezelView.backgroundColor=RGB(60, 74, 93);
    hudP.bezelView.layer.cornerRadius=22;
    hudP.bezelView.clipsToBounds=YES;
    hudP.removeFromSuperViewOnHide = YES;
    hudP.delegate = self;
    hudP.detailsLabel.text=message;
    hudP.detailsLabel.textColor=RGB(255, 255, 255);
    hudP.detailsLabel.font = [UIFont systemFontOfSize:13.0f];
    [hudP hideAnimated:YES afterDelay:2.0];
}
- (void)getUserInfoWithUserId:(NSString *)userId
                   completion:(void (^)(RCUserInfo *userInfo))completion
{
    RCUserInfo *info=[[RCUserInfo alloc] init];
    info.userId=self.targetId;
    info.name=self.userinfo.name;
    info.portraitUri=self.userinfo.portraitUri;
    completion(info);
}
- (void)getGroupInfoWithGroupId:(NSString *)groupId
                     completion:(void (^)(RCGroup *groupInfo))completion
{
    RCGroup *info=[[RCGroup alloc] init];
    info.groupId=self.targetId;
    info.groupName=self.groupinfo.groupName;
    info.portraitUri=self.groupinfo.portraitUri;
    completion(info);
}
-(void)leftBarButtonItemPressed:(id)sender
{
    [super leftBarButtonItemPressed:nil];
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
