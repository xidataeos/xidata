//
//  CreatealbumController.h
//  Woo
//
//  Created by 王起锋 on 2018/10/12.
//  Copyright © 2018年 杭州蜂布式. All rights reserved.
//

#import "WooBaseViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface CreatealbumController : WooBaseViewController
-(instancetype)initwitdata:(NSMutableArray *)list type:(UpdataType)type;
@property(nonatomic,strong)NSMutableArray *contentList;
@property(nonatomic,copy)NSString *albumTitle;
@property(nonatomic,copy)NSString *audioFilstr;
@property(nonatomic,assign)UpdataType selfType;
@end

NS_ASSUME_NONNULL_END
