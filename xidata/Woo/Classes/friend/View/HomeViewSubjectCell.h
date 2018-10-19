//
//  HomeViewSubjectCell.h
//  newLoan
//
//  Created by 王起锋 on 2018/6/20.
//  Copyright © 2018年 王起锋. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface HomeViewSubjectCell : UICollectionViewCell
@property(nonatomic,strong)UILabel *titllabel;
@property(nonatomic,strong)UIImageView *imageview;
@property(nonatomic,copy)NSString *iconurl;
@property(nonatomic,strong)NSIndexPath *index;
@property(nonatomic,strong)UIImageView *watchimage;
@property(nonatomic,strong)HomeModel *model;
@property(nonatomic,strong)RCDGroupInfo *groupmodel;
@property(nonatomic,strong)UILabel *zhuanji;
@end
