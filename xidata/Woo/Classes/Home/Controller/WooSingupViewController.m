//
//  WooSingupViewController.m
//  Woo
//
//  Created by 风外杏林香 on 2018/8/24.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import "WooSingupViewController.h"
#import "SAPlayVideo.h"
#import "AppDelegate.h"
#import "WooSpotViewController.h"
#import "GameWooViewController.h"
#import "VideoWooViewController.h"
@interface WooSingupViewController ()<UIWebViewDelegate>
@property (nonatomic, strong)SAPlayVideo *player;
@property (nonatomic, strong)UIScrollView *mainScrollView;
@property (nonatomic, strong)UILabel *label1;
@property (nonatomic, strong)UILabel *label2;
@property (nonatomic, strong)UILabel *label3;
@property (nonatomic, strong)UILabel *label4;
@property (nonatomic, strong)UILabel *label5;
@property (nonatomic, strong)UILabel *label6;
@property (nonatomic, strong)UIButton *button1;
@property (nonatomic, copy)NSString *groupid;
@property (nonatomic, copy)NSString *groupname;
@property (nonatomic, strong)UIImageView *imageView3;

@property (nonatomic, strong) ZFPlayerController *player1;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) ZFPlayerControlView *controlView;
@property (nonatomic, strong) UIButton *playBtn;
@property (nonatomic, strong) UIButton *thplayBtn;
@property(nonatomic,copy)NSString *playurl;
@property(nonatomic,copy)NSString *sharetitle;
@property (nonatomic, strong)ZFAVPlayerManager *playerManager;
@property(nonatomic,strong)UIWebView *webview;
@end

@implementation WooSingupViewController
-(UIButton *)thplayBtn
{
    if (_thplayBtn==nil) {
        _thplayBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _thplayBtn.frame=CGRectMake(0, 0, 48*KWidth_Scale, 48*KWidth_Scale*KWidth_Scale);
        [_thplayBtn setImage:[UIImage imageNamed:@"play_icon"] forState:UIControlStateNormal];
        [_thplayBtn setImageEdgeInsets:UIEdgeInsetsMake(4*KWidth_Scale, 4*KWidth_Scale, 4*KWidth_Scale, 4*KWidth_Scale)];
        [_thplayBtn addTarget:self action:@selector(pushzhibo) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _thplayBtn;
}
-(void)pushzhibo
{
    VideoWooViewController *woo=[[VideoWooViewController alloc] init];
    woo.urlstr=self.playurl;
    [self presentViewController:woo animated:YES completion:^{
        
    }];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleLightContent;
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
     [self.navigationController setNavigationBarHidden:NO animated:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self initWithUI];
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.allowRotation = 1;
    
    [self initWithBottomView];
    [self requestURL];
    
    if (IsPortrait) {
        [self initWithScrollView];
    }
}

- (void)initWithScrollView
{
    self.mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.containerView.frame), ScreenWidth, ScreenHeight - CGRectGetHeight(self.containerView.frame) - TabbarSafeBottomMargin - 50 - StatusBarHeight)];
    self.mainScrollView.backgroundColor = [UIColor whiteColor];
    self.mainScrollView.contentSize = CGSizeMake(ScreenWidth, ScreenHeight);
    [self.view addSubview:self.mainScrollView];
    
    self.label1 = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, ScreenWidth - 40, 30)];
    self.label1.textAlignment = NSTextAlignmentLeft;
    self.label1.font = UIFont(18);
//    self.label1.backgroundColor = [UIColor redColor];
    [self.mainScrollView addSubview:self.label1];
    
    self.label2 = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(self.label1.frame), ScreenWidth - 40, 30)];
    self.label2.textAlignment = NSTextAlignmentLeft;
    self.label2.font = UIFont(11);
//    self.label2.backgroundColor = [UIColor redColor];
    [self.mainScrollView addSubview:self.label2];
    
    self.label3 = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(self.label2.frame), ScreenWidth - 40, 30)];
    self.label3.textAlignment = NSTextAlignmentLeft;
    self.label3.font = UIFont(11);
//    self.label3.backgroundColor = [UIColor redColor];
    [self.mainScrollView addSubview:self.label3];
    
    UIImageView *imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(self.label3.frame) + 8, 15, 15)];
    imageView1.image = [UIImage imageNamed:@"time_Image"];
    [self.mainScrollView addSubview:imageView1];
    
    self.label4 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imageView1.frame) + 5, CGRectGetMaxY(self.label3.frame), ScreenWidth - 40 - 20, 30)];
    self.label4.textAlignment = NSTextAlignmentLeft;
    self.label4.font = UIFont(11);
//    self.label4.backgroundColor = [UIColor redColor];
    [self.mainScrollView addSubview:self.label4];
    
    UIImageView *imageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(self.label4.frame) + 8, 15, 15)];
    imageView2.image = [UIImage imageNamed:@"location_Image"];
    [self.mainScrollView addSubview:imageView2];
    
    self.button1 = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.button1.frame = CGRectMake(CGRectGetMinX(self.label4.frame), CGRectGetMaxY(self.label4.frame), ScreenWidth - 40 - 20 - 50, 30);
    self.button1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.button1.titleLabel.font = UIFont(11);
//    self.button1.backgroundColor = [UIColor redColor];
    self.button1.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self.button1 setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [self.button1 addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    self.button1.tag = 4;
    [self.button1 setTitleColor:RGB(29, 173, 245) forState:(UIControlStateNormal)];
    [self.mainScrollView addSubview:self.button1];
    
    self.imageView3 = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.button1.frame), CGRectGetMinY(self.button1.frame) + 5, 20, 20)];
    self.imageView3.image = [UIImage imageNamed:@"map_Image"];
    [self.mainScrollView addSubview:self.imageView3];
    
    UIImageView *imageView4 = [[UIImageView alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(self.button1.frame) + 8, 15, 15)];
    imageView4.image = [UIImage imageNamed:@"shoufei_Image"];
    [self.mainScrollView addSubview:imageView4];
    
    self.label5 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.label4.frame), CGRectGetMaxY(self.button1.frame), ScreenWidth - 40 - 20, 30)];
    self.label5.textAlignment = NSTextAlignmentLeft;
    self.label5.font = UIFont(11);
//    self.label5.backgroundColor = [UIColor redColor];
    [self.mainScrollView addSubview:self.label5];
    
    
    
    self.label6 = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(self.label5.frame), ScreenWidth - 30, 60)];
//    self.label6.textAlignment = NSTextAlignmentLeft;
    self.label6.font = UIFont(15);
//    self.label6.backgroundColor = [UIColor redColor];
    self.label6.numberOfLines = 0;
    [self.mainScrollView addSubview:self.label6];
}

- (void)relodLabel:(NSDictionary *)dict
{
    self.groupid=dict[@"crewCid"];
    self.groupname=dict[@"mName"];
    self.label1.text = [NSString stringWithFormat:@"%@", dict[@"mName"]];
    self.label2.text = [NSString stringWithFormat:@"主办方：%@", dict[@""]];
    self.label3.text = [NSString stringWithFormat:@"浏览数：%@   报名数：%@", dict[@"mPageview"], dict[@"mApplicantcount"]];
    self.label4.text = [NSString stringWithFormat:@"%@", dict[@"mStarttime"]];
    [self.button1 setTitle:[NSString stringWithFormat:@"%@", dict[@"mAddress"]] forState:(UIControlStateNormal)];
    
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:11]};
    CGSize sizeWidth = [self.button1.titleLabel.text boundingRectWithSize:CGSizeMake(360, MAXFLOAT) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    ZKLog(@"size -- %.f", sizeWidth.width);
    self.imageView3.frame = CGRectMake(45 + sizeWidth.width, CGRectGetMinY(self.button1.frame) + 5, 20, 20);
    if ([dict[@"mPrice"] intValue] > 0) {
        self.label5.text = [NSString stringWithFormat:@"%@", dict[@"mPrice"]];
    } else {
        self.label5.text = @"免费";
    }
    
    NSString *contentStr=[NSString stringWithFormat:@"%@", dict[@"mDesc"]];
    CGSize size = [contentStr boundingRectWithSize:CGSizeMake(ScreenWidth - 30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:15.0] forKey:NSFontAttributeName] context:nil].size;
    self.label6.text = contentStr;
    self.label6.frame = CGRectMake(20, CGRectGetMaxY(self.label5.frame), ScreenWidth - 30, size.height);
    self.mainScrollView.contentSize = CGSizeMake(ScreenWidth, 180 + size.height);
    self.sharetitle=dict[@"mName"];
    NSString *urlstr=@"www";
    if ([dict[@"mVideo"] rangeOfString:urlstr].location != NSNotFound) {
        self.thplayBtn.center=self.playBtn.center;
        self.playurl=dict[@"mVideo"];
        [self.containerView addSubview:self.thplayBtn];
        return;
    }
    if ([dict[@"mVideo"] length] > 0) {
        self.playerManager.assetURL = [NSURL URLWithString:dict[@"mVideo"]];
    } else {
        NSString *URLString =[@"http://ivi.bupt.edu.cn/hls/cctv6hd.m3u8" stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        self.playerManager.assetURL = [NSURL URLWithString:URLString];
    }

    
}
- (void)requestURL
{
    WEAKSELF;
    [self showhudmessage:@"数据加载中..." offy:-100];
    [UserRequestToo shareInstance].rquesturl = HomeMeetingDetailUrl;
    [UserRequestToo shareInstance].params = @{@"mId" : self.mId};
    [[UserRequestToo shareInstance] statrrequestgetwith:(MHAsiNetWorkGET) successBlock:^(id returnData) {
        [weakSelf hideHud];
        ZKLog(@"returnData -- %@", returnData);
        if ([returnData[@"success"] intValue] == 1) {
            if ([returnData[@"data"] isKindOfClass:[NSDictionary class]]) {
              [weakSelf relodLabel:returnData[@"data"]];
            }
            
        } else {
            
        }
    } failureBlock:^(NSError *error) {
        [weakSelf hideHud];
    }];
}

#pragma mark -- 分享事件
- (void)shareAction
{
    Sharemangerview *share=[[Sharemangerview alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, ScreenHeight) withtype:shar_type_watch];
    [share setMyblock:^(NSInteger indexrow) {
        SharePlatfrom  mshareToPlatfrom;
        if (indexrow==0) {
            mshareToPlatfrom=share_QQFriend;
        }
        else if (indexrow==1){
            mshareToPlatfrom=share_Qzone;
        }
        else if (indexrow==2){
            mshareToPlatfrom=share_weChat;
        }
        else {
            mshareToPlatfrom=share_timeline;
        }
        NSString *shareurl=@"http://ivi.bupt.edu.cn/hls/cctv6hd.m3u8";
        if (self.playurl.length!=0) {
            shareurl=self.playurl;
        }
        [[ShareObject defaultShare] addShareImageUrl:@"http://47.92.53.135:8080/meeting/20180907/d8d53dd600d04628a23dfdcc3c77db46.jpg" shareText: self.sharetitle shareTitle:WOWOInvitationCode shareUrl:shareurl shareCompletionBlcok:^(SSDKResponseState state) {
                                    
        }];
        [[ShareObject defaultShare] shareToPlatfrom:mshareToPlatfrom fromecontroller:self ContentType:SSDKContentTypeWebPage];
    }];
    [share shareviewShow];
}
- (void)initWithUI
{
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, StatusBarHeight)];
    view1.backgroundColor = [UIColor blackColor];
    [self.view addSubview:view1];
    
    self.containerView = [UIView new];
    self.containerView.backgroundColor = [UIColor whiteColor];
    self.controlView = [ZFPlayerControlView new];
    self.playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.playBtn setImage:[UIImage imageNamed:@"new_allPlay_44x44_"] forState:UIControlStateNormal];
    CGFloat x = 0;
    CGFloat y = StatusBarHeight;
    CGFloat w = CGRectGetWidth(self.view.frame);
    CGFloat h = w*9/16;
    self.containerView.frame = CGRectMake(x, y, w, h);
    
    w = 200;
    h = 35;
    x = (self.containerView.frame.size.width - w)/2;
    y = (self.containerView.frame.size.height - h)/2;
    
    w = 44;
    h = w;
    x = (CGRectGetWidth(self.containerView.frame)-w)/2;
    y = (CGRectGetHeight(self.containerView.frame)-h)/2;
    self.playBtn.frame = CGRectMake(x, y, w, h);
    [self.view addSubview:self.containerView];
    [self.containerView addSubview:self.playBtn];
    
    self.playerManager = [[ZFAVPlayerManager alloc] init];
    /// 播放器相关
    self.player1 = [[ZFPlayerController alloc] initWithPlayerManager:self.playerManager containerView:self.containerView];
    
    self.player1.controlView = self.controlView;
    @weakify(self)
    self.player1.orientationWillChange = ^(ZFPlayerController * _Nonnull player, BOOL isFullScreen) {
        @strongify(self)
        [self setNeedsStatusBarAppearanceUpdate];
    };
    //NSString *URLString = [@"http://47.92.53.135:8080/video/20180902/e4daa10b4d9a4f079415518c68408ab3.mp4" stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    //self.playerManager.assetURL = [NSURL URLWithString:URLString];

    UIButton *btn1 = [UIButton buttonWithType:(UIButtonTypeCustom)];
    btn1.frame = CGRectMake(20, StatusBarHeight, 40, 40);
//    btn1.backgroundColor = [UIColor redColor];
    [btn1 setImage:[UIImage imageNamed:@"playBack_Image"] forState:(UIControlStateNormal)];
    [btn1 addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    btn1.tag = 5;
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [UIButton buttonWithType:(UIButtonTypeCustom)];
    btn2.frame = CGRectMake(ScreenWidth - 55, StatusBarHeight, 35, 35);
    [btn2 setImage:[UIImage imageNamed:@"fenxiang"] forState:(UIControlStateNormal)];
    [btn2 addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    btn2.tag = 110;
    [self.view addSubview:btn2];
    
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    if (self.player1.isFullScreen) {
        return UIStatusBarStyleLightContent;
    }
    return UIStatusBarStyleDefault;
}

- (BOOL)prefersStatusBarHidden {
    return self.player1.isStatusBarHidden;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationSlide;
}

- (BOOL)shouldAutorotate {
    return self.player1.shouldAutorotate;
}

- (void)initWithBottomView
{
    UIView *diView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight - 50 - TabbarSafeBottomMargin, ScreenWidth, 50)];
    diView.backgroundColor = RGB(240, 240, 240);
    diView.userInteractionEnabled = YES;
    [self.view addSubview:diView];
    
    CGFloat width = ScreenWidth / 3;
    UIButton *button1 = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button1.frame = CGRectMake(ScreenWidth - width, 0, width, 50);
    button1.backgroundColor = RGB(255, 101, 0);
    [button1 setTitle:@"去现场" forState:(UIControlStateNormal)];
    [button1 setImage:[UIImage imageNamed:@"baoming_Image"] forState:(UIControlStateNormal)];
    button1.titleLabel.font = UIFont(15);
    [button1 setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [button1 addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    button1.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    button1.tag = 1;
    [diView addSubview:button1];
    
    UIButton *button2 = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button2.frame = CGRectMake(0, 0, width, 50);
    [button2 setTitle:@"玩彩蛋" forState:(UIControlStateNormal)];
    button2.titleLabel.font = UIFont(15);
    [button2 setTitleColor:RGB(255, 101, 0) forState:(UIControlStateNormal)];
    [button2 addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [button2 setImage:[UIImage imageNamed:@"zhuzhu_Image"] forState:(UIControlStateNormal)];
    button2.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    button2.tag = 2;
    //[diView addSubview:button2];
    
    UIButton *button3 = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button3.frame = CGRectMake(0, 0, width, 50);
    [button3 setTitle:@"社群" forState:(UIControlStateNormal)];
    button3.titleLabel.font = UIFont(15);
    [button3 setTitleColor:RGB(255, 101, 0) forState:(UIControlStateNormal)];
    [button3 addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [button3 setImage:[UIImage imageNamed:@"shequn_Image"] forState:(UIControlStateNormal)];
    button3.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    button3.tag = 3;
    [diView addSubview:button3];
}

- (void)buttonAction:(UIButton *)sender
{

    switch (sender.tag) {
        case 1:
        {
            NSLog(@"报名");
            [self.playerManager pause];
            WooSpotViewController *spotVC = [[WooSpotViewController alloc]init];
            spotVC.meetingId = self.mId;
            [self.navigationController pushViewController:spotVC animated:YES];
        }
            break;
        case 2:
        {
            [self.playerManager pause];
           // [self playgames];
            NSLog(@"彩蛋");
        }
            break;
        case 3:
        {
            [self.playerManager pause];
            [self sendjosingroupid:self.groupid];
            NSLog(@"社群");
        }
            break;
        case 4:
        {
            NSLog(@"定位地址");
            [self.playerManager pause];
            ZKLog(@"%@",sender.titleLabel.text);
            [self goToLocation:sender.titleLabel.text];
        }
            break;
        case 5:
        {
            [self.playerManager stop];
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
        case 110:
        {
            ZKLog(@"分享");
            [self shareAction];
        }
        default:
            break;
    }
}
#pragma mark -- 百度地图
- (void)goToLocation:(NSString *)str
{
    NSString *oreillyAddress = [NSString stringWithFormat:@"%@", str];
    CLGeocoder *myGeocoder = [[CLGeocoder alloc] init];
    [myGeocoder geocodeAddressString:oreillyAddress completionHandler:^(NSArray *placemarks, NSError *error) {
        if ([placemarks count] > 0 && error == nil) {
            CLPlacemark *firstPlacemark = [placemarks objectAtIndex:0];
            NSLog(@"Longitude = %f", firstPlacemark.location.coordinate.longitude);
            NSLog(@"Latitude = %f", firstPlacemark.location.coordinate.latitude);
            NSString *urlString = [[NSString stringWithFormat:@"baidumap://map/direction?origin={{我的位置}}&destination=latlng:%f,%f|name=目的地&mode=driving&coord_type=gcj02",firstPlacemark.location.coordinate.latitude, firstPlacemark.location.coordinate.longitude] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
          
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:urlString]]) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
            }
            //if( [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]])
            else {
            NSString *gurlString = [[NSString stringWithFormat:@"iosamap://path?sourceApplication=%@&sid=BGVIS1&did=BGVIS2&dlat=%f&dlon=%f&dname=%@&dev=0&t=2",@"WOWO",firstPlacemark.location.coordinate.latitude,firstPlacemark.location.coordinate.longitude,str] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:gurlString]];
            }

        } else if ([placemarks count] == 0 && error == nil) {
            ZKLog(@"Found no placemarks.");
        } else if (error != nil) {
            ZKLog(@"An error occurred = %@", error);
        }
    }];
}
-(void)playgames
{
    GameWooViewController *game=[[GameWooViewController alloc] init];
    [self.navigationController pushViewController:game animated:YES];
    game.meetid=self.mId;
    return;
}
-(void)sendjosingroupid:(NSString *)group
{
  RCDGroupInfo *info = [[RCDataBaseManager shareInstance] getGroupByGroupId:group];
    if (info.groupId.length!=0) {
        [[ChatmangerObject ShareManger] gotoChatViewtargetid:self.groupid convertitle:info.groupName conversationModelType:ConversationType_GROUP fromview:self info:nil];
        return;
    }
    [self showhudmessage:@"申请处理中..." offy:-100];
    NSMutableDictionary *parametDic = [NSMutableDictionary dictionaryWithCapacity:9];
    [parametDic setObject:RCLOUD_ID forKey:@"userId"];
    [parametDic setObject:group forKey:@"crewId"];
    [parametDic setObject:@"我想要进群" forKey:@"content"];
    [UserRequestToo shareInstance].rquesturl=SendJoinGroupRequrl;
    [UserRequestToo shareInstance].params=parametDic;
    [[UserRequestToo shareInstance] statrrequestgetwith:MHAsiNetWorkPOST successBlock:^(id returnData) {
        [self hideHud];
        if (returnData[@"success"]) {
            if([returnData[@"status"] isEqualToString:@"200"]) {
                RCDGroupInfo *groups=[[RCDGroupInfo alloc] init];
                NSDictionary *dic = returnData[@"data"];
                groups.introduce=dic[@"brief"];
                groups.portraitUri=dic[@"photo"];
                groups.groupId=dic[@"cid"];
                groups.groupName=dic[@"name"];
                groups.creatorId=dic[@"uid"];
                groups.creatorTime=dic[@"createTime"];
                groups.number=[NSString stringWithFormat:@"%@",dic[@"num"]];
                groups.qrcode=dic[@"qrcode"];
                groups.pub= [NSString stringWithFormat:@"%@",dic[@"pub"]];
                if ([dic[@"isCrewMember"] isEqual:@1]) {
                    groups.isCrewMember=YES;
                    [[NSNotificationCenter defaultCenter] postNotificationName:UPDATE_GROUP_FRIEND object:nil];
                }
                    [[ChatmangerObject ShareManger] gotoChatViewtargetid:self.groupid convertitle:groups.groupName conversationModelType:ConversationType_GROUP fromview:self info:nil];
        }
        else if ([returnData[@"status"] isEqualToString:@"2105"])
        {
            [[ChatmangerObject ShareManger] gotoChatViewtargetid:self.groupid convertitle:self.groupname conversationModelType:ConversationType_GROUP fromview:self info:nil];
        }
    }
    } failureBlock:^(NSError *error) {
        [self showAlertHud:self.view.center withStr:@"申请发送失败" offy:-100];
        [self hideHud];
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
