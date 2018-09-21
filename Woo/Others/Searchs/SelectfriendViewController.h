//
//  SelectfriendViewController.h
//  Woo
//
//  Created by 王起锋 on 2018/8/15.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import "WooBaseViewController.h"
@protocol SelectfriendViewDelegate <NSObject>
- (void)SelectfriendCancelClick;
@end
@interface SelectfriendViewController : WooBaseViewController
@property(nonatomic, weak) id<SelectfriendViewDelegate> SearchViewDelegate;
@end
