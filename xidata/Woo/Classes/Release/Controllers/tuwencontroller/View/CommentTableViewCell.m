
//
//  CommentTableViewCell.m
//  Woo
//
//  Created by 王起锋 on 2018/10/10.
//  Copyright © 2018年 杭州蜂布式. All rights reserved.
//

#import "CommentTableViewCell.h"

@implementation CommentTableViewCell
-(UIImageView *)cellimage
{
    if (_cellimage==nil) {
        _cellimage=[[UIImageView alloc] initWithFrame:CGRectMake(10*KWidth_Scale,10*KWidth_Scale, 30*KWidth_Scale, 30*KWidth_Scale)];
        [_cellimage sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1539162370911&di=c972ae0e80d51e307ac9eedd20719693&imgtype=0&src=http%3A%2F%2Fimg5.duitang.com%2Fuploads%2Fitem%2F201409%2F20%2F20140920163111_fsSQj.thumb.700_0.png"]];
    }
    return _cellimage;
}
-(UILabel *)celllabel
{
    if (_celllabel==nil) {
        _celllabel=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.cellimage.frame)+5*KWidth_Scale, 10*KWidth_Scale, SCREEN_WIDTH*0.5, 15*KWidth_Scale)];
        _celllabel.textColor=WordsofcolorColor;
        _celllabel.font=UIFont(15);
        _celllabel.text=@"发布于";
    }
    return _celllabel;
}
-(UILabel *)detailcelllabel
{
    if (_detailcelllabel==nil) {
        _detailcelllabel=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.cellimage.frame)+5*KWidth_Scale, CGRectGetMaxY(self.celllabel.frame)+1*KWidth_Scale, SCREEN_WIDTH*0.5, 16*KWidth_Scale)];
        _detailcelllabel.textColor=RGB(153, 153, 153);
        _detailcelllabel.font=UIFont(12);
        _detailcelllabel.text=@"10分钟前";
    }
    return _detailcelllabel;
}
-(UILabel *)commentLabel
{
    if (_commentLabel==nil) {
        _commentLabel=[[UILabel alloc] initWithFrame:CGRectMake(10*KWidth_Scale,CGRectGetMaxY(self.detailcelllabel.frame)+2*KWidth_Scale, SCREEN_WIDTH-20*KWidth_Scale, 40*KWidth_Scale)];
        _commentLabel.textColor=WordsofcolorColor;
        _commentLabel.font=UIFont(13);
        _commentLabel.text=@"(1)，位置;座次。《史记·天官书》:“紫宫，房心，权衡，咸池，虚危列宿步星，此天之五官坐位也。”清李渔《闲情偶寄·词曲·音律》:“其高踞词坛之坐位，业如泰山之稳，磐石之固。”《红楼梦》第三八回:“把那大团圆桌子放在当中，酒菜都放着，也不必拘定坐位。”";
        _commentLabel.numberOfLines=0;
    }
    return _commentLabel;
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
    [self addSubview:self.cellimage];
    [self addSubview:self.celllabel];
    [self addSubview:self.detailcelllabel];
    [self addSubview:self.commentLabel];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(CGSize)getusetlabelsize:(NSString *)text font:(UIFont*)font
{
    return  [text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-20*KWidth_Scale, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName] context:nil].size;
    
}
+(CGFloat)getCommentheight:(NSString *)introduction
{
    CGSize pricelabelsize=[introduction boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-20*KWidth_Scale, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:UIFont(15) forKey:NSFontAttributeName] context:nil].size;;
    return pricelabelsize.height+60*KWidth_Scale;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
