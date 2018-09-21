//
//  Sharemangerview.h
//  Woo
//
//  Created by 王起锋 on 2018/8/6.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import "baseview.h"
typedef enum {
    sharType_friend = 1,   /**两个 */
    shar_type_watch       /** 四个*/
} sharType;

typedef void (^clickblock) (NSInteger indexrow);
@interface Sharemangerview : baseview
@property(nonatomic,copy)clickblock myblock;
@property(nonatomic,strong)UIButton *canlebtn;
@property(nonatomic,strong)UIView *botomoview;
@property(nonatomic,strong)UIView *topview;
-(instancetype)initWithFrame:(CGRect)frame withtype:(sharType)type;
-(void)shareviewShow;
-(void)canleclick;
@end
