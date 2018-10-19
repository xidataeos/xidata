//
//  Custtextview.h
//  Woo
//
//  Created by 王起锋 on 2018/9/28.
//  Copyright © 2018年 杭州蜂布式. All rights reserved.
//

#import "baseview.h"
#import "PlaceholderTextView.h"
NS_ASSUME_NONNULL_BEGIN

@interface Custtextview : baseview<UITextViewDelegate>

@property (nonatomic, strong) PlaceholderTextView * textView;
@property (nonatomic, copy) void (^retublock)(NSString *textstr);
@property (nonatomic, strong) UIButton * sendButton;
@end

NS_ASSUME_NONNULL_END
