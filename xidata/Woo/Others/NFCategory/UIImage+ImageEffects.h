//
//  UIImage+ImageEffects.h
//  Lianlianapp
//
//  Created by yongting on 15/7/28.
//  Copyright (c) 2015年 yongting. All rights reserved.
//

#import <UIKit/UIKit.h>
#import<Accelerate/Accelerate.h>
@interface UIImage (ImageEffects)


-(UIImage*)applyLightEffect;

-(UIImage*)applyExtraLightEffect;

-(UIImage*)applyDarkEffect;
-(UIImage*)applyTintEffectWithColor:(UIColor*)tintColor;

-(UIImage*)applyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor*)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage*)maskImage;


@end
