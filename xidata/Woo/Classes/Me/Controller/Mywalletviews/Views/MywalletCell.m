//
//  MywalletCell.m
//  Woo
//
//  Created by 王起锋 on 2018/10/11.
//  Copyright © 2018年 杭州蜂布式. All rights reserved.
//

#import "MywalletCell.h"

@implementation MywalletCell
-(UIImageView *)cellimage
{
    if (_cellimage==nil) {
        _cellimage=[[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-70*KWidth_Scale,12.5*KWidth_Scale, 25, 25*KWidth_Scale)];
        _cellimage.image=[UIImage imageNamed:@"zhankai_Image"];
    }
    return _cellimage;
}
-(UILabel *)titllabel
{
    if (_titllabel==nil) {
        _titllabel=[[UILabel alloc] initWithFrame:CGRectMake(15*KWidth_Scale, 0, SCREEN_WIDTH, 50*KWidth_Scale)];
        _titllabel.font=UIFont(15);
        _titllabel.textColor=WordsofcolorColor;
        _titllabel.numberOfLines=0;
    }
    return _titllabel;
}
-(UIButton *)WithdrawalBtn
{
    if (_WithdrawalBtn==nil) {
        _WithdrawalBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _WithdrawalBtn.frame=CGRectMake(SCREEN_WIDTH-30*KWidth_Scale-60*KWidth_Scale,0, 55*KWidth_Scale, 120*KWidth_Scale);
        [_WithdrawalBtn setTitle:@"提现" forState:UIControlStateNormal];
        [_WithdrawalBtn.titleLabel setFont:UIFont(15)];
        [_WithdrawalBtn setTitleColor:[PublicFunction colorWithHexString:@"#F06D6D"] forState:UIControlStateNormal];
        [_WithdrawalBtn addTarget:self action:@selector(Withdrawal:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _WithdrawalBtn;
}
-(void)Withdrawal:(UIButton *)btn
{
    if (self.WithdrawalBlock) {
        self.WithdrawalBlock();
    }
}
-(UILabel *)Monthlyincome
{
    if (_Monthlyincome==nil) {
        _Monthlyincome=[[UILabel alloc] initWithFrame:CGRectMake(0, 30*KWidth_Scale, 140*KWidth_Scale, 20*KWidth_Scale)];
        _Monthlyincome.textColor=WordsofcolorColor;
        _Monthlyincome.font=UIFont(18);
        _Monthlyincome.text=@"365.0";
        _Monthlyincome.userInteractionEnabled=YES;
        _Monthlyincome.textAlignment=NSTextAlignmentCenter;
    }
    return _Monthlyincome;
}
-(UILabel *)Withdrawalamount
{
    if (_Withdrawalamount==nil) {
        _Withdrawalamount=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.Monthlyincome.frame)+1*KWidth_Scale, 30*KWidth_Scale, 140*KWidth_Scale, 20*KWidth_Scale)];
        _Withdrawalamount.textColor=WordsofcolorColor;
        _Withdrawalamount.font=UIFont(18);
        _Withdrawalamount.text=@"996.00";
        _Withdrawalamount.userInteractionEnabled=YES;
        _Withdrawalamount.textAlignment=NSTextAlignmentCenter;
    }
    return _Withdrawalamount;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier indexpath:(NSIndexPath *)indexpath
{
    if (self==[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUIwithindexpath:indexpath];
    }
    return self;
}
-(void)initUIwithindexpath:(NSIndexPath *)indexpath
{
    CGFloat heighe=50*KWidth_Scale;
    if (indexpath.row==0) {
        heighe=120*KWidth_Scale;
    }
    shawview *botomo=[[shawview alloc] initWithFrame:CGRectMake(15*KWidth_Scale,3*KWidth_Scale, SCREEN_WIDTH-30*KWidth_Scale, heighe)];
    [self addSubview:botomo];
    if (indexpath.row==0) {
        UILabel *moth=[[UILabel alloc] initWithFrame:CGRectMake(1*KWidth_Scale, CGRectGetMaxY(self.Monthlyincome.frame), 140*KWidth_Scale, 40*KWidth_Scale)];
        moth.textColor=WordsofcolorColor;
        moth.font=UIFont(12);
        moth.textAlignment=NSTextAlignmentCenter;
        moth.text=@"当月收入 (元)";
        
        UILabel *moth1=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.Monthlyincome.frame)+1*KWidth_Scale, CGRectGetMaxY(self.Monthlyincome.frame), 140*KWidth_Scale, 40*KWidth_Scale)];
        moth1.textColor=WordsofcolorColor;
        moth1.font=UIFont(12);
        moth1.textAlignment=NSTextAlignmentCenter;
        moth1.text=@"本次可提现金额 (元)";
        _Withdrawalamount.textColor=WordsofcolorColor;
        _Withdrawalamount.font=UIFont(18);
        _Withdrawalamount.text=@"996.00";
        _Withdrawalamount.userInteractionEnabled=YES;
        _Withdrawalamount.textAlignment=NSTextAlignmentCenter;
        
        UIView *cell=[[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.Monthlyincome.frame), 30*KWidth_Scale, 0.7, 60*KWidth_Scale)];
        cell.backgroundColor=NaviBackgroundColor;
        UIView *cell1=[[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.Withdrawalamount.frame), 30*KWidth_Scale, 0.7, 60*KWidth_Scale)];
        cell1.backgroundColor=NaviBackgroundColor;
        [botomo addSubview:self.Monthlyincome];
        [botomo addSubview:self.Withdrawalamount];
        [botomo addSubview:self.WithdrawalBtn];
        [botomo addSubview:moth];
        [botomo addSubview:moth1];
        [botomo addSubview:cell];
        [botomo addSubview:cell1];
    }
    else{
        [botomo addSubview:self.titllabel];
        [botomo addSubview:self.cellimage];
    }
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setFrame:(CGRect)frame
{
    frame.size.height-=15*KWidth_Scale;
    [super setFrame:frame];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
