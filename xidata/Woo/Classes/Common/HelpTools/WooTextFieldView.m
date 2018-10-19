//
//  WooTextFieldView.m
//  Woo
//
//  Created by 风外杏林香 on 2018/7/26.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import "WooTextFieldView.h"
#import "WooTextFieldLabel.h"
@interface WooTextFieldView () <UITextFieldDelegate>
/**用于获取键盘输入的内容，实际不显示*/
@property (nonatomic,strong)UITextField *textField;
/**验证码/密码输入框的背景图片*/
@property (nonatomic,strong)UIImageView *backgroundImageView;
/**实际用于显示验证码/密码的label*/
@property (nonatomic,strong)WooTextFieldLabel *label;
@end

@implementation WooTextFieldView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // 设置透明背景色，保证vertificationCodeInputView显示的frame为backgroundImageView的frame
        self.backgroundColor = [UIColor clearColor];
        /* 调出键盘的textField */
        _textField = [[UITextField alloc]initWithFrame:self.bounds];
        // 隐藏textField，通过点击IDVertificationCodeInputView使其成为第一响应者，来弹出键盘
        _textField.hidden =YES;
        _textField.keyboardType =UIKeyboardTypeNumberPad;
        _textField.delegate =self;
        _textField.font = [UIFont systemFontOfSize:25];
        // 将textField放到最后边
        [self insertSubview:self.textField atIndex:0];
        /* 添加用于显示验证码/密码的label */
        _label = [[WooTextFieldLabel alloc]initWithFrame:self.bounds];
        _label.numberOfVertificationCode =_numberOfVertificationCode;
        _label.secureTextEntry =_secureTextEntry;
        _label.font =self.textField.font;
        [self addSubview:self.label];
    }
    return self;
}
#pragma mark --------- 设置背景图片
- (void)setBackgroudImageName:(NSString *)backgroudImageName {
    _backgroudImageName = backgroudImageName;
    // 若用户设置了背景图片，则添加背景图片
    self.backgroundImageView = [[UIImageView alloc]initWithFrame:self.bounds];
    self.backgroundImageView.image = [UIImage imageNamed:self.backgroudImageName];
    // 将背景图片插入到label的后边，避免遮挡验证码/密码的显示
    [self insertSubview:self.backgroundImageView belowSubview:self.label];
}
- (void)setNumberOfVertificationCode:(NSInteger)numberOfVertificationCode {
    _numberOfVertificationCode = numberOfVertificationCode;
    // 保持label的验证码/密码位数与IDVertificationCodeInputView一致，此时label一定已经被创建
    self.label.numberOfVertificationCode =_numberOfVertificationCode;
}
- (void)setSecureTextEntry:(bool)secureTextEntry {
    _secureTextEntry = secureTextEntry;
    self.label.secureTextEntry =_secureTextEntry;
}
-(void)becomeFirstResponder{
    [self.textField becomeFirstResponder];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.textField becomeFirstResponder];
}
#pragma mark ------ 时时监测输入框的内容
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // 判断是不是“删除”字符
    if (string.length !=0) {//不是“删除”字符
        // 判断验证码/密码的位数是否达到预定的位数
        if (textField.text.length <self.numberOfVertificationCode) {
            self.label.text = [textField.text stringByAppendingString:string];
            self.vertificationCode =self.label.text;
            if (self.label.text.length == _numberOfVertificationCode) {
                /******* 通过协议将验证码返回当前页面  ******/
                if ([_delegate respondsToSelector:@selector(returnTextFieldContent:)]){
                    [_delegate returnTextFieldContent:_vertificationCode];
                }
            }
            return YES;
        } else {
            return NO;
        }
    } else {//是“删除”字符
        self.label.text = [textField.text substringToIndex:textField.text.length -1];
        self.vertificationCode =self.label.text;
        return YES;
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
