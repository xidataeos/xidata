//
//  PersonalCenterViewController.m
//  PersonalCenter
//
//  Created by Arch on 2017/6/16.
//  Copyright © 2017年 mint_bin. All rights reserved.
//

#import "AlbumdetailsController.h"
#import <Masonry.h>
#import "AlbumdetailsViewCell.h"
#import "JianJieViewController.h"
#define STATUS_BAR_HEIGHT [UIApplication sharedApplication].statusBarFrame.size.height
static CGFloat const NAVIGATION_BAR_HEIGHT = 44;
static CGFloat const HeaderImageViewHeight = 240;

@interface AlbumdetailsController () <UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>
@property (nonatomic, strong) BaseTableView *mainTableView;
@property (nonatomic, strong) UIView *naviView;
@property (nonatomic, strong) UIImageView *headerImageView;
@property (nonatomic, strong) UIView *headerContentView;
@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UIImageView *myavatarImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *nickNameLabel;
@property (nonatomic, strong) UILabel *workListLabel;
@property (nonatomic, strong) UIView *botomoview;
@property (nonatomic, strong) UIButton *favBtn;
@property (nonatomic, strong) UIButton *nofavBtn;
@property (nonatomic, strong) UIButton *commentBtn;
@property (nonatomic, strong) UIButton *shareBtn;
@property (nonatomic, strong) HomeModel *pageinfo;
@property (nonatomic, strong) UILabel *faveLabel;
@property (nonatomic, strong) NSMutableArray *commentList;
/** mainTableView是否可以滚动 */
@property (nonatomic, assign) BOOL canScroll;
/** segmentHeaderView到达顶部, mainTableView不能移动 */
@property (nonatomic, assign) BOOL isTopIsCanNotMoveTabView;
/** segmentHeaderView离开顶部,childViewController的滚动视图不能移动 */
@property (nonatomic, assign) BOOL isTopIsCanNotMoveTabViewPre;
/** 是否正在pop */
@property (nonatomic, assign) BOOL isBacking;

@end

@implementation AlbumdetailsController
-(NSMutableArray *)commentList
{
    if (_commentList==nil) {
        _commentList=[[NSMutableArray alloc] init];
    }
    return _commentList;
}
-(void)getAlbumList
{
    NSMutableDictionary *parametDic = [NSMutableDictionary dictionaryWithCapacity:9];
    [parametDic setObject:RCLOUD_ID forKey:@"userId"];
    [parametDic setObject:self.AlbumModel.alid forKey:@"albumId"];
    [UserRequestToo shareInstance].rquesturl=getlbumlistUrl;
    [UserRequestToo shareInstance].params=parametDic;
    [[UserRequestToo shareInstance] statrrequestgetwith:MHAsiNetWorkGET successBlock:^(id returnData) {
        if (returnData[@"success"]) {
            if([returnData[@"status"] isEqualToString:@"200"])
            {
                NSArray *list=returnData[@"data"];
                for (NSDictionary *dic in list) {
                    GraphicinfoModel *model=[[GraphicinfoModel alloc] init];
                    [model setValuesForKeysWithDictionary:dic];
                    [self.dataArray addObject:model];
                }
                [self.mainTableView reloadData];
                
            }
        }
    } failureBlock:^(NSError *error) {
    }];
}
-(void)getAlbuminfo
{
    NSMutableDictionary *parametDic = [NSMutableDictionary dictionaryWithCapacity:9];
    [parametDic setObject:RCLOUD_ID forKey:@"userId"];
    [parametDic setObject:self.AlbumModel.alid forKey:@"albumId"];
    [UserRequestToo shareInstance].rquesturl=getalbumdetaiUrl;
    [UserRequestToo shareInstance].params=parametDic;
    [[UserRequestToo shareInstance] statrrequestgetwith:MHAsiNetWorkGET successBlock:^(id returnData) {
        if (returnData[@"success"]) {
            if([returnData[@"status"] isEqualToString:@"200"])
            {
                if (!returnData[@"data"]) {
                    nil;
                }
                NSDictionary *dic=returnData[@"data"];
                    self.pageinfo=[[HomeModel alloc] init];
                AlbuminfoModel *model=[[AlbuminfoModel alloc] init];
                model.alid=dic[@"id"];
                    [model setValuesForKeysWithDictionary:dic];
                [self setpageUI:model];
                self.pageinfo.albuminfoModel=model;
            }
        }
    } failureBlock:^(NSError *error) {
    }];
}
-(void)setpageUI:(AlbuminfoModel *)model
{
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@""]];
    [self.myavatarImageView sd_setImageWithURL:[NSURL URLWithString:model.userPhoto] placeholderImage:[UIImage imageNamed:@"photo_boy"]];
    self.nickNameLabel.text=model.title;
    self.nameLabel.text=model.userName;
    _headerImageView.image=[self imageFromImage:self.avatarImageView.image inRect:CGRectMake(0, 0, 50, 50 )];
    _faveLabel.text=[NSString stringWithFormat:@"%@",model.likeNum];
    [_commentBtn setTitle:[NSString stringWithFormat:@"%@",model.commentNum] forState:UIControlStateNormal];
}
// 裁剪图片
-(UIImage *)imageFromImage:(UIImage *)image inRect:(CGRect)rect {
    CGImageRef sourceImageRef = [image CGImage];
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, rect);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    CGImageRelease(newImageRef);
    return newImage;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人中心";
    self.view.backgroundColor=[UIColor whiteColor];
    self.isEnlarge=YES;
    if (@available(iOS 11.0, *)) {
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    [self setupSubViews];
    [self getAlbuminfo];
    [self getAlbumList];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    self.naviView.hidden = NO;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.isBacking = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.isBacking = YES;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    self.naviView.hidden = YES;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Private Methods
- (void)setupSubViews {
    [self.view addSubview:self.mainTableView];
    [self.view addSubview:self.naviView];
    [self.headerImageView addSubview:self.headerContentView];
    [self.headerContentView addSubview:self.avatarImageView];
    [self.headerContentView addSubview:self.nickNameLabel];
    [self.headerImageView addSubview:self.nameLabel];
    [self.headerImageView addSubview:self.myavatarImageView];
    [self.headerImageView addSubview:self.botomoview];
    [self.botomoview addSubview:self.favBtn];
    [self.botomoview addSubview:self.faveLabel];
    [self.botomoview addSubview:self.nofavBtn];
    [self.botomoview addSubview:self.commentBtn];
    [self.botomoview addSubview:self.shareBtn];
    [self.mainTableView addSubview:self.headerImageView];
    [self.headerContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.centerX.mas_equalTo(self.headerImageView);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(HeaderImageViewHeight);
    }];
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(-(SCREEN_WIDTH/2.0-40-15));
        make.size.mas_equalTo(CGSizeMake(80, 80));
        make.bottom.mas_equalTo(-70);
    }];
    [self.nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.avatarImageView.mas_right).mas_offset(15);
    make.top.equalTo(self.avatarImageView.mas_top).mas_offset(-10);
       make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-115, 50));
    }];
    
    [self.myavatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatarImageView.mas_right).mas_offset(15);
        make.top.equalTo(self.nickNameLabel.mas_bottom).mas_offset(0);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.myavatarImageView.mas_right).mas_offset(5);
        make.top.equalTo(self.nickNameLabel.mas_bottom).mas_offset(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-135, 20));
    }];
    
    [self.botomoview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headerImageView);
        make.top.equalTo(self.avatarImageView.mas_bottom).mas_offset(10);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 50));
    }];
    
    [self.favBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.botomoview.mas_left).offset(20);
        make.top.equalTo(self.botomoview.mas_top).mas_offset(12);
        make.size.mas_equalTo(CGSizeMake(25, 25));
    }];
    [self.faveLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.favBtn.mas_right).offset(1);
        make.top.equalTo(self.botomoview.mas_top).mas_offset(12);
        make.size.mas_equalTo(CGSizeMake(45, 25));
    }];
    [self.nofavBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.faveLabel.mas_right).offset(1);
        make.top.equalTo(self.botomoview.mas_top).mas_offset(12);
        make.size.mas_equalTo(CGSizeMake(25, 25));
    }];
    
    [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.botomoview.mas_right).offset(-45);
        make.top.equalTo(self.botomoview.mas_top).mas_offset(12);
        make.size.mas_equalTo(CGSizeMake(25, 25));
    }];
    [self.commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.shareBtn.mas_left).offset(-20);
        make.top.equalTo(self.botomoview.mas_top).mas_offset(12);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH/4.0-10, 25));
    }];
    
}

- (void)backAction {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
#pragma mark - UiScrollViewDelegate
/**
 * 处理联动
 * 因为要实现下拉头部放大的问题，tableView设置了contentInset，所以试图刚加载的时候会调用一遍这个方法，所以要做一些特殊处理，
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.mainTableView) {
        //当前y轴偏移量
        CGFloat yOffset  = scrollView.contentOffset.y;
        //临界点偏移量(吸顶临界点)
        self.naviView.backgroundColor = [UIColor clearColor];
       
        if(yOffset <= -HeaderImageViewHeight) {
                CGRect f = self.headerImageView.frame;
                //改变HeadImageView的frame
                //上下放大
                f.origin.y = yOffset;
                f.size.height = -yOffset;
                //左右放大
                f.origin.x = (yOffset * SCREEN_WIDTH / HeaderImageViewHeight + SCREEN_WIDTH) / 2;
                f.size.width = -yOffset * SCREEN_WIDTH / HeaderImageViewHeight;
                //改变头部视图的frame
                self.headerImageView.frame = f;
            }
   
    }
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60*KWidth_Scale;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellid=@"AlbumdetailsViewCell";
    AlbumdetailsViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellid];
    GraphicinfoModel *model=self.dataArray[indexPath.row];
    cell = [[AlbumdetailsViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    cell.model=model;
    cell.imageview.text=[NSString stringWithFormat:@"%ld",indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50*KWidth_Scale;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headview=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50*KWidth_Scale)];
    headview.layer.cornerRadius=5*KWidth_Scale;
    headview.clipsToBounds=YES;
    //添加返回按钮
    UIButton *backButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    backButton.backgroundColor=UIColorFromRGB(0xFB4C52);
    [backButton setTitle:[NSString stringWithFormat:@"＋  订阅(%ld)",(long)self.pageinfo.albuminfoModel.subsNum]  forState:UIControlStateNormal];
    backButton.frame = CGRectMake(SCREEN_WIDTH-134,0, 134, 45*KWidth_Scale);
    [backButton.titleLabel setFont:UIFont(13)];
    backButton.adjustsImageWhenHighlighted = YES;
    [backButton addTarget:self action:@selector(subscribe) forControlEvents:(UIControlEventTouchUpInside)];
    [headview addSubview:backButton];
    [headview addSubview:self.workListLabel];
    headview.backgroundColor=[UIColor whiteColor];
    return headview;
}
#pragma mark 订阅按钮
-(void)subscribe
{
    
}
#pragma mark - Lazy
- (UIView *)naviView {
    if (!_naviView) {
        _naviView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, STATUS_BAR_HEIGHT + NAVIGATION_BAR_HEIGHT)];
        _naviView.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
        //添加返回按钮
        UIButton *backButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [backButton setImage:[UIImage imageNamed:@"whiteback"] forState:(UIControlStateNormal)];
        backButton.frame = CGRectMake(5, 8 + STATUS_BAR_HEIGHT, 28, 25);
        backButton.adjustsImageWhenHighlighted = YES;
        [backButton addTarget:self action:@selector(backAction) forControlEvents:(UIControlEventTouchUpInside)];
        [_naviView addSubview:backButton];
        
        //添加消息按钮
        UIButton *messageButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [messageButton setImage:[UIImage imageNamed:@"message"] forState:(UIControlStateNormal)];
        messageButton.frame = CGRectMake(SCREEN_WIDTH - 35, 8 + STATUS_BAR_HEIGHT, 25, 25);
        messageButton.adjustsImageWhenHighlighted = YES;
        //[messageButton addTarget:self action:@selector(gotoMessagePage) forControlEvents:(UIControlEventTouchUpInside)];
        //[_naviView addSubview:messageButton];
    }
    return _naviView;
}

- (UITableView *)mainTableView {
    if (!_mainTableView) {
        //⚠️这里的属性初始化一定要放在mainTableView.contentInset的设置滚动之前, 不然首次进来视图就会偏移到临界位置，contentInset会调用scrollViewDidScroll这个方法。
        //初始化变量
        self.canScroll = YES;
        self.isTopIsCanNotMoveTabView = NO;
        
        self.mainTableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.showsVerticalScrollIndicator = NO;
        //注意：这里不能使用动态高度_headimageHeight, 不然tableView会往下移，在iphone X下，头部不放大的时候，上方依然会有白色空白
        _mainTableView.contentInset = UIEdgeInsetsMake(HeaderImageViewHeight, 0, 0, 0);//内容视图开始正常显示的坐标为(0, HeaderImageViewHeight)
    }
    return _mainTableView;
}

- (UIView *)headerContentView {
    if (!_headerContentView) {
        _headerContentView = [[UIView alloc]init];
        _headerContentView.backgroundColor = [UIColor clearColor];
    }
    return _headerContentView;
}

- (UIImageView *)avatarImageView {
    if (!_avatarImageView) {
        _avatarImageView = [[UIImageView alloc] init];
        _avatarImageView.image = [UIImage imageNamed:@"center_avatar.jpeg"];
        _avatarImageView.userInteractionEnabled = YES;
        _avatarImageView.layer.masksToBounds = YES;
        _avatarImageView.layer.borderWidth = 1;
        _avatarImageView.layer.borderColor = RGBAColor(255, 253, 253, 1).CGColor;
        _avatarImageView.layer.cornerRadius = 5;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickHead)];
        _avatarImageView.userInteractionEnabled=YES;
        [_avatarImageView addGestureRecognizer:tap];
    }
    return _avatarImageView;
}
-(void)clickHead
{
    JianJieViewController *jianje=[[JianJieViewController alloc] init];
    jianje.infoModel=self.pageinfo.albuminfoModel;
    [self.navigationController presentViewController:jianje animated:YES completion:nil];
}
- (UILabel *)nickNameLabel {
    if (!_nickNameLabel) {
        _nickNameLabel = [[UILabel alloc] init];
        _nickNameLabel.font = [UIFont systemFontOfSize:14];
        _nickNameLabel.textColor = [UIColor whiteColor];
        _nickNameLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _nickNameLabel.numberOfLines = 0;
        _nickNameLabel.text = @"撒哈拉下雪了";
    }
    return _nickNameLabel;
}
-(UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont systemFontOfSize:14];
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _nameLabel.numberOfLines = 0;
        _nameLabel.text = @"撒哈拉下雪了";
    }
    return _nameLabel;
}
-(UIImageView *)myavatarImageView
{
    if (!_myavatarImageView) {
        _myavatarImageView = [[UIImageView alloc] init];
        _myavatarImageView.image = [UIImage imageNamed:@"center_avatar.jpeg"];
        _myavatarImageView.userInteractionEnabled = YES;
        _myavatarImageView.layer.masksToBounds = YES;
        _myavatarImageView.layer.borderColor = RGBAColor(255, 253, 253, 1).CGColor;
        _myavatarImageView.layer.cornerRadius = 2;
    }
    return _myavatarImageView;
}
- (UIImageView *)headerImageView {
    if (!_headerImageView) {
        _headerImageView = [[UIImageView alloc] init];
        [_headerImageView sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1539596327626&di=b28b69cc2d84a5a631a2121624f911bd&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimage%2Fc0%253Dshijue1%252C0%252C0%252C294%252C40%2Fsign%3D80e9d3b7c1ef7609280691dc46b4c9b9%2F4a36acaf2edda3ccf0c46f0a0be93901213f92fc.jpg"]];
        _headerImageView.userInteractionEnabled = YES;
        _headerImageView.frame = CGRectMake(0, -HeaderImageViewHeight, SCREEN_WIDTH, HeaderImageViewHeight);
    }
    return _headerImageView;
}
-(UIView *)botomoview
{
    if (!_botomoview) {
        _botomoview = [[UIView alloc] init];
    }
    return _botomoview;
}
-(UIButton *)favBtn
{
    if (_favBtn==nil) {
       _favBtn= [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_favBtn setImage:[UIImage imageNamed:@"selecticon"] forState:(UIControlStateNormal)];
        _favBtn.adjustsImageWhenHighlighted = YES;
        [_favBtn addTarget:self action:@selector(BtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [_favBtn setTitle:@"" forState:UIControlStateNormal];
        [_favBtn setImage:[UIImage imageNamed:@"pay_selected"] forState:(UIControlStateSelected)];
        [_favBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [_favBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _favBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//使图片和文字水平居中显示
        _favBtn.tag=1;

    }
    return _favBtn;
}
-(UIButton *)nofavBtn
{
    if (_nofavBtn==nil) {
        _nofavBtn= [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_nofavBtn setImage:[UIImage imageNamed:@"selecticon"] forState:(UIControlStateNormal)];
        [_nofavBtn setImage:[UIImage imageNamed:@"pay_selected"] forState:(UIControlStateSelected)];
        _nofavBtn.adjustsImageWhenHighlighted = YES;
        [_nofavBtn addTarget:self action:@selector(BtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [_nofavBtn setTitle:@"" forState:UIControlStateNormal];
        [_nofavBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [_nofavBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _nofavBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//使图片和文字水平居中显示
        _nofavBtn.tag=2;
    }
    return _nofavBtn;
}
-(UIButton *)commentBtn
{
    if (_commentBtn==nil) {
        _commentBtn= [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_commentBtn setImage:[UIImage imageNamed:@"selecticon"] forState:(UIControlStateNormal)];
        _commentBtn.adjustsImageWhenHighlighted = YES;
        [_commentBtn addTarget:self action:@selector(BtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [_commentBtn setTitle:@"0" forState:UIControlStateNormal];
        [_commentBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [_commentBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _commentBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//使图片和文字水平居中显示
        _commentBtn.tag=3;
    }
    return _commentBtn;
}
-(UIButton *)shareBtn
{
    if (_shareBtn==nil) {
        _shareBtn= [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_shareBtn setImage:[UIImage imageNamed:@"selecticon"] forState:(UIControlStateNormal)];
        _shareBtn.adjustsImageWhenHighlighted = YES;
        [_shareBtn addTarget:self action:@selector(BtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [_shareBtn setTitle:@"" forState:UIControlStateNormal];
        [_shareBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [_shareBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _shareBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//使图片和文字水平居中显示
        _shareBtn.tag=4;
    }
    return _shareBtn;
}
-(UILabel *)faveLabel
{
    if (_faveLabel==nil) {
        _faveLabel=[[UILabel alloc] init];
        _faveLabel.textColor=[UIColor whiteColor];
        _faveLabel.textAlignment=NSTextAlignmentCenter;
        _faveLabel.font=UIFont(12);
    }
    return _faveLabel;
}
-(void)BtnAction:(UIButton *)btn
{
    if (btn.tag==1) {
        [[ChatmangerObject ShareManger] favorSomebody:self.AlbumModel successBlock:^(id returnData) {
            
        } failureBlock:^(NSError *error) {
            
        }];
        ZKLog(@"点赞");
    }
    else if (btn.tag==2)
    {
        [[ChatmangerObject ShareManger] nounfavorSomebody:self.AlbumModel successBlock:^(id returnData) {
            
        } failureBlock:^(NSError *error) {
            
        }];
        ZKLog(@"踩");
    }
    else if (btn.tag==3)
    {
        [[ChatmangerObject ShareManger] commentSomebody:self.AlbumModel content:@"我是评论的内容" successBlock:^(id returnData) {
            
        } failureBlock:^(NSError *error) {
            
        }];
        ZKLog(@"评论");
    }
    else if (btn.tag==4)
    {
        [self sharecontent];
        ZKLog(@"分享");
    }
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
-(UILabel *)workListLabel
{
    if (!_workListLabel) {
        _workListLabel = [[UILabel alloc] initWithFrame:CGRectMake(10*KWidth_Scale, 0, SCREEN_WIDTH*0.5, 45*KWidth_Scale)];
        _workListLabel.font = [UIFont systemFontOfSize:13];
        _workListLabel.textColor = WordsofcolorColor;
        _workListLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _workListLabel.numberOfLines = 0;
        _workListLabel.text = [NSString stringWithFormat:@"作品列表(%ld)",self.dataArray.count];
    }
    return _workListLabel;
}

@end
