//
//  WooDrawEggModel.h
//  Woo
//
//  Created by 风外杏林香 on 2018/9/15.
//  Copyright © 2018年 杭州蜂布式. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WooDrawEggModel : NSObject
@property (nonatomic, copy)NSString *ids;//id
@property (nonatomic, copy)NSString *meetingName;//会议名称
@property (nonatomic, copy)NSString *startTime;//开始时间
@property (nonatomic, copy)NSString *gameStartTime;//游戏开始时间
@property (nonatomic, copy)NSString *gameStopTime;//游戏结束时间
@property (nonatomic, copy)NSString *maxPrice;//最高价格
@property (nonatomic, copy)NSString *dealerGain;//商家获取 前面加一个百分号
@property (nonatomic, copy)NSString *userGain;//向前反还 前面加一个百分号
@property (nonatomic, copy)NSString *lastUserGain;//最后一位获取 前面加一个百分号
@property (nonatomic, copy)NSString *bonusCount;//奖池总数
@property (nonatomic, copy)NSString *gamePutCountNumber;//游戏投入总次数
@property (nonatomic, copy)NSString *gameCountNumber;   // 参与人数
@property (nonatomic, copy)NSString *useTime;//用时
@property (nonatomic, copy)NSString *myPutNumber;//我投了多少次
@property (nonatomic, copy)NSString *myPutEggCount;//投了多少彩蛋
@property (nonatomic, copy)NSString *name;//会议创建人的名称
@property (nonatomic, copy)NSString *myGainEgg;//我赚取的彩蛋


@end
