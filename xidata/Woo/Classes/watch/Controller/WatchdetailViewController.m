

//
//  WatchdetailViewController.m
//  Woo
//
//  Created by 王起锋 on 2018/8/13.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import "WatchdetailViewController.h"
#import "GameWooViewController.h"
@interface WatchdetailViewController ()<UIWebViewDelegate>
@property(nonatomic,strong)UIWebView *webview;
@property(nonatomic,strong)Watchobject *selfobject;
@property (nonatomic, strong) UIProgressView *progressView;
@end

@implementation WatchdetailViewController
-(UILabel *)timeLabel
{
    if (_timeLabel==nil) {
        _timeLabel=[[UILabel alloc] initWithFrame:CGRectMake(10*KWidth_Scale,CGRectGetMaxY(self.titleLabel.frame)+10*KWidth_Scale, SCREEN_WIDTH-20*KWidth_Scale, 15*KWidth_Scale)];
        _timeLabel.textColor=[PublicFunction colorWithHexString:@"666666"];
        _timeLabel.font=UIFont(13);
        _timeLabel.backgroundColor=[UIColor whiteColor];
    }
    return _timeLabel;
}
-(UILabel *)titleLabel
{
    if (_titleLabel==nil) {
        _titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(10*KWidth_Scale, 15*KWidth_Scale, SCREEN_WIDTH-20*KWidth_Scale, 15*KWidth_Scale)];
        _titleLabel.textColor=WordsofcolorColor;
        _titleLabel.font=UIFont(17);
        _titleLabel.text=self.modle.title;
        _titleLabel.backgroundColor=[UIColor whiteColor];
    }
    return _titleLabel;
}
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
    self.progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0,0, [[UIScreen mainScreen] bounds].size.width, 1.0)];
    self.progressView.backgroundColor = [UIColor blueColor];
    //设置进度条的高度，下面这句代码表示进度条的宽度变为原来的1倍，高度变为原来的1.5倍.
    self.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.5f);
    [self.view addSubview:self.progressView];
    
    self.view.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.timeLabel];
    self.webview=[[UIWebView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.timeLabel.frame)+5, SCREEN_WIDTH, SCREEN_HEIGHT-StatusBarAndNavigationBarHeight-50*KWidth_Scale)];
    self.webview.delegate=self;
    [self.view addSubview:self.webview];
    self.webview.backgroundColor=[UIColor whiteColor];
    [self loadrequest];
    [self setnavigation];
    // Do any additional setup after loading the view.
}
-(void)setnavigation
{
    UIButton *  rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setImage:[UIImage imageNamed:@"fenxiang"]  forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(sharemyself) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.frame = CGRectMake(SCREEN_WIDTH, 25, 45, 45);
    [rightBtn setImageEdgeInsets:UIEdgeInsetsMake(7, 20, 7, 0)];
    UIBarButtonItem *right=[[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    UIButton *  trightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [trightBtn setTitle:@"玩游戏" forState:UIControlStateNormal];
    [trightBtn addTarget:self action:@selector(playgames) forControlEvents:UIControlEventTouchUpInside];
    trightBtn.frame = CGRectMake(SCREEN_WIDTH, 25, 45, 45);
    [trightBtn setImageEdgeInsets:UIEdgeInsetsMake(7, 20, 7, 0)];
    UIBarButtonItem *tright=[[UIBarButtonItem alloc] initWithCustomView:trightBtn];
 self.navigationItem.rightBarButtonItems=@[right];
}
-(void)playgames
{
    GameWooViewController *game=[[GameWooViewController alloc] init];
    [self.navigationController pushViewController:game animated:YES];
    return;
}
-(void)sharemyself
{
    Sharemangerview *share=[[Sharemangerview alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, ScreenHeight)withtype:shar_type_watch];
    [share setMyblock:^(NSInteger indexrow) {
        ZKLog(@"分享的第几个%ld",indexrow);
        SharePlatfrom mshareToPlatfrom;
        if (indexrow==0) {
            mshareToPlatfrom=share_QQFriend;
        }
        else if (indexrow==1){
            mshareToPlatfrom=share_Qzone;
        }
        else if (indexrow==2){
             mshareToPlatfrom=share_weChat;
        }
        else{
            mshareToPlatfrom=share_timeline;
        }
            [[ShareObject defaultShare] addShareImageUrl:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1535518551554&di=7873e6129333b20ffad2524c3149d570&imgtype=0&src=http%3A%2F%2Fs4.sinaimg.cn%2Fmw690%2F001sB7zxzy74flKL4FJb3%26690" shareText:@"我来自美国" shareTitle:@"我来自洗发膏" shareUrl:@"www.baidu.com"
                                    shareCompletionBlcok:^(SSDKResponseState state) {
                                        
                                    }];
            [[ShareObject defaultShare] shareToPlatfrom:mshareToPlatfrom fromecontroller:self ContentType:SSDKContentTypeWebPage];
    }];
    [share shareviewShow];
}
-(void)loadrequest
{
    WEAKSELF;
    NSMutableDictionary *parametDic = [NSMutableDictionary dictionaryWithCapacity:9];
    [parametDic setObject:[NSNumber numberWithInteger:self.modle.nId] forKey:@"nId"];
    [UserRequestToo shareInstance].rquesturl=getWatcdetailRequrl;
    [UserRequestToo shareInstance].params=parametDic;
     [self showhudmessage:@"页面据加载中..." offy:0];
    [[UserRequestToo shareInstance] statrrequestgetwith:MHAsiNetWorkGET successBlock:^(id returnData) {
        [weakSelf hideHud];
        //            [weakSelf showAlertHud:weakSelf.view.center withStr:@"已没有更多数据" offy:-100];
        //            return ;
        if (returnData[@"success"]) {
            NSDictionary *dic;
            if (returnData[@"data"]) {
            dic=returnData[@"data"];
                Watchobject *object=[[Watchobject alloc] init];
                if (dic) {
                    [object setValuesForKeysWithDictionary:dic];
                    self.selfobject=object;
                    [self.webview loadHTMLString:object.mainBody baseURL:nil];
                    self.titleLabel.text=object.title;
                    self.timeLabel.text=[NSString stringWithFormat:@"%@   %@   %@",object.userName,object.createTime,object.readNum];
                }
            }
            }
        else{
            [self showAlertHud:self.view.center withStr:@"数据获取失败" offy:-100];
        }
    } failureBlock:^(NSError *error) {
        [self hideHud];
        NSLog(@"%@",error);
    }];
    
}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
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
