//
//  publicBotomoview.h
//  Woo
//
//  Created by 王起锋 on 2018/10/10.
//  Copyright © 2018年 杭州蜂布式. All rights reserved.
//

#import "baseview.h"

NS_ASSUME_NONNULL_BEGIN
typedef void (^Botomoviewblock) (NSInteger indexrow ,BOOL selected);
@interface publicBotomoview : baseview
@property(nonatomic,strong)UIView *botomo;
@property(nonatomic,strong)UIButton *favortButton;//点赞
@property(nonatomic,strong)UIButton *SteponButton;//踩
@property(nonatomic,strong)UIButton *commentButton;//评论
@property(nonatomic,strong)UIButton *collectionButton;//收藏
@property(nonatomic,strong)UILabel *favorLabel;//点赞数
@property(nonatomic,copy)Botomoviewblock selfBlock;
@end

NS_ASSUME_NONNULL_END
