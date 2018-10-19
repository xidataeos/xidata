//
//  cusetselectview.h
//  Woo
//
//  Created by 王起锋 on 2018/10/8.
//  Copyright © 2018年 杭州蜂布式. All rights reserved.
//

#import "baseview.h"

NS_ASSUME_NONNULL_BEGIN

@interface cusetselectview : baseview
{
    NSMutableArray *selecteddata;
}
@property(nonatomic,assign)NSInteger myselectindex;
@property(nonatomic,copy)publicclickblock myblock;
-(instancetype)initWithFrame:(CGRect)frame withdata:(NSMutableArray *)data;
@end

NS_ASSUME_NONNULL_END
