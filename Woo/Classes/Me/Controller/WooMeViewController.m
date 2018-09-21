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
#import "WooErWeiMaView.h"
#import "WooPhotoView.h"
#import "WooYaoQingVC.h"
#import "WooLoginViewController.h"
@interface WooMeViewController ()<UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UIPopoverControllerDelegate>

@property (nonatomic, strong)UITableView *dataTableView;
@property (strong, nonatomic) UIPopoverController *imagePickerPopover;
@property (nonatomic, strong)UIView *backgroundView;
@property (nonatomic, strong)UIView *whiteView;
@property (nonatomic, strong)NSMutableDictionary *dataDictionary;


@end

@implementation WooMeViewController

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
//    [self.navigationController.navigationBar removeFromSuperview];
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
    // Do any additional setup after loading the view.
    self.navigationController.title = @"我的";
    [self.view addSubview:self.dataTableView];
    [self initWithUI];
    WEAKSELF;
    self.dataTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (self.dataDictionary.count > 0) {
            [self.dataDictionary removeAllObjects];
        }
        [weakSelf requestURL];
    }];
    [self.dataTableView.mj_header beginRefreshing];
    
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
    if (section == 0) {
        return 1;
    } else
        return 4;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
    }
    WooMeCell *meCell = [[WooMeCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
    NSArray *titleArr = @[@"我的彩蛋", @"我的邀请码", @"我的二维码", @"消息提醒"];
    UIImage *image1 = [UIImage imageNamed:@"caidan_Image"];
    UIImage *image2 = [UIImage imageNamed:@"yaoqingjiangli_Image"];
    UIImage *image3 = [UIImage imageNamed:@"erwei_Image"];
    UIImage *image4 = [UIImage imageNamed:@"tixing_Image"];
    NSArray *imageArr = [NSArray arrayWithObjects:image1, image2, image3, image4, nil];
    
    if (indexPath.section == 0) {
//        meCell.label1.text = @"一个测试账号";
        meCell.label1.text = [NSString stringWithFormat:@"%@", self.dataDictionary[@"name"]];
        meCell.label2.hidden = YES;
        meCell.imageView1.backgroundColor = RGB(220, 221, 222);
        meCell.imageView1.frame = CGRectMake(20, 10, 60, 60);
        meCell.label1.frame = CGRectMake(CGRectGetMaxX(meCell.imageView1.frame) + 10, 10, 100, 60);
        meCell.imageView1.userInteractionEnabled = YES;
        [meCell.imageView1 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", [self.dataDictionary objectForKey:@"photo"]]] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            
        }];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        [meCell.imageView1 addGestureRecognizer:tap];
    } else if (indexPath.section == 1) {
        meCell.label1.text = [NSString stringWithFormat:@"%@", titleArr[indexPath.row]];
        meCell.imageView1.image = [imageArr objectAtIndex:indexPath.row];
        if (indexPath.row != 0) {
            meCell.label2.hidden = YES;
        } else {
            meCell.label2.hidden = NO;
        }
    }
    meCell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell = meCell;
    return cell;
}

#pragma mark -- 上传图片事件
- (void)tapAction:(UITapGestureRecognizer *)sender
{
    ZKLog(@"上传图片");
    WooPhotoView *photoView = [[WooPhotoView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - StatusBarAndNavigationBarHeight - TabbarHeight - 10)];
    
    if ([self.imagePickerPopover isPopoverVisible]) {
        [self.imagePickerPopover dismissPopoverAnimated:YES];
        self.imagePickerPopover = nil;
        return;
    }
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.editing = YES;
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    photoView.buttonAction = ^(NSInteger btnTag) {
        ZKLog(@"tag -- %ld", btnTag);
        UIButton *button = (UIButton *)[photoView viewWithTag:btnTag];
        switch (btnTag) {
            case 1:
            {
                ZKLog(@"相机");
                imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                //创建UIPopoverController对象前先检查当前设备是不是ipad
                if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
                    self.imagePickerPopover = [[UIPopoverController alloc] initWithContentViewController:imagePicker];
                    self.imagePickerPopover.delegate = self;
                    [self.imagePickerPopover presentPopoverFromBarButtonItem:button
                                                    permittedArrowDirections:UIPopoverArrowDirectionAny
                                                                    animated:YES];
                }else{
                    
                    [self presentViewController:imagePicker animated:YES completion:nil];
                }
            }
                break;
            case 2:
            {
                ZKLog(@"相册");
                imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                //创建UIPopoverController对象前先检查当前设备是不是ipad
                if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
                    self.imagePickerPopover = [[UIPopoverController alloc] initWithContentViewController:imagePicker];
                    self.imagePickerPopover.delegate = self;
                    [self.imagePickerPopover presentPopoverFromBarButtonItem:button
                                                    permittedArrowDirections:UIPopoverArrowDirectionAny
                                                                    animated:YES];
                }else{
                    [self presentViewController:imagePicker animated:YES completion:nil];
                }
            }
                break;
            default:
                break;
        }
    };
    [self.view addSubview:photoView];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //通过info字典获取选择的照片
    UIImage *image = [info valueForKey:UIImagePickerControllerEditedImage];
    ZKLog(@"image -- %@", image);
    //把一张照片保存到图库中，此时无论是这张照片是照相机拍的还是本身从图库中取出的，都会保存到图库中；
    UIImageWriteToSavedPhotosAlbum(image, self, nil, nil);
    //压缩图片,如果图片要上传到服务器或者网络，则需要执行该步骤（压缩），第二个参数是压缩比例，转化为NSData类型；
    //    NSData *fileData = UIImageJPEGRepresentation(image, 1.0);
    [self reloadIconWith:image];
    //    [self uploadPhotoAndController:self WithSize:CGSizeMake(50, 50) Image:image AndFinish:nil];
    //判断UIPopoverController对象是否存在
    if (self.imagePickerPopover) {
        [self.imagePickerPopover dismissPopoverAnimated:YES];
        self.imagePickerPopover = nil;
    }else{
        //关闭以模态形式显示的UIImagePickerController
        [self dismissViewControllerAnimated:YES completion:nil];
    }
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
    WQUploadParam *loadimag=[[WQUploadParam alloc] init];
    loadimag.data=dataImage;
    loadimag.name=@"file";
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0),^{
        
        [AfnetHttpsTool uploadFileWithURL: ModifyUrl params:parametDic successBlock:^(id returnData) {
            [weakSelf hideHud];
            ZKLog(@"returnData -- %@", returnData[@"message"]);
            if ([returnData[@"success"] intValue] == 1) {
                ZKLog(@"上传成功");
                [PublicFunction showAlert:@"" message:@"上传成功"];
            } else {
                ZKLog(@"上传失败");
                [PublicFunction showAlert:@"" message:@"上传成功"];
            }
                
        } failureBlock:^(NSError *error) {
            [weakSelf hideHud];
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
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 80;
    } else
        return 45;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        ZKLog(@"修改昵称");
        WooInfoVC *niVC = [[WooInfoVC alloc]init];
        [self.navigationController pushViewController:niVC animated:YES];
    } else if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
            {
                ZKLog(@"彩蛋");
            }
                break;
            case 1:
            {
                ZKLog(@"邀请码");
                WooYaoQingVC *yaoVC = [[WooYaoQingVC alloc]init];
                [self.navigationController pushViewController:yaoVC animated:YES];
            }
                break;
            case 2:
            {
                ZKLog(@"二维码");
                WooErWeiMaView *erView = [[WooErWeiMaView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
                [self.view addSubview:erView];
            }
                break;
            case 3:
            {
                ZKLog(@"消息提醒");
            }
            default:
                break;
        }
    }
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
    label.text = @"真的要退出WOWO么？";
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
            [UserDefaults setObject:@"" forKey:@"rel"];
            [UserDefaults setObject:@"" forKey:@"uid"];
            [UserDefaults setObject:@"" forKey:@"name"];
            [UserDefaults setObject:@"" forKey:@"sex"];
            [UserDefaults setObject:@"" forKey:@"userId"];
//            [self.backgroundView removeFromSuperview];
//            [self.whiteView removeFromSuperview];
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
    WEAKSELF;
    [UserRequestToo shareInstance].rquesturl = UserUrl;
    NSString *userId = [UserDefaults objectForKey:@"userId"];
    [UserRequestToo shareInstance].params = @{@"userId" : userId};
    [[UserRequestToo shareInstance] statrrequestgetwith:(MHAsiNetWorkGET) successBlock:^(id returnData) {
        [self.dataTableView.mj_header endRefreshing];
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
