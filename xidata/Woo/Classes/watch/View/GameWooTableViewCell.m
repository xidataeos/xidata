
//
//  GameWooTableViewCell.m
//  Woo
//
//  Created by 王起锋 on 2018/8/28.
//  Copyright © 2018年 杭州蜂布式. All rights reserved.
//

#import "GameWooTableViewCell.h"
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
        _timeLabel=[[UILabel alloc] initWithFrame:CGRectMake(15*KWidth_Scale, CGRectGetMaxY(self.titleLabel.frame)+3*KWidth_Scale, SCREEN_WIDTH-30*KWidth_Scale, 25*KWidth_Scale)];
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
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier style:(cellstyle)type index:(NSIndexPath*)index
{
    if (self==[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        if (type==detail_style) {
            [self creatdetialUI];
        }
        else{
            [self creatsinglelUIindex:index];
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
        fuzhilebel.frame=CGRectMake(col*(with)+15*KWidth_Scale+(col)*30*KWidth_Scale,CGRectGetMaxY(self.timeLabel.frame)+(height+1)*row+(row+1)*paing, with, height);
        fuzhilebel.font=UIFont(15);
        [self addSubview:fuzhilebel];
    }
}
-(void)creatsinglelUIindex:(NSIndexPath*)index
{
    [self addSubview:self.detailLabel];
    NSString *strlabel;
    if (index.section==1) {
       strlabel=@"玩彩蛋”游戏 分为组织者和参与者(彩蛋玩家)两种角色,组织者在游戏开始前负责为本轮游戏定价(个人彩蛋投入上限)，确定收益百分比和向前返还比。玩家根据当前彩蛋价格进行彩蛋投入，每轮游戏每位玩家可重复投入彩蛋。游戏以会议发布时间为开始时间，以会议结束时间为游戏结束时间。\n例如：\n本轮游戏组织者定价为1000个彩蛋，玩家向前返还比为35%，组织者收益60%，最后一位玩家收益5%。游戏开始后第一位玩家投入1个彩蛋。第二位玩家投入2个彩蛋，其中35%（0.7个彩蛋）返还给第一位玩家。第三位玩家投入4个彩蛋，其中35%(1.4个彩蛋)平均分给第一个位和第二位玩家。\n依此类推,当前玩家投入的彩蛋数量是上一位玩家投入数量的2倍。持平1000个彩蛋后，后续玩家的彩蛋投入量稳定在1000个彩蛋。玩家投入彩蛋数量的上限由组织者限定。当游戏结束时组织者获得所有参与者彩蛋总投入的60%(即奖池总数的60%)，而最后一位玩家可获得奖池总数的5%。";
    }
    else{
        strlabel=@"（1）“玩彩蛋”游戏是一种基于区块链技术，由智能合约控制全局流程的新兴游戏。\n（2）合约代码完全开源，开发团队不具有对智能合约的控制权限，合约代码无任何“后门”操作。\n（3）智能合约运行过程经过多轮严密内测和专业的安全审计，保证游戏的公平、公正、公开。\n（4）彩蛋投入过程采用更为快捷高效安全的钱包支付方式，由区块链技术保障交易的安全性和真实性。";
    }
    CGSize lablesize=[self getusetlabelsize:strlabel font:UIFont(15)];
    self.detailLabel.frame=CGRectMake(15*KWidth_Scale, 0, SCREEN_WIDTH-30*KWidth_Scale, lablesize.height);
    self.detailLabel.text=strlabel;
}
-(CGSize)getusetlabelsize:(NSString *)text font:(UIFont*)font
{
    return  [text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName] context:nil].size;
    
}
+ (CGFloat)getmyheight:(NSString *)introduction
{
    CGSize pricelabelsize=[introduction boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:UIFont(15) forKey:NSFontAttributeName] context:nil].size;;
    return pricelabelsize.height+15*KWidth_Scale;
}
-(void)setJsionmodel:(NSDictionary *)jsionmodel
{
    self.titleLabel.text=[NSString stringWithFormat:@"组织者: %@",jsionmodel[@"name"]];
    self.timeLabel.text=[NSString stringWithFormat:@"游戏时间: %@开始",jsionmodel[@"gameStartTime"]];
    NSString *pricetext=[NSString stringWithFormat:@"<font color='#333333'>组织者定价:</font><font color='#ff8170'>%@</font>",jsionmodel[@"maxPrice"]];
    self.priceLabel.attributedText=[PublicFunction attributedStringWithHTMLString:pricetext];
    self.priceLabel.font=UIFont(14);

    NSString *allgamers=[NSString stringWithFormat:@"<font color='#333333'>玩家总人数:</font><font color='#ff8170'>%@</font>",jsionmodel[@"gameCountNumber"]];
    self.playercountLabel.attributedText=[PublicFunction attributedStringWithHTMLString:allgamers];
    self.playercountLabel.font=UIFont(14);
    
    NSString *shouyi=[NSString stringWithFormat:@"<font color='#333333'>组织者收益:</font><font color='#ff8170'>%@%%</font>",jsionmodel[@"dealerGain"]];
    self.organizersprofitLabel.attributedText=[PublicFunction attributedStringWithHTMLString:shouyi];
    self.organizersprofitLabel.font=UIFont(14);
    
    NSString *alltouru=[NSString stringWithFormat:@"<font color='#333333'>玩家总次数:</font><font color='#ff8170'>%@</font>",jsionmodel[@"gamePutCountNumber"]];
    self.playerinputcount.attributedText=[PublicFunction attributedStringWithHTMLString:alltouru];
    self.playerinputcount.font=UIFont(14);
    
    NSString *fanhuanrate=[NSString stringWithFormat:@"<font color='#333333'>玩家向前返还比:</font><font color='#ff8170'>%@%%</font>",jsionmodel[@"userGain"]];
    self.playerinverse.attributedText=[PublicFunction attributedStringWithHTMLString:fanhuanrate];
    self.playerinverse.font=UIFont(14);
    
    NSString *myalltouru=[NSString stringWithFormat:@"<font color='#333333'>我的总投入:</font><font color='#ff8170'>%@</font>",jsionmodel[@"gameUserCountPutEgg"]];
    self.myallinverse.attributedText=[PublicFunction attributedStringWithHTMLString:myalltouru];
    self.myallinverse.font=UIFont(14);
    
    NSString *lastplayerlinve=[NSString stringWithFormat:@"<font color='#333333'>最后一位玩家收益:</font><font color='#ff8170'>%@%%</font>",jsionmodel[@"lastUserGain"]];
    self.lastplayerlinverse.attributedText=[PublicFunction attributedStringWithHTMLString:lastplayerlinve];
    self.lastplayerlinverse.font=UIFont(14);
    
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
