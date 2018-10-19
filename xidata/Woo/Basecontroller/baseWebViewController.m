


//
//  baseWebViewController.m
//  LoansMarket
//
//  Created by 零号007 on 2017/12/13.
//  Copyright © 2017年 零号007. All rights reserved.
//

#import "baseWebViewController.h"

@interface baseWebViewController ()<UIWebViewDelegate>
@property(nonatomic,strong)NSURLRequest *request;
@end

@implementation baseWebViewController

-(void)startLoadingAnimation{
    [UIView animateWithDuration:0.4 animations:^{
        self.progressView.progress =0.6;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.4 animations:^{
            self.progressView.progress =0.8;
        }];
    }];
    
    
}

-(void)endLoadingAnimation{
    [self.progressView removeFromSuperview];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0,StatusBarHeight, [[UIScreen mainScreen] bounds].size.width, 1.0)];
    self.progressView.backgroundColor = [UIColor blueColor];
    //设置进度条的高度，下面这句代码表示进度条的宽度变为原来的1倍，高度变为原来的1.5倍.
    self.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.5f);
    [self.view addSubview:self.progressView];
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
-(void)webViewDidFinishLoad:(UIWebView *)webView {
    NSString *script = [NSString stringWithFormat:
                        @"var script = document.createElement('script');"
                        "script.type = 'text/javascript';"
                        "script.text = \"function ResizeImages() { "
                        "var img;"
                        "var maxwidth=%f;"
                        "for(i=0;i <document.images.length;i++){"
                        "img = document.images[i];"
                        "if(img.width > maxwidth){"
                        "img.width = maxwidth;"
                        "}"
                        "}"
                        "}\";"
                        "document.getElementsByTagName('head')[0].appendChild(script);", SCREEN_WIDTH - 20];
    [webView stringByEvaluatingJavaScriptFromString: script];
    [webView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
    [self endLoadingAnimation];
}
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [self startLoadingAnimation];
    [self.view bringSubviewToFront:self.progressView];
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    self.progressView.hidden=YES;
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
