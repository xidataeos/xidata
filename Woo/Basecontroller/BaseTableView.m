
//
//  BaseTableView.m
//  Woo
//
//  Created by 王起锋 on 2018/8/21.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import "BaseTableView.h"
#import "NoContentView.h"
@interface BaseTableView (){
    NoContentView *_noContentView;
}
@end
@implementation BaseTableView

/**
 展示无数据占位图
 
 @param emptyViewType 无数据占位图的类型
 */
- (void)showEmptyViewWithType:(NSInteger)emptyViewType{
    
    // 如果已经展示无数据占位图，先移除
    if (_noContentView) {
        [_noContentView removeFromSuperview];
        _noContentView = nil;
    }
    
    //------- 再创建 -------//
    _noContentView = [[NoContentView alloc]initWithFrame:CGRectMake(0,SCREEN_HEIGHT/2.0-130*KWidth_Scale, SCREEN_WIDTH, SCREEN_HEIGHT-100*KWidth_Scale)];
    [self addSubview:_noContentView];
    _noContentView.type = emptyViewType;
    
    //------- 添加单击手势 -------//
    [_noContentView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(noContentViewDidTaped:)]];
}

/* 移除无数据占位图 */
- (void)removeEmptyView{
    [_noContentView removeFromSuperview];
    _noContentView = nil;
}

// 无数据占位图点击
- (void)noContentViewDidTaped:(NoContentView *)noContentView{
    if (self.noContentViewTapedBlock)
    {
        self.noContentViewTapedBlock(); // 调用回调函数
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
