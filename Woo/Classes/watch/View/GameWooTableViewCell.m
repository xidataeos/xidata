
//
//  GameWooTableViewCell.m
//  Woo
//
//  Created by 王起锋 on 2018/8/28.
//  Copyright © 2018年 杭州蜂布式. All rights reserved.
//

#import "GameWooTableViewCell.h"
/*
 @property(nonatomic,strong)UILabel *titleLabel;
 @property(nonatomic,strong)UILabel *timeLabel;
 @property(nonatomic,strong)UILabel *priceLabel;//组织者定价
 @property(nonatomic,strong)UILabel *playercountLabel;//玩家总投入
 @property(nonatomic,strong)UILabel *organizersprofitLabel;//组织者收益
 @property(nonatomic,strong)UILabel *playerinputcount;//玩家投入总次数
 @property(nonatomic,strong)UILabel *playerinverse;//玩家向前反比
 @property(nonatomic,strong)UILabel *myallinverse;//我的总投入
 @property(nonatomic,strong)UILabel *lastplayerlinverse;//最后一位玩家收益
 */
@implementation GameWooTableViewCell
-(NSMutableArray *)labelarr
{
    if (_labelarr==nil) {
        self.priceLabel=[[UILabel alloc] init];
        self.playercountLabel=[[UILabel alloc] init];
        self.organizersprofitLabel=[[UILabel alloc] init];
        self.playerinputcount=[[UILabel alloc] init];
        self.playerinverse=[[UILabel alloc] init];
        self.myallinverse=[[UILabel alloc] init];
        self.lastplayerlinverse=[[UILabel alloc] init];
        _labelarr=[[NSMutableArray alloc] initWithObjects:self.priceLabel,self.playercountLabel,self.organizersprofitLabel,self.playerinputcount,self.playerinverse,self.myallinverse,self.lastplayerlinverse, nil];
    }
    return _labelarr;
}
-(UILabel *)titleLabel
{
    if (_titleLabel==nil) {
        _titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(15*KWidth_Scale, 5*KWidth_Scale, SCREEN_WIDTH-30*KWidth_Scale, 20*KWidth_Scale)];
        _titleLabel.textColor=WordsofcolorColor;
        _titleLabel.font=UIFont(15);
        _titleLabel.text=@"杭州蜂布式";
    }
    return _titleLabel;
}
-(UILabel *)timeLabel
{
    if (_timeLabel==nil) {
        _timeLabel=[[UILabel alloc] initWithFrame:CGRectMake(15*KWidth_Scale, CGRectGetMaxY(self.titleLabel.frame), SCREEN_WIDTH-30*KWidth_Scale, 25*KWidth_Scale)];
        _timeLabel.textColor=WordsofcolorColor;
        _timeLabel.font=UIFont(14);
        _timeLabel.text=@"游戏时间: 2018.09.08";
    }
    return _timeLabel;
}
-(UILabel *)detailLabel{
    if (_detailLabel==nil) {
        _detailLabel=[[UILabel alloc] initWithFrame:CGRectMake(15*KWidth_Scale,15*KWidth_Scale , SCREEN_WIDTH-30*KWidth_Scale, self.frame.size.height-15*KWidth_Scale)];
        _detailLabel.textColor=RGB(102, 102, 102);
        _detailLabel.font=UIFont(15);
        _detailLabel.text=@" 2018.09.08";
        _detailLabel.numberOfLines=0;
    }
    return _detailLabel;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier style:(cellstyle)type
{
    if (self==[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        if (type==detail_style) {
            [self creatdetialUI];
        }
        else{
            [self creatsinglelUI];
        }
    }
    return self;
}
-(void)creatdetialUI
{
    [self addSubview:self.titleLabel];
    [self addSubview:self.timeLabel];
    CGFloat with=(SCREEN_WIDTH-15*KWidth_Scale*4)/2.0;
    CGFloat height=25*KWidth_Scale;
    CGFloat paing=5*KWidth_Scale;
    for (int i=0; i<self.labelarr.count; i++) {
        int row = i/2;
        int col = i%2;
        UILabel *fuzhilebel=self.labelarr[i];
        fuzhilebel=[[UILabel alloc] initWithFrame:CGRectMake(col*(with)+15*KWidth_Scale+(col)*30*KWidth_Scale,CGRectGetMaxY(self.timeLabel.frame)+(height+1)*row+(row+1)*paing, with, height)];
        fuzhilebel.font=UIFont(15);
        fuzhilebel.text=@"组织者定价 :1000";
        [self addSubview:fuzhilebel];
    }
}
-(void)creatsinglelUI
{
    [self addSubview:self.detailLabel];
    CGSize lablesize=[self getusetlabelsize:@"得到彩蛋的那天，林觉的人生发生了翻天覆地的变化。噩梦一样的夜晚，整个校园的活人都变成了丧尸，除了拿到彩蛋的13个人。 不是因为生化病毒，而是一个残忍的游戏。 无法离开学校，却能在广场得到活下去的筹码。 黑暗中蠢蠢欲动的猎食者并不是最恐怖的对手，隐匿在幸存者中的“犹大”才是致命的危机。 活人一个个死去，幸存者挣扎着等待黎明。 [1]第二部简介：那是一场噩梦——被封闭的大学校园，得到彩蛋的13个人被困在这里，为了生存到次日黎明而挣扎。隐藏在玩家里的犹大，岌岌可危的信任，无处不在的敌人，心怀叵测的同伴，让这个夜晚危险而漫长。林觉醒来身上没有任何伤口，躺在寝室的床上，前一晚的一切都如同一场梦。但是，莉莉丝依旧在派发着她的彩蛋，而宋寒章和陆刃则早已站在那里。第二轮游戏即将开始。" font:UIFont(15)];
    self.detailLabel.frame=CGRectMake(15*KWidth_Scale, 0, SCREEN_WIDTH-30*KWidth_Scale, lablesize.height);
    self.detailLabel.text=@"得到彩蛋的那天，林觉的人生发生了翻天覆地的变化。噩梦一样的夜晚，整个校园的活人都变成了丧尸，除了拿到彩蛋的13个人。 不是因为生化病毒，而是一个残忍的游戏。 无法离开学校，却能在广场得到活下去的筹码。 黑暗中蠢蠢欲动的猎食者并不是最恐怖的对手，隐匿在幸存者中的“犹大”才是致命的危机。 活人一个个死去，幸存者挣扎着等待黎明。 [1]第二部简介：那是一场噩梦——被封闭的大学校园，得到彩蛋的13个人被困在这里，为了生存到次日黎明而挣扎。隐藏在玩家里的犹大，岌岌可危的信任，无处不在的敌人，心怀叵测的同伴，让这个夜晚危险而漫长。林觉醒来身上没有任何伤口，躺在寝室的床上，前一晚的一切都如同一场梦。但是，莉莉丝依旧在派发着她的彩蛋，而宋寒章和陆刃则早已站在那里。第二轮游戏即将开始。";
}
-(CGSize)getusetlabelsize:(NSString *)text font:(UIFont*)font
{
    return  [text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName] context:nil].size;
    
}
+ (CGFloat)getmyheight:(NSString *)introduction
{
    CGSize pricelabelsize=[introduction boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:UIFont(15) forKey:NSFontAttributeName] context:nil].size;;
    return pricelabelsize.height+30*KWidth_Scale;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
