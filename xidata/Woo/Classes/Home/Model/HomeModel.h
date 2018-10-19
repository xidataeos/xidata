//
//  HomeModel.h
//  Woo
//
//  Created by 王起锋 on 2018/10/16.
//  Copyright © 2018年 杭州蜂布式. All rights reserved.
//

#import "baseobject.h"
NS_ASSUME_NONNULL_BEGIN
@class AlbuminfoModel;
@class GraphicinfoModel;
@interface HomeModel : baseobject
@property (nonatomic, copy)NSString *img;
@property (nonatomic, copy)NSString *alid;
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *title;
@property (nonatomic, assign)NSInteger pageView;
@property (nonatomic, copy)NSString *intro;
@property (nonatomic, copy)NSString *createDate;
@property (nonatomic, copy)NSString *mStoptime;
@property (nonatomic, copy)NSString *parentId;
@property (nonatomic, copy)NSString *classifyId;//恋爱 婚姻等
@property (nonatomic, copy)NSString *userId;//创建者的ID
@property (nonatomic, strong)AlbuminfoModel *albuminfoModel;
@property (nonatomic, strong)GraphicinfoModel *graphicinfoModel;
@end
//专辑详情
@interface AlbuminfoModel : baseobject
@property (nonatomic, copy)NSString *alid;
@property (nonatomic, copy)NSString *classifyId;
@property (nonatomic, copy)NSString *commentNum;
@property (nonatomic, copy)NSString *createDate;
@property (nonatomic, copy)NSString *createUserId;
@property (nonatomic, assign)NSInteger pageView;
@property (nonatomic, copy)NSString *delFlag;
@property (nonatomic, copy)NSString *img;
@property (nonatomic, copy)NSString *intro;
@property (nonatomic, copy)NSString *likeNum;
@property (nonatomic, copy)NSString *price;
@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *updateDate;
@property (nonatomic, copy)NSString *updateUserId;
@property (nonatomic, copy)NSString *userId;
@property (nonatomic, copy)NSString *userName;
@property (nonatomic, copy)NSString *userPhoto;
@property (nonatomic, assign)NSInteger proNum;
@property (nonatomic, assign)NSInteger subsNum;
@property (nonatomic, assign)NSInteger subsState;
@end

//图文或者音频详情
@interface GraphicinfoModel : baseobject
@property (nonatomic, copy)NSString *essayId;
@property (nonatomic, copy)NSString *albumId;
@property (nonatomic, assign)NSInteger commentNum;
@property (nonatomic, copy)NSString *author;//确权人的名字
@property (nonatomic, copy)NSString *createDate;
@property (nonatomic, copy)NSString *albumImg;
@property (nonatomic, copy)NSString *intro;
@property (nonatomic, assign)NSInteger likeNum;
@property (nonatomic, copy)NSString *price;
@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *albumTitle;
@property (nonatomic, copy)NSString *updateDate;
@property (nonatomic, copy)NSString *updateUserId;
@property (nonatomic, copy)NSString *descr;
@property (nonatomic, assign)BOOL enshrineState;
@property (nonatomic, assign)BOOL subsState;
@property (nonatomic, copy)NSString *text;
@property (nonatomic, copy)NSString *userPhoto;
@property (nonatomic, copy)NSString *userName;
@property (nonatomic, assign)NSInteger albumSubsNum;
@property (nonatomic, assign)NSInteger type;
@property(nonatomic,strong)NSMutableArray *comments;
@end

NS_ASSUME_NONNULL_END
