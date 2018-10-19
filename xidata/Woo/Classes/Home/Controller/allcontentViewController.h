//
//  MeetingissuedViewController.h
//  Woo
//
//  Created by 王起锋 on 2018/8/2.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import "WooBaseViewController.h"
typedef NS_ENUM(NSInteger, contentStyle) {
    /**
     * By default, there is a slider on the bottom.
     */
    contentStyleall = 0,
    /**
     * This flag will zoom the selected text label.
     */
    contentStylesingle   = 1,
};
@interface allcontentViewController : WooBaseViewController
@property(nonatomic,assign)contentStyle style;
@property(nonatomic,copy)NSString *classid;
@end
