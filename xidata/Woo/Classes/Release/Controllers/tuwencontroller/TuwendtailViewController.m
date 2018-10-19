//
//  TuwendtailViewController.m
//  Woo
//
//  Created by 王起锋 on 2018/10/10.
//  Copyright © 2018年 杭州蜂布式. All rights reserved.
//通用图文详情

#import "TuwendtailViewController.h"
#import "EditContentModel.h"
#import "EditContentImgViewCell.h"
#import "publicBotomoview.h"
#import "TuwenHeadview.h"
#import "YFMPaymentView.h"
#import <STPopup/STPopup.h>
#import "SubscribeTableViewCell.h"
#import "CommentTableViewCell.h"
#import "dataDetailController.h"
#define BottomViewHeight 44
@interface TuwendtailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    publicBotomoview *_bottomView;
    UIView *moreView;
    CGFloat dy;
}
@property(nonatomic,strong)Custtextview *mytextview;
@property (nonatomic, strong) UITableView *myTableView;
@property(nonatomic,strong)UIMenuController *menu;
@property(nonatomic,assign)NSInteger selectindex;
@property(nonatomic,strong)EditContentModel *selectdmodel;
@property(nonatomic,strong)UIButton *exceptionalBtn;//打赏;
@property(nonatomic,strong)CommentsView *commentview;
@property(nonatomic,strong)GraphicinfoModel *selfInfoMoel;
@property(nonatomic,strong)TuwenHeadview *headtuwe;
@property(nonatomic,strong)NSMutableArray *commentlists;
@end

@implementation TuwendtailViewController
-(NSMutableArray *)commentlists
{
    if (_commentlists==nil) {
        _commentlists=[[NSMutableArray alloc] init];
    }
    return _commentlists;
}
-(UIView *)commentview
{
    WEAKSELF;
    if (_commentview==nil) {
        _commentview=[[CommentsView alloc] initWithFrame:CGRectMake(0,SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-StatusBarAndNavigationBarHeight)];
        UIPanGestureRecognizer *swipeRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didDismissself:)];
        //[_commentview addGestureRecognizer:swipeRecognizer];
        [_commentview setClosepageBlock:^{
            [weakSelf hideComment];
        }];
    }
    return _commentview;
}
-(void)hideComment
{
    [UIView animateWithDuration:0.3 animations:^{
        _commentview.frame=CGRectMake(0,SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-StatusBarAndNavigationBarHeight);
    }];
}
- (UIView *)gettableHeader {
    WEAKSELF;
    UIView *head=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60*KWidth_Scale)];
    head.backgroundColor=[UIColor whiteColor];
    self.headtuwe=[[TuwenHeadview alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60*KWidth_Scale)];
    [head addSubview:self.headtuwe];
    [self.headtuwe setClickblock:^{
        ZKLog(@"你点击了头像");
    }];
    [self.headtuwe setQukuaiblock:^{
        [weakSelf cheakDetail];
    }];
    return head;
}
-(void)cheakDetail
{
    dataDetailController *pushi=[[dataDetailController alloc] init];
    [self.navigationController pushViewController:pushi animated:YES];
}
-(Custtextview *)mytextview
{
    if (_mytextview==nil) {
        _mytextview=[[Custtextview alloc] initWithFrame:self.view.bounds];
        _mytextview.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.3];
        [self.view addSubview:_mytextview];
    }
    return _mytextview;
}
-(UITableView *)myTableView{
    if (!_myTableView) {
        _myTableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-StatusBarAndNavigationBarHeight-BottomViewHeight) style:UITableViewStyleGrouped];
        _myTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _myTableView.allowsSelection=NO;
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
- (void)addAction
{
    NSArray *titles = @[@"分享",@"举报"];
    MLMenuView *menuView = [[MLMenuView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 110 - 10, 0, 110, 40 * 3) WithTitles:titles WithImageNames:nil WithMenuViewOffsetTop:StatusBarAndNavigationBarHeight WithTriangleOffsetLeft:90 triangleColor:RGBAColor(255, 255, 255, 1.0)];
    [menuView setCoverViewBackgroundColor:RGBAColor(255, 255, 255, 0.1)];
    [menuView setSeparatorOffSet:0];
    menuView.separatorColor = RGBAColor(151, 151, 151,0.2);
    [menuView setMenuViewBackgroundColor:RGBAColor(255, 255, 255, 1.0)];
    menuView.layer.shadowOpacity = 0.4f;
    menuView.layer.shadowColor=[UIColor blackColor].CGColor;
    menuView.layer.shadowOffset=CGSizeMake(2, 2);
    menuView.titleColor =  WordsofcolorColor;
    menuView.didSelectBlock = ^(NSInteger index) {
        if (index == 0) {
           
        } else if (index == 1) {
           
        }
    };
    [menuView showMenuEnterAnimation:MLAnimationStyleNone];
}
- (void)initBottomView {
    WEAKSELF;
    CGFloat bottomHeight = BottomViewHeight;
    _bottomView = [[publicBotomoview alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - bottomHeight - StatusBarAndNavigationBarHeight, [UIScreen mainScreen].bounds.size.width, bottomHeight)];
    _bottomView.layer.shadowColor = [UIColor blackColor].CGColor;
    _bottomView.layer.shadowOffset = CGSizeMake(0, 0);
    _bottomView.layer.shadowOpacity = .5f;
    _bottomView.layer.shadowRadius = 3.f;
    _bottomView.backgroundColor = NaviBackgroundColor;
    [_bottomView setSelfBlock:^(NSInteger indexrow, BOOL selected) {
        if (indexrow==1) {
            [[ChatmangerObject ShareManger] favorSomebody:weakSelf.tuwModel successBlock:^(id returnData) {
                
            } failureBlock:^(NSError *error) {
                
            }];
            [weakSelf favort:selected];
        }
        else if (indexrow==2){
            [[ChatmangerObject ShareManger] nounfavorSomebody:weakSelf.tuwModel successBlock:^(id returnData) {
                
            } failureBlock:^(NSError *error) {
                
            }];
            [weakSelf Stepon:selected];
        }
        else if (indexrow==3){
            [[ChatmangerObject ShareManger] commentSomebody:weakSelf.tuwModel content:@"" successBlock:^(id returnData) {
                
            } failureBlock:^(NSError *error) {
                
            }];
        }
        else
        {
            [[ChatmangerObject ShareManger] CollectionSomebody:weakSelf.tuwModel successBlock:^(id returnData) {
                
            } failureBlock:^(NSError *error) {
                
            }];
            [weakSelf collection:selected];
        }
    }];
    [self.view addSubview:_bottomView];
}
-(void)sharecontent
{
    Sharemangerview *share=[[Sharemangerview alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, ScreenHeight)withtype:sharType_friend];
    [share setMyblock:^(NSInteger indexrow) {
        ZKLog(@"分享的第几个%ld",indexrow);
        SharePlatfrom  mshareToPlatfrom;
        if (indexrow==0) {
            mshareToPlatfrom=share_QQFriend;
        }
        else {
            mshareToPlatfrom=share_weChat;
        }
        [[ShareObject defaultShare] addShareImageUrl:@"http://47.92.53.135:8080/707241169052803645.png" shareText:@"邀请码\n点击可以下载app哦\n新一代价值互联网社交平台" shareTitle:WOWOInvitationCode shareUrl:@"https://www.pgyer.com/6xVV"
                                shareCompletionBlcok:^(SSDKResponseState state) {
                                    
                                }];
        [[ShareObject defaultShare] shareToPlatfrom:mshareToPlatfrom fromecontroller:self ContentType:SSDKContentTypeWebPage];
    }];
    [share shareviewShow];
}
-(void)favort:(BOOL)select
{
    
}
-(void)Stepon:(BOOL)select
{
    
}
-(void)comment:(BOOL)select
{
    WEAKSELF;
    self.mytextview.hidden=NO;
    [self.mytextview.textView becomeFirstResponder];
    [self.mytextview setRetublock:^(NSString * _Nonnull textstr)
     {
         [weakSelf.view endEditing:YES];
         weakSelf.mytextview.hidden=YES;
         if (textstr.length!=0) {
             ZKLog(@"%@", textstr);
         }
     }];
}
-(void)collection:(BOOL)select
{
    
}
-(void)creatMoreview
{
    moreView =[[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT*0.5, SCREEN_WIDTH, SCREEN_HEIGHT/2)];
    UIImage *botomoewimage=[UIImage imageNamed:@"EffectVicn"];
    moreView.layer.contents = (id)botomoewimage.CGImage;
    [self.view addSubview:moreView];
    self.myTableView.bounces=NO;
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0,15*KWidth_Scale, SCREEN_WIDTH, 30*KWidth_Scale);
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn setTitle:@"查看全文" forState:UIControlStateNormal];
    btn.titleLabel.font=UIFont(14);
    [btn addTarget:self action:@selector(payClick) forControlEvents:UIControlEventTouchUpInside];
    [moreView addSubview:btn];
}
-(void)payClick
{
    NSArray *payTypeArr = @[
                            @{@"pic":@"pic_blance",
                              @"title":@"余额",
                              @"type":@"balance"},
                            @{@"pic":@"pic_alipay",
                              @"title":@"支付宝",
                              @"type":@"alipay"},
                            @{@"pic":@"pic_wxpay",
                              @"title":@"微信",
                              @"type":@"wxpay"}
                            ];
    
    YFMPaymentView *pop = [[YFMPaymentView alloc]initTotalPay:@"39.99" vc:self dataSource:payTypeArr type:paytype];
    STPopupController *popVericodeController = [[STPopupController alloc] initWithRootViewController:pop];
    popVericodeController.style = STPopupStyleBottomSheet;
    [popVericodeController presentInViewController:self];
    
    pop.payType = ^(NSString *type,NSString *balance) {
        NSLog(@"选择了支付方式:%@\n需要支付金额:%@",type,balance);
    };
}
-(void)setnavitionright
{
    UIButton *  rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setImage:[UIImage imageNamed:@"jiahao"]  forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(addAction) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.frame = CGRectMake(SCREEN_WIDTH, 25, 45, 45);
    [rightBtn setImageEdgeInsets:UIEdgeInsetsMake(7, 20, 7, 0)];
    UIBarButtonItem *right=[[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem=right;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=self.tuwModel.title;
    [self setnavitionright];
    [self initBottomView];
    [self.myTableView setTableHeaderView:[self gettableHeader]];
    if (self.Paystatus==Paymenstatus) {
    [self creatMoreview];
    }
    [self loadataList];
    [self.view addSubview:self.commentview];
    // Do any additional setup after loading the view.
}
#pragma mark 请求数据接口
-(void)loadataList
{
    [self showWithStatus:@"数据加载中..."];
    NSMutableDictionary *parametDic = [NSMutableDictionary dictionaryWithCapacity:9];
    [parametDic setObject:RCLOUD_ID forKey:@"uId"];
    [parametDic setObject:self.tuwModel.alid forKey:@"essayId"];
    [UserRequestToo shareInstance].rquesturl=getlarticledetailsUrl;
    [UserRequestToo shareInstance].params=parametDic;
    [[UserRequestToo shareInstance] statrrequestgetwith:MHAsiNetWorkGET successBlock:^(id returnData) {
        [self dismiss];
        if (returnData[@"success"]) {
            if([returnData[@"status"] isEqualToString:@"200"])
            {
                if (![returnData[@"data"] isKindOfClass:[NSDictionary class]]) {
                    return ;
                }
                NSDictionary *dic=returnData[@"data"];
                GraphicinfoModel *model=[[GraphicinfoModel alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                self.selfInfoMoel=model;
                [self refreshUI:model];
            }
        }
    } failureBlock:^(NSError *error) {
        [self dismiss];
    }];
}
-(void)refreshUI:(GraphicinfoModel *)model
{
    NSString * jsonString = model.text;
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dic=[PublicFunction dicFromJSONWithData:jsonData];
    NSArray *data=dic[@"EditorDatas"];
    for (NSDictionary *mdic in data) {
        EditContentModel *model=[[EditContentModel alloc] init];
        [model setValuesForKeysWithDictionary:mdic];
        if (model.inputStr.length==0) {
            model.cellType=EditContentCellTypeImage;
        }
        else{
            model.cellType=EditContentCellTypeText;
        }
        [self.dataArray addObject:model];
    }
    [self.headtuwe.avimage sd_setImageWithURL:[NSURL URLWithString:model.userPhoto] forState:UIControlStateNormal];
    self.headtuwe.nameLabel.text=model.userName;
    self.headtuwe.timeLabel.text=model.createDate;
    _bottomView.favorLabel.text=[NSString stringWithFormat:@"%ld",(long)model.likeNum];
    [_bottomView.commentButton setTitle:[NSString stringWithFormat:@"%ld",(long)model.commentNum] forState:UIControlStateNormal];
    //1.传入要刷新的组数
    NSIndexSet *indexSet=[[NSIndexSet alloc] initWithIndex:0];
    //[self.myTableView reloadData];
    //2.传入NSIndexSet进行刷新
    [self.myTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
}
#pragma mark - <UITableViewDelegate, UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
       return self.dataArray.count;
    }
    else if (section==1){
        return 1;
    }
    return self.commentlists.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section==0) {
        EditContentModel *model = self.dataArray[indexPath.row];
        static NSString *onecellid=@"EditContentImgViewCell";
        EditContentImgViewCell *cell=[tableView dequeueReusableCellWithIdentifier:onecellid];
        cell=[[EditContentImgViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:onecellid celltype:model.cellType];
        cell.Model=model;
        UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
        [cell addGestureRecognizer:longPressGestureRecognizer];
        return cell;
    }
    else if (indexPath.section==1) {
        static NSString *onecellid=@"SubscribeTableViewCell";
        SubscribeTableViewCell *Subscell=[tableView dequeueReusableCellWithIdentifier:onecellid];
        Subscell=[[SubscribeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:onecellid];
        [Subscell setSubscribeblock:^{
            ZKLog(@"开始订阅专辑");
        }];
        Subscell.model=self.selfInfoMoel;
        return Subscell;
    }
    else{
        static NSString *onecellid=@"CommentTableViewCell";
        CommentTableViewCell *Commentcell=[tableView dequeueReusableCellWithIdentifier:onecellid];
        Commentcell=[[CommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:onecellid];
        return Commentcell;
    }
}
-(void)longPress:(UILongPressGestureRecognizer *)gestureRecognizer
{
    EditContentImgViewCell *cell = (EditContentImgViewCell *) gestureRecognizer.view;
    CGPoint point = [gestureRecognizer locationInView:self.myTableView];
    NSIndexPath * indexPath = [self.myTableView indexPathForRowAtPoint:point];
    self.selectindex=indexPath.row;
    self.selectdmodel=self.dataArray[indexPath.row];
    [cell becomeFirstResponder];
    self.menu = [UIMenuController sharedMenuController];
    UIMenuItem *withDraw = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(copyDrawAction:)];
    //设定菜单显示的区域，显示再Rect的最上面居中
    [self.menu setTargetRect:cell.frame inView:self.myTableView];
    if (self.selectdmodel.cellType==EditContentCellTypeText)
    {
       [self.menu setMenuItems:@[withDraw]];
       [self.menu setMenuVisible:YES animated:YES];
    }
}
#pragma mark 删除
-(void)copyDrawAction:(id)sender
{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.selectdmodel.inputStr;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        EditContentModel *model = self.dataArray[indexPath.row];
        if (model.cellType==EditContentCellTypeImage) {
            return model.imageH*((SCREEN_WIDTH-30*KWidth_Scale)/model.imageW)+20*KWidth_Scale;
        } else {
            return [EditContentImgViewCell getmyheight:model.inputStr];
        }
    }
    else if (indexPath.section==1){
        return 60*KWidth_Scale;
    }
    else{
        return 100*KWidth_Scale;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==2) {
        return 50*KWidth_Scale;
    }
    return 0.01f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==0||section==2) {
        return 60*KWidth_Scale;
    }
    return 0.01f;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headview=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40*KWidth_Scale)];
    UIView *cellview=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 8*KWidth_Scale)];
    cellview.backgroundColor=CellBackgroundColor;
    [headview addSubview:cellview];
    UILabel *commentLabel=[[UILabel alloc] initWithFrame:CGRectMake(10*KWidth_Scale, 20*KWidth_Scale, SCREEN_WIDTH*0.5, 20*KWidth_Scale)];
    commentLabel.textColor=WordsofcolorColor;
    commentLabel.font=UIFont(15);
    commentLabel.text=[NSString stringWithFormat:@"评论(%ld)",(long)self.selfInfoMoel.commentNum];
    [headview addSubview:commentLabel];
    if (section==2) {
        return headview;
    }
    return [UIView new];
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *headview=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60*KWidth_Scale)];
    UIView *cellview=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1*KWidth_Scale)];
    cellview.backgroundColor=CellBackgroundColor;
    [headview addSubview:cellview];
    
    self.exceptionalBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.exceptionalBtn.frame=CGRectMake((SCREEN_WIDTH-40*KWidth_Scale)/2.0, 5*KWidth_Scale, 40*KWidth_Scale, 40*KWidth_Scale);
    [self.exceptionalBtn setImage:[UIImage imageNamed:@"logo_icon"] forState:UIControlStateNormal];
    [self.exceptionalBtn addTarget:self action:@selector(exceptional) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *commentLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.exceptionalBtn.frame), SCREEN_WIDTH, 11*KWidth_Scale)];
    commentLabel.textColor=WordsofcolorColor;
    commentLabel.font=UIFont(12);
    commentLabel.text=@"已被打赏210次";
    commentLabel.textAlignment=NSTextAlignmentCenter;
    
    UIButton *moreLabel=[UIButton buttonWithType:UIButtonTypeCustom];
    moreLabel.frame=CGRectMake(0, 0, SCREEN_WIDTH, 60*KWidth_Scale);
    [moreLabel setTitleColor:WordsofcolorColor forState:UIControlStateNormal];
    moreLabel.titleLabel.font=UIFont(15);
    [moreLabel setTitle:@"更多评论" forState:UIControlStateNormal];
    [moreLabel addTarget:self action:@selector(moreclick:) forControlEvents:UIControlEventTouchUpInside];
    if (section==2) {
        [headview addSubview:moreLabel];
        return headview;
    }
    else if (section==0) {
        [headview addSubview:self.exceptionalBtn];
        [headview addSubview:commentLabel];
        return headview;
    }
    return [UIView new];
}
-(void)moreclick:(UIButton *)sender
{
    [UIView animateWithDuration:0.4 animations:^{
        self.commentview.frame=CGRectMake(0,0, SCREEN_HEIGHT,SCREEN_HEIGHT-StatusBarAndNavigationBarHeight);
    }];
}
#pragma mark 打赏
-(void)exceptional
{
    [self payClick];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    return;
}
-(void)didDismissself:(UIPanGestureRecognizer *)sender
{
    CGFloat viewWidth = SCREEN_WIDTH;
    CGFloat viewHeigh = SCREEN_HEIGHT-StatusBarAndNavigationBarHeight;
    CGPoint startPoint = CGPointMake(0, 0),swipingPoint = CGPointMake(0, 0);
    swipingPoint = [sender locationInView:_commentview];
    dy = swipingPoint.y - startPoint.y;
    
    
    CGPoint pt = [sender translationInView:_commentview];
    if (pt.y>=0) {
        sender.view.center = CGPointMake(sender.view.center.x, sender.view.center.y+pt.y);
    }
    [UIView animateWithDuration:0.3 animations:^{
        [sender setTranslation:CGPointMake(0, 0) inView:_commentview];
    }];
    
    if (sender.state == UIGestureRecognizerStateEnded)
    {
        if (_commentview.frame.origin.y >SCREEN_WIDTH*0.6) {
            [UIView animateWithDuration:0.3 animations:^{
                _commentview.frame = CGRectMake(0,SCREEN_HEIGHT, viewWidth, viewHeigh);
            } completion:^(BOOL finished) {
                [self hideComment];
            }];
        }
        else{
            _commentview.frame = CGRectMake(0,0, viewWidth, viewHeigh);
        }
    }
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
