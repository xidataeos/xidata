//
//  SelectContactViewController.h
//  Woo
//
//  Created by 王起锋 on 2018/8/8.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import "WooBaseViewController.h"
@protocol SelectContactViewDelegate <NSObject>
- (void)sendThecontacts:(NSMutableArray *)selectedcontacts;
@end
@interface SelectContactViewController : WooBaseViewController
@property(nonatomic,assign)CreatGroupType type;
@property(nonatomic,copy)NSString *Grouptitle;
@property(nonatomic,copy)NSString *Groupjianjie;
@property(nonatomic, weak) id<SelectContactViewDelegate> delegate;
@end
