//
//  WooEggDetailView.m
//  Woo
//
//  Created by 风外杏林香 on 2018/9/7.
//  Copyright © 2018年 杭州蜂布式. All rights reserved.
//

#import "WooEggDetailView.h"
#import "WooDrawEggModel.h"
@implementation WooEggDetailView

- (instancetype)initWithFrame:(CGRect)frame model:(WooDrawEggModel *)model
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initWithUI:model];
    }
    return self;
}

- (void)initWithUI:(WooDrawEggModel *)model
{
    ZKLog(@"model -- %@", model.startTime);
//    self.backgroundColor = [UIColor redColor];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(10, 0, ScreenWidth - 20, 0.5)];
    line.backgroundColor = RGB(235, 235, 235);
    [self addSubview:line];
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(20, 2, ScreenWidth - 40, 20)];
    label1.text = [NSString stringWithFormat:@"组织者：%@", model.name];
    label1.textAlignment = NSTextAlignmentLeft;
    label1.font = UIFont(14);
    [self addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(label1.frame), ScreenWidth - 40, 20)];
    label2.text = [NSString stringWithFormat:@"游戏时间：%@-%@", model.gameStartTime, model.gameStopTime];
    label2.textAlignment = NSTextAlignmentLeft;
    label2.adjustsFontSizeToFitWidth = YES;
    label2.font = UIFont(14);
    [self addSubview:label2];
    
    CGFloat width = (ScreenWidth - 40) / 2;
    UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(label2.frame), width, 20)];
    label3.text = [NSString stringWithFormat:@"组织者定价：%@", model.maxPrice];
    label3.textAlignment = NSTextAlignmentLeft;
    label3.font = UIFont(14);
    label3.adjustsFontSizeToFitWidth = YES;
    NSMutableAttributedString *attributedStr1 = [[NSMutableAttributedString alloc] initWithString:label3.text];
    [attributedStr1 addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:RGB(255, 101, 0)} range:[label3.text rangeOfString:model.maxPrice]];
    label3.attributedText = attributedStr1;
    [self addSubview:label3];
    
    UILabel *label4 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label3.frame), CGRectGetMinY(label3.frame), width, 20)];
    label4.text = [NSString stringWithFormat:@"玩家总人数：%@", model.gameCountNumber];
    label4.textAlignment = NSTextAlignmentLeft;
    label4.font = UIFont(14);
    label4.adjustsFontSizeToFitWidth = YES;
    NSMutableAttributedString *attributedStr2 = [[NSMutableAttributedString alloc] initWithString:label4.text];
    [attributedStr2 addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:RGB(255, 101, 0)} range:[label4.text rangeOfString:model.gameCountNumber]];
    label4.attributedText = attributedStr2;
    [self addSubview:label4];
    
    UILabel *label5 = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(label3.frame), width, 20)];
    label5.text = [NSString stringWithFormat:@"组织者收益：%@%%", model.dealerGain];
    label5.textAlignment = NSTextAlignmentLeft;
    label5.font = UIFont(14);
    label5.adjustsFontSizeToFitWidth = YES;
    NSMutableAttributedString *attributedStr3 = [[NSMutableAttributedString alloc] initWithString:label5.text];
    [attributedStr3 addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:RGB(255, 101, 0)} range:[label5.text rangeOfString:[NSString stringWithFormat:@"%@%%", model.dealerGain]]];
    label5.attributedText = attributedStr3;
    [self addSubview:label5];
    
    UILabel *label6 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label5.frame), CGRectGetMinY(label5.frame), width, 20)];
    label6.text = [NSString stringWithFormat:@"玩家投入总次数：%@", model.gamePutCountNumber];
    label6.textAlignment = NSTextAlignmentLeft;
    label6.font = UIFont(14);
    label6.adjustsFontSizeToFitWidth = YES;
    NSMutableAttributedString *attributedStr4 = [[NSMutableAttributedString alloc] initWithString:label6.text];
    [attributedStr4 addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:RGB(255, 101, 0)} range:[label6.text rangeOfString:[NSString stringWithFormat:@"%@", model.gamePutCountNumber]]];
    label6.attributedText = attributedStr4;
    [self addSubview:label6];
    
    UILabel *label7 = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(label6.frame), width, 20)];
    label7.text = [NSString stringWithFormat:@"玩家向前返还比：%@%%", model.userGain];
    label7.textAlignment = NSTextAlignmentLeft;
    label7.font = UIFont(14);
    label7.adjustsFontSizeToFitWidth = YES;
    NSMutableAttributedString *attributedStr5 = [[NSMutableAttributedString alloc] initWithString:label7.text];
    [attributedStr5 addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:RGB(255, 101, 0)} range:[label7.text rangeOfString:[NSString stringWithFormat:@"%@%%", model.userGain]]];
    label7.attributedText = attributedStr5;
    [self addSubview:label7];
    
    UILabel *label8 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label7.frame), CGRectGetMinY(label7.frame), width, 20)];
    label8.text = [NSString stringWithFormat:@"我的投入次数：%@", model.myPutNumber];
    label8.textAlignment = NSTextAlignmentLeft;
    label8.font = UIFont(14);
    label8.adjustsFontSizeToFitWidth = YES;
    NSMutableAttributedString *attributedStr6 = [[NSMutableAttributedString alloc] initWithString:label8.text];
    [attributedStr6 addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:RGB(255, 101, 0)} range:[label8.text rangeOfString:[NSString stringWithFormat:@"%@", model.myPutNumber]]];
    label8.attributedText = attributedStr6;
    [self addSubview:label8];
    
    UILabel *label9 = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(label8.frame), width, 20)];
    label9.text = [NSString stringWithFormat:@"最后一位玩家收益：%@%%", model.lastUserGain];
    label9.textAlignment = NSTextAlignmentLeft;
    label9.font = UIFont(14);
    label9.adjustsFontSizeToFitWidth = YES;
    NSMutableAttributedString *attributedStr7 = [[NSMutableAttributedString alloc] initWithString:label9.text];
    [attributedStr7 addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:RGB(255, 101, 0)} range:[label9.text rangeOfString:[NSString stringWithFormat:@"%@%%", model.lastUserGain]]];
    label9.attributedText = attributedStr7;
    [self addSubview:label9];
    
    UILabel *label10 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label9.frame), CGRectGetMinY(label9.frame), width, 20)];
    label10.text = [NSString stringWithFormat:@"我的总投入：%@", model.myPutEggCount];
    label10.textAlignment = NSTextAlignmentLeft;
    label10.font = UIFont(14);
    label10.adjustsFontSizeToFitWidth = YES;
    NSMutableAttributedString *attributedStr8 = [[NSMutableAttributedString alloc] initWithString:label10.text];
    [attributedStr8 addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:RGB(255, 101, 0)} range:[label10.text rangeOfString:[NSString stringWithFormat:@"%@", model.myPutEggCount]]];
    label10.attributedText = attributedStr8;
    [self addSubview:label10];
    
    UILabel *label11 = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(label10.frame), width, 20)];
    label11.text = [NSString stringWithFormat:@"本轮用时：%@", model.useTime];
    label11.textAlignment = NSTextAlignmentLeft;
    label11.font = UIFont(14);
    label11.adjustsFontSizeToFitWidth = YES;
    NSMutableAttributedString *attributedStr9 = [[NSMutableAttributedString alloc] initWithString:label11.text];
    [attributedStr9 addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:RGB(255, 101, 0)} range:[label11.text rangeOfString:[NSString stringWithFormat:@"%@", model.useTime]]];
    label11.attributedText = attributedStr9;
    [self addSubview:label11];
    
    UILabel *label12 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label11.frame), CGRectGetMinY(label11.frame), width, 20)];
    label12.text = [NSString stringWithFormat:@"获得奖励：%@", model.myGainEgg];
    label12.textAlignment = NSTextAlignmentLeft;
    label12.font = UIFont(14);
    label12.adjustsFontSizeToFitWidth = YES;
    NSMutableAttributedString *attributedStr10 = [[NSMutableAttributedString alloc] initWithString:label12.text];
    [attributedStr10 addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:RGB(255, 101, 0)} range:[label12.text rangeOfString:[NSString stringWithFormat:@"%@", model.myGainEgg]]];
    label12.attributedText = attributedStr10;
    [self addSubview:label12];
    
    UILabel *label13 = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(label12.frame), width, 20)];
    label13.text = [NSString stringWithFormat:@"奖池总数：%@", model.bonusCount];
    label13.textAlignment = NSTextAlignmentLeft;
    label13.font = UIFont(14);
    label13.adjustsFontSizeToFitWidth = YES;
    NSMutableAttributedString *attributedStr11 = [[NSMutableAttributedString alloc] initWithString:label13.text];
    [attributedStr11 addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:RGB(255, 101, 0)} range:[label13.text rangeOfString:[NSString stringWithFormat:@"%@", model.bonusCount]]];
    label13.attributedText = attributedStr11;
    [self addSubview:label13];
    
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
