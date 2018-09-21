//
//  Showerwimaview.h
//  Woo
//
//  Created by 王起锋 on 2018/8/8.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import "baseview.h"
#import "RCDGroupInfo.h"
@interface Showerwimaview : baseview
@property(nonatomic,strong)UIImageView *userimageview;
@property(nonatomic,strong)RCDGroupInfo *groupinfo;
@property(nonatomic,strong)UILabel *namelabel;
@property(nonatomic,strong)UIImageView *erweimaimageview;
@property(nonatomic,strong)UIButton *canlBtn;
@property(nonatomic,strong)UIView *bottomview;
-(void)customeviewShow;
-(instancetype)initWithFrame:(CGRect)frame groupInfo:(RCDGroupInfo *)groupInfo;
@end
