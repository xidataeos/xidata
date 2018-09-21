//
//  WooNiChenVC.m
//  Woo
//
//  Created by 风外杏林香 on 2018/8/9.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import "WooNiChenVC.h"

@interface WooNiChenVC ()
@property (nonatomic, strong)UITextField *textField1;

@end

@implementation WooNiChenVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"更改昵称";
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame =CGRectMake(ScreenWidth - 50, 60,40,40);
//    [leftBtn setImage:[UIImage imageNamed:@"jiahao_Image"] forState:UIControlStateNormal];
    [leftBtn setTitle:@"保存" forState:(UIControlStateNormal)];
    leftBtn.titleLabel.font = UIFont(15);
    [leftBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(8, 8, 8, 8)];
    [leftBtn addTarget:self action: @selector(addAction) forControlEvents: UIControlEventTouchUpInside];
    [self.view addSubview:leftBtn];
    
    UIBarButtonItem* item=[[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width =-10;
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, item, nil];
    
    [self initWithUI];
}

- (void)addAction
{
    ZKLog(@"保存  并退出");
    [self requestURL];
}

- (void)initWithUI
{
    self.textField1 = [[UITextField alloc]initWithFrame:CGRectMake(20, 20, ScreenWidth - 40, 40)];
//    self.textField1.keyboardType = UIKeyboardTypePhonePad;
    [self.textField1 setValue:RGB(102, 102, 102) forKeyPath:@"_placeholderLabel.textColor"];
    self.textField1.font = UIFont(15);
    self.textField1.textColor = RGB(51, 51, 51);
//    [self.textField1 addTarget:self action:@selector(textFieldChanged:) forControlEvents:(UIControlEventAllEditingEvents)];
    [self.view addSubview:self.textField1];
    
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(self.textField1.frame), ScreenWidth - 40, 0.5)];
    line2.backgroundColor = UIColorFromRGB(0xff6400);
    [self.view addSubview:line2];
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(line2.frame), ScreenWidth - 40, 30)];
    label1.text = @"好名字可以让朋友更容易记住你";
    label1.textColor = RGB(102, 102, 102);
    label1.font = UIFont(12);
    label1.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:label1];
    
}

- (void)requestURL
{
    WEAKSELF;
    [self showhudmessage:@"数据加载中..." offy:-100];
    [UserRequestToo shareInstance].rquesturl = ModifyUrl;
    
    [UserRequestToo shareInstance].params = @{@"name" : self.textField1.text,
                                              @"userId" : [UserDefaults objectForKey:@"userId"]};
    [[UserRequestToo shareInstance] statrrequestgetwith:(MHAsiNetWorkPOST) successBlock:^(id returnData) {
        ZKLog(@"returnData -- %@", returnData[@"message"]);
        NSLog(@"");
        if ([returnData[@"success"] intValue] == 1) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"requestURL" object:nil];
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            
        }
        [weakSelf hideHud];
    } failureBlock:^(NSError *error) {
        ZKLog(@"error -- %@", error);
        [weakSelf hideHud];
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.textField1 resignFirstResponder];
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
