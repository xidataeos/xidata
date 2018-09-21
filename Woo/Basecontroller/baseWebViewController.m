


//
//  baseWebViewController.m
//  LoansMarket
//
//  Created by 零号007 on 2017/12/13.
//  Copyright © 2017年 零号007. All rights reserved.
//

#import "baseWebViewController.h"

@interface baseWebViewController ()<UIWebViewDelegate>
@property(nonatomic,strong)UIWebView *webview;
@property(nonatomic,strong)NSURLRequest *request;
@end

@implementation baseWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=self.titlestr;
    self.webview=[[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, ScreenHeight-[PublicFunction getnavi_heightwithcontroller:self])];
    self.webview.delegate=self;
    self.request=[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.urlstr]];
    self.webview.scalesPageToFit = YES;
     //self.webview.scalesPageToFit = YES;//自动对页面进行缩放以适应
    [self.webview loadRequest:self.request];
    [self.view addSubview:self.webview];
    // Do any additional setup after loading the view.
}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *str = request.URL.absoluteString;
    if ([str containsString:@"zhima_forward://"]) {
        [self.navigationController popViewControllerAnimated:NO];
//        NSNotification * notice = [NSNotification notificationWithName:@"goEavlueView" object:nil userInfo:nil];
//        [[NSNotificationCenter defaultCenter]postNotification:notice];
        [self.navigationController popViewControllerAnimated:YES];
                NSNotification * notice = [NSNotification notificationWithName:@"goRoot" object:nil userInfo:nil];
                [[NSNotificationCenter defaultCenter]postNotification:notice];
        
    
    }else if([str containsString:@"zhima_back://"]){
        
        [self.navigationController popViewControllerAnimated:YES];
                NSNotification * notice = [NSNotification notificationWithName:@"goRoot" object:nil userInfo:nil];
                [[NSNotificationCenter defaultCenter]postNotification:notice];
    }else{
    
    }
    return YES;
}
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [self showhudmessage:@"加载中..." offy:-50];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self hideHud];
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self hideHud];
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
