//
//  WooTextFieldView.h
//  Woo
//
//  Created by 风外杏林香 on 2018/7/26.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol WooTextFieldViewDelegate <NSObject>
//返回搜索内容
- (void)returnTextFieldContent : (NSString *)content;
@end

@interface WooTextFieldView : UIView
@property (assign,nonatomic,readwrite)id <WooTextFieldViewDelegate>delegate;
/**背景图片*/
@property (nonatomic,copy)NSString *backgroudImageName;
/**验证码/密码的位数*/
@property (nonatomic,assign)NSInteger numberOfVertificationCode;
/**控制验证码/密码是否密文显示*/
@property (nonatomic,assign)bool secureTextEntry;
/**验证码/密码内容，可以通过该属性拿到验证码/密码输入框中验证码/密码的内容*/
@property (nonatomic,copy)NSString *vertificationCode;

-(void)becomeFirstResponder;
@end
