//
//  Theselectorviewcell.h
//  Backtorent
//
//  Created by 零号007 on 2017/12/11.
//  Copyright © 2017年 零号007. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Theselectorviewcell : UITableViewCell
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UIView *cellline;
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier indexPath:(NSIndexPath *)indexPath;
@end
