//
//  PayCustView.h
//  Woo
//
//  Created by 王起锋 on 2018/8/27.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import "baseview.h"
typedef void (^sureclickblock) (NSString *password);
@interface PayCustView : baseview<UITextFieldDelegate>
{
    NSString *mytitle;
    NSString *detaistr;
}
@property(nonatomic,copy)sureclickblock myblock;
@property(nonatomic,strong)UILabel *selftitleLable;
@property(nonatomic,strong)UITextField *passtextfield;
@property(nonatomic,strong)UIView *botomo;
-(instancetype)initWithFrame:(CGRect)frame title:(NSString *)title detailstr:(NSString *)detailstr;
-(void)shareviewShow;
@end
