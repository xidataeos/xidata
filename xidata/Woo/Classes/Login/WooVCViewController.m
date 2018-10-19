//
//  WooVCViewController.m
//  Woo
//
//  Created by 风外杏林香 on 2018/7/26.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import "WooVCViewController.h"

@interface WooVCViewController ()
{
    NSInteger sexNumer;
}

@property (nonatomic, strong)UITextField *textField1;
@property (nonatomic, strong)UIImageView *imageView3;
@property (nonatomic, strong)UIImageView *imageView4;

@end

@implementation WooVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    sexNumer = 0;
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame =CGRectMake(10, 60,40,40);
    [leftBtn setImage:[UIImage imageNamed:@"back_Image"] forState:UIControlStateNormal];
    [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(8, 8, 8, 8)];
    [leftBtn addTarget:self action: @selector(backAction) forControlEvents: UIControlEventTouchUpInside];
    [self.view addSubview:leftBtn];
    
    [self initWithUI];
}

- (void)backAction
{
//    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)initWithUI
{
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(30, 180, ScreenWidth - 60, 30)];
    label1.text = @"请设置昵称";
    label1.textColor = RGB(51, 51, 51);
    label1.textAlignment = NSTextAlignmentCenter;
    label1.font = UIFont(18);
    [self.view addSubview:label1];
    
    self.textField1 = [[UITextField alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(label1.frame) + 10, ScreenWidth - 60, 40)];
    [self.textField1 setValue:RGB(102, 102, 102) forKeyPath:@"_placeholderLabel.textColor"];
    self.textField1.font = DefleFuont;
    self.textField1.textColor = UIColorFromRGB(0xff6400);
    self.textField1.textAlignment = NSTextAlignmentCenter;
    [self.textField1 addTarget:self action:@selector(textFieldChanged:) forControlEvents:(UIControlEventAllEditingEvents)];
    [self.view addSubview:self.textField1];
    
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(self.textField1.frame), ScreenWidth - 60, 0.5)];
    line1.backgroundColor = UIColorFromRGB(0xff6400);
    [self.view addSubview:line1];
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(line1.frame), ScreenWidth - 60, 40)];
    label2.textColor = RGB(102, 102, 102);
    label2.font = UIFont(14);
    label2.textAlignment = NSTextAlignmentCenter;
    label2.text = @"一个好的昵称可以让朋友更快记住你哦";
    [self.view addSubview:label2];
    
    UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(label2.frame) + 5, ScreenWidth - 60, 40)];
    label3.textColor = RGB(102, 102, 102);
    label3.font = UIFont(18);
    label3.textAlignment = NSTextAlignmentCenter;
    label3.text = @"请选择性别";
    [self.view addSubview:label3];
    
    CGFloat width = (ScreenWidth - 120) / 3;
    UIImageView *imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(width, CGRectGetMaxY(label3.frame) + 5, 60, 60)];
    imageView1.image = [UIImage imageNamed:@"photo_boy"];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    imageView1.userInteractionEnabled = YES;
    [imageView1 addGestureRecognizer:tap1];
    imageView1.tag = 1;
    [self.view addSubview:imageView1];
    
    self.imageView3 = [[UIImageView alloc]initWithFrame:CGRectMake(width + 15, CGRectGetMinY(imageView1.frame) + 20, 20, 20)];
//    self.imageView3.backgroundColor = [UIColor redColor];
    self.imageView3.image = [UIImage imageNamed:@"selecticon"];
    self.imageView3.center = CGPointMake(imageView1.center.x, imageView1.center.y);
    self.imageView3.hidden = YES;
    [self.view addSubview:self.imageView3];
    
    
    
    UIImageView *imageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imageView1.frame) + width, CGRectGetMinY(imageView1.frame), 60, 60)];
    imageView2.image = [UIImage imageNamed:@"pgoto_girl"];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [imageView2 addGestureRecognizer:tap2];
    imageView2.userInteractionEnabled = YES;
    imageView2.tag = 2;
    [self.view addSubview:imageView2];
    
    self.imageView4 = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(imageView2.frame) + 20, CGRectGetMinY(self.imageView3.frame), 20, 20)];
    self.imageView4.image = [UIImage imageNamed:@"selecticon"];
    self.imageView4.center = CGPointMake(imageView2.center.x, imageView2.center.y);
    self.imageView4.hidden = YES;
    [self.view addSubview:self.imageView4];
    
    
    UIButton *button1 = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button1.frame = CGRectMake(width, CGRectGetMaxY(imageView1.frame) + 5, 60, 30);
    [button1 setImage:[UIImage imageNamed:@"man_Image"] forState:(UIControlStateNormal)];
    [button1 setTitle:@"男" forState:(UIControlStateNormal)];
    [button1 setTitleColor:RGB(253, 44, 0) forState:(UIControlStateNormal)];
    button1.titleEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    button1.imageEdgeInsets = UIEdgeInsetsMake(0, 30, 0, 0);
    button1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    button1.tag = 1;
    [self.view addSubview:button1];
    
    UIButton *button2 = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button2.frame = CGRectMake(CGRectGetMaxX(imageView1.frame) + width, CGRectGetMaxY(imageView1.frame) + 5, 60, 30);
    [button2 setImage:[UIImage imageNamed:@"women_Image"] forState:(UIControlStateNormal)];
    [button2 setTitle:@"女" forState:(UIControlStateNormal)];
    [button2 setTitleColor:RGB(140, 141, 142) forState:(UIControlStateNormal)];
    button2.titleEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    button2.imageEdgeInsets = UIEdgeInsetsMake(0, 30, 0, 0);
    button2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    button2.tag = 2;
    [self.view addSubview:button2];
    
    
    UIButton *button3 = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button3.frame = CGRectMake(30, CGRectGetMaxY(button2.frame) + 10, ScreenWidth - 60, 40);
    [button3 setTitle:@"完成" forState:(UIControlStateNormal)];
    [button3 setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    button3.titleLabel.font = UIFont(18);
    button3.layer.masksToBounds = YES;
    button3.layer.cornerRadius = 5;
    button3.backgroundColor = RGB(239, 240, 241);
    button3.tag = 3;
    [button3 addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:button3];
    
    UIButton *button4 = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button4.frame = CGRectMake(30, CGRectGetMaxY(button3.frame), ScreenWidth - 60, 40);
    NSString *titleStr = @"注册登录即表示你已阅读并同意《xidata用户须知》";
    [button4 setTitle:titleStr forState:(UIControlStateNormal)];
    [button4 setTitleColor:RGB(102, 102, 102) forState:(UIControlStateNormal)];
    button4.titleLabel.font = UIFont(12);
    button4.titleLabel.adjustsFontSizeToFitWidth = YES;
    //    button3.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:titleStr];
    [attributedString addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xff6400) range:[titleStr rangeOfString:@"《xidata用户须知》"]];
    [button4 setAttributedTitle:attributedString forState:(UIControlStateNormal)];
    button4.tag = 4;
    [button4 addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:button4];
    
    
}

- (void)tapAction:(UITapGestureRecognizer *)tap
{
    UIView *tapV = [tap view];
    ZKLog(@"tap -- %ld", tapV.tag);

    for (int i = 0; i < 2; i ++) {
        UIImageView *imageView = [self.view viewWithTag:i + 1];

        if (tapV.tag == imageView.tag) {
            
            if (imageView.tag == 1) {
                self.imageView4.hidden = YES;
                self.imageView3.hidden = NO;
                sexNumer = 1;
            }
            if (imageView.tag == 2) {
                self.imageView3.hidden = YES;
                self.imageView4.hidden = NO;
                sexNumer = 0;
            }
        } else {
        }
    }
}

- (void)textFieldChanged:(UITextField *)textField
{
    UIButton *button = (UIButton *)[self.view viewWithTag:3];
    if ([self.textField1.text length] > 0) {
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
            ZKLog(@"男");
        }
            break;
        case 2:
        {
            ZKLog(@"女");
        }
            break;
        case 3:
        {
            ZKLog(@"完成");
            [self requestRegist];

        }
            break;
        case 4:
        {
            ZKLog(@"协议");
        }
        default:
            break;
    }
}

- (void)requestRegist
{
    WEAKSELF;
    [self showWithStatus:@"数据加载中..."];
    [UserRequestToo shareInstance].rquesturl = ModifyUrl;
    [UserRequestToo shareInstance].params = @{@"name" : self.textField1.text,
                                              @"sex" : [NSNumber numberWithInteger:sexNumer],
                                              @"userId" : [UserDefaults objectForKey:@"userId"]};
    [[UserRequestToo shareInstance] statrrequestgetwith:(MHAsiNetWorkPOST) successBlock:^(id returnData) {
        ZKLog(@"retnrnData -- %@", returnData);
        [weakSelf dismiss];
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
        [weakSelf dismiss];
        ZKLog(@"error -- %@", error);
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.textField1 resignFirstResponder];
//    [self.navigationController popToRootViewControllerAnimated:YES];
//    [self.view removeFromSuperview];
//    self.tabBarController.selectedIndex = 0;
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
