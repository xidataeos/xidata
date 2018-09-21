//
//  Watchobject.h
//  Woo
//
//  Created by 王起锋 on 2018/8/13.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//
#import "baseobject.h"
#import "Watchuserobject.h"
/*
 id = 1;
 img = "https://cdn.8btc.com/wp-content/uploads/2018/08/201808200739173441.png";
 intro = "\U8fd9\U662f\U4e00\U4e2a\U4fdd\U5b88\U7684\U6a21\U578b\Uff0c\U5efa\U7acb\U5728\U7b80\U5355\U5047\U8bbe\U7684\U57fa\U7840\U4e0a\Uff0c\U7531\U5b9e\U9645\U8c03\U67e5\U6570\U636e\U652f\U6301\U3002
 \n\U56de\U5230\U9c8d\U52c3\U8fea\U4f26\U3002\U201c\U65f6\U4ee3\U5728\U53d8\U3002";
 title = "1\U4ebf\U6f5c\U5728\U6295\U8d44\U8005\U6574\U88c5\U5f85\U53d1\Uff0c\U52a0\U5bc6\U5e02\U573a\U7ec8\U7a76\U6563\U6237\U4e3a\U738b";
 type = 1;
 userId = 002101;
 userName = "\U91d1\U8272\U8d22\U7ecf";
 },

 */
@interface Watchobject : baseobject
@property(nonatomic,assign)NSInteger type;
@property(nonatomic,assign)NSInteger nId;
@property(nonatomic,copy)NSString *img;
@property(nonatomic,copy)NSString *intro;
@property(nonatomic,copy)NSString *mainBody;
@property(nonatomic,copy)NSString *readNum;
@property(nonatomic,copy)NSString *createTime;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *userId;
@property(nonatomic,copy)NSString *userName;
@end
