//
//  CommentsView.h
//  Woo
//
//  Created by 王起锋 on 2018/10/14.
//  Copyright © 2018年 杭州蜂布式. All rights reserved.
//

#import "baseview.h"
typedef void (^closeMyselfB) (void);
NS_ASSUME_NONNULL_BEGIN

@interface CommentsView : baseview
@property(nonatomic,copy)closeMyselfB closepageBlock;
@end

NS_ASSUME_NONNULL_END
