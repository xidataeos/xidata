//
//  RedmessageModle.h
//  Woo
//
//  Created by 王起锋 on 2018/8/29.
//  Copyright © 2018年 杭州蜂布式. All rights reserved.
//

#import "baseobject.h"
@interface RedmessageModle : baseobject
@property(nonatomic,copy)NSString *fromId;
@property(nonatomic,copy)NSString *toId;
@property(nonatomic,copy)NSString *sendTransaction;
@property(nonatomic,copy)NSString *recvTransaction;
@property(nonatomic,copy)NSString *sendTime;
@property(nonatomic,copy)NSString *recvTime;
@property(nonatomic,assign)BOOL hasRecv;
@property(nonatomic,copy)NSString *asset;//总金额
@property(nonatomic,copy)NSString *tip;
@property(nonatomic,copy)NSString *photo;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *fromName;
@property(nonatomic,copy)NSString *fromPhoto;
@property(nonatomic,copy)NSString *toName;
@property(nonatomic,copy)NSString *toPhoto;
@property(nonatomic,copy)NSDictionary *redMultiDetail;
@property(nonatomic,copy)NSDictionary *redMultiRecv;
@property(nonatomic,copy)NSString *remain;//剩余个数
@property(nonatomic,copy)NSString *balance;//剩余金额
@property(nonatomic,copy)NSString *size;
@property(nonatomic,strong)NSMutableArray *list;
@end

