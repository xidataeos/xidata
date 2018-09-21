//
//  GameWooTableViewCell.h
//  Woo
//
//  Created by 王起锋 on 2018/8/28.
//  Copyright © 2018年 杭州蜂布式. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    detail_style = 1,   /**详情cell */
    single_style       /** 默认的*/
} cellstyle;
@interface GameWooTableViewCell : UITableViewCell
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *detailLabel;
@property(nonatomic,strong)UILabel *timeLabel;
@property(nonatomic,strong)UILabel *priceLabel;//组织者定价
@property(nonatomic,strong)UILabel *playercountLabel;//玩家总投入
@property(nonatomic,strong)UILabel *organizersprofitLabel;//组织者收益
@property(nonatomic,strong)UILabel *playerinputcount;//玩家投入总次数
@property(nonatomic,strong)UILabel *playerinverse;//玩家向前反比
@property(nonatomic,strong)UILabel *myallinverse;//我的总投入
@property(nonatomic,strong)UILabel *lastplayerlinverse;//最后一位玩家收益
@property(nonatomic,strong)NSMutableArray *labelarr;
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier style:(cellstyle)type;
+ (CGFloat)getmyheight:(NSString *)introduction;
@end
