//
//  EditorbeizhuViewController.h
//  Woo
//
//  Created by 王起锋 on 2018/8/7.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import "WooBaseViewController.h"
@protocol EditorbeizhuDelegate <NSObject>

@optional
//保存备注信息
-(void)savelabel:(NSString *)label;

@end
@interface EditorbeizhuViewController : WooBaseViewController
@property(nonatomic,strong)RCDUserInfo *usermodel;
@property(nonatomic,weak)id<EditorbeizhuDelegate> delegate;
@end
