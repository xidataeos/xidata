
//
//  MicrocopyrightdetailController.m
//  Woo
//
//  Created by 王起锋 on 2018/10/14.
//  Copyright © 2018年 杭州蜂布式. All rights reserved.
//

#import "MicrocopyrightdetailController.h"
#import "albumSelectview.h"
#import "Custtextview.h"
#import "CWNumberKeyboard.h"
#import "CertificationController.h"
#import <AssetsLibrary/AssetsLibrary.h>
@interface MicrocopyrightdetailController ()
<UITableViewDelegate,UITableViewDataSource>
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
@property (nonatomic, strong) NSArray *titlearr;
@property(nonatomic,strong)Custtextview *inputextview;
@end

@implementation MicrocopyrightdetailController

-(UITableView *)myTableView{
    if (!_myTableView) {
        _myTableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-StatusBarAndNavigationBarHeight) style:UITableViewStylePlain];
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
    self.title = @"数据详情";
    [self.view addSubview:self.myTableView];
    [self.myTableView setTableHeaderView:self.topBtn];
    UIView *head=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    [self.myTableView setTableHeaderView:head];
    [self setFootview];
    self.titlearr=[[NSArray alloc] initWithObjects:@"标题",@"作者",@"存证时间",@"区块高度",@"文件MD5码",@"版权存证ID",@"区块链ID", nil];
    // Do any additional setup after loading the view.
}
-(void)setFootview
{
    UIView *footview=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60*KWidth_Scale)];
    [footview addSubview:[self getBtn]];
    [self.myTableView setTableFooterView:footview];
}
-(UIButton *)getBtn
{
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button.frame = CGRectMake(15*KWidth_Scale, 10*KWidth_Scale, 112, 30*KWidth_Scale);
    button.layer.borderColor = UIColorFromRGB(0xff6400).CGColor;
    button.layer.borderWidth=0.8;
    button.layer.cornerRadius = 5;
    button.layer.masksToBounds = YES;
    [button setTitle:@"查看证书" forState:(UIControlStateNormal)];
    [button setTitleColor:UIColorFromRGB(0xff6400) forState:(UIControlStateNormal)];
    button.titleLabel.font = UIFont(14);
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    return button;
}
-(void)buttonAction:(UIButton *)submit
{
    CYPhotoPreviewer *previewer = [[CYPhotoPreviewer alloc] init];
    UIImageView *cyimag=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-200)];
    [cyimag sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1539577954639&di=6a80963bd89fa07771d9f64233f92fbd&imgtype=0&src=http%3A%2F%2Fwww.jituwang.com%2Fuploads%2Fallimg%2F151017%2F258149-15101H35S445.jpg"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        [previewer previewFromImageView:cyimag inContainer:self.view];
    }];
   
    [previewer setSaveblock:^{
        __block ALAssetsLibrary *lib = [[ALAssetsLibrary alloc] init];
        [lib writeImageToSavedPhotosAlbum:cyimag.image.CGImage metadata:nil completionBlock:^(NSURL *assetURL, NSError *error) {
            
            [self showSuccessWithStatus:@"保存成功"];
            lib = nil;
            
        }];
    }];
}
-(void)saveadraft
{
    
}
#pragma mark - <UITableViewDelegate, UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==1) {
        return 7;
    }
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *onecellid=@"EditContentImgViewCell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:onecellid];
    cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:onecellid];
     cell.detailTextLabel.numberOfLines=0;
    if (indexPath.section==0) {
        if (indexPath.row==0) {
          cell.textLabel.text=@"区块链版权说明";
            cell.detailTextLabel.text=@"1、根据“谁先创作、谁先申请，谁就拥有著作权”的原则，将原创信息加盖时间戳写入区块链，证明原创作品的确权时间。\n2、经由暿数平台，版权登记的“作者+确权时间+发布内容”三者被合并加密上传，拥有唯一区块链版权MD5码，数据将永久保存，不可篡改。\n3、区块链版权登记信息会同步至司法鉴定中心，和传统著作权证书同样具备法律效力。";
        }
        else{
            cell.textLabel.text=@"作品描述";
            cell.detailTextLabel.text=@"描述描述描述描述描述描述描述描述描述描述描述描述描述描述描述描述描述描述描述描述描述描述描述描述描述描述描述描述描述描述描述描述";
        }
    }
    else{
        cell.textLabel.font=UIFont(15);
        cell.textLabel.textColor=NaviBackgroundColor;
        cell.textLabel.text=self.titlearr[indexPath.row];
        cell.detailTextLabel.text=@"w我是待等待的名字";
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        if (indexPath.row==0) {
           return 145;
        }
        else{
            return 80;
        }
    }
    return 50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==1) {
       return 40.f;
    }
    return 0.1f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01*KWidth_Scale;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *cellview=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40*KWidth_Scale)];
    cellview.backgroundColor=[UIColor whiteColor];
    UILabel *headtitle=[[UILabel alloc] initWithFrame:CGRectMake(15*KWidth_Scale,0,  SCREEN_WIDTH*0.7,40*KWidth_Scale)];
    headtitle.textColor=WordsofcolorColor;
    headtitle.font=UIFont(15);
    headtitle.textAlignment=NSTextAlignmentLeft;
    [cellview addSubview:headtitle];
    
    headtitle.text=@"确权数据";
    if (section==1) {
        return cellview;
    }
    return [UIView new];
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    return [UIView new];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
   
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
