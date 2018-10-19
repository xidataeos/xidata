//
//  WooJoinEggModel.h
//  Woo
//
//  Created by 风外杏林香 on 2018/9/15.
//  Copyright © 2018年 杭州蜂布式. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WooJoinEggModel : NSObject
@property (nonatomic, copy)NSString *mId;//会议ID
@property (nonatomic, copy)NSString *meetingName;//会议名称
@property (nonatomic, copy)NSString *startTime;//会议开始时间
@property (nonatomic, copy)NSString *countPutEgg;//个人投入的总彩蛋
@end
