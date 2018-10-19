//
//  SubscribeTableViewCell.m
//  Woo
//
//  Created by 王起锋 on 2018/10/10.
//  Copyright © 2018年 杭州蜂布式. All rights reserved.
//

#import "SubscribeTableViewCell.h"

@implementation SubscribeTableViewCell
-(UIImageView *)cellimage
{
    if (_cellimage==nil) {
        _cellimage=[[UIImageView alloc] initWithFrame:CGRectMake(10*KWidth_Scale,10*KWidth_Scale, 40*KWidth_Scale, 40*KWidth_Scale)];
        [_cellimage sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1539162370911&di=c972ae0e80d51e307ac9eedd20719693&imgtype=0&src=http%3A%2F%2Fimg5.duitang.com%2Fuploads%2Fitem%2F201409%2F20%2F20140920163111_fsSQj.thumb.700_0.png"]];
    }
    return _cellimage;
}
-(UIView *)cellline
{
    if (_cellline==nil) {
        _cellline=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.7)];
        _cellline.backgroundColor=CellBackgroundColor;
    }
    return _cellline;
}
-(UILabel *)celllabel
{
    if (_celllabel==nil) {
        _celllabel=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.cellimage.frame)+5*KWidth_Scale, 10*KWidth_Scale, SCREEN_WIDTH*0.5, 20*KWidth_Scale)];
        _celllabel.textColor=WordsofcolorColor;
        _celllabel.font=UIFont(15);
        _celllabel.text=@"发布于";
    }
    return _celllabel;
}
-(UILabel *)detailcelllabel
{
    if (_detailcelllabel==nil) {
        _detailcelllabel=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.cellimage.frame)+5*KWidth_Scale, CGRectGetMaxY(self.celllabel.frame), SCREEN_WIDTH*0.5, 20*KWidth_Scale)];
        _detailcelllabel.textColor=RGB(153, 153, 153);
        _detailcelllabel.font=UIFont(13);
        _detailcelllabel.text=@"订阅数量15万";
    }
    return _detailcelllabel;
}
-(UIButton *)SubscribeBtn
{
    if (_SubscribeBtn==nil) {
        _SubscribeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _SubscribeBtn.frame=CGRectMake(SCREEN_WIDTH-90*KWidth_Scale,15*KWidth_Scale, 80*KWidth_Scale, 30*KWidth_Scale);
        [_SubscribeBtn setTitle:@"订阅专辑" forState:UIControlStateNormal];
        [_SubscribeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_SubscribeBtn.titleLabel setFont:UIFont(13)];
        _SubscribeBtn.layer.cornerRadius=15*KWidth_Scale;
        _SubscribeBtn.backgroundColor=NaviBackgroundColor;
        _SubscribeBtn.clipsToBounds=YES;
        [_SubscribeBtn addTarget:self action:@selector(Subscribeclick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _SubscribeBtn;
}
-(void)Subscribeclick
{
    if (self.Subscribeblock) {
        self.Subscribeblock();
    }
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self==[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creatUI];
    }
    return self;
}
-(void)creatUI
{
    [self addSubview:self.cellline];
    [self addSubview:self.cellimage];
    [self addSubview:self.celllabel];
    [self addSubview:self.detailcelllabel];
    [self addSubview:self.SubscribeBtn];
}
-(void)setModel:(GraphicinfoModel *)model
{
    [self.cellimage sd_setImageWithURL:[NSURL URLWithString:model.albumImg] placeholderImage:[UIImage imageNamed:@""]];
    self.celllabel.text=model.albumTitle;
    self.detailcelllabel.text=[NSString stringWithFormat:@"订阅数量 %ld",(long)model.albumSubsNum];
    if (model.subsState) {
        [self.SubscribeBtn setTitle:@"已订阅" forState:UIControlStateNormal];
        self.SubscribeBtn.userInteractionEnabled=NO;
    }
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
