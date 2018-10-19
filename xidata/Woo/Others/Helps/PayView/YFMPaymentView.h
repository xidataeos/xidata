//
//  YFMPaymentView.h
//  YFMBottomPayView
//
//  Created by YFM on 2018/8/7.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <STPopup/STPopup.h>
typedef enum {
    paytype= 1,   /**GIF */
    selecttype       /** 图片*/
} seltcttype;

@interface YFMPaymentView : UIViewController
- (instancetype)initTotalPay:(NSString *)totalBalance vc:(UIViewController *)vc dataSource:(NSArray *)dataSource type:(seltcttype)type;
//支付方式
@property (nonatomic, strong)UILabel *titleLable;
@property (nonatomic ,strong) UIButton *sureBtn;
@property (nonatomic ,assign)seltcttype selftype;
@property (nonatomic, copy) void(^payType)(NSString *type ,NSString *balance);
@end
