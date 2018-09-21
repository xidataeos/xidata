//
//  Gropudetailheadview.h
//  Woo
//
//  Created by 王起锋 on 2018/8/7.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import "baseview.h"

@interface Gropudetailheadview : baseview
@property(nonatomic,strong)UIImageView *userimage;
@property(nonatomic,strong)UILabel *namelabel;
@property(nonatomic,strong)UILabel *groupusercount;
@property(nonatomic,strong)UILabel *jianjie;
@property(nonatomic,strong)UILabel *Introduction;
@property(nonatomic,strong)RCDGroupInfo *groupmodel;
+(CGFloat)getmyheight:(NSString *)introduction;
-(instancetype)initWithFrame:(CGRect)frame withgroupmodel:(RCDGroupInfo *)groupmodel;
@end
