
//
//  Custtextview.m
//  Woo
//
//  Created by 王起锋 on 2018/9/28.
//  Copyright © 2018年 杭州蜂布式. All rights reserved.
//

#import "Custtextview.h"
@implementation Custtextview
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self==[super initWithFrame:frame]) {
        [self setUI];
    }
    return self;
}
-(void)setUI
{
    [self addSubview:self.textView];
    [self addSubview:self.sendButton];
}
-(PlaceholderTextView *)textView{
    
    if (!_textView) {
        _textView = [[PlaceholderTextView alloc]initWithFrame:CGRectMake(20, 25*KWidth_Scale, self.width - 40, 180)];
        _textView.backgroundColor = [UIColor whiteColor];
        _textView.delegate = self;
        _textView.font = [UIFont systemFontOfSize:14.f];
        _textView.textColor = [UIColor blackColor];
        _textView.textAlignment = NSTextAlignmentLeft;
        _textView.editable = YES;
        _textView.layer.cornerRadius = 4.0f;
        _textView.layer.borderColor = RGB(227,224,216).CGColor;
        _textView.layer.borderWidth = 0.5;
        _textView.placeholderColor = RGB(89, 89, 89);
        _textView.placeholder = @"请输入您想说的话";
    }
    
    return _textView;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if ([@"\n" isEqualToString:text] == YES)
    {
        [textView resignFirstResponder];
        
        
        return NO;
    }
    
    return YES;
}

- (UIButton *)sendButton{
    
    if (!_sendButton) {
        _sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _sendButton.layer.cornerRadius = 2.0f;
        _sendButton.frame = CGRectMake(40, CGRectGetMaxY(self.textView.frame)+20, self.width - 80, 40);
        _sendButton.backgroundColor = [PublicFunction colorWithHexString:@"#60cdf8"];
        [_sendButton setTitle:@"提交" forState:UIControlStateNormal];
        [_sendButton addTarget:self action:@selector(sendFeedBack) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _sendButton;
    
}
- (void)sendFeedBack{
    if (self.retublock) {
        [self.textView resignFirstResponder];
        self.retublock(self.textView.text);
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
