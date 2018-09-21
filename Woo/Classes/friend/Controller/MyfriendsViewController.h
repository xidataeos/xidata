//
//  MyfriendsViewController.h
//  Woo
//
//  Created by 王起锋 on 2018/8/10.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import "WooBaseViewController.h"

typedef enum {
    Single_chat = 1,//单聊
    Group_chat  //群聊
} chattype;

@interface MyfriendsViewController : WooBaseViewController
@property(nonatomic,assign)chattype chatype;
@end
