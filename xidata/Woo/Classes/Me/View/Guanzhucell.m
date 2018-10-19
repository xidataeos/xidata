//
//  WooNoticeCell.m
//  Woo
//
//  Created by 风外杏林香 on 2018/9/3.
//  Copyright © 2018年 杭州蜂布式. All rights reserved.
//

#import "Guanzhucell.h"

@implementation Guanzhucell
-(UIImageView *)tipsimage
{
    if (_tipsimage==nil) {
        _tipsimage=[[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-10*KWidth_Scale-40*KWidth_Scale, 10*KWidth_Scale, 40*KWidth_Scale, 40*KWidth_Scale)];
        [_tipsimage setImage:[UIImage imageNamed:@"logo_icon"]];
        _tipsimage.userInteractionEnabled=YES;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(guanzhuclick)];
        [_fensiLabel addGestureRecognizer:tap];
    }
    return _tipsimage;
}
-(void)guanzhuclick
{
    if (self.guanzhublock) {
        self.guanzhublock();
    }
}

-(UIButton *)avimage
{
    if (_avimage==nil) {
        _avimage=[UIButton buttonWithType:UIButtonTypeCustom];
        _avimage.frame=CGRectMake(5*KWidth_Scale,5*KWidth_Scale, 50*KWidth_Scale, 50*KWidth_Scale);
        _avimage.layer.cornerRadius=25*KWidth_Scale;
        _avimage.clipsToBounds=YES;
        [_avimage sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1539162370911&di=c972ae0e80d51e307ac9eedd20719693&imgtype=0&src=http%3A%2F%2Fimg5.duitang.com%2Fuploads%2Fitem%2F201409%2F20%2F20140920163111_fsSQj.thumb.700_0.png"] forState:UIControlStateNormal];
    }
    return _avimage;
}
-(UILabel *)nameLabel
{
    if (_nameLabel==nil) {
        _nameLabel=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.avimage.frame)+10*KWidth_Scale, 10*KWidth_Scale, SCREEN_WIDTH*0.5, 20*KWidth_Scale)];
        _nameLabel.textColor=WordsofcolorColor;
        _nameLabel.font=UIFont(15);
        _nameLabel.text=@"我的名字";
    }
    return _nameLabel;
}
-(UIView *)botomoview
{
    if (_botomoview==nil) {
        _botomoview=[[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.avimage.frame)+10*KWidth_Scale, CGRectGetMaxY(self.nameLabel.frame)+2*KWidth_Scale, SCREEN_WIDTH, 20*KWidth_Scale)];
        UIImageView *fensi=[[UIImageView alloc] initWithFrame:CGRectMake(0,0, 20*KWidth_Scale, 20*KWidth_Scale)];
        fensi.image=[UIImage imageNamed:@"logo_icon"];
        
        UIImageView *guanzhu=[[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.fensiLabel.frame),0, 20*KWidth_Scale, 20*KWidth_Scale)];
        guanzhu.image=[UIImage imageNamed:@"logo_icon"];
        [_botomoview addSubview:fensi];
        [_botomoview addSubview:guanzhu];
        [_botomoview addSubview:self.fensiLabel];
        [_botomoview addSubview:self.guanzhuLabel];
    }
    return _botomoview;
}
-(UILabel *)guanzhuLabel
{
    if (_guanzhuLabel==nil) {
        _guanzhuLabel=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.fensiLabel.frame)+20*KWidth_Scale, 0, 60*KWidth_Scale, 20*KWidth_Scale)];
        _guanzhuLabel.textColor=WordsofcolorColor;
        _guanzhuLabel.font=UIFont(12);
        _guanzhuLabel.text=@"关注";
    }
    return _guanzhuLabel;
}

-(UILabel *)fensiLabel
{
    if (_fensiLabel==nil) {
        _fensiLabel=[[UILabel alloc] initWithFrame:CGRectMake(21*KWidth_Scale, 0, 60*KWidth_Scale, 20*KWidth_Scale)];
        _fensiLabel.textColor=WordsofcolorColor;
        _fensiLabel.font=UIFont(12);
        _fensiLabel.text=@"粉丝";
    }
    return _fensiLabel;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initWithUI];
    }
    return self;
}
- (void)initWithUI
{
    [self addSubview:self.avimage];
    [self addSubview:self.nameLabel];
    [self addSubview:self.tipsimage];
    [self addSubview:self.botomoview];
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
