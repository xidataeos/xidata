
//
//  RCDChatListViewController.m
//  Woo
//
//  Created by 王起锋 on 2018/8/2.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import "RCDChatListViewController.h"

@interface RCDChatListViewController ()
@property(nonatomic, assign) NSUInteger index;
@end

@implementation RCDChatListViewController
- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        //设置要显示的会话类型
        [self setDisplayConversationTypes:@[
                                            @(ConversationType_PRIVATE), @(ConversationType_DISCUSSION), @(ConversationType_APPSERVICE),
                                            @(ConversationType_PUBLICSERVICE), @(ConversationType_GROUP), @(ConversationType_SYSTEM)
                                            ]];
        
        //聚合会话类型
        [self setCollectionConversationType:@[ @(ConversationType_SYSTEM) ]];
    }
    return self;
}

- (id)init {
    self = [super init];
    if (self) {
        //设置要显示的会话类型
        [self setDisplayConversationTypes:@[
                                            @(ConversationType_PRIVATE), @(ConversationType_DISCUSSION), @(ConversationType_APPSERVICE),
                                            @(ConversationType_PUBLICSERVICE), @(ConversationType_GROUP), @(ConversationType_SYSTEM)
                                            ]];
        
        //聚合会话类型
        [self setCollectionConversationType:@[ @(ConversationType_SYSTEM) ]];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationController.navigationBar.translucent = NO;
    //设置tableView样式
    self.conversationListTableView.separatorColor = [PublicFunction colorWithHexString:@"dfdfdf"];
    self.conversationListTableView.tableFooterView = [UIView new];
    
    // 设置在NavigatorBar中显示连接中的提示
    self.showConnectingStatusOnNavigatorBar = YES;

    //定位未读数会话
    self.index = 0;
    //接收定位到未读数会话的通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(GotoNextCoversation)
                                                 name:@"GotoNextCoversation"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateForSharedMessageInsertSuccess)
                                                 name:@"RCDSharedMessageInsertSuccess"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(refreshCell:)
                                                 name:@"RefreshConversationList"
                                               object:nil];
    // Do any additional setup after loading the view.
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
