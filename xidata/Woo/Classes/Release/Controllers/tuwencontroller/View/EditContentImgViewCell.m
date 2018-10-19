
//
//  TableViewCell.m
//  Woo
//
//  Created by 王起锋 on 2018/9/28.
//  Copyright © 2018年 杭州蜂布式. All rights reserved.
//

#import "EditContentImgViewCell.h"

@implementation EditContentImgViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier celltype:(EditContentCellType)celltype
{
    if (self==[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        if (celltype==EditContentCellTypeImage) {
            [self addSubview:self.cellimage];
        }
        else{
            [self addSubview:self.celllabel];
        }
    }
    return self;
}
-(UIImageView *)cellimage
{
    if (_cellimage==nil) {
        _cellimage=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0)];
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapclick)];
        [_cellimage addGestureRecognizer:tap];
    }
    return _cellimage;
}
-(void)tapclick
{
//    if (self.retuimageviewcell) {
//        self.retuimageviewcell();
//    }
}
-(UILabel *)celllabel
{
    if (_celllabel==nil) {
        _celllabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, MAXFLOAT)];
        _celllabel.textColor=RGB(51, 51, 51);
        _celllabel.font=UIFont(15);
    }
    return _celllabel;
}
-(void)setModel:(EditContentModel *)Model
{
    if (Model.cellType==EditContentCellTypeImage) {
        self.cellimage.frame=CGRectMake(15*KWidth_Scale, 10*KWidth_Scale, SCREEN_WIDTH-30*KWidth_Scale, Model.imageH*((SCREEN_WIDTH-30*KWidth_Scale)/Model.imageW));
        if (Model.img) {
            self.cellimage.image=Model.img;
        }
        else{
           [self.cellimage sd_setImageWithURL:[NSURL URLWithString:Model.imageUrl] placeholderImage:[UIImage imageNamed:@"playback"]];
        }
    }
    else{
        CGSize size=[self getusetlabelsize:Model.inputStr font:UIFont(15)];
        self.celllabel.frame=CGRectMake(15*KWidth_Scale, KWidth_Scale, SCREEN_WIDTH-30*KWidth_Scale, size.height);
        self.celllabel.numberOfLines=0;
        self.celllabel.text=Model.inputStr;
    }
}
-(CGSize)getusetlabelsize:(NSString *)text font:(UIFont*)font
{
    return  [text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-30*KWidth_Scale, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName] context:nil].size;
    
}
+ (CGFloat)getmyheight:(NSString *)introduction
{
    CGSize pricelabelsize=[introduction boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-30*KWidth_Scale, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:UIFont(15) forKey:NSFontAttributeName] context:nil].size;;
    return pricelabelsize.height+10*KWidth_Scale;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
//重载UItableViewDelegate中得方法，长按Cell的时候，系统会调用该方法，确定是否显示出UIMenuController
- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//当上面方法返回YES时，系统调用该方法确定UIMenuController显示哪些选项
- (BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath  withSender:(id)sender {
    if (action == @selector(copy:)) {
        return YES;
    }
    return NO;
}

//系统调用该方法确定点击按钮后的相关响应操作
- (void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
   
}
- (BOOL)canBecomeFirstResponder {
    return YES;
}
@end
