
//
//  CreatealbumController.m
//  Woo
//
//  Created by 王起锋 on 2018/10/12.
//  Copyright © 2018年 杭州蜂布式. All rights reserved.
//创建专辑
#import "CreatealbumController.h"
#import "albumSelectview.h"
#import "Custtextview.h"
#import "CWNumberKeyboard.h"
#import "CertificationController.h"
#import "CreateAnewalbumController.h"
#import "EditContentModel.h"
#import "TOCropViewController.h"
@interface CreatealbumController ()<UITableViewDelegate,UITableViewDataSource,CreateAnewalbumDelegate,TOCropViewControllerDelegate>
{
    UIView *moreView;
}
@property (strong, nonatomic) CWNumberKeyboard *numberKb;
@property(nonatomic,strong)Custtextview *mytextview;
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) UILabel *zhuanjititle;
@property (nonatomic, strong) UILabel *brieftitle;
@property (nonatomic, strong) UILabel *BelongsL;
@property (nonatomic, strong) UILabel *priceL;
@property (nonatomic, strong) UIImageView *topBtn;
@property(nonatomic,strong)Custtextview *inputextview;
@property(nonatomic,copy)NSString *coverstr;
@property (nonatomic, strong) UIImage *converimage;
@property (nonatomic, strong) HomeModel *selType;

@property (nonatomic, assign) TOCropViewCroppingStyle croppingStyle; //The cropping style
@property (nonatomic, assign) CGRect croppedFrame;
@property (nonatomic, assign) NSInteger angle;
@end

@implementation CreatealbumController
-(instancetype)initwitdata:(NSMutableArray *)list type:(UpdataType)type
{
    if (self==[super init]) {
       self.selfType=type;
       [self.contentList addObjectsFromArray:list];
    }
    return self;
}
-(NSMutableArray *)contentList
{
    if (_contentList==nil) {
        _contentList=[[NSMutableArray alloc] init];
    }
    return _contentList;
}
-(Custtextview *)inputextview
{
    if (_inputextview==nil) {
        _inputextview=[[Custtextview alloc] initWithFrame:self.view.bounds];
        _inputextview.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.3];
        _inputextview.textView.placeholder = @"请输入专辑的简介";
        [self.view addSubview:_inputextview];
    }
    return _inputextview;
}
-(void)insertTextCell:(BOOL)isTitle{
    WEAKSELF;
    self.inputextview.hidden=NO;
    [self.inputextview.textView becomeFirstResponder];
    self.inputextview.textView.placeholder=@"请输入作品的简介";
    if (isTitle) {
        self.inputextview.textView.placeholder=@"请输入作品的标题";
    }
    [self.inputextview setRetublock:^(NSString * _Nonnull textstr)
     {
         [weakSelf.view endEditing:YES];
         weakSelf.inputextview.hidden=YES;
         if (isTitle) {
             weakSelf.zhuanjititle.text=textstr;
         }
         weakSelf.brieftitle.text=textstr;
     }];
}
-(UIImageView *)topBtn
{
    if (_topBtn==nil) {
        _topBtn=[[UIImageView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 160*KWidth_Scale)];
        _topBtn.image=[UIImage imageNamed:@"music_placeholder"];
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addThecover)];
        _topBtn.userInteractionEnabled=YES;
        [_topBtn addGestureRecognizer:tap];
     }
    return _topBtn;
}
-(void)addThecover
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
    _topBtn.image=image;
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
        _zhuanjititle.text=@"我是标题";
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
        _brieftitle.text=@"我是简介";
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
        _BelongsL.text=@"专辑分类";
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
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"存草稿" style:UIBarButtonItemStylePlain target:self action:@selector(saveadraft)];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    [self.view addSubview:self.myTableView];
    [self.myTableView setTableHeaderView:self.topBtn];
    [self setFootview];
    // Do any additional setup after loading the view.
}
-(void)setFootview
{
    UIView *footview=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*0.5)];
    [footview addSubview:[self getBtn]];
    UIButton *btn=[PublicFunction getbtnwithtexttitle:@"" fram:CGRectMake(0,60*KWidth_Scale, SCREEN_WIDTH, 15*KWidth_Scale) cornerRadius:0 textcolor:RGB(153, 153, 153) textfont:[UIFont systemFontOfSize:12] backcolor:[UIColor clearColor]];
    btn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [btn addTarget:self action:@selector(cliclbtn) forControlEvents:UIControlEventTouchUpInside];
     NSString *titletext=[NSString stringWithFormat:@"<font color='#999999'>我已阅读并同意</font><font color='#ff8170'>《授信协议》</font>"];
     [btn setAttributedTitle:[PublicFunction attributedStringWithHTMLString:titletext] forState:UIControlStateNormal];
    [footview addSubview:btn];
    UIView *tipsview=[[UIView alloc] initWithFrame:CGRectMake(5*KWidth_Scale, CGRectGetMaxY(btn.frame)+10*KWidth_Scale,SCREEN_WIDTH-10*KWidth_Scale, 136*KWidth_Scale)];
    [footview addSubview:tipsview];
    tipsview.backgroundColor=UIColorFromRGB(0xFBE4E4);
    tipsview.layer.cornerRadius=3;
    tipsview.clipsToBounds=YES;
    UILabel *nameLabel=[PublicFunction getlabelwithtexttitle:@"温馨提示" fram:CGRectMake(15*KWidth_Scale, 15*KWidth_Scale, 100*KWidth_Scale, 15*KWidth_Scale) cornerRadius:0 textcolor:WordsofcolorColor textfont:UIFont(14) backcolor:[UIColor clearColor] textAlignment:NSTextAlignmentLeft];
    
    UILabel *tipsLabel=[PublicFunction getlabelwithtexttitle:@"好的标题和简介能够让更多小伙伴发现你哦!要发布一系列同类作品时可以先创建一个专辑，同类作品可以直接放同一个专辑里，增加曝光度。你可以通过实名认证来提高你提交内容的审核周期。" fram:CGRectMake(15*KWidth_Scale, 30*KWidth_Scale, SCREEN_WIDTH-30*KWidth_Scale, 80*KWidth_Scale) cornerRadius:0 textcolor:WordsofcolorColor textfont:UIFont(13) backcolor:[UIColor clearColor] textAlignment:NSTextAlignmentLeft];
    tipsLabel.numberOfLines=0;
    [tipsview addSubview:tipsLabel];
    [tipsview addSubview:nameLabel];
    [self.myTableView setTableFooterView:footview];
    
    UIButton *clickbtn=[PublicFunction getbtnwithtexttitle:@"实名认证，请戳这里。" fram:CGRectMake(0,CGRectGetMaxY(tipsLabel.frame), 150, 15*KWidth_Scale) cornerRadius:0 textcolor:UIColorFromRGB(0xE51C23) textfont:[UIFont systemFontOfSize:12] backcolor:[UIColor clearColor]];
    clickbtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [clickbtn addTarget:self action:@selector(pushirez) forControlEvents:UIControlEventTouchUpInside];
    [tipsview addSubview:clickbtn];
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
    [button setTitle:@"发布" forState:(UIControlStateNormal)];
    [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    button.titleLabel.font = UIFont(18);
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    return button;
}
-(void)buttonAction:(UIButton *)submit
{
    [self publishiall:@"0"];
}
-(void)saveadraft
{
     [self publishiall:@"1"];
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
        cell.textLabel.font=UIFont(15);
    if (indexPath.section==0) {
        if (indexPath.row==0) {
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.textLabel.text=@"标题";
            [cell addSubview:self.zhuanjititle];
            self.zhuanjititle.text=self.albumTitle;
        }
        else{
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.text=@"简介";
            [cell addSubview:self.brieftitle];
        }
    }
    else
    {
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        if (indexPath.row==0) {
            cell.textLabel.text=@"所属专辑";
            [cell addSubview:self.BelongsL];
        }
        else{
            cell.textLabel.text=@"定价";
            [cell addSubview:self.priceL];
        }
    }
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
            [self getMtalbumLists];
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
            [self insertTextCell:NO];
        }
        else{
            [self insertTextCell:YES];
        }
    }
}
-(void)getMtalbumLists
{
    [UserRequestToo shareInstance].rquesturl=deletefriendRelationshipRequrl;
    NSMutableDictionary *parametDic = [[NSMutableDictionary alloc] init];
    [parametDic setValue:RCLOUD_ID forKey:@"userId"];

    [UserRequestToo shareInstance].params=parametDic;
    [UserRequestToo shareInstance].rquesturl=getownAlbumListUrl;
    [[UserRequestToo shareInstance] statrrequestgetwith:MHAsiNetWorkGET successBlock:^(id returnData) {
        if (returnData[@"success"]) {
            if([returnData[@"status"] isEqualToString:@"200"]) {
                NSArray *list=returnData[@"data"];
                NSMutableArray *classarr=[[NSMutableArray alloc] init];
                for (NSDictionary *dic in list) {
                    HomeModel *model=[[HomeModel alloc] init];
                    model.alid=dic[@"id"];
                    [model setValuesForKeysWithDictionary:dic];
                    [classarr addObject:model];
                }
                [self selectZJ:classarr];
                return ;
            }
            else{
                [self showErrorWithStatus:returnData[@"message"]];
            }
        }
        else{
            [self showErrorWithStatus:returnData[@"message"] ];
        }
    } failureBlock:^(NSError *error) {
        [self showErrorWithStatus:error.description ];
    }];
}
-(void)selectZJ:(NSArray *)arr
{
    WEAKSELF;
    self.selType=[arr firstObject];
    albumSelectview *selectview=[[albumSelectview alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) title:[NSString stringWithFormat:@"选择专辑 (%lu)",(unsigned long)arr.count] detailtitle:(NSMutableArray *)arr btntitle:@"取消"];
    [selectview setCreatblock:^{
        [weakSelf creatAnewalbum];
    }];
    [selectview show];
    [selectview setBlock:^(id project) {
        HomeModel *model=(HomeModel *)project;
        weakSelf.BelongsL.text=model.title;
        weakSelf.selType=model;
    }];
}
-(void)creatAnewalbum
{
    CreateAnewalbumController *Certification=[[CreateAnewalbumController alloc] init];
    Certification.Creatdeleagte=self;
    [self.navigationController pushViewController:Certification animated:YES];
}
#pragma mark CreateAnewalbumDelegate
-(void)getAlbum:(HomeModel *)Album
{
    self.selType=Album;
    self.BelongsL.text=Album.title;
}
#pragma mark 上传音频文件
-(void)UpdatavideoFlie:(NSString *)saveorNo
{
    NSMutableDictionary *parametDic = [[NSMutableDictionary alloc] init];
    NSData *dataImage = [NSData dataWithContentsOfFile:self.audioFilstr];
    [parametDic setValue:dataImage forKey:@"file"];
    [parametDic setValue:@"voice" forKey:@"type"];
    [parametDic setValue:self.selType.title forKey:@"name"];
    WQUploadParam *loadimag=[[WQUploadParam alloc] init];
    loadimag.data=dataImage;
    loadimag.name=@"file";
    loadimag.mimeType=@"amr/mp3/wmr";
    [AfnetHttpsTool uploadFileWithURL:UpdataFileUrl params:parametDic successBlock:^(id returnData) {
        if([returnData[@"status"] isEqualToString:@"200"]) {
            NSDictionary *dic=(NSDictionary *)returnData;
            [self upload:dic[@"data"] saveadraft:saveorNo];
        }
        else{
            [self showErrorWithStatus:@"作品发布失败" ];
        }
    } failureBlock:^(NSError *error) {
    } uploadParam:loadimag];
}
#pragma mark 发布图文
-(void)publishiall:(NSString *)saveorNo
{
    if (self.selfType==graphic_type) {
        if (self.contentList.count==0) {
            return;
        }
    }
    [self setThecover:saveorNo];
}
-(void)upPhones:(NSString *)saveorNo
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"cellType == %d", 0];
    NSMutableArray *arr=[[NSMutableArray alloc] init];
    [arr addObjectsFromArray:self.contentList];
    NSArray *newdataarr = [arr filteredArrayUsingPredicate:predicate];
    if (newdataarr.count==0) {
        [self updatestr:saveorNo];
        return;
    }
    EditContentModel *judgemodel=[newdataarr lastObject];
    for (int i=0; i<self.contentList.count; i++) {
        EditContentModel *imodel=self.contentList[i];
        if (imodel.cellType==EditContentCellTypeImage) {
            NSMutableDictionary *parametDic = [[NSMutableDictionary alloc] init];
            NSData *dataImage = UIImageJPEGRepresentation(imodel.img, 1.0);
            [parametDic setValue:dataImage forKey:@"file"];
            [parametDic setValue:@"img" forKey:@"type"];
            [parametDic setValue:self.selType.title forKey:@"name"];
            WQUploadParam *loadimag=[[WQUploadParam alloc] init];
            loadimag.data=dataImage;
            loadimag.name=@"file";
            loadimag.mimeType=@"image/jpeg/png";
            [AfnetHttpsTool uploadFileWithURL:UpdataFileUrl params:parametDic successBlock:^(id returnData) {
                if([returnData[@"status"] isEqualToString:@"200"]) {
                    NSDictionary *dic=(NSDictionary *)returnData;
                    imodel.imageUrl=dic[@"data"];
                    if ([imodel isEqual:judgemodel]) {
                        [self updatestr:saveorNo];
                    }
                }
                else{
                    [self showErrorWithStatus:returnData[@"message"] ];
                }
            } failureBlock:^(NSError *error) {
                [self dismiss];
            } uploadParam:loadimag];
            
        }
        
    }
}
-(void)updatestr:(NSString *)saveorNo
{
    NSMutableArray *arrM = [NSMutableArray array];
    for (NSInteger i = 0; i < self.contentList.count; i ++) {
        EditContentModel *imodel=self.contentList[i];
        EditContentItemModel *model = [[EditContentItemModel alloc] init];
        model.imageUrl = imodel.imageUrl;
        model.inputStr = imodel.inputStr;
        model.imageW=imodel.imageW;
        model.imageH=imodel.imageH;
        if (imodel.inputStr.length==0) {
            model.inputStr = @"";
        }
        [arrM addObject:model];
    }
    NSDictionary *dict = @{@"EditorDatas" : arrM};
    NSString *mEditorDatas = [dict yy_modelToJSONString];
    ZKLog(@"%@", mEditorDatas);
    [self upload:mEditorDatas saveadraft:saveorNo];
}
-(void)upload:(NSString *)contectstr saveadraft:(NSString *)saveadraft
{
//    NSData *jsonData = [contectstr dataUsingEncoding:NSUTF8StringEncoding];
//   NSDictionary *dic =[PublicFunction dicFromJSONWithData:jsonData];
    NSInteger price;
    NSString *postType;
    if ([self.priceL.text isEqualToString:@"免费"]||[self.priceL.text isEqualToString:@"0"]) {
        price=0;
    }
    else{
        price=[self.priceL.text integerValue];
    }
    if (self.selfType==graphic_type) {
        postType=@"1";
    }
    else{
        postType=@"0";
    }
    [UserRequestToo shareInstance].rquesturl=deletefriendRelationshipRequrl;
     if ([saveadraft isEqualToString:@"1"]) {
          [self showWithStatus:@"请求正在处理中..."];
     }
     else{
          [self showWithStatus:@"作品正在发布..."];
     }
    NSMutableDictionary *parametDic = [[NSMutableDictionary alloc] init];
    [parametDic setValue:RCLOUD_ID forKey:@"userId"];
    [parametDic setValue:self.selType.alid forKey:@"albumId"];
    [parametDic setValue:self.brieftitle.text forKey:@"intro"];
    [parametDic setValue:self.albumTitle forKey:@"title"];
    [parametDic setValue:[NSNumber numberWithInteger:price] forKey:@"price"];
    [parametDic setValue:saveadraft forKey:@"state"];
    [parametDic setValue:contectstr forKey:@"text"];
    [parametDic setValue:postType forKey:@"type"];
    [parametDic setValue:self.coverstr forKey:@"img"];
    [UserRequestToo shareInstance].params=parametDic;
    [UserRequestToo shareInstance].rquesturl=UpdateGraphic;
    [[UserRequestToo shareInstance] statrrequestgetwith:MHAsiNetWorkPOST successBlock:^(id returnData) {
        [self dismiss];
        if (returnData[@"success"]) {
            if([returnData[@"status"] isEqualToString:@"200"]) {
                if ([saveadraft isEqualToString:@"1"]) {
                    [self showSuccessWithStatus:@"作品已保存为草稿" ];
                    return ;
                }
                [self showSuccessWithStatus:@"您的作品已发布成功" ];
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
        [self showErrorWithStatus:@"您的作品发布失败！" ];
        [self showErrorWithStatus:[NSString stringWithFormat:@"%ld",(long)error.code]];
    }];
}
-(void)setThecover:(NSString *)saveorNo
{
    if (!self.converimage) {
        [self showInfoWithStatus:@"请先设置封面!" ];
        return;
    }
    NSMutableDictionary *parametDic = [[NSMutableDictionary alloc] init];
    NSData *dataImage = UIImageJPEGRepresentation(self.converimage, 1.0);
    [parametDic setValue:dataImage forKey:@"file"];
    [parametDic setValue:@"img" forKey:@"type"];
    [parametDic setValue:@"filename" forKey:@"name"];
    WQUploadParam *loadimag=[[WQUploadParam alloc] init];
    loadimag.data=dataImage;
    loadimag.name=@"file";
    loadimag.mimeType=@"image/jpeg/png";
    [self showWithStatus:@"数据正在上传中..." ];
    [AfnetHttpsTool uploadFileWithURL:UpdataFileUrl params:parametDic successBlock:^(id returnData) {
        if([returnData[@"status"] isEqualToString:@"200"]) {
            NSDictionary *dic=(NSDictionary *)returnData;
            self.coverstr=dic[@"data"];
            if (self.selfType==audio_type) {
                [self UpdatavideoFlie:saveorNo];
                return;
            }
            else{
                [self upPhones:saveorNo];
            }
        }
        else{
            [self showErrorWithStatus:returnData[@"message"] ];
        }
    } failureBlock:^(NSError *error) {
        [self showErrorWithStatus:@"作品发布失败!"];
        [self dismiss];
    } uploadParam:loadimag];
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
