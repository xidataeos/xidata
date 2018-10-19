//
//  WooPhotoView.h
//  Woo
//
//  Created by 风外杏林香 on 2018/8/10.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ButtonAction)(NSInteger btnTag);
@interface WooPhotoView : UIView
@property (nonatomic, copy)ButtonAction buttonAction;
@end
