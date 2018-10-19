//
//  WooTextFieldLabel.h
//  Woo
//
//  Created by 风外杏林香 on 2018/7/26.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WooTextFieldLabel : UILabel
/**验证码/密码的位数*/
@property (nonatomic,assign)NSInteger numberOfVertificationCode;
/**控制验证码/密码是否密文显示*/
@property (nonatomic,assign)bool secureTextEntry;  
@end
