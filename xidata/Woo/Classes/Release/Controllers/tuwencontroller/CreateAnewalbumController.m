
//
//  CreateAnewalbumController.m
//  Woo
//
//  Created by 王起锋 on 2018/10/14.
//  Copyright © 2018年 杭州蜂布式. All rights reserved.
//

#import "CreateAnewalbumController.h"
#import "albumSelectview.h"
#import "Custtextview.h"
#import "CWNumberKeyboard.h"
#import "CertificationController.h"
#import "TOCropViewController.h"

@interface CreateAnewalbumController ()
<UITableViewDelegate,UITableViewDataSource,TOCropViewControllerDelegate>
{
    UIView *moreView;
    Theselectorview *selectview;
}
@property (strong, nonatomic) CWNumberKeyboard *numberKb;
@property(nonatomic,strong)Custtextview *mytextview;
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) UILabel *zhuanjititle;
@property (nonatomic, strong) UILabel *brieftitle;
@property (nonatomic, strong) UILabel *BelongsL;
@property (nonatomic, strong) UILabel *priceL;
@property (nonatomic, strong) UIButton *topBtn;
@property(nonatomic,strong)Custtextview *inputextview;
@property(nonatomic,copy)NSString *coverstr;
@property (nonatomic, strong) UIImage *converimage;
@property (nonatomic, strong) HomeModel *selType;
@property (nonatomic, assign) TOCropViewCroppingStyle croppingStyle; //The cropping style
@property (nonatomic, assign) CGRect croppedFrame;
@property (nonatomic, assign) NSInteger angle;
@end

@implementation CreateAnewalbumController

-(Custtextview *)inputextview
{
    if (_inputextview==nil) {
        _inputextview=[[Custtextview alloc] initWithFrame:self.view.bounds];
        _inputextview.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.3];
        [self.view addSubview:_inputextview];
    }
    return _inputextview;
}
-(void)insertTextCell:(NSString *)title istitle:(BOOL)istitle{
    WEAKSELF;
    self.inputextview.hidden=NO;
    [self.inputextview.textView becomeFirstResponder];
    _inputextview.textView.placeholder = title;
    [self.inputextview setRetublock:^(NSString * _Nonnull textstr)
     {
         [weakSelf.view endEditing:YES];
         weakSelf.inputextview.hidden=YES;
         if (istitle) {
            weakSelf.zhuanjititle.text=textstr;
         }
         else{
             weakSelf.brieftitle.text=textstr;
         }
     }];
}
-(UIButton *)topBtn
{
    if (_topBtn==nil) {
        _topBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _topBtn.frame=CGRectMake(0,0, SCREEN_WIDTH, 160*KWidth_Scale);
        [_topBtn setImage:[UIImage imageNamed:@"music_placeholder"] forState:UIControlStateNormal];
        [_topBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [_topBtn addTarget:self action:@selector(setThecover:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _topBtn;
}
-(void)setThecover:(UIButton *)sender
{
    WEAKSELF;
    [self showCanEdit:NO photo:^(UIImage *photo) {
        [weakSelf CropViewImage:photo];
    }];
}
-(void)CropViewImage:(UIImage *)image
{
    TOCropViewController *cropController = [[TOCropViewController alloc] initWithCroppingStyle:self.croppingStyle image:image];
    cropController.delegate = self;
    CGRect viewFrame = [self.view convertRect:self.topBtn.frame toView:self.navigationController.view];
    [cropController presentAnimatedFromParentViewController:self
                                                  fromImage:self.converimage
                                                   fromView:nil
                                                  fromFrame:viewFrame
                                                      angle:self.angle
                                               toImageFrame:self.croppedFrame
                                                      setup:^{ self.topBtn.hidden = NO;
                                                      }
                                                 completion:nil];
}
#pragma mark - Cropper Delegate -
- (void)cropViewController:(TOCropViewController *)cropViewController didCropToImage:(UIImage *)image withRect:(CGRect)cropRect angle:(NSInteger)angle
{
    self.croppedFrame = cropRect;
    self.angle = angle;
    [_topBtn setImage:image forState:UIControlStateNormal];
    _topBtn.frame=CGRectMake(0,0, SCREEN_WIDTH,image.size.height*(SCREEN_WIDTH/image.size.width));
    self.converimage=image;
    [self.myTableView setTableHeaderView:_topBtn];
    [cropViewController dismissViewControllerAnimated:YES completion:nil];
}
-(UILabel *)zhuanjititle
{
    if (_zhuanjititle==nil) {
        _zhuanjititle=[[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*0.3,0,  SCREEN_WIDTH*0.7-35*KWidth_Scale, 50*KWidth_Scale)];
        _zhuanjititle.textColor=WordsofcolorColor;
        _zhuanjititle.font=UIFont(15);
        _zhuanjititle.textAlignment=NSTextAlignmentRight;
        _zhuanjititle.text=@"创建标题";
    }
    return _zhuanjititle;
}
-(UILabel *)brieftitle
{
    if (_brieftitle==nil) {
        _brieftitle=[[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*0.3,0,  SCREEN_WIDTH*0.7-35*KWidth_Scale, 50*KWidth_Scale)];
        _brieftitle.textColor=WordsofcolorColor;
        _brieftitle.font=UIFont(15);
        _brieftitle.textAlignment=NSTextAlignmentRight;
        _brieftitle.text=@"创建简介";
    }
    return _brieftitle;
}
-(UILabel *)BelongsL
{
    if (_BelongsL==nil) {
        _BelongsL=[[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*0.3,0,  SCREEN_WIDTH*0.7-35*KWidth_Scale, 50*KWidth_Scale)];
        _BelongsL.textColor=WordsofcolorColor;
        _BelongsL.font=UIFont(15);
        _BelongsL.textAlignment=NSTextAlignmentRight;
        _BelongsL.text=@"选择分类";
    }
    return _BelongsL;
}
-(UILabel *)priceL
{
    if (_priceL==nil) {
        _priceL=[[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*0.3,0,  SCREEN_WIDTH*0.7-35*KWidth_Scale, 50*KWidth_Scale)];
        _priceL.textColor=UIColorFromRGB(0xE51C23);
        _priceL.font=UIFont(15);
        _priceL.textAlignment=NSTextAlignmentRight;
        _priceL.text=@"免费";
    }
    return _priceL;
}
-(UITableView *)myTableView{
    if (!_myTableView) {
        _myTableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-StatusBarAndNavigationBarHeight) style:UITableViewStyleGrouped];
        //_myTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        //_myTableView.allowsSelection=NO;
        _myTableView.delegate=self;
        _myTableView.dataSource = self;
        _myTableView.showsVerticalScrollIndicator = NO;
        _myTableView.showsHorizontalScrollIndicator = NO;
        [_myTableView setTableFooterView:[UIView new]];
        _myTableView.separatorColor=CellBackgroundColor;
        _myTableView.backgroundColor=[UIColor whiteColor];
        if (@available(iOS 11.0, *)) {
            _myTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _myTableView.estimatedRowHeight = 0;
            _myTableView.estimatedSectionFooterHeight = 0;
            _myTableView.estimatedSectionHeaderHeight = 0;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        [self.view  addSubview:_myTableView];
    }
    return _myTableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"创建专辑";
    [self.view addSubview:self.myTableView];
    [self.myTableView setTableHeaderView:self.topBtn];
    [self setFootview];
    // Do any additional setup after loading the view.
}
-(void)setFootview
{
    UIView *footview=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80*KWidth_Scale)];
    [footview addSubview:[self getBtn]];
    [self.myTableView setTableFooterView:footview];
}
-(void)pushirez
{
    CertificationController *Certification=[[CertificationController alloc] init];
    [self.navigationController pushViewController:Certification animated:YES];
}
-(void)cliclbtn
{
    
}
-(UIButton *)getBtn
{
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button.frame = CGRectMake(15*KWidth_Scale, 15*KWidth_Scale, ScreenWidth - 30*KWidth_Scale, 40*KWidth_Scale);
    button.backgroundColor = UIColorFromRGB(0xff6400);
    button.layer.cornerRadius = 5;
    button.layer.masksToBounds = YES;
    [button setTitle:@"创建专辑" forState:(UIControlStateNormal)];
    [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    button.titleLabel.font = UIFont(18);
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    return button;
}
-(void)buttonAction:(UIButton *)submit
{
    [self setThecover];
}
#pragma mark - <UITableViewDelegate, UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *onecellid=@"EditContentImgViewCell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:onecellid];
    cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:onecellid];
    cell.textLabel.font=UIFont(16);
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            cell.textLabel.text=@"标题";
            [cell addSubview:self.zhuanjititle];
        }
        else{
            cell.textLabel.text=@"简介";
            [cell addSubview:self.brieftitle];
        }
    }
    else
    {
        if (indexPath.row==0) {
            cell.textLabel.text=@"分类";
            [cell addSubview:self.BelongsL];
        }
        else{
            cell.textLabel.text=@"定价";
            [cell addSubview:self.priceL];
        }
    }
 cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;

    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50*KWidth_Scale;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10*KWidth_Scale;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [UIView new];
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *cellview=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10*KWidth_Scale)];
    cellview.backgroundColor=CellBackgroundColor;
    return cellview;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WEAKSELF;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section==1) {
        if (indexPath.row==0) {
            [weakSelf getfindClass];
        }
        else{
            if (!_numberKb) {
                _numberKb = [[CWNumberKeyboard alloc] init];
                [self.view addSubview:_numberKb];
            }
            _myTableView.contentInset = UIEdgeInsetsMake(0, 0, 100, 0);
            [_numberKb setHidden:NO];
            [UIView animateWithDuration:0.3 animations:^{
                weakSelf.myTableView.contentOffset = CGPointMake(0,200);
            }];
            [_numberKb showNumKeyboardViewAnimateWithPrice:self.priceL.text andBlock:^(NSString *priceString) {
                weakSelf.priceL.text = priceString;
                [UIView animateWithDuration:0.3 animations:^{
                    weakSelf.myTableView.contentOffset = CGPointMake(0,0);
                }];
            }];
        }
    }
    else{
        if (indexPath.row==1) {
            [weakSelf insertTextCell:@"请输入专辑的简介" istitle:NO];
        }
        else{
            [weakSelf insertTextCell:@"请输入专辑的标题"istitle:YES];
        }
    }
}

-(void)selectZJ
{
    NSMutableArray*sexarr =[[NSMutableArray alloc] initWithObjects:@"你是我的优乐美号码",@"你是我的优乐美号码", nil];
    albumSelectview *selectview=[[albumSelectview alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) title:@"选择专辑（2个）" detailtitle:sexarr btntitle:@"取消"];
    [selectview show];
    [selectview setBlock:^(NSString *project) {
        
    }];
}
-(void)setThecover
{
    if (!self.converimage) {
        [self showInfoWithStatus:@"请先设置封面!"];
        return;
    }
    NSMutableDictionary *parametDic = [[NSMutableDictionary alloc] init];
    NSData *dataImage = UIImageJPEGRepresentation(self.converimage, 1.0);
    [parametDic setValue:dataImage forKey:@"file"];
    [parametDic setValue:@"img" forKey:@"type"];
    [parametDic setValue:@"filename" forKey:@"name"];
    WQUploadParam *loadimag=[[WQUploadParam alloc] init];
    [self showWithStatus:@"专辑正在创建" ];
    loadimag.data=dataImage;
    loadimag.name=@"file";
    loadimag.mimeType=@"image/jpeg/png";
    [AfnetHttpsTool uploadFileWithURL:UpdataFileUrl params:parametDic successBlock:^(id returnData) {
        if([returnData[@"status"] isEqualToString:@"200"]) {
            NSDictionary *dic=(NSDictionary *)returnData;
            [self dismiss];
            self.coverstr=dic[@"data"];
            [self BeginCreatalbum];
        }
        else{
            [self showErrorWithStatus:returnData[@"message"] ];
        }
    } failureBlock:^(NSError *error) {
        [self dismiss];
    } uploadParam:loadimag];
}
-(void)BeginCreatalbum
{
    NSInteger price;
    NSString *postType;
    if ([self.priceL.text isEqualToString:@"免费"]||[self.priceL.text isEqualToString:@"0"]) {
        price=0;
    }
    else{
        price=[self.priceL.text integerValue];
    }
    [UserRequestToo shareInstance].rquesturl=deletefriendRelationshipRequrl;
    NSMutableDictionary *parametDic = [[NSMutableDictionary alloc] init];
    [parametDic setValue:RCLOUD_ID forKey:@"userId"];
    [parametDic setValue:@"2" forKey:@"albumId"];
    [parametDic setValue:self.brieftitle.text forKey:@"intro"];
    [parametDic setValue:self.zhuanjititle.text forKey:@"title"];
    [parametDic setValue:[NSNumber numberWithInteger:price] forKey:@"price"];
    [parametDic setValue:self.selType.alid forKey:@"classifyId"];
    [parametDic setValue:self.coverstr forKey:@"img"];
    [parametDic setValue:postType forKey:@"type"];
    [UserRequestToo shareInstance].params=parametDic;
    [UserRequestToo shareInstance].rquesturl=CreatAlbumUrl;
    [[UserRequestToo shareInstance] statrrequestgetwith:MHAsiNetWorkPOST successBlock:^(id returnData) {
        [self dismiss];
        if (returnData[@"success"]) {
            if([returnData[@"status"] isEqualToString:@"200"]) {
                [self showSuccessWithStatus:@"专辑创建成功" ];
                if ([self.Creatdeleagte respondsToSelector:@selector(getAlbum:)]) {
                    [self.Creatdeleagte getAlbum:self.selType];
                }
                [self.navigationController popViewControllerAnimated:YES];
                return ;
            }
            else{
                [self showErrorWithStatus:returnData[@"message"] ];
            }
        }
        else{
            [self showErrorWithStatus:returnData[@"message"] ];
        }
    } failureBlock:^(NSError *error) {
        [self dismiss];
        [self showErrorWithStatus:error.description ];
    }];
    [self.Creatdeleagte getAlbum:nil];
}
-(void)getfindClass
{
    [[ChatmangerObject ShareManger] getAlbumClasssuccessBlock:^(id returnData) {
        NSArray *list=returnData[@"data"];
        NSMutableArray *classarr=[[NSMutableArray alloc] init];
        for (NSDictionary *dic in list) {
            HomeModel *model=[[HomeModel alloc] init];
            model.alid=dic[@"id"];
            [model setValuesForKeysWithDictionary:dic];
            [classarr addObject:model];
        }
        [self selectFenLei:classarr];
    } failureBlock:^(NSError *error) {
        
    }];
    [self.Creatdeleagte getAlbum:nil];
}
-(void)selectFenLei:(NSArray *)arr
{
    self.selType=[arr firstObject];
    WEAKSELF;
    selectview=[[Theselectorview alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) withWQAlertViewType:WQAlertView_no_btn title:@"请选择专辑分类" detailtitle:(NSMutableArray *)arr btntitle:@"取消"];
    [selectview show];
    [selectview setBlock:^(id project) {
        HomeModel *model=(HomeModel *)project;
        weakSelf.BelongsL.text=model.title;
        weakSelf.selType=model;
    }];
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
