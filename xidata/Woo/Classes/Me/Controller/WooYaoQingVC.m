//
//  WooYaoQingVC.m
//  Woo
//
//  Created by 风外杏林香 on 2018/8/10.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import "WooYaoQingVC.h"
#import "Sharemangerview.h"
@interface WooYaoQingVC ()

@end

@implementation WooYaoQingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initWithUI];
}

- (void)initWithUI
{
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 40, ScreenWidth, 40)];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.font = UIFont(18);
    label1.text = @"创世合伙人名额剩余";
    [self.view addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(label1.frame), ScreenWidth, 40)];
    label2.textAlignment = NSTextAlignmentCenter;
    label2.font = UIFont(18);
    label2.text = @"2000";
    [self.view addSubview:label2];
    
    UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(label2.frame), ScreenWidth, 80)];
    label3.numberOfLines = 0;
    label3.text = @"为了完成xidata建设，当前仅招募10万名合伙人，\n请认真挑选受邀人";
    label3.textAlignment = NSTextAlignmentCenter;
    label3.font = UIFont(15);
    [self.view addSubview:label3];
    
    UILabel *label4 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(label3.frame), ScreenWidth, 40)];
    label4.text = @"受邀人";
    label4.textAlignment = NSTextAlignmentCenter;
    label4.font = UIFont(18);
    label4.textColor = UIColorFromRGB(0xff6400);
    [self.view addSubview:label4];
    
    UILabel *label5 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(label4.frame), ScreenWidth, 40)];
    label5.text = @"A A A A";
    label5.textAlignment = NSTextAlignmentCenter;
    label5.font = UIFont(24);
    label5.textColor = UIColorFromRGB(0xff6400);
    [self.view addSubview:label5];
    
    UILabel *label6 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(label5.frame), ScreenWidth, 40)];
    label6.text = @"我邀请的xidata合伙人";
    label6.textAlignment = NSTextAlignmentCenter;
    label6.font = UIFont(18);
    [self.view addSubview:label6];
    
    CGFloat width = (ScreenWidth - 300) / 6;
    for (int i = 0; i < 5; i ++) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(width + (width + 60) * i, CGRectGetMaxY(label6.frame), 60, 60)];
        label.backgroundColor = RGB(230, 231, 231);
        label.layer.masksToBounds = YES;
        label.layer.cornerRadius = 30;
        label.textColor = UIColorFromRGB(0xff6400);
        label.font = UIFont(18);
        label.text = @"?";
        label.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:label];
    }
    
    UILabel *label7 = [[UILabel alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(label6.frame) + 70, ScreenWidth - 60, 80)];
    label7.numberOfLines = 0;
    label7.textAlignment = NSTextAlignmentCenter;
    label7.font = UIFont(12);
    label7.text = @"你可以邀请5位好友加入WOWO成为合伙人，每成功邀请一位好友加入你和好友均可获得2000枚彩蛋作为奖励";
    [self.view addSubview:label7];
    
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button.frame = CGRectMake(30, ScreenHeight - 100 - TabbarHeight, ScreenWidth - 60, 40);
    [button setTitle:@"邀请" forState:(UIControlStateNormal)];
    button.backgroundColor = UIColorFromRGB(0xff6400);
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 5;
    [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:button];
}

- (void)buttonAction:(UIButton *)sender
{
    Sharemangerview *share=[[Sharemangerview alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, ScreenHeight) withtype:shar_type_watch];
    [share setMyblock:^(NSInteger indexrow) {
        ZKLog(@"分享的第几个%ld",indexrow);
    }];
    [share shareviewShow];
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
