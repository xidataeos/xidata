
//
//  ChatmangerObject.m
//  Woo
//
//  Created by 王起锋 on 2018/8/10.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import "ChatmangerObject.h"
#import "GroupsdetailViewController.h"
@implementation ChatmangerObject
+ (id)ShareManger{
    static dispatch_once_t once;
    static ChatmangerObject *_Chatmanger;
    dispatch_once(&once, ^ {
        _Chatmanger = [[ChatmangerObject alloc] init];
    });
    return _Chatmanger;
}
-(void)gotoChatViewtargetid:(NSString *)targetid convertitle:(NSString *)convertitle conversationModelType:(RCConversationType)conversationModelType fromview:(WooBaseViewController *)fromeview;
{
    WOOConversationViewController *chat = [[WOOConversationViewController alloc] init];
    //设置会话的类型，如单聊、群聊、聊天室、客服、公众服务会话等
    chat.conversationType =conversationModelType;
    //设置会话的目标会话ID。（单聊、客服、公众服务会话为对方的ID，群聊、聊天室为会话的ID）
    chat.targetId = targetid;
    //设置聊天会话界面要显示的标题
    if (conversationModelType==ConversationType_PRIVATE) {
        RCDUserInfo *info=[[RCDataBaseManager shareInstance] getFriendInfo:targetid];
        chat.title = info.displayName;
    }
    else{
        
        RCDGroupInfo *group=[[RCDataBaseManager shareInstance] getGroupByGroupId:targetid];
        chat.title = group.groupName;
    }
    
    //显示聊天会话界面
    [fromeview.navigationController pushViewController:chat animated:YES];
}
-(void)cgreatGroupwith:(NSMutableArray *)list fromview:(WooBaseViewController *)fromcontroller;
{
    NSMutableArray *titles=[[NSMutableArray alloc] init];
    NSMutableArray *uids=[[NSMutableArray alloc] init];
    [titles addObject:@"我自己"];
    for (RCDUserInfo *info in list) {
        [titles addObject:info.displayName];
        [uids addObject:info.userId];
    }
    [fromcontroller showhudmessage:@"群组创建中..." offy:-100];
    NSString *title;
    NSString *useid;
    if (titles.count>1) {
        title=[titles componentsJoinedByString:@","];
    }
    else{
        title=[titles firstObject];
    }
    if (uids.count>1) {
        useid=[uids componentsJoinedByString:@","];
    }
    else{
        useid=[uids firstObject];
    }
    NSMutableDictionary *parametDic = [NSMutableDictionary dictionaryWithCapacity:9];
    [parametDic setObject:RCLOUD_ID forKey:@"uid"];
    [parametDic setObject:title forKey:@"name"];
    [parametDic setObject:useid forKey:@"uids"];
    [UserRequestToo shareInstance].rquesturl=CreatGroupandInvateRequrl;
    [UserRequestToo shareInstance].params=parametDic;
    [[UserRequestToo shareInstance] statrrequestgetwith:MHAsiNetWorkPOST successBlock:^(id returnData) {
        [fromcontroller hideHud];
        if (returnData[@"success"]) {
            if([returnData[@"status"] isEqualToString:@"200"]) {
                NSDictionary *dic=returnData[@"data"];
                [fromcontroller showAlertHud:fromcontroller.view.center withStr:@"群组创建成功" offy:-100];
                [self gotoChatViewtargetid:dic[@"cid"] convertitle:dic[@"name"] conversationModelType:ConversationType_GROUP fromview:fromcontroller];
                [[NSNotificationCenter defaultCenter] postNotificationName:UPDATE_GROUP_FRIEND object:nil];
            }
        }
        else{
            [fromcontroller showAlertHud:fromcontroller.view.center withStr:returnData[@"message"] offy:-100];
        }
    } failureBlock:^(NSError *error) {
        [fromcontroller hideHud];
        [fromcontroller showAlertHud:fromcontroller.view.center withStr:@"群组创建失败" offy:-100];
    }];
}
-(void)addsomegroup:(NSMutableArray *)list fromcontroller:(WooBaseViewController *)fromcontroller Groupid:(NSString *)Groupid
{
     [fromcontroller showAlertHud:fromcontroller.view.center withStr:@"数据处理中" offy:-100];
    for (int i=0; i<list.count; i++) {
        RCDUserInfo *info =list[i];
        NSMutableDictionary *parametDic = [NSMutableDictionary dictionaryWithCapacity:9];
        [parametDic setObject:info.userId forKey:@"uids"];
        [parametDic setObject:Groupid forKey:@"crewId"];
        [UserRequestToo shareInstance].rquesturl=GroupInvateFriendsRequrl;
        [UserRequestToo shareInstance].params=parametDic;
        [[UserRequestToo shareInstance] statrrequestgetwith:MHAsiNetWorkPOST successBlock:^(id returnData) {
            if (i==list.count-1) {
                [fromcontroller hideHud];
            }
            if (returnData[@"success"]) {
                if([returnData[@"status"] isEqualToString:@"200"]) {
                    if (i==list.count-1) {
                    [fromcontroller showAlertHud:fromcontroller.view.center withStr:@"邀请成员成功" offy:-100];
                    }
                }
            }
        else{
            [fromcontroller showAlertHud:fromcontroller.view.center withStr:returnData[@"message"] offy:-100];
                //[fromcontroller showAlertHud:fromcontroller.view.center withStr:@"邀请成员失败" offy:-100];
            }
        } failureBlock:^(NSError *error) {
            [fromcontroller hideHud];
            [fromcontroller showAlertHud:fromcontroller.view.center withStr:@"邀请成员失败" offy:-100];
        }];
    }
}
-(void)addfriend:(NSString *)fid frome:(WooBaseViewController *)frome
{
    [frome showhudmessage:@"请求处理中..." offy:-100];
    NSMutableDictionary *parametDic = [NSMutableDictionary dictionaryWithCapacity:9];
    [parametDic setObject:RCLOUD_ID forKey:@"mid"];
    [parametDic setObject:fid forKey:@"fid"];
    [parametDic setObject:@"好友请求" forKey:@"content"];
    [UserRequestToo shareInstance].rquesturl=invitefriendlistRequrl;
    [UserRequestToo shareInstance].params=parametDic;
    [[UserRequestToo shareInstance] statrrequestgetwith:MHAsiNetWorkPOST successBlock:^(id returnData) {
        [frome hideHud];
        if (returnData[@"success"]) {
            if([returnData[@"status"] isEqualToString:@"200"]) {
                [frome showAlertHud:frome.view.center withStr:@"好友申请发送成功" offy:-100];
            }
        }
        else{
            [frome showAlertHud:frome.view.center withStr:returnData[@"message"] offy:-100];
        }
    } failureBlock:^(NSError *error) {
        [frome hideHud];
        [frome showAlertHud:frome.view.center withStr:@"好友申请发送失败" offy:-100];
    }];
}
-(void)sendJionGroup:(NSString *)groupId frome:(WooBaseViewController *)frome
{
    [frome showhudmessage:@"申请处理中..." offy:-100];
    NSMutableDictionary *parametDic = [NSMutableDictionary dictionaryWithCapacity:9];
    [parametDic setObject:RCLOUD_ID forKey:@"userId"];
    [parametDic setObject:groupId forKey:@"crewId"];
    [parametDic setObject:@"我想加群" forKey:@"content"];
    [UserRequestToo shareInstance].rquesturl=SendJoinGroupRequrl;
    [UserRequestToo shareInstance].params=parametDic;
    [[UserRequestToo shareInstance] statrrequestgetwith:MHAsiNetWorkPOST successBlock:^(id returnData) {
        [frome hideHud];
        if (returnData[@"success"]) {
            if([returnData[@"status"] isEqualToString:@"200"]) {
                RCDGroupInfo *groups=[[RCDGroupInfo alloc] init];
                NSDictionary *dic = returnData[@"data"];
                groups.introduce=dic[@"brief"];
                groups.portraitUri=dic[@"photo"];
                groups.groupId=dic[@"cid"];
                groups.groupName=dic[@"name"];
                groups.creatorId=dic[@"uid"];
                groups.creatorTime=dic[@"createTime"];
                groups.number=[NSString stringWithFormat:@"%@",dic[@"num"]];
                groups.qrcode=dic[@"qrcode"];
                groups.pub= [NSString stringWithFormat:@"%@",dic[@"pub"]];
                if ([dic[@"isCrewMember"] isEqual:@1]) {
                    groups.isCrewMember=YES;
                    [[NSNotificationCenter defaultCenter] postNotificationName:UPDATE_GROUP_FRIEND object:nil];
                }
                else{
                    groups.isCrewMember=NO;
                }
                if ([returnData[@"isCrewMember"] isEqual:@1])
                {
                    GroupsdetailViewController *pushview=[[GroupsdetailViewController alloc] init];
                    pushview.GroupInfo=groups;
                    [frome.navigationController pushViewController:pushview animated:YES];
                }
                else{
                  [frome showAlertHud:frome.view.center withStr:@"申请已发送" offy:-100];
                }
            }
            else if ([returnData[@"status"] isEqualToString:@"400"])
            {
                
            }
            else{
                [frome showAlertHud:frome.view.center withStr:returnData[@"message"] offy:-100];
            }
        }
    } failureBlock:^(NSError *error) {
        [frome showAlertHud:frome.view.center withStr:@"申请发送失败" offy:-100];
        [frome hideHud];
    }];
    
}
@end
