//
//  BaseTableView.h
//  Woo
//
//  Created by 王起锋 on 2018/8/21.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableView : UITableView
// 无数据占位图点击的回调函数
@property (copy,nonatomic) void(^noContentViewTapedBlock)();

/**
 展示无数据占位图
 
 @param emptyViewType 无数据占位图的类型
 */
- (void)showEmptyViewWithType:(NSInteger)emptyViewType;

/* 移除无数据占位图 */
- (void)removeEmptyView;

@end
