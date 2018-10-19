//
//  baseview.h
//  LoansMarket
//
//  Created by 零号007 on 2017/12/1.
//  Copyright © 2017年 零号007. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MBProgressHUD.h>
@interface baseview : UIView<MBProgressHUDDelegate>
@property(nonatomic,strong)MBProgressHUD *myhub;
-(CGFloat)witdth;
-(CGFloat)height;
/**
 *  开启HUD等待请求接口
 */
- (void)showhudmessage:(NSString *)message offy:(CGFloat)offy;


/**
 *  结束HUD
 */
-(void)hideHud;
@end
