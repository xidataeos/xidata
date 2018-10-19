//
//  WooSpotViewController.m
//  Woo
//
//  Created by 风外杏林香 on 2018/8/25.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//通用图文详情文

#import "graphicViewController.h"

@interface graphicViewController ()
@property (nonatomic, strong)UIButton *button;
@property (nonatomic, strong)UITextField *textField1;
@property (nonatomic, strong)UITextField *textField2;
@property (nonatomic, strong)UITextField *textField3;
@property (nonatomic, strong)UITextField *textField4;
@property (nonatomic, strong)UITextField *textField5;
@end

@implementation graphicViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"填写报名单";
    [self.view addSubview:self.button];
    [self initWithUI];
}

- (void)initWithUI
{
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    label1.text = @"姓名(必填)";
    label1.font = UIFont(15);
    label1.textAlignment = NSTextAlignmentCenter;
    NSMutableAttributedString *attributedStr1 = [[NSMutableAttributedString alloc] initWithString:label1.text];
    [attributedStr1 addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:RGB(255, 101, 0)} range:[label1.text rangeOfString:@"(必填)"]];
    label1.attributedText = attributedStr1;
    [self.view addSubview:label1];
    
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(label1.frame) + 10, ScreenWidth, 0.5)];
    line1.backgroundColor = RGB(230, 230, 230);
    [self.view addSubview:line1];
    
    self.textField1 = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label1.frame), 0, ScreenWidth - 100, 40)];
    [self.view addSubview:self.textField1];
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(line1.frame), 100, 30)];
    label2.text = @"手机(必填)";
    label2.font = UIFont(15);
    label2.textAlignment = NSTextAlignmentCenter;
    NSMutableAttributedString *attributedStr2 = [[NSMutableAttributedString alloc] initWithString:label2.text];
    [attributedStr2 addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:RGB(255, 101, 0)} range:[label2.text rangeOfString:@"(必填)"]];
    label2.attributedText = attributedStr2;
    [self.view addSubview:label2];
    
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(label2.frame) + 10, ScreenWidth, 0.5)];
    line2.backgroundColor = RGB(230, 230, 230);
    [self.view addSubview:line2];
    
    self.textField2 = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label1.frame), CGRectGetMaxY(line1.frame), ScreenWidth - 100, 40)];
    self.textField2.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:self.textField2];
    
    UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(line2.frame), 100, 30)];
    label3.text = @"公司(选填)";
    label3.font = UIFont(15);
    label3.textAlignment = NSTextAlignmentCenter;
    NSMutableAttributedString *attributedStr3 = [[NSMutableAttributedString alloc] initWithString:label3.text];
    [attributedStr3 addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:RGB(255, 101, 0)} range:[label3.text rangeOfString:@"(选填)"]];
    label3.attributedText = attributedStr3;
    [self.view addSubview:label3];
    
    UIView *line3 = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(label3.frame) + 10, ScreenWidth, 0.5)];
    line3.backgroundColor = RGB(230, 230, 230);
    [self.view addSubview:line3];
    
    self.textField3 = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label1.frame), CGRectGetMaxY(line2.frame), ScreenWidth - 100, 40)];
    [self.view addSubview:self.textField3];
    
    UILabel *label4 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(line3.frame), 100, 30)];
    label4.text = @"部门(选填)";
    label4.font = UIFont(15);
    label4.textAlignment = NSTextAlignmentCenter;
    NSMutableAttributedString *attributedStr4 = [[NSMutableAttributedString alloc] initWithString:label4.text];
    [attributedStr4 addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:RGB(255, 101, 0)} range:[label4.text rangeOfString:@"(选填)"]];
    label4.attributedText = attributedStr4;
    [self.view addSubview:label4];
    
    UIView *line4 = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(label4.frame) + 10, ScreenWidth, 0.5)];
    line4.backgroundColor = RGB(230, 230, 230);
    [self.view addSubview:line4];
    
    self.textField4 = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label1.frame), CGRectGetMaxY(line3.frame), ScreenWidth - 100, 40)];
    [self.view addSubview:self.textField4];
    
    UILabel *label5 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(line4.frame), 100, 30)];
    label5.text = @"职位(选填)";
    label5.font = UIFont(15);
    label5.textAlignment = NSTextAlignmentCenter;
    NSMutableAttributedString *attributedStr5 = [[NSMutableAttributedString alloc] initWithString:label5.text];
    [attributedStr5 addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:RGB(255, 101, 0)} range:[label5.text rangeOfString:@"(选填)"]];
    label5.attributedText = attributedStr4;
    [self.view addSubview:label5];
    
    UIView *line5 = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(label5.frame) + 10, ScreenWidth, 0.5)];
    line5.backgroundColor = RGB(230, 230, 230);
    [self.view addSubview:line5];
    
    self.textField5 = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label1.frame), CGRectGetMaxY(line4.frame), ScreenWidth - 100, 40)];
    [self.view addSubview:self.textField5];
    
}

- (UIButton *)button
{
    if (!_button) {
        _button = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _button.frame = CGRectMake(30, ScreenHeight - TabbarSafeBottomMargin - 40 - StatusBarAndNavigationBarHeight - 20, ScreenWidth - 60, 40);
        _button.backgroundColor = RGB(255, 101, 0);
        [_button setTitle:@"提交" forState:(UIControlStateNormal)];
        _button.titleLabel.font = UIFont(17);
        _button.layer.masksToBounds = YES;
        _button.layer.cornerRadius = 5;
        [_button addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _button;
}
- (void)buttonAction:(UIButton *)sender
{
    NSLog(@"提交");
    [self requestURL];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.textField1 resignFirstResponder];
    [self.textField2 resignFirstResponder];
    [self.textField3 resignFirstResponder];
    [self.textField4 resignFirstResponder];
    [self.textField5 resignFirstResponder];
}

- (void)requestURL
{
    if (self.textField2.text.length!=11) {
        [self showInfoWithStatus:@"手机号码不对"];
        return;
    }
    WEAKSELF;
    [self showWithStatus:@"加载中..."];
    [UserRequestToo shareInstance].rquesturl = ApplyUrl;
    [UserRequestToo shareInstance].params = @{@"applyName" : self.textField1.text,
                                              @"phone" : self.textField2.text,
                                              @"corporation" : self.textField3.text,
                                              @"dept" : self.textField4.text,
                                              @"position" : self.textField5.text,
                                              @"meetingId" : self.meetingId,
                                              @"userId" : [UserDefaults objectForKey:@"userId"]};
    [[UserRequestToo shareInstance] statrrequestgetwith:(MHAsiNetWorkPOST) successBlock:^(id returnData) {
        [weakSelf dismiss];
        if ([returnData[@"success"] intValue] == 1) {
            [self showSuccessWithStatus:@"您已报名成功"];
        } else {
            [self showErrorWithStatus:returnData[@"message"]];
        }
    } failureBlock:^(NSError *error) {
        [weakSelf dismiss];
        ZKLog(@"error -- %@", error);
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
