//
//  TransFercell.h
//  Woo
//
//  Created by 王起锋 on 2018/8/27.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import <RongIMKit/RongIMKit.h>
#import "TransferMessage.h"
@interface TransFercell : RCMessageCell
/*!
 文本内容的Label
 */
@property(strong, nonatomic) UILabel *textLabel;
@property(strong, nonatomic) UILabel *detaillable;
@property(strong, nonatomic) UIImageView *titleimage;
@property(strong, nonatomic) UILabel *tiplabel;
/*!
 背景View
 */
@property(nonatomic, strong) UIImageView *bubbleBackgroundView;
/*!
 根据消息内容获取显示的尺寸
 
 @param message 消息内容
 
 @return 显示的View尺寸
 */
+ (CGSize)getBubbleBackgroundViewSize:(TransferMessage *)message;

@end
