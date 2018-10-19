

//
//  Theselectorviewcell.m
//  Backtorent
//
//  Created by 零号007 on 2017/12/11.
//  Copyright © 2017年 零号007. All rights reserved.
//

#import "Theselectorviewcell.h"

@implementation Theselectorviewcell
-(UIView *)cellline
{
    if (_cellline==nil) {
        _cellline=[[UIView alloc] initWithFrame:CGRectMake(0, 43, SCREEN_WIDTH, 0.7)];
        _cellline.backgroundColor=CellBackgroundColor;
    }
    return _cellline;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier indexPath:(NSIndexPath *)indexPath
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setindexPath:indexPath];
    }
    return self;
}
-(void)setindexPath:(NSIndexPath *)indexPath
{
    self.backgroundColor=[UIColor whiteColor];
    self.nameLabel=[PublicFunction getlabelwithtexttitle:nil fram:CGRectMake(0, 0, SCREEN_WIDTH, self.frame.size.height) cornerRadius:0 textcolor:RGB(51, 51, 51) textfont:[UIFont systemFontOfSize:13] backcolor:[UIColor clearColor] textAlignment:NSTextAlignmentCenter];
    [self addSubview:self.nameLabel];
    [self addSubview:self.cellline];
}
-(void)setFrame:(CGRect)frame
{
    frame.size.height -= 1;    // 减掉的值就是分隔线的高度
    [super setFrame:frame];
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
