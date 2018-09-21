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
@interface WooSingupViewController ()
@property (nonatomic, strong)SAPlayVideo *player;
@property (nonatomic, strong)UIScrollView *mainScrollView;
@property (nonatomic, strong)UILabel *label1;
@property (nonatomic, strong)UILabel *label2;
@property (nonatomic, strong)UILabel *label3;
@property (nonatomic, strong)UILabel *label4;
@property (nonatomic, strong)UILabel *label5;
@property (nonatomic, strong)UILabel *label6;
@property (nonatomic, strong)UIButton *button1;

@end

@implementation WooSingupViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
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
    self.mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.player.frame), ScreenWidth, ScreenHeight - CGRectGetHeight(self.player.frame) - TabbarSafeBottomMargin - 50 - StatusBarHeight)];
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
    [self.mainScrollView addSubview:self.button1];
    
    UIImageView *imageView3 = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.button1.frame), CGRectGetMinY(self.button1.frame) + 5, 20, 20)];
    imageView3.image = [UIImage imageNamed:@"map_Image"];
    [self.mainScrollView addSubview:imageView3];
    
    UIImageView *imageView4 = [[UIImageView alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(self.button1.frame) + 8, 15, 15)];
    imageView4.image = [UIImage imageNamed:@"shoufei_Image"];
    [self.mainScrollView addSubview:imageView4];
    
    self.label5 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.label4.frame), CGRectGetMaxY(self.button1.frame), ScreenWidth - 40 - 20, 30)];
    self.label5.textAlignment = NSTextAlignmentLeft;
    self.label5.font = UIFont(11);
//    self.label5.backgroundColor = [UIColor redColor];
    [self.mainScrollView addSubview:self.label5];
    
    
    
    self.label6 = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(self.label5.frame), ScreenWidth - 40, 60)];
    self.label6.textAlignment = NSTextAlignmentLeft;
    self.label6.font = UIFont(15);
//    self.label6.backgroundColor = [UIColor redColor];
    self.label6.numberOfLines = 0;
    [self.mainScrollView addSubview:self.label6];
    
    

}

- (void)relodLabel:(NSDictionary *)dict
{
    self.label1.text = [NSString stringWithFormat:@"%@", dict[@"mName"]];
    self.label2.text = [NSString stringWithFormat:@"主办方：%@", dict[@""]];
    self.label3.text = [NSString stringWithFormat:@"浏览数：%@   报名数：%@", dict[@"mPageview"], dict[@"mApplicantcount"]];
    self.label4.text = [NSString stringWithFormat:@"%@", dict[@"mStarttime"]];
    [self.button1 setTitle:[NSString stringWithFormat:@"%@", dict[@"mAddress"]] forState:(UIControlStateNormal)];
    self.label5.text = [NSString stringWithFormat:@"%@", dict[@"mPrice"]];
    NSDictionary *dict110 = @{NSFontAttributeName : [UIFont systemFontOfSize:13.0]};
    NSString *contentStr=@"今天天气不错呢，准备到中国参加耐克的活动，中国的球迷准备好了吗？明天早上八点五棵松体育馆见，我爱你们！今天天气不错呢，准备到中国参加耐克的活动，中国的球迷准备好了吗？明天早上八点五棵松体育馆见，我爱你们！今天天气不错呢，准备到中国参加耐克的活动，中国的球迷准备好了吗？明天早上八点五棵松体育馆见，我爱你们！今天天气不错呢，准备到中国参加耐克的活动，中国的球迷准备好了吗？明天早上八点五棵松体育馆见，我爱你们！今天天气不错呢，准备到中国参加耐克的活动，中国的球迷准备好了吗？明天早上八点五棵松体育馆见，我爱你们！今天天气不错呢，准备到中国参加耐克的活动，中国的球迷准备好了吗？明天早上八点五棵松体育馆见，我爱你们！";
    CGSize size = [contentStr boundingRectWithSize:CGSizeMake(200, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict110 context:nil].size;
    self.label6.text = contentStr;
    self.label6.frame = CGRectMake(20, CGRectGetMaxY(self.label5.frame), ScreenWidth - 40, size.height);
//    self.mainScrollView.contentSize = CGSizeMake(ScreenWidth, ScreenHeight + size.height + 20 - 200);
    self.player.videoUrlStr = [NSString stringWithFormat:@"%@", dict[@"mVideo"]];
//    self.player.videoUrlStr = @"http://220.249.115.46:18080/wav/no.9.mp4";
}
- (void)requestURL
{
    WEAKSELF;
    [self showhudmessage:@"数据加载中..." offy:-100];
    [UserRequestToo shareInstance].rquesturl = HomeMeetingDetailUrl;
    [UserRequestToo shareInstance].params = @{@"mId" : self.mId};
    [[UserRequestToo shareInstance] statrrequestgetwith:(MHAsiNetWorkGET) successBlock:^(id returnData) {
        [weakSelf hideHud];
        NSLog(@"returnData -- %@", returnData);
        if ([returnData[@"success"] intValue] == 1) {
            [weakSelf relodLabel:returnData[@"data"]];
            
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
        ZKLog(@"分享的第几个%ld",indexrow);
    }];
    [share shareviewShow];
}
- (void)initWithUI
{
    WEAKSELF;
    self.player = [[SAPlayVideo alloc]initWithFrame:CGRectMake(0, StatusBarHeight, ScreenWidth, 200)];
    self.player.backgroundColor = [UIColor blackColor];
//    self.player.videoUrlStr = @"http://220.249.115.46:18080/wav/no.9.mp4";//此处只能真机测试
    self.player.ButtonAction = ^(UIButton *backBtn) {
        NSLog(@"backBtn -- %ld", backBtn.tag);
        if (backBtn.tag == 110) {
            NSLog(@"分享");
            [weakSelf shareAction];
        } else if (backBtn.tag == 1){
            NSLog(@"横竖屏");
            UIInterfaceOrientation sataus = [UIApplication sharedApplication].statusBarOrientation;
            NSLog(@"status -- %ld", (long)sataus);
            if (!IsPortrait) {
                weakSelf.mainScrollView.hidden = YES;
            } else {
                weakSelf.mainScrollView.hidden = NO;
            }
        } else if (backBtn.tag == 2){
            if (!IsPortrait) {
                weakSelf.mainScrollView.hidden = YES;
            } else {
                weakSelf.mainScrollView.hidden = NO;
            }
            if (IsPortrait) {
                [weakSelf.navigationController popToRootViewControllerAnimated:YES];
            }
        } else {
            
        }
    };
    [self.view addSubview:self.player];
    
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
    [diView addSubview:button2];
    
    UIButton *button3 = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button3.frame = CGRectMake(CGRectGetMaxX(button2.frame), 0, width, 50);
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
            WooSpotViewController *spotVC = [[WooSpotViewController alloc]init];
            [self.navigationController pushViewController:spotVC animated:YES];
        }
            break;
        case 2:
        {
            NSLog(@"彩蛋");
        }
            break;
        case 3:
        {
            NSLog(@"社群");
        }
            break;
        case 4:
        {
            NSLog(@"定位地址");
        }
            break;
        default:
            break;
    }
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
