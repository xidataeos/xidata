//
//  GroupMember.h
//  Woo
//
//  Created by 王起锋 on 2018/8/20.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import "baseobject.h"
/*
 "cid":"63f0838f-e5f0-40cf-9a08-0115b521cdcc",
 "uid":"RCLOUD_ID",
 "name":"289a8-9de9-4edb-8",
 "valid":1,
 "shield":0,
 "photo":"http://www.rongcloud.cn/images/logo.png",
 "createTime":"2018-08-18T13:28:22.000+0000",
 "updateTime":null
 */
@interface GroupMemberInfo : baseobject
@property(nonatomic,copy)NSString *cid;//群组ID
@property(nonatomic,copy)NSString *uid;//用户ID
@property(nonatomic,copy)NSString *name;//群成员名字
@property(nonatomic,copy)NSString *photo;//群成员头像
@property(nonatomic,copy)NSString *createTime;//群组创建时间
@property(nonatomic,copy)NSString *updateTime;//群组更新时间
@property(nonatomic,assign)NSInteger valid;
@property(nonatomic,assign)NSInteger shield;//是否屏蔽群组
@end
