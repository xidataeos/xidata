//
//  UserRequestToo.h
//  newLoan
//
//  Created by 王起锋 on 2018/6/20.
//  Copyright © 2018年 王起锋. All rights reserved.
//

#import "baseobject.h"

@interface UserRequestToo : baseobject
@property(nonatomic,strong)NSDictionary *params;
@property(nonatomic,copy)NSString *rquesturl;
+ (instancetype)shareInstance;
-(void)statrrequestgetwith:(MHAsiNetWorkType)WorkType successBlock:(MHAsiSuccessBlock)successBlock
              failureBlock:(MHAsiFailureBlock)failureBlock;
@end
