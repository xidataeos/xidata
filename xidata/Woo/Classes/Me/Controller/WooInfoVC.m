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
#import "Guanzhucell.h"
#import "WooPhotoView.h"
#import "CertificationController.h"
@interface WooInfoVC ()<UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UIPopoverControllerDelegate>
{
    Theselectorview *selectview;
}
@property (nonatomic, strong)UITableView *dataTableView;
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
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WEAKSELF;
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
    }
    NSArray *titleArr = @[@"头像", @"昵称", @"性别",@"手机号", @"实名认证"];
    WooInfoCell *infoCell = [[WooInfoCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
    infoCell.label1.text = [NSString stringWithFormat:@"%@", titleArr[indexPath.row]];
    if (indexPath.row == 0 || indexPath.row == 4) {
        infoCell.label2.hidden = YES;
        infoCell.imageView1.hidden = NO;
        if (indexPath.row == 4) {
            infoCell.imageView1.image = [UIImage imageNamed:@"erweima_Image"];
        } else if (indexPath.row == 0) {
            infoCell.imageView1.backgroundColor = RGB(220, 221, 223);
            [infoCell.imageView1 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", [self.dataDictionary objectForKey:@"urlPhoto"]]] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                
            }];
            __strong typeof(infoCell) newcell=infoCell;
            [infoCell setClickblock:^{
                [weakSelf tapclick:newcell.imageView1];
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
-(void)tapclick:(UIImageView *)image
{
    CYPhotoPreviewer *previewer = [[CYPhotoPreviewer alloc] init];
    [previewer previewFromImageView:image inContainer:self.view];
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
    return 50;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WEAKSELF;
    switch (indexPath.row) {
        case 0:
        {
            [self selectPhone];
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
            NSMutableArray*sexarr =[[NSMutableArray alloc] initWithObjects:@"男",@"女", nil];
            selectview=[[Theselectorview alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) withWQAlertViewType:WQAlertView_no_btn title:@"请选择性别" detailtitle:sexarr btntitle:@"取消"];
            [selectview show];
            [selectview setBlock:^(NSString *project) {
               
            }];
            
        }
            break;
        case 3:
        {
        
        }
            break;
        case 4:
        {
            [self Certification];
        }
        default:
            break;
    }
}
-(void)Certification
{
    CertificationController *Certification=[[CertificationController alloc] init];
    [self.navigationController pushViewController:Certification animated:YES];
}
-(void)selectPhone
{
    WEAKSELF;
    [self showCanEdit:NO photo:^(UIImage *photo) {
       [weakSelf reloadIconWith:photo];
    }];
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
    loadimag.name=@"photoFile";
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0),^{
        
        [AfnetHttpsTool uploadFileWithURL: ModifyUrl params:parametDic successBlock:^(id returnData) {
            ZKLog(@"returnData -- %@", returnData[@"message"]);
            if ([returnData[@"success"] intValue] == 1) {
                ZKLog(@"上传成功");
                [PublicFunction showAlert:@"" message:@"上传成功"];
                [self.dataTableView.mj_header beginRefreshing];
                
            } else {
                ZKLog(@"上传失败");
                [PublicFunction showAlert:@"" message:@"上传失败"];
            }
            
        } failureBlock:^(NSError *error) {
            [weakSelf dismiss];
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
