//
//  TocreatealiveController.m
//  Woo
//
//  Created by 王起锋 on 2018/10/14.
//  Copyright © 2018年 杭州蜂布式. All rights reserved.
//

#import "TocreatealiveController.h"
#import "albumSelectview.h"
#import "Custtextview.h"
#import "CWNumberKeyboard.h"
#import "CertificationController.h"
@interface TocreatealiveController ()
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
@property(nonatomic,strong)Custtextview *inputextview;
@end

@implementation TocreatealiveController

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
        [_topBtn setBackgroundImage:[UIImage imageNamed:@"music_placeholder"] forState:UIControlStateNormal];
        [_topBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 30*KWidth_Scale, 0, 0)];
        [_topBtn addTarget:self action:@selector(setThecover:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _topBtn;
}
-(void)setThecover:(UIButton *)sender
{
    [self showCanEdit:NO photo:^(UIImage *photo) {
        [_topBtn setBackgroundImage:photo forState:UIControlStateNormal];
    }];
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
    UIView *footview=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 120*KWidth_Scale)];
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
    button.frame = CGRectMake(15*KWidth_Scale, 70*KWidth_Scale, ScreenWidth - 30*KWidth_Scale, 40*KWidth_Scale);
    button.backgroundColor = UIColorFromRGB(0xff6400);
    button.layer.cornerRadius = 5;
    button.layer.masksToBounds = YES;
    [button setTitle:@"开始直播" forState:(UIControlStateNormal)];
    [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    button.titleLabel.font = UIFont(18);
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    return button;
}
-(void)buttonAction:(UIButton *)submit
{
    
}
-(void)saveadraft
{
    
}
#pragma mark - <UITableViewDelegate, UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *onecellid=@"EditContentImgViewCell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:onecellid];
    cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:onecellid];
        if (indexPath.row==0) {
            cell.textLabel.text=@"标题";
            [cell addSubview:self.zhuanjititle];
        }
        else{
            cell.textLabel.text=@"分类";
            [cell addSubview:self.BelongsL];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
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
    return 0.01*KWidth_Scale;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [UIView new];
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *cellview=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10*KWidth_Scale)];
    cellview.backgroundColor=CellBackgroundColor;
    return [UIView new];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WEAKSELF;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
        if (indexPath.row==0) {
            [weakSelf insertTextCell:@"请输入直播标题" istitle:NO];
        }
        else{
            [weakSelf selectFenLei];
        }
}
-(void)selectFenLei
{
    WEAKSELF;
    NSMutableArray*sexarr =[[NSMutableArray alloc] initWithObjects:@"恋爱",@"游途",@"时尚",@"婚姻", nil];
    selectview=[[Theselectorview alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) withWQAlertViewType:WQAlertView_no_btn title:@"请选择专辑分类" detailtitle:sexarr btntitle:@"取消"];
    [selectview show];
    [selectview setBlock:^(NSString *project) {
        weakSelf.BelongsL.text=project;
    }];
}
-(void)selectZJ
{
    NSMutableArray*sexarr =[[NSMutableArray alloc] initWithObjects:@"你是我的优乐美号码",@"你是我的优乐美号码", nil];
    albumSelectview *selectview=[[albumSelectview alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) title:@"选择专辑（2个）" detailtitle:sexarr btntitle:@"取消"];
    [selectview show];
    [selectview setBlock:^(NSString *project) {
        
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
