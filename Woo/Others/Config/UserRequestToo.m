
//
//  UserRequestToo.m
//  newLoan
//
//  Created by 王起锋 on 2018/6/20.
//  Copyright © 2018年 王起锋. All rights reserved.
//

#import "UserRequestToo.h"
static UserRequestToo *userRequestToo = nil;
@implementation UserRequestToo
+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        userRequestToo = [UserRequestToo new];
    });
    
    return userRequestToo;
}
-(void)statrrequestgetwith:(MHAsiNetWorkType)WorkType successBlock:(MHAsiSuccessBlock)successBlock
                      failureBlock:(MHAsiFailureBlock)failureBlock
{
    if (WorkType==MHAsiNetWorkGET) {
        [AfnetHttpsTool getRequstWithURL:self.rquesturl ResuestWorkType:WQAsiNetWorkJson params:self.params successBlock:^(id returnData) {
            if (successBlock) {
                successBlock(returnData);
            }
        } failureBlock:^(NSError *error) {
            if (failureBlock) {
                failureBlock(error);
            }
        }];
    }
    else{
        [AfnetHttpsTool postReqeustWithURL:self.rquesturl ResuestWorkType:WQAsiNetWorkJson params:self.params successBlock:^(id returnData) {
            if (successBlock) {
                successBlock(returnData);
            }
        } failureBlock:^(NSError *error) {
            if (failureBlock) {
                failureBlock(error);
            }
        }];
    }
    
}
@end
