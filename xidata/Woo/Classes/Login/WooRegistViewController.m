//
//  WooRegistViewController.m
//  Woo
//
//  Created by 风外杏林香 on 2018/7/26.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import "WooRegistViewController.h"
#import "WooVCViewController.h"
#import "WooHeader.h"
@interface WooRegistViewController ()
@property (nonatomic, strong)UITextField *textField1;
@property (nonatomic, strong)UITextField *textField2;
@property (nonatomic, strong)UITextField *textField3;
@property (nonatomic, strong)UIButton *button1;
@property (nonatomic, strong)NSTimer *timer;
@property (nonatomic, assign)NSInteger timeCount;

@end

@implementation WooRegistViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.timeCount = 60;
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame =CGRectMake(10, 60,40,40);
    [leftBtn setImage:[UIImage imageNamed:@"back_Image"] forState:UIControlStateNormal];
    [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(8, 8, 8, 8)];
    [leftBtn addTarget:self action: @selector(backAction) forControlEvents: UIControlEventTouchUpInside];
    [self.view addSubview:leftBtn];
//    UIBarButtonItem* item=[[UIBarButtonItem alloc] initWithCustomView:leftBtn];
//
//    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//        negativeSpacer.width =-10;
//    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, item, nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccess) name:@"loginSuccess" object:nil];
    [self initWithUI];
}

- (void)initWithUI
{
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(30, 180, ScreenWidth - 60, 30)];
    label1.text = @"手机号";
    label1.textColor = RGB(51, 51, 51);
    label1.textAlignment = NSTextAlignmentLeft;
    label1.font = UIFont(18);
    [self.view addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(label1.frame), 60, 40)];
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
    
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(label3.frame) + 20, ScreenWidth - 160, 0.5)];
    line2.backgroundColor = UIColorFromRGB(0xff6400);
    [self.view addSubview:line2];
    
    self.button1 = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.button1.frame = CGRectMake(ScreenWidth - 130, CGRectGetMinY(line2.frame) - 40, 100, 40);
    self.button1.backgroundColor = UIColorFromRGB(0xff6400);
    self.button1.layer.cornerRadius = 5;
    self.button1.layer.masksToBounds = YES;
    [self.button1 setTitle:@"获取验证码" forState:(UIControlStateNormal)];
    self.button1.titleLabel.font = DefleFuont;
    [self.button1 setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    self.button1.tag = 1;
    [self.button1 addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.button1];
    
    self.textField2 = [[UITextField alloc]initWithFrame:CGRectMake(30, CGRectGetMinY(self.button1.frame), CGRectGetWidth(line2.frame), 40)];
    //    self.textField2.placeholder = @"请填写验证码";
    self.textField2.keyboardType = UIKeyboardTypePhonePad;
    [self.textField2 setValue:RGB(102, 102, 102) forKeyPath:@"_placeholderLabel.textColor"];
    self.textField2.font = DefleFuont;
    self.textField2.textColor = UIColorFromRGB(0xff6400);
    [self.textField2 addTarget:self action:@selector(textFieldChanged:) forControlEvents:(UIControlEventAllEditingEvents)];
    [self.view addSubview:self.textField2];
    
    UILabel *label4 = [[UILabel alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(line2.frame), ScreenWidth - 100, 40)];
    label4.numberOfLines = 0;
    label4.textColor = RGB(51, 51, 51);
    label4.text = @"6位邀请码(选填)";
    label4.textAlignment = NSTextAlignmentLeft;
    label4.font = UIFont(18);
    [self.view addSubview:label4];
    
    self.textField3 = [[UITextField alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(label4.frame), CGRectGetWidth(line2.frame), 40)];
//        self.textField3.placeholder = @"请填写验证码";
    self.textField3.keyboardType = UIKeyboardTypePhonePad;
    [self.textField3 setValue:RGB(102, 102, 102) forKeyPath:@"_placeholderLabel.textColor"];
    self.textField3.font = DefleFuont;
    self.textField3.textColor = UIColorFromRGB(0xff6400);
    [self.textField3 addTarget:self action:@selector(textFieldChanged:) forControlEvents:(UIControlEventAllEditingEvents)];
    [self.view addSubview:self.textField3];
    
    UIView *line3 = [[UIView alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(self.textField3.frame), ScreenWidth - 60, 0.5)];
    line3.backgroundColor = UIColorFromRGB(0xff6400);
    [self.view addSubview:line3];
    
    UILabel *label5 = [[UILabel alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(line3.frame), ScreenWidth, 40)];
    label5.text = @"填写好友邀请码注册，双方都可获得2000枚彩蛋作为奖励";
    label5.textAlignment = NSTextAlignmentLeft;
    label5.font = UIFont(12);
    label5.textColor = RGB(102, 102, 102);
    label5.adjustsFontSizeToFitWidth = YES;
    [self.view addSubview:label5];
    
    UIButton *button2 = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button2.frame = CGRectMake(30, CGRectGetMaxY(label5.frame) + 10, ScreenWidth - 60, 40);
    [button2 setTitle:@"提交" forState:(UIControlStateNormal)];
    [button2 setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    button2.titleLabel.font = UIFont(18);
    button2.layer.masksToBounds = YES;
    button2.layer.cornerRadius = 5;
    button2.backgroundColor = RGB(239, 240, 241);
    button2.tag = 2;
    [button2 addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:button2];
    
    UIButton *button3 = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button3.frame = CGRectMake(30, CGRectGetMaxY(button2.frame), ScreenWidth - 60, 40);
    NSString *titleStr = @"注册登录即表示你已阅读并同意《xidata用户须知》";
    [button3 setTitle:titleStr forState:(UIControlStateNormal)];
    [button3 setTitleColor:RGB(102, 102, 102) forState:(UIControlStateNormal)];
    button3.titleLabel.font = UIFont(12);
    button3.titleLabel.adjustsFontSizeToFitWidth = YES;
    //    button3.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:titleStr];
    [attributedString addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xff6400) range:[titleStr rangeOfString:@"《xidata用户须知》"]];
    [button3 setAttributedTitle:attributedString forState:(UIControlStateNormal)];
    button3.tag = 3;
    [button3 addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:button3];
    
    
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

- (void)textFieldChanged:(UITextField *)textField
{
    UIButton *button = (UIButton *)[self.view viewWithTag:2];
    if ([self.textField1.text length] > 0 && [self.textField2.text length] > 0 && [self.textField3.text length] > 0) {
        button.backgroundColor = UIColorFromRGB(0xff6400);
        [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
        
    } else {
        button.backgroundColor = RGB(239, 240, 241);
    }
}

- (void)buttonAction:(UIButton *)sender
{
    switch (sender.tag) {
        case 1:
        {
            NSLog(@"验证码");
            self.timer= [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
        }
            break;
        case 2:
        {
            NSLog(@"提交");
            WooVCViewController *vc = [[WooVCViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 3:
        {
            NSLog(@"用户须知");
        }
        default:
            break;
    }
}




- (void)loginSuccess
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"remove" object:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)backAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.textField1 resignFirstResponder];
    [self.textField2 resignFirstResponder];
    [self.textField3 resignFirstResponder];

}

- (void)requestRegistCode
{
    WEAKSELF;
    [self showWithStatus:@"数据加载中..."];
    [UserRequestToo shareInstance].rquesturl = LoginUrl;
    NSDictionary *dict = @{@"tel" : self.textField1.text};
    [UserRequestToo shareInstance].params = dict;
    [[UserRequestToo shareInstance] statrrequestgetwith:(MHAsiNetWorkPOST) successBlock:^(id returnData) {
        if (returnData[@"success"]) {
            
        } else {
            
        }
    } failureBlock:^(NSError *error) {
        [weakSelf dismiss];
    }];
}

- (void)requestRegist
{
    WEAKSELF;
    [self showWithStatus:@"数据加载中..."];
    [UserRequestToo shareInstance].rquesturl = LoginUrl;
    NSDictionary *dict = @{@"tel" : self.textField1.text,
                           @"verifyCode" : self.textField2.text,
                           @"invitationCodeSu" : self.textField3.text};
    [UserRequestToo shareInstance].params = dict;
    [[UserRequestToo shareInstance] statrrequestgetwith:(MHAsiNetWorkPOST) successBlock:^(id returnData) {
        [weakSelf dismiss];
        if (returnData[@""]) {
            
        } else {
            
        }
    } failureBlock:^(NSError *error) {
        [weakSelf dismiss];
    }];
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
