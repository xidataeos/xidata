//
//  FootCollectionReusableView.h
//  Woo
//
//  Created by 王起锋 on 2018/10/8.
//  Copyright © 2018年 杭州蜂布式. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FootCollectionReusableView : UICollectionReusableView
@property(nonatomic,strong)NSMutableArray *datarr;
@property(nonatomic,strong)UILabel *tiptitle;
@property (nonatomic,assign) NSInteger index ;

@end

NS_ASSUME_NONNULL_END
