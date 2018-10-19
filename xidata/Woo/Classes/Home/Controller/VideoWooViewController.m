
//
//  VideoWooViewController.m
//  Woo
//
//  Created by 王起锋 on 2018/9/7.
//  Copyright © 2018年 杭州蜂布式. All rights reserved.
//

#import "VideoWooViewController.h"

@interface VideoWooViewController ()
@property(nonatomic,strong)UIButton *closeBtn;
@end

@implementation VideoWooViewController
-(UIButton *)closeBtn
{
    if (_closeBtn==nil) {
        _closeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _closeBtn.frame=CGRectMake(0*KWidth_Scale, StatusBarHeight, 60*KWidth_Scale, 60*KWidth_Scale);
        [_closeBtn setImage:[UIImage imageNamed:@"webclose"] forState:UIControlStateNormal];
        [_closeBtn setImageEdgeInsets:UIEdgeInsetsMake(10*KWidth_Scale, 10*KWidth_Scale, 10*KWidth_Scale, 10*KWidth_Scale)];
        [_closeBtn addTarget:self action:@selector(closeview) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}
-(void)closeview
{
    [self dismissViewControllerAnimated:YES completion:^{
        nil;
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
     self.webview.frame=CGRectMake(0, 0, SCREEN_WIDTH, ScreenHeight);
    [self.view addSubview:self.closeBtn];
     [self hideHud];
    // Do any additional setup after loading the view.
}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
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
