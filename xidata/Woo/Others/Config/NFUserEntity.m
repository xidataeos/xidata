
//
//  NFUserEntity.m
//  newLoan
//
//  Created by 王起锋 on 2018/6/20.
//  Copyright © 2018年 王起锋. All rights reserved.
//

#import "NFUserEntity.h"
static NFUserEntity *userEntity = nil;
@implementation NFUserEntity
/*!
 @function
 @abstract      用户对象的实体单例
 
 @note          该对象中的对象属性不可被多线程共享访问修改
 
 @result        返回用户的单例对象
 */
+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        userEntity = [NFUserEntity new];
        
    });
    
    return userEntity;
}
- (void)clearUserData{
    self.sex = nil;
    self.age = nil;
    self.nation = nil;
    self.date = nil;
    self.address = nil;
    self.organ = nil;
    self.deadline = nil;
}
@end
