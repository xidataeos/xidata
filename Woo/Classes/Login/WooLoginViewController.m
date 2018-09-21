//
//  WooLoginViewController.m
//  Woo
//
//  Created by 风外杏林香 on 2018/7/26.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import "WooLoginViewController.h"
#import "WooRegistViewController.h"
@interface WooLoginViewController ()
@property (nonatomic, strong)UILabel *label1;
@property (nonatomic, strong)UITextField *textField1;
@property (nonatomic, strong)UIButton *button1;
@property (nonatomic, strong)UITextField *textField2;
@property (nonatomic, strong)NSTimer *timer;
@property (nonatomic, assign)NSInteger timeCount;
@property (nonatomic, strong)NSDictionary *dataDictionary;
@property (nonatomic, strong)UIButton *button2;
@property (nonatomic, strong)UIButton *button3;
@property (nonatomic, strong)UIView *line2;
@property (nonatomic, strong)UITextField *textField3;

@end

@implementation WooLoginViewController

- (NSDictionary *)dataDictionary
{
    if (!_dataDictionary) {
        _dataDictionary = [NSDictionary dictionary];
    }
    return _dataDictionary;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initWithUI];
    self.timeCount = 120;

}

- (void)initWithUI
{
    self.label1 = [[UILabel alloc]initWithFrame:CGRectMake(30, 180, ScreenWidth - 60, 30)];
    self.label1.text = @"手机号";
    self.label1.textColor = RGB(51, 51, 51);
    self.label1.textAlignment = NSTextAlignmentLeft;
    self.label1.font = UIFont(18);
    [self.view addSubview:self.label1];

    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(self.label1.frame), 60, 40)];
    label2.text = @"+86";
    label2.textColor = UIColorFromRGB(0xff6400);
    label2.textAlignment = NSTextAlignmentCenter;
    label2.font = UIFont(18);
    [self.view addSubview:label2];

    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(label2.frame), ScreenWidth - 60, 0.5)];
    line1.backgroundColor = UIColorFromRGB(0xff6400);
    [self.view addSubview:line1];

    self.textField1 = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label2.frame) + 20, CGRectGetMinY(label2.frame), ScreenWidth - 40 - 60 - 20, 40)];
//    self.textField1.placeholder = @"请填写手机号";
    self.textField1.keyboardType = UIKeyboardTypePhonePad;
    [self.textField1 setValue:RGB(102, 102, 102) forKeyPath:@"_placeholderLabel.textColor"];
    self.textField1.font = DefleFuont;
    self.textField1.textColor = UIColorFromRGB(0xff6400);
    [self.textField1 addTarget:self action:@selector(textFieldChanged:) forControlEvents:(UIControlEventAllEditingEvents)];
    [self.view addSubview:self.textField1];

    UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(line1.frame), ScreenWidth - 60, 60)];
    label3.numberOfLines = 0;
    label3.textColor = RGB(51, 51, 51);
    label3.text = @"4位验证码";
    label3.textAlignment = NSTextAlignmentLeft;
    label3.font = UIFont(18);
    [self.view addSubview:label3];
    
    self.line2 = [[UIView alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(label3.frame) + 20, ScreenWidth - 160, 0.5)];
    self.line2.backgroundColor = UIColorFromRGB(0xff6400);
    [self.view addSubview:self.line2];

    self.button1 = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.button1.frame = CGRectMake(ScreenWidth - 130, CGRectGetMinY(self.line2.frame) - 40, 100, 40);
    self.button1.backgroundColor = UIColorFromRGB(0xff6400);
    self.button1.layer.cornerRadius = 5;
    self.button1.layer.masksToBounds = YES;
    [self.button1 setTitle:@"获取验证码" forState:(UIControlStateNormal)];
    self.button1.titleLabel.font = DefleFuont;
    [self.button1 setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    self.button1.tag = 1;
    [self.button1 addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.button1];
    
    self.textField2 = [[UITextField alloc]initWithFrame:CGRectMake(30, CGRectGetMinY(self.button1.frame), CGRectGetWidth(self.line2.frame), 40)];
//    self.textField2.placeholder = @"请填写验证码";
    self.textField2.keyboardType = UIKeyboardTypePhonePad;
    [self.textField2 setValue:RGB(102, 102, 102) forKeyPath:@"_placeholderLabel.textColor"];
    self.textField2.font = DefleFuont;
    self.textField2.textColor = UIColorFromRGB(0xff6400);
    [self.textField2 addTarget:self action:@selector(textFieldChanged:) forControlEvents:(UIControlEventAllEditingEvents)];

    [self.view addSubview:self.textField2];
//
    self.button2 = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.button2.frame = CGRectMake(30, CGRectGetMaxY(self.line2.frame) + 30, ScreenWidth - 60, 40);
    [self.button2 setTitle:@"提交" forState:(UIControlStateNormal)];
    [self.button2 setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    self.button2.titleLabel.font = UIFont(18);
    self.button2.layer.masksToBounds = YES;
    self.button2.layer.cornerRadius = 5;
    self.button2.backgroundColor = RGB(239, 240, 241);
    self.button2.tag = 2;
    [self.button2 addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.button2];
    
    self.button3 = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.button3.frame = CGRectMake(30, CGRectGetMaxY(self.button2.frame), ScreenWidth - 60, 40);
    NSString *titleStr = @"注册登录即表示你已阅读并同意《WoWo用户须知》";
    [self.button3 setTitle:titleStr forState:(UIControlStateNormal)];
    [self.button3 setTitleColor:RGB(102, 102, 102) forState:(UIControlStateNormal)];
    self.button3.titleLabel.font = UIFont(12);
    self.button3.titleLabel.adjustsFontSizeToFitWidth = YES;
//    button3.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:titleStr];
    [attributedString addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xff6400) range:[titleStr rangeOfString:@"《WoWo用户须知》"]];
    [self.button3 setAttributedTitle:attributedString forState:(UIControlStateNormal)];
    self.button3.tag = 3;
    [self.button3 addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.button3];

}

- (void)textFieldChanged:(UITextField *)textField
{
    UIButton *button = (UIButton *)[self.view viewWithTag:2];
    if ([self.textField1.text length] > 0 && [self.textField2.text length] > 0) {
        button.backgroundColor = UIColorFromRGB(0xff6400);
        [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];

    } else {
        button.backgroundColor = RGB(239, 240, 241);
    }
}

- (void)countDown
{
    if (self.timeCount <= 0) {
        dispatch_async(dispatch_get_main_queue()
                       , ^{
                           [self.timer invalidate];
                           self.button1.enabled = YES;
                           [self.button1 setTitle:@"获取验证码" forState:UIControlStateNormal];
                       });
    } else {
        dispatch_async(dispatch_get_main_queue()
                       , ^{
                           NSString *title = [[NSString alloc] initWithFormat:@"%ld秒",self.timeCount];
                           [self.button1 setTitle:title forState:UIControlStateNormal];
                       });
    }
    self.timeCount --;
}

- (void)buttonAction:(UIButton *)sender
{
    switch (sender.tag) {
        case 1:
        {
            ZKLog(@"获取验证码");
            if ([self.textField1.text length] > 0) {
                self.timer= [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
                [self requestTelCode];
            }
            

        }
            break;
        case 2:
        {
            ZKLog(@"下一步,此处后台判断是否注册，如果已经注册  跳转至首页，如果未注册跳转下一页注册一系列");
            if ([self.dataDictionary[@"isReg"] intValue] == 0) {
                ZKLog(@"已经注册  直接跳转首页，同时保存token或者id，此处先跳转注册 修改接口");
//                [UserDefaults setObject:@"1" forKey:@"isLogin"];
//                [[NSNotificationCenter defaultCenter] postNotificationName:@"remove" object:nil];
                [self requestLogin];
            } else {
                ZKLog(@"未注册 跳转注册页面");
                [self requestRegist];
//                WooRegistViewController *registVC = [[WooRegistViewController alloc]init];
//                UINavigationController *registNC = [[UINavigationController alloc]initWithRootViewController:registVC];
//                [self presentViewController:registNC animated:YES completion:nil];
            }
            
        }
            break;
        case 3:
        {
            ZKLog(@"用户须知");
        }
            
        default:
            break;
    }
}

- (void)requestTelCode
{
    WEAKSELF;
    [self showhudmessage:@"数据加载中..." offy:-100];
    [UserRequestToo shareInstance].rquesturl=RegistTelCode;
    NSDictionary *dict = @{@"tel" : self.textField1.text};
    [UserRequestToo shareInstance].params = dict;
    [[UserRequestToo shareInstance] statrrequestgetwith:(MHAsiNetWorkPOST) successBlock:^(id returnData) {
        [weakSelf hideHud];
        ZKLog(@"returnData -- %@", returnData);
        if (returnData[@"success"]) {
            ZKLog(@"验证码发送成功");
            self.dataDictionary = [NSDictionary dictionaryWithDictionary:returnData[@"data"]];
            if ([[returnData[@"data"] objectForKey:@"isReg"] intValue] == 0) {
                ZKLog(@"已经注册  直接跳转首页，同时保存token或者id，此处先跳转注册 修改接口");
//                [UserDefaults setObject:@"1" forKey:@"isLogin"];
//                [[NSNotificationCenter defaultCenter] postNotificationName:@"remove" object:nil];
                ZKLog(@"验证码发送成功，输入之后 直接登录账户");
            } else {
                ZKLog(@"未注册 跳转注册页面");
                
                [weakSelf initWithYaoCode];
               
            }
        }
    } failureBlock:^(NSError *error) {
        [weakSelf hideHud];
    }];

}
#pragma mark -- 登录
- (void)requestLogin
{
    WEAKSELF;
    [self showhudmessage:@"数据加载中..." offy:-100];
    NSDictionary *dict = @{@"tel" : self.textField1.text,
                           @"verifyCode" : self.textField2.text};
    [UserRequestToo shareInstance].params = dict;
    [UserRequestToo shareInstance].rquesturl = LoginUrl;
    [[UserRequestToo shareInstance]statrrequestgetwith:(MHAsiNetWorkPOST) successBlock:^(id returnData) {
        [weakSelf hideHud];
        ZKLog(@"returnData -- %@", returnData);
        if ([returnData[@"success"] intValue] == 1) {
            [UserDefaults setObject:@"1" forKey:@"isLogin"];
            [UserDefaults setObject:returnData[@"data"][@"rcToken"] forKey:@"rcToken"];
            [UserDefaults setObject:returnData[@"data"][@"name"] forKey:@"name"];
            [UserDefaults setObject:returnData[@"data"][@"photo"] forKey:@"photo"];
            [UserDefaults setObject:returnData[@"data"][@"tel"] forKey:@"rel"];
            [UserDefaults setObject:returnData[@"data"][@"uid"] forKey:@"uid"];
            [UserDefaults setObject:returnData[@"data"][@"name"] forKey:@"name"];
            [UserDefaults setObject:returnData[@"data"][@"sex"] forKey:@"sex"];
            [UserDefaults setObject:returnData[@"data"][@"userId"] forKey:@"userId"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"remove" object:nil];
        } else {
            
        }
    } failureBlock:^(NSError *error) {
        [weakSelf hideHud];
        ZKLog(@"error -- %@", error);
    }];

}
#pragma mark -- 注册
- (void)requestRegist
{
    WEAKSELF;
    [self showhudmessage:@"数据加载中..." offy:-100];
    NSDictionary *dict = @{@"tel" : self.textField1.text,
                           @"verifyCode" : self.textField2.text,
                           @"invitationCodeSu" : self.textField3.text};
    [UserRequestToo shareInstance].params = dict;
    [UserRequestToo shareInstance].rquesturl = RegistNewUser;
    [[UserRequestToo shareInstance]statrrequestgetwith:(MHAsiNetWorkPOST) successBlock:^(id returnData) {
        [weakSelf hideHud];
        ZKLog(@"returnData -- %@", returnData);
        if ([returnData[@"success"] intValue] == 1) {
            [UserDefaults setObject:@"1" forKey:@"isLogin"];
            [UserDefaults setObject:returnData[@"data"][@"rcToken"] forKey:@"rcToken"];
            [UserDefaults setObject:returnData[@"data"][@"name"] forKey:@"name"];
            [UserDefaults setObject:returnData[@"data"][@"photo"] forKey:@"photo"];
            [UserDefaults setObject:returnData[@"data"][@"tel"] forKey:@"rel"];
            [UserDefaults setObject:returnData[@"data"][@"userId"] forKey:@"userId"];
            [UserDefaults setObject:returnData[@"data"][@"sex"] forKey:@"sex"];
             [UserDefaults setObject:returnData[@"data"][@"invitationCode"] forKey:@"invitationCode"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"remove" object:nil];
        } else {
            
        }
    } failureBlock:^(NSError *error) {
        [weakSelf hideHud];
        ZKLog(@"error -- %@", error);
    }];
}

#pragma mark -- 如果位注册过的可选填邀请码
- (void)initWithYaoCode
{
    UILabel *label4 = [[UILabel alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(self.line2.frame), ScreenWidth - 100, 40)];
    label4.numberOfLines = 0;
    label4.textColor = RGB(51, 51, 51);
    label4.text = @"6位邀请码(选填)";
    label4.textAlignment = NSTextAlignmentLeft;
    label4.font = UIFont(18);
    [self.view addSubview:label4];
    
    self.textField3 = [[UITextField alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(label4.frame), CGRectGetWidth(self.line2.frame), 40)];
    self.textField3.keyboardType = UIKeyboardTypePhonePad;
    [self.textField3 setValue:RGB(102, 102, 102) forKeyPath:@"_placeholderLabel.textColor"];
    self.textField3.font = DefleFuont;
    self.textField3.textColor = UIColorFromRGB(0xff6400);
    [self.textField3 addTarget:self action:@selector(textFieldChanged:) forControlEvents:(UIControlEventAllEditingEvents)];
    [self.view addSubview:self.textField3];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(self.textField3.frame), ScreenWidth - 60, .5)];
    lineView.backgroundColor = UIColorFromRGB(0xff6400);
    [self.view addSubview:lineView];
    
    self.button2.frame = CGRectMake(30, CGRectGetMaxY(lineView.frame) + 30, ScreenWidth - 60, 40);
    self.button3.frame = CGRectMake(30, CGRectGetMaxY(self.button2.frame), ScreenWidth - 60, 40);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.textField1 resignFirstResponder];
    [self.textField2 resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
