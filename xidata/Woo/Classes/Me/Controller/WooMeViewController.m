//
//  WooMeViewController.m
//  Woo
//
//  Created by 风外杏林香 on 2018/7/25.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import "WooMeViewController.h"
#import "WooHeader.h"
#import "WooMeCell.h"
#import "WooInfoVC.h"
#import "GuanZhucontroller.h"
#import "WooPhotoView.h"
#import "GuanZhucontroller.h"
#import "WooLoginViewController.h"
#import "WooNoticeVC.h"
#import "Myshopingcontroller.h"
#import "MeHeadview.h"
#import "MycollectionController.h"
#import "SubscribeController.h"
#import "AboutViewController.h"
#import "MywalletController.h"
#import "MyworkController.h"

@interface WooMeViewController ()<UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UIPopoverControllerDelegate>

@property (nonatomic, strong)UITableView *dataTableView;
@property (strong, nonatomic) UIPopoverController *imagePickerPopover;
@property (nonatomic, strong)UIView *backgroundView;
@property (nonatomic, strong)UIView *whiteView;
@property (nonatomic, strong)NSMutableDictionary *dataDictionary;
@property (nonatomic, strong)NSMutableArray *titlearr;
@property (nonatomic, strong)NSMutableArray *imageearr;
@property (nonatomic, strong)UIButton *walletBtn;
@property (nonatomic, strong)UIButton *MyworkBtn;
@property (nonatomic, strong)UIButton *liveBtn;
@end

@implementation WooMeViewController
-(UIButton *)walletBtn
{
    if (_walletBtn==nil) {
        _walletBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _walletBtn.frame=CGRectMake(CGRectGetMaxX(self.MyworkBtn.frame),0, (SCREEN_WIDTH-70*KWidth_Scale)/3.0, 80*KWidth_Scale);
         [_walletBtn setImage:[UIImage imageNamed:@"logo_icon"] forState:UIControlStateNormal];
        [_walletBtn setTitle:@"我的钱包" forState:UIControlStateNormal];
        [_walletBtn setTitleColor:WordsofcolorColor forState:UIControlStateNormal];
        [_walletBtn.titleLabel setFont:UIFont(13)];
        [_walletBtn addTarget:self action:@selector(clickhead:) forControlEvents:UIControlEventTouchUpInside];
        _walletBtn.tag=3;
        _walletBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//使图片和文字水平居
        [_walletBtn setTitleEdgeInsets:UIEdgeInsetsMake(_walletBtn.imageView.frame.size.height+5*KWidth_Scale ,-_walletBtn.imageView.frame.size.width, 0.0,0.0)];//文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
        [_walletBtn setImageEdgeInsets:UIEdgeInsetsMake(-10*KWidth_Scale, 0.0,0.0, -_walletBtn.titleLabel.bounds.size.width)];//图片距离右边框距离减少图片的宽度，其它不边
    }
    return _walletBtn;
}
-(UIButton *)MyworkBtn
{
    if (_MyworkBtn==nil) {
        _MyworkBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _MyworkBtn.frame=CGRectMake(CGRectGetMaxX(self.liveBtn.frame),0, (SCREEN_WIDTH-70*KWidth_Scale)/3.0, 80*KWidth_Scale);
        [_MyworkBtn setImage:[UIImage imageNamed:@"logo_icon"] forState:UIControlStateNormal];
        [_MyworkBtn setTitle:@"我的作品" forState:UIControlStateNormal];
        [_MyworkBtn setTitleColor:WordsofcolorColor forState:UIControlStateNormal];
        [_MyworkBtn.titleLabel setFont:UIFont(13)];
        [_MyworkBtn addTarget:self action:@selector(clickhead:) forControlEvents:UIControlEventTouchUpInside];
        _MyworkBtn.tag=2;
        _MyworkBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//使图片和文字水平居
        [_MyworkBtn setTitleEdgeInsets:UIEdgeInsetsMake(_MyworkBtn.imageView.frame.size.height+5*KWidth_Scale ,-_MyworkBtn.imageView.frame.size.width, 0.0,0.0)];//文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
        [_MyworkBtn setImageEdgeInsets:UIEdgeInsetsMake(-10*KWidth_Scale, 0.0,0.0, -_MyworkBtn.titleLabel.bounds.size.width)];//图片距离右边框距离减少图片的宽度，其它不边
    }
    return _MyworkBtn;
}
-(UIButton *)liveBtn
{
    if (_liveBtn==nil) {
        _liveBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _liveBtn.frame=CGRectMake(35*KWidth_Scale,0, (SCREEN_WIDTH-70*KWidth_Scale)/3.0, 80*KWidth_Scale);
        _liveBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//使图片和文字水平居
        [_liveBtn setImage:[UIImage imageNamed:@"logo_icon"] forState:UIControlStateNormal];
        [_liveBtn setTitle:@"我的订阅" forState:UIControlStateNormal];
        [_liveBtn setTitleColor:WordsofcolorColor forState:UIControlStateNormal];
        [_liveBtn.titleLabel setFont:UIFont(13)];
        [_liveBtn addTarget:self action:@selector(clickhead:) forControlEvents:UIControlEventTouchUpInside];
        _liveBtn.tag=1;
        [_liveBtn setTitleEdgeInsets:UIEdgeInsetsMake(_liveBtn.imageView.frame.size.height+5*KWidth_Scale  ,-_liveBtn.imageView.frame.size.width, 0.0,0.0)];//文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
        [_liveBtn setImageEdgeInsets:UIEdgeInsetsMake(-10*KWidth_Scale , 0.0,0.0, -_liveBtn.titleLabel.bounds.size.width)];//图片距离右边框距离减少图片的宽度，其它不边
    }
    return _liveBtn;
}
-(void)clickhead:(UIButton *)sender
{
    if (sender.tag==1) {
        [self Subscribeview];
    }
    else if (sender.tag==2) {
        MyworkController *wallet=[[MyworkController alloc] init];
        [self.navigationController pushViewController:wallet animated:YES];
    }
    else{
        MywalletController *wallet=[[MywalletController alloc] init];
        [self.navigationController pushViewController:wallet animated:YES];
    }
}
-(NSMutableArray *)titlearr
{
    if (_titlearr==nil) {
        _titlearr=[[NSMutableArray alloc] init];
    }
    return _titlearr;
}
-(NSMutableArray *)imageearr
{
    if (_imageearr==nil) {
        _imageearr=[[NSMutableArray alloc] init];
    }
    return _imageearr;
}
- (NSMutableDictionary *)dataDictionary
{
    if (!_dataDictionary) {
        _dataDictionary = [NSMutableDictionary dictionary];
    }
    return _dataDictionary;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self requestURL];
}

- (UITableView *)dataTableView
{
    if (!_dataTableView) {
        _dataTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - StatusBarAndNavigationBarHeight - 150) style:(UITableViewStyleGrouped)];
        _dataTableView.separatorColor=CellBackgroundColor;
        _dataTableView.delegate = self;
        _dataTableView.dataSource = self;
        if (@available(iOS 11.0, *)) {
            //当有heightForHeader delegate时设置
            _dataTableView.estimatedSectionHeaderHeight = 0;
            //当有heightForFooter delegate时设置
            _dataTableView.estimatedSectionFooterHeight = 0;
        }
    }
    return _dataTableView;
}
- (void)viewDidLoad {
    self.isnosetfbackbtn=YES;
    [super viewDidLoad];
    //@"我的彩蛋",@"我的邀请码"
    NSArray *titleArr = @[@"我的购买",@"我的收藏",@"消息中心",@"关于我们"];
    [self.titlearr addObjectsFromArray:titleArr];
    UIImage *image1 = [UIImage imageNamed:@"caidan_Image"];
    UIImage *image2 = [UIImage imageNamed:@"yaoqingjiangli_Image"];
    UIImage *image3 = [UIImage imageNamed:@"erwei_Image"];
    UIImage *image4 = [UIImage imageNamed:@"tixing_Image"];
    UIImage *image5 = [UIImage imageNamed:@"tixing_Image"];
    [self.imageearr addObject:image1];
    [self.imageearr addObject:image2];
    [self.imageearr addObject:image3];
    [self.imageearr addObject:image4];
    [self.imageearr addObject:image5];
    // Do any additional setup after loading the view.
    self.navigationController.title = @"我的";
    [self.view addSubview:self.dataTableView];
    //[self initWithUI];
    [self inittableviewheadview];
}
-(void)inittableviewheadview
{
    WEAKSELF;
    MeHeadview *head=[[MeHeadview alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100*KWidth_Scale)];
    head.backgroundColor=[UIColor whiteColor];
    [self.dataTableView setTableHeaderView:head];
    [head setClickblock:^{
        WooInfoVC *guanzhu=[[WooInfoVC alloc] init];
        [weakSelf.navigationController pushViewController:guanzhu animated:YES];
    }];
    [head setGuanzhublock:^{
        GuanZhucontroller *guanzhu=[[GuanZhucontroller alloc] init];
        [weakSelf.navigationController pushViewController:guanzhu animated:YES];
    }];
    [head setFensiblock:^{
        GuanZhucontroller *guanzhu=[[GuanZhucontroller alloc] init];
        [weakSelf.navigationController pushViewController:guanzhu animated:YES];
    }];
}
- (void)initWithUI
{
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button.frame = CGRectMake(30, CGRectGetMaxY(self.dataTableView.frame) + 10, ScreenWidth - 60, 40);
    button.backgroundColor = UIColorFromRGB(0xff6400);
    button.layer.cornerRadius = 5;
    button.layer.masksToBounds = YES;
    [button setTitle:@"退出登录" forState:(UIControlStateNormal)];
    [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    button.titleLabel.font = UIFont(18);
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:button];
}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titlearr.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    WooMeCell *meCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (meCell == nil) {
        meCell = [[WooMeCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
    }
    meCell = [[WooMeCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
        meCell.label1.text = [NSString stringWithFormat:@"%@", self.titlearr[indexPath.row]];
        meCell.imageView1.image = [self.imageearr objectAtIndex:indexPath.row];
    meCell.selectionStyle = UITableViewCellSelectionStyleNone;
    meCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return meCell;
}
#pragma mark -- 上传头像
- (void)reloadIconWith:(UIImage *)image
{
    WEAKSELF;
    NSMutableDictionary *parametDic = [[NSMutableDictionary alloc] init];
    NSData *dataImage = UIImageJPEGRepresentation(image, 1.0);
    //生成签名
    [parametDic setValue:dataImage forKey:@"photoFile"];
    [parametDic setValue:[UserDefaults objectForKey:@"userId"] forKey:@"userId"];
    [self showWithStatus:@"头像上传中..."];
    WQUploadParam *loadimag=[[WQUploadParam alloc] init];
    loadimag.data=dataImage;
    loadimag.name=@"file";
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0),^{
        
        [AfnetHttpsTool uploadFileWithURL: ModifyUrl params:parametDic successBlock:^(id returnData) {
            ZKLog(@"returnData -- %@", returnData[@"message"]);
            [self dismiss];
            if ([returnData[@"success"] intValue] == 1) {
                ZKLog(@"上传成功");
                [PublicFunction showAlert:@"" message:@"上传成功"];
            } else {
                ZKLog(@"上传失败");
                [PublicFunction showAlert:@"" message:@"上传成功"];
            }
                
        } failureBlock:^(NSError *error) {
            [self dismiss];
            ZKLog(@" error -- %@", error);
            if (error) {
                return ;
            }
        } uploadParam:loadimag];
        
    });
}

#pragma mark -- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 90*KWidth_Scale;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headview=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80*KWidth_Scale)];
    headview.backgroundColor=[UIColor whiteColor];
     UIView *botomoview=[[UIView alloc] initWithFrame:CGRectMake(15*KWidth_Scale, 0, SCREEN_WIDTH-30*KWidth_Scale, 80*KWidth_Scale)];
    botomoview.backgroundColor=[UIColor lightGrayColor];
    botomoview.layer.cornerRadius=5;
    botomoview.clipsToBounds=YES;
    [headview addSubview:botomoview];
    [headview addSubview:self.liveBtn];
    [headview addSubview:self.MyworkBtn];
    [headview addSubview:self.walletBtn];
    return headview;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row==0) {
        [self Mypayview];
    }
    else if (indexPath.row==1){
        [self collectionview];
    }
    else if (indexPath.row==2)
    {
        [self NoticeVC];
    }
    else{
        [self AboutViewVC];
    }
}
#pragma mark 我的购买
-(void)Mypayview
{
    Myshopingcontroller *shoping=[[Myshopingcontroller alloc] init];
    [self.navigationController pushViewController:shoping animated:YES];
}
#pragma mark 我的收藏
-(void)collectionview{
    MycollectionController *shoping=[[MycollectionController alloc] init];
    [self.navigationController pushViewController:shoping animated:YES];
}
#pragma mark 我的订阅
-(void)Subscribeview{
    SubscribeController *shoping=[[SubscribeController alloc] init];
    [self.navigationController pushViewController:shoping animated:YES];
}
#pragma mark 消息中心
-(void)NoticeVC{
    WooNoticeVC *shoping=[[WooNoticeVC alloc] init];
    [self.navigationController pushViewController:shoping animated:YES];
}
#pragma mark 关于我们
-(void)AboutViewVC{
    AboutViewController *shoping=[[AboutViewController alloc] init];
    [self.navigationController pushViewController:shoping animated:YES];
}
- (void)buttonAction:(UIButton *)sender
{
    ZKLog(@"退出登录");
    [self initTuiChuView];
}

- (void)initTuiChuView
{
    self.backgroundView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.backgroundView.backgroundColor = [UIColor blackColor];
    self.backgroundView.alpha = 0.3;
    [self.view addSubview:self.backgroundView];
    
    self.whiteView = [[UIView alloc]initWithFrame:CGRectMake(40, 80, ScreenWidth - 80, 120)];
    self.whiteView.backgroundColor = [UIColor whiteColor];
    self.whiteView.layer.masksToBounds = YES;
    self.whiteView.layer.cornerRadius = 5;
    self.whiteView.center = CGPointMake(ScreenWidth / 2, ScreenHeight / 3);
    [self.view addSubview:self.whiteView];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, ScreenWidth - 80, 30)];
    label.text = @"真的要退出xidata么？";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = UIFont(15);
    [self.whiteView addSubview:label];
    
    CGFloat width = (ScreenWidth - 80 - 60) / 2;
    UIButton *button1 = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button1.frame = CGRectMake(20, CGRectGetMaxY(label.frame) + 20, width, 30);
    button1.backgroundColor = UIColorFromRGB(0xff6400);
    button1.layer.masksToBounds = YES;
    button1.layer.cornerRadius = 3;
    [button1 setTitle:@"再玩一会" forState:(UIControlStateNormal)];
    button1.titleLabel.font = UIFont(15);
    button1.tag = 1;
    [button1 addTarget:self action:@selector(tuiChuAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.whiteView addSubview:button1];
    
    UIButton *button2 = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button2.frame = CGRectMake(CGRectGetMaxX(button1.frame) + 20, CGRectGetMaxY(label.frame) + 20, width, 30);
    button2.layer.masksToBounds = YES;
    button2.layer.cornerRadius = 3;
    [button2 setTitle:@"狠心退出" forState:(UIControlStateNormal)];
    [button2 setTitleColor:RGB(102, 102, 102) forState:(UIControlStateNormal)];
    button2.titleLabel.font = UIFont(15);
    button2.tag = 2;
    [button2 addTarget:self action:@selector(tuiChuAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.whiteView addSubview:button2];
}

- (void)tuiChuAction:(UIButton *)sender
{
    switch (sender.tag) {
        case 1:
        {
            ZKLog(@"取消退出，不删除数据");
            [self.backgroundView removeFromSuperview];
            [self.whiteView removeFromSuperview];
        }
            break;
        case 2:
        {
            ZKLog(@"直接退出,并删除数据");
            [UserDefaults setObject:@"0" forKey:@"isLogin"];
            [UserDefaults setObject:@"" forKey:@"rcToken"];
            [UserDefaults setObject:@"" forKey:@"name"];
            [UserDefaults setObject:@"" forKey:@"photo"];
            [UserDefaults setObject:@"" forKey:@"uid"];
            [UserDefaults setObject:@"" forKey:@"name"];
            [UserDefaults setObject:@"" forKey:@"sex"];
            [UserDefaults setObject:@"" forKey:@"userId"];
            ZKLog(@"userId -- %@", [UserDefaults objectForKey:@"userId"]);
             [[RCDataBaseManager shareInstance] clearGroupsData];
             [[RCDataBaseManager shareInstance] clearFriendsData];
            WooLoginViewController *loginVC = [[WooLoginViewController alloc]init];
            [self presentViewController:loginVC animated:NO completion:nil];
            
        }
        default:
            break;
    }
}
- (void)requestURL
{
    if ([PublicFunction isEmpty:RCLOUD_ID]) {
        return;
    }
    WEAKSELF;
    [UserRequestToo shareInstance].rquesturl = UserUrl;
    NSString *userId = [UserDefaults objectForKey:@"userId"];
    [UserRequestToo shareInstance].params = @{@"userId" : userId};
    [[UserRequestToo shareInstance] statrrequestgetwith:(MHAsiNetWorkGET) successBlock:^(id returnData) {
        [self.dataTableView.mj_header endRefreshing];
        ZKLog(@"returnData -- %@", returnData);
        if ([returnData[@"success"] intValue] == 1) {
            if ([returnData[@"data"] count] > 0) {
                weakSelf.dataDictionary = [NSMutableDictionary dictionaryWithDictionary:returnData[@"data"]];
            }
            if (weakSelf.dataDictionary.count != 0) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf.dataTableView reloadData];
                });
            }
        } else {
            
        }
    } failureBlock:^(NSError *error) {
        [self.dataTableView.mj_header endRefreshing];
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
