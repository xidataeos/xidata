//
//  NFUserEntity.h
//  newLoan
//
//  Created by 王起锋 on 2018/6/20.
//  Copyright © 2018年 王起锋. All rights reserved.
//

#import "baseobject.h"

@interface NFUserEntity : baseobject
@property (nonatomic, strong) NSString *sex;
@property (nonatomic, strong) NSString *age;
@property (nonatomic, strong) NSString *nation;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *organ;
@property (nonatomic, strong) NSString *deadline;
+ (instancetype)shareInstance;
//清空当前用户数据
- (void)clearUserData;
@end
