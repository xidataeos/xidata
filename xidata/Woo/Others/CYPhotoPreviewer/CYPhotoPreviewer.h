//
//  CYPhotoPreviewer.h
//  QuoraDots
//
//  Created by angelen on 2017/3/7.
//  Copyright © 2017年 ANGELEN. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^savePhoneblock) (void);
@interface CYPhotoPreviewer : UIView
@property(nonatomic,copy)savePhoneblock saveblock;
- (void)previewFromImageView:(UIImageView *)fromImageView inContainer:(UIView *)container;

@end
