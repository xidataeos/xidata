
//
//  WithdrawaController.m
//  Woo
//
//  Created by 王起锋 on 2018/10/11.
//  Copyright © 2018年 杭州蜂布式. All rights reserved.
//提现

#import "WithdrawaController.h"
#import "YFMPaymentView.h"
#import <STPopup/STPopup.h>
#import "GalenPayPasswordView.h"
@interface WithdrawaController ()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *paycountLabel;
@property (nonatomic, strong) UIButton *cellpay;
@property (nonatomic, strong) UILabel *amount;
@end

@implementation WithdrawaController
-(UITextField *)paycountLabel
{
    if (_paycountLabel==nil) {
        _paycountLabel=[[UITextField alloc] initWithFrame:CGRectMake(90*KWidth_Scale, 0*KWidth_Scale, SCREEN_WIDTH*0.5, 50*KWidth_Scale)];
        _paycountLabel.placeholder=@"提现金额";
        _paycountLabel.keyboardType=UIKeyboardTypeNumberPad;
        _paycountLabel.textColor=WordsofcolorColor;
        _paycountLabel.font=[UIFont systemFontOfSize:15];
        _paycountLabel.text=@"144.9";
        _paycountLabel.delegate=self;
        [_paycountLabel addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _paycountLabel;
}
-(void)textFieldDidChange:(UITextField *)textField
{
    if (textField == self.paycountLabel) {
        if (textField.text.length >11) {
            textField.text = [textField.text substringToIndex:11];
        }
    }
}
-(UIButton *)cellpay
{
    if (_cellpay==nil) {
        _cellpay=[UIButton buttonWithType:UIButtonTypeCustom];
        _cellpay.frame=CGRectMake(SCREEN_WIDTH-15*KWidth_Scale-60*KWidth_Scale,0, 60*KWidth_Scale, 50*KWidth_Scale);
        [_cellpay setImage:[UIImage imageNamed:@"zhankai_Image"] forState:UIControlStateNormal];
        [_cellpay setImageEdgeInsets:UIEdgeInsetsMake(0, 30*KWidth_Scale, 0, 0)];
        [_cellpay.titleLabel setFont:UIFont(15)];
        [_cellpay setTitleColor:[PublicFunction colorWithHexString:@"#F06D6D"] forState:UIControlStateNormal];
        [_cellpay addTarget:self action:@selector(Withdrpaytype:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cellpay;
    
}
-(void)payClick
{
    NSArray *payTypeArr = @[
                            @{@"pic":@"pic_alipay",
                              @"title":@"支付宝",
                              @"type":@"alipay"},
                            @{@"pic":@"pic_wxpay",
                              @"title":@"微信",
                              @"type":@"wxpay"}
                            ];
    
    YFMPaymentView *pop = [[YFMPaymentView alloc]initTotalPay:@"" vc:self dataSource:payTypeArr type:selecttype];
    STPopupController *popVericodeController = [[STPopupController alloc] initWithRootViewController:pop];
    popVericodeController.style = STPopupStyleBottomSheet;
    [popVericodeController presentInViewController:self];
    
    pop.payType = ^(NSString *type,NSString *balance) {
        NSLog(@"选择了支付方式:%@\n需要支付金额:%@",type,balance);
    };
}
-(void)Withdrpaytype:(UIButton *)sender
{
    [self payClick];
}
-(UILabel *)amount
{
    if (_amount==nil) {
        _amount=[[UILabel alloc] initWithFrame:CGRectMake(90*KWidth_Scale, 0*KWidth_Scale, SCREEN_WIDTH*0.5, 50*KWidth_Scale)];
        _amount.textColor=WordsofcolorColor;
        _amount.font=UIFont(15);
        _amount.text=@"支付宝()";
    }
    return _amount;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"提现";
    [self initUI];
    // Do any additional setup after loading the view.
}
-(void)initUI
{
    UILabel *nameLabel=[PublicFunction getlabelwithtexttitle:@"提现账户" fram:CGRectMake(15*KWidth_Scale, 0, 65*KWidth_Scale, 50*KWidth_Scale) cornerRadius:0 textcolor:WordsofcolorColor textfont:UIFont(15) backcolor:[UIColor clearColor] textAlignment:NSTextAlignmentLeft];
    UILabel *phoneLabel=[PublicFunction getlabelwithtexttitle:@"提现金额" fram:CGRectMake(15*KWidth_Scale,0, 65*KWidth_Scale, 50*KWidth_Scale) cornerRadius:0 textcolor:WordsofcolorColor textfont:UIFont(15) backcolor:[UIColor clearColor] textAlignment:NSTextAlignmentLeft];
    UIView *topview=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50*KWidth_Scale)];
    topview.backgroundColor=[UIColor whiteColor];
    [topview addSubview:nameLabel];
    [topview addSubview:self.amount];
    [topview addSubview:self.cellpay];
    
    UIView *midview=[[UIView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(topview.frame)+10*KWidth_Scale, SCREEN_WIDTH, 50*KWidth_Scale)];
    midview.backgroundColor=[UIColor whiteColor];
    [midview addSubview:phoneLabel];
    [midview addSubview:self.paycountLabel];
    
    UIView *botomoview=[[UIView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(midview.frame)+10*KWidth_Scale, SCREEN_WIDTH, 100*KWidth_Scale)];
    botomoview.backgroundColor=[UIColor whiteColor];
    [botomoview addSubview:[self getBtn]];
     UILabel *yuelabel=[PublicFunction getlabelwithtexttitle:@"可提现余额500.00元 " fram:CGRectMake(15*KWidth_Scale,10*KWidth_Scale, SCREEN_WIDTH, 20*KWidth_Scale) cornerRadius:0 textcolor:WordsofcolorColor textfont:UIFont(12) backcolor:[UIColor clearColor] textAlignment:NSTextAlignmentLeft];
    [botomoview addSubview:yuelabel];
    [self.view addSubview:topview];
    [self.view addSubview:midview];
    [self.view addSubview:botomoview];
}
-(UIButton *)getBtn
{
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button.frame = CGRectMake(15*KWidth_Scale,40*KWidth_Scale, ScreenWidth - 30*KWidth_Scale, 40*KWidth_Scale);
    button.backgroundColor = UIColorFromRGB(0xff6400);
    button.layer.cornerRadius = 5;
    button.layer.masksToBounds = YES;
    [button setTitle:@"下一步" forState:(UIControlStateNormal)];
    [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    button.titleLabel.font = UIFont(18);
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    return button;
}
-(void)buttonAction:(UIButton *)sender
{
    GalenPayPasswordView *payPassword=[GalenPayPasswordView tradeView];
    [payPassword showInView:self.view.window];
    
    __block typeof(GalenPayPasswordView *) blockPay=payPassword;
    [payPassword setFinish:^(NSString * pwd) {
        [blockPay showProgressView:@"正在处理中..."];
        [blockPay performSelector:@selector(showSuccess:) withObject:self afterDelay:3.0];
    }];
    [payPassword setLessPassword:^{
        NSLog(@"忘记密码？");
    }];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
