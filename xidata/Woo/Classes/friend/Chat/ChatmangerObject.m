
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
#pragma mark 进入会话列表
-(void)gotoChatViewtargetid:(NSString *)targetid convertitle:(NSString *)convertitle conversationModelType:(RCConversationType)conversationModelType fromview:(WooBaseViewController *)fromeview info:(RCDUserInfo *)info
{
    WOOConversationViewController *chat = [[WOOConversationViewController alloc] init];
    //设置会话的类型，如单聊、群聊、聊天室、客服、公众服务会话等
    chat.conversationType =conversationModelType;
    //设置会话的目标会话ID。（单聊、客服、公众服务会话为对方的ID，群聊、聊天室为会话的ID）
    chat.targetId = targetid;
    //设置聊天会话界面要显示的标题
    if (conversationModelType==ConversationType_PRIVATE) {
        RCDUserInfo *info=[[RCDataBaseManager shareInstance] getFriendInfo:targetid];
        chat.userinfo=info;
        chat.title = info.displayName;
        if (info) {
            chat.userinfo=info;
        }
    }
    else{
        RCDGroupInfo *group=[[RCDataBaseManager shareInstance] getGroupByGroupId:targetid];
        chat.title = group.groupName;
        chat.groupinfo=group;
    }
    //显示聊天会话界面
    [fromeview.navigationController pushViewController:chat animated:YES];
}
#pragma mark 创建群组
-(void)cgreatGroupwith:(NSMutableArray *)list fromview:(WooBaseViewController *)fromcontroller;
{
    NSMutableArray *titles=[[NSMutableArray alloc] init];
    NSMutableArray *uids=[[NSMutableArray alloc] init];
    [titles addObject:[UserDefaults objectForKey:@"name"]];
    for (RCDUserInfo *info in list) {
        [titles addObject:info.displayName];
        [uids addObject:info.userId];
    }
    [fromcontroller showWithStatus:@"群组创建中..."];
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
    [parametDic setObject:@"" forKey:@"brief"];
    [UserRequestToo shareInstance].rquesturl=CreatGroupandInvateRequrl;
    [UserRequestToo shareInstance].params=parametDic;
    [[UserRequestToo shareInstance] statrrequestgetwith:MHAsiNetWorkPOST successBlock:^(id returnData) {
        [fromcontroller dismiss];
        if (returnData[@"success"]) {
            if([returnData[@"status"] isEqualToString:@"200"]) {
                NSDictionary *dic=returnData[@"data"];
                [fromcontroller showSuccessWithStatus:@"群组创建成功"];
                [self gotoChatViewtargetid:dic[@"cid"] convertitle:dic[@"name"] conversationModelType:ConversationType_GROUP fromview:fromcontroller info:nil];
                [[NSNotificationCenter defaultCenter] postNotificationName:UPDATE_GROUP_FRIEND object:nil];
            }
        }
        else{
            [fromcontroller showSuccessWithStatus:returnData[@"message"]];
        }
    } failureBlock:^(NSError *error) {
        [fromcontroller dismiss];
        [fromcontroller showErrorWithStatus:@"群组创建失败"];
    }];
}
#pragma mark 邀请群成语
-(void)addsomegroup:(NSMutableArray *)list fromcontroller:(WooBaseViewController *)fromcontroller Groupid:(NSString *)Groupid
{
    [fromcontroller showWithStatus:@"数据处理中"];
    for (int i=0; i<list.count; i++) {
        RCDUserInfo *info =list[i];
        NSMutableDictionary *parametDic = [NSMutableDictionary dictionaryWithCapacity:9];
        [parametDic setObject:info.userId forKey:@"uids"];
        [parametDic setObject:Groupid forKey:@"crewId"];
        [UserRequestToo shareInstance].rquesturl=GroupInvateFriendsRequrl;
        [UserRequestToo shareInstance].params=parametDic;
        [[UserRequestToo shareInstance] statrrequestgetwith:MHAsiNetWorkPOST successBlock:^(id returnData) {
            if (i==list.count-1) {
                [fromcontroller dismiss];
            }
            if (returnData[@"success"]) {
                if([returnData[@"status"] isEqualToString:@"200"]) {
                    if (i==list.count-1) {
                    [fromcontroller showSuccessWithStatus:@"邀请成员成功"];
                    }
                }
            }
        else{
            [fromcontroller showSuccessWithStatus:returnData[@"message"]];
            }
        } failureBlock:^(NSError *error) {
            [fromcontroller dismiss];
            [fromcontroller showErrorWithStatus:@"邀请成员失败"];
        }];
    }
}
#pragma mark 申请好友
-(void)addfriend:(NSString *)fid frome:(WooBaseViewController *)frome
{
    [frome showWithStatus:@"数据处理中"];
    NSMutableDictionary *parametDic = [NSMutableDictionary dictionaryWithCapacity:9];
    [parametDic setObject:RCLOUD_ID forKey:@"mid"];
    [parametDic setObject:fid forKey:@"fid"];
    [parametDic setObject:@"好友请求" forKey:@"content"];
    [UserRequestToo shareInstance].rquesturl=invitefriendlistRequrl;
    [UserRequestToo shareInstance].params=parametDic;
    [[UserRequestToo shareInstance] statrrequestgetwith:MHAsiNetWorkPOST successBlock:^(id returnData) {
        [frome dismiss];
        if (returnData[@"success"]) {
            if([returnData[@"status"] isEqualToString:@"200"]) {
                [frome showSuccessWithStatus:@"好友申请发送成功"];
            }
        }
        else{
            [frome showSuccessWithStatus:returnData[@"message"]];
        }
    } failureBlock:^(NSError *error) {
        [frome dismiss];
        [frome showErrorWithStatus:@"好友申请发送失败"];
    }];
}
#pragma mark 申请加群
-(void)sendJionGroup:(NSString *)groupId frome:(WooBaseViewController *)frome
{
    [frome showWithStatus:@"数据处理中"];
    NSMutableDictionary *parametDic = [NSMutableDictionary dictionaryWithCapacity:9];
    [parametDic setObject:RCLOUD_ID forKey:@"userId"];
    [parametDic setObject:groupId forKey:@"crewId"];
    [parametDic setObject:@"我想加群" forKey:@"content"];
    [UserRequestToo shareInstance].rquesturl=SendJoinGroupRequrl;
    [UserRequestToo shareInstance].params=parametDic;
    [[UserRequestToo shareInstance] statrrequestgetwith:MHAsiNetWorkPOST successBlock:^(id returnData) {
        [frome dismiss];
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
                if (dic) {
                    groups.isCrewMember=YES;
                    [[NSNotificationCenter defaultCenter] postNotificationName:UPDATE_GROUP_FRIEND object:nil];
                }
                else{
                    groups.isCrewMember=NO;
                }
                if (dic)
                {
                    GroupsdetailViewController *pushview=[[GroupsdetailViewController alloc] init];
                    pushview.GroupInfo=groups;
                    [frome.navigationController pushViewController:pushview animated:YES];
                    return ;
                }
                else{
                  [frome showSuccessWithStatus:@"申请已发送"];
                    return;
                }
            }
            else if ([returnData[@"status"] isEqualToString:@"400"])
            {
                
            }
            else{
                [frome showSuccessWithStatus:returnData[@"message"]];
            }
        }
    } failureBlock:^(NSError *error) {
        [frome showErrorWithStatus:@"申请发送失败"];
        [frome dismiss];
    }];
    
}
-(void)getFriendRelationship:(NSString *)fid successBlock:(MHAsiSuccessBlock)successBlock
                failureBlock:(MHAsiFailureBlock)failureBlock
{
    NSMutableDictionary *parametDic = [NSMutableDictionary dictionaryWithCapacity:9];
    [parametDic setObject:RCLOUD_ID forKey:@"mid"];
    [parametDic setObject:fid forKey:@"fid"];
    [UserRequestToo shareInstance].rquesturl=getfriendRelationshipRequrl;
    [UserRequestToo shareInstance].params=parametDic;
    [[UserRequestToo shareInstance] statrrequestgetwith:MHAsiNetWorkGET successBlock:^(id returnData) {
        if (returnData[@"success"]) {
          if([returnData[@"status"] isEqualToString:@"200"]) {
              RCDUserInfo *userinfomodel=[[RCDUserInfo alloc] init];
              ContactdetailViewController *contact=[[ContactdetailViewController alloc] init];
              NSDictionary *dic=returnData[@"data"];
              userinfomodel.name=dic[@"name"];
              userinfomodel.userId=fid;
              userinfomodel.displayName=dic[@"nickname"];
              userinfomodel.signature=dic[@"brief"];
              userinfomodel.portraitUri=dic[@"photo"];
              userinfomodel.status=[NSString stringWithFormat:@"%@",dic[@"isFriend"]];
              userinfomodel.sex=[NSString stringWithFormat:@"%@",dic[@"sex"]];
              contact.userinfo=userinfomodel;
              if([returnData[@"status"] isEqualToString:@"200"])
              {
                  successBlock(userinfomodel);
              }
          }
          else{
              
          }
        }
    } failureBlock:^(NSError *error) {
        failureBlock(error);
    }];
}
//点赞
-(void)favorSomebody:(HomeModel *)model successBlock:(MHAsiSuccessBlock)successBlock
        failureBlock:(MHAsiFailureBlock)failureBlock
{
    NSMutableDictionary *parametDic = [NSMutableDictionary dictionaryWithCapacity:9];
    [parametDic setObject:RCLOUD_ID forKey:@"userId"];
    [parametDic setObject:model.graphicinfoModel.essayId forKey:@"likeEntity"];
    [parametDic setObject:[NSNumber numberWithInteger:model.graphicinfoModel.type] forKey:@"likeType"];
    [UserRequestToo shareInstance].rquesturl=TofraorUrl;
    [UserRequestToo shareInstance].params=parametDic;
    [[UserRequestToo shareInstance] statrrequestgetwith:MHAsiNetWorkGET successBlock:^(id returnData) {
        if (returnData[@"success"]) {
            if([returnData[@"status"] isEqualToString:@"200"])
            {
                
                successBlock(returnData);
            }
            else{
                
            }
        }
    } failureBlock:^(NSError *error) {
        failureBlock(error);
    }];
}
//踩
-(void)nounfavorSomebody:(HomeModel *)model successBlock:(MHAsiSuccessBlock)successBlock
            failureBlock:(MHAsiFailureBlock)failureBlock
{
    NSMutableDictionary *parametDic = [NSMutableDictionary dictionaryWithCapacity:9];
    [parametDic setObject:RCLOUD_ID forKey:@"userId"];
    [parametDic setObject:model.graphicinfoModel.essayId forKey:@"likeEntity"];
    [parametDic setObject:[NSNumber numberWithInteger:model.graphicinfoModel.type] forKey:@"likeType"];
    [UserRequestToo shareInstance].rquesturl=TonounfraorUrl;
    [UserRequestToo shareInstance].params=parametDic;
    [[UserRequestToo shareInstance] statrrequestgetwith:MHAsiNetWorkGET successBlock:^(id returnData) {
        if (returnData[@"success"]) {
            if([returnData[@"status"] isEqualToString:@"200"])
            {
                
                successBlock(returnData);
            }
            else{
                
            }
        }
    } failureBlock:^(NSError *error) {
        failureBlock(error);
    }];
}
//评论
-(void)commentSomebody:(HomeModel *)model content:(NSString *)content successBlock:(MHAsiSuccessBlock)successBlock
          failureBlock:(MHAsiFailureBlock)failureBlock
{
    NSMutableDictionary *parametDic = [NSMutableDictionary dictionaryWithCapacity:9];
    [parametDic setObject:RCLOUD_ID forKey:@"userId"];
    [parametDic setObject:model.graphicinfoModel.essayId forKey:@"commentEntity"];
    [parametDic setObject:[NSNumber numberWithInteger:model.graphicinfoModel.type] forKey:@"commentType"];
    [parametDic setObject:@"内容" forKey:@"content"];
    [UserRequestToo shareInstance].rquesturl=TocommetnUrl;
    [UserRequestToo shareInstance].params=parametDic;
    [[UserRequestToo shareInstance] statrrequestgetwith:MHAsiNetWorkGET successBlock:^(id returnData) {
        if (returnData[@"success"]) {
            if([returnData[@"status"] isEqualToString:@"200"])
            {
                
                successBlock(returnData);
            }
            else{
                
            }
        }
    } failureBlock:^(NSError *error) {
        failureBlock(error);
    }];
}
//收藏
-(void)CollectionSomebody:(HomeModel *)model successBlock:(MHAsiSuccessBlock)successBlock
             failureBlock:(MHAsiFailureBlock)failureBlock
{
    NSMutableDictionary *parametDic = [NSMutableDictionary dictionaryWithCapacity:9];
    [parametDic setObject:RCLOUD_ID forKey:@"userId"];
    [parametDic setObject:model.graphicinfoModel.essayId forKey:@"commentEntity"];
    [parametDic setObject:[NSNumber numberWithInteger:model.graphicinfoModel.type] forKey:@"commentType"];
    [parametDic setObject:@"内容" forKey:@"content"];
    [UserRequestToo shareInstance].rquesturl=getfriendRelationshipRequrl;
    [UserRequestToo shareInstance].params=parametDic;
    [[UserRequestToo shareInstance] statrrequestgetwith:MHAsiNetWorkGET successBlock:^(id returnData) {
        if (returnData[@"success"]) {
            if([returnData[@"status"] isEqualToString:@"200"])
            {
                
                successBlock(returnData);
            }
            else{
                
            }
        }
    } failureBlock:^(NSError *error) {
        failureBlock(error);
    }];
}
//获取专辑分类列表
-(void)getAlbumClasssuccessBlock:(MHAsiSuccessBlock)successBlock
                    failureBlock:(MHAsiFailureBlock)failureBlock
{
    [UserRequestToo shareInstance].rquesturl=deletefriendRelationshipRequrl;
    NSMutableDictionary *parametDic = [[NSMutableDictionary alloc] init];
    [parametDic setValue:RCLOUD_ID forKey:@"userId"];
    [UserRequestToo shareInstance].params=parametDic;
    [UserRequestToo shareInstance].rquesturl=getfindClassUrl;
    [[UserRequestToo shareInstance] statrrequestgetwith:MHAsiNetWorkGET successBlock:^(id returnData) {
        if (returnData[@"success"]) {
            if([returnData[@"status"] isEqualToString:@"200"]) {
                successBlock(returnData);
                return ;
            }
        }
        
    } failureBlock:^(NSError *error) {
    }];
}
@end
