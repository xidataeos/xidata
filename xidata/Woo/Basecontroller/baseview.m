
//
//  baseview.m
//  LoansMarket
//
//  Created by 零号007 on 2017/12/1.
//  Copyright © 2017年 零号007. All rights reserved.
//

#import "baseview.h"
#import "UIView+Extension.h"
@implementation baseview
-(CGFloat)witdth{
    return self.frame.size.width;
}
-(CGFloat)height{
     return self.frame.size.height;
}
#pragma mark - showHUD
/**
 *  开启HUD等待请求接口
 */
- (void)showhudmessage:(NSString *)message offy:(CGFloat)offy{
    
    self.myhub = [MBProgressHUD showHUDAddedTo:self animated:YES];
    _myhub.label.backgroundColor=RGB(153, 153, 153);
    _myhub.mode = MBProgressHUDModeText;
    _myhub.margin = 15.f;
    _myhub.bezelView.backgroundColor=NaviBackgroundColor;
    _myhub.removeFromSuperViewOnHide = YES;
    _myhub.delegate = self;
    [_myhub setY:offy];
    _myhub.detailsLabel.text=message;
    _myhub.activityIndicatorColor = [UIColor whiteColor];
    _myhub.detailsLabel.font = [UIFont systemFontOfSize:15.0f];
     [_myhub hideAnimated:YES afterDelay:1.5];
}

#pragma mark - hideHud
/**
 *  结束HUD
 */
-(void)hideHud
{
    [self.myhub hideAnimated:YES];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
