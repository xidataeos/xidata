//
//  WooInfoVC.m
//  Woo
//
//  Created by 风外杏林香 on 2018/8/9.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import "WooInfoVC.h"
#import "WooInfoCell.h"
#import "WooNiChenVC.h"
#import "WooErWeiMaView.h"
#import "WooPhotoView.h"
@interface WooInfoVC ()<UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UIPopoverControllerDelegate>
@property (nonatomic, strong)UITableView *dataTableView;
@property (strong, nonatomic) UIPopoverController *imagePickerPopover;
@property (nonatomic, strong)NSMutableDictionary *dataDictionary;

@end

@implementation WooInfoVC

- (NSMutableDictionary *)dataDictionary
{
    if (!_dataDictionary) {
        _dataDictionary = [NSMutableDictionary dictionary];
    }
    return _dataDictionary;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"个人信息";
    [self.view addSubview:self.dataTableView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestURL) name:@"requestURL" object:nil];
    WEAKSELF;
    self.dataTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (self.dataDictionary.count > 0) {
            [self.dataDictionary removeAllObjects];
        }
        [weakSelf requestURL];
    }];
    [self.dataTableView.mj_header beginRefreshing];
}

- (UITableView *)dataTableView
{
    if (!_dataTableView) {
        _dataTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:(UITableViewStyleGrouped)];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
    }
    NSArray *titleArr = @[@"头像", @"昵称", @"ID", @"我的二维码"];
    WooInfoCell *infoCell = [[WooInfoCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
    infoCell.label1.text = [NSString stringWithFormat:@"%@", titleArr[indexPath.row]];
    if (indexPath.row == 0 || indexPath.row == 3) {
        infoCell.label2.hidden = YES;
        infoCell.imageView1.hidden = NO;
        if (indexPath.row == 3) {
            infoCell.imageView1.image = [UIImage imageNamed:@"erweima_Image"];
        } else if (indexPath.row == 0) {
            infoCell.imageView1.backgroundColor = RGB(220, 221, 223);
            [infoCell.imageView1 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", [self.dataDictionary objectForKey:@"photo"]]] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                
            }];
        }
    } else if (indexPath.row == 1 || indexPath.row == 2) {
        infoCell.label2.hidden = NO;
        infoCell.imageView1.hidden = YES;
        if (indexPath.row == 1) {
//            infoCell.label2.text = @"一个测试账号";
            infoCell.label2.text = [NSString stringWithFormat:@"%@", self.dataDictionary[@"name"]];
        } else if (indexPath.row == 2) {
//            infoCell.label2.text = @"这是个ID啊";
            infoCell.label2.text = [NSString stringWithFormat:@"%@", self.dataDictionary[@"id"]];
        }
    }
    infoCell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell = infoCell;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            ZKLog(@"头像");
            WooPhotoView *photoView = [[WooPhotoView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - StatusBarAndNavigationBarHeight - TabbarSafeBottomMargin)];
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
                UIButton *button = (UIButton *)[photoView viewWithTag:btnTag];
                ZKLog(@"btnTag -- %ld", btnTag);
                switch (btnTag) {
                    case 1:
                    {
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
                        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                        //创建UIPopoverController对象前先检查当前设备是不是ipad
                        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
                            self.imagePickerPopover = [[UIPopoverController alloc] initWithContentViewController:imagePicker];
                            self.imagePickerPopover.delegate = self;
                            [self.imagePickerPopover presentPopoverFromBarButtonItem:button
                                                            permittedArrowDirections:UIPopoverArrowDirectionAny
                                                                            animated:YES];
                        } else {
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
            break;
        case 1:
        {
            ZKLog(@"昵称");
            WooNiChenVC *niVC = [[WooNiChenVC alloc]init];
            [self.navigationController pushViewController:niVC animated:YES];
        }
            break;
        case 2:
        {
            ZKLog(@"ID");
            
        }
            break;
        case 3:
        {
            ZKLog(@"二维码");
            WooErWeiMaView *erView = [[WooErWeiMaView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
            [self.view addSubview:erView];
        }
            
        default:
            break;
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
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
                [PublicFunction showAlert:@"" message:@"上传失败"];
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

- (void)requestURL
{
    WEAKSELF;
    [self.dataDictionary removeAllObjects];
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
