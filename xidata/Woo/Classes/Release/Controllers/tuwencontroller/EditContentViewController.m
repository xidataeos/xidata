//
//  EditContentViewController.m
//  EditContentDemo
//
//  Created by Eleven on 2017/3/25.
//  Copyright © 2017年 Hawk. All rights reserved.
//

#import "EditContentViewController.h"
#import "EditContentModel.h"
#import "EditContentImgViewCell.h"
#import "CreatealbumController.h"
#define XZCollectionInsetVertical 15.f
#define XZCollectionItemSpace 15.f
#define BottomViewHeight 52
static CGFloat const kFooterHeight = 45;

@interface EditContentViewController () <UITableViewDataSource, UITableViewDelegate, TZImagePickerControllerDelegate,UITextViewDelegate>
{
    UIView *_bottomView;                    /**< 底栏 */
    UIButton *_addTextBtn;
}
@property(nonatomic,strong)Custtextview *mytextview;
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) NSMutableArray<EditContentModel *> *dataArr;
@property (nonatomic, strong) UIButton *footerView;
@property (nonatomic, strong) PlaceholderTextView * textView;
@property (nonatomic, assign) NSInteger responderIndex;
@property (nonatomic, getter=isInsertImg) BOOL insertImg;
@property (nonatomic, copy) NSArray *testUrls;
@property(nonatomic,strong)UIMenuController *menu;
@property(nonatomic,assign)NSInteger selectindex;
@property(nonatomic,strong)EditContentModel *selectdmodel;
@end

@implementation EditContentViewController

#pragma mark - life cycle
#pragma mark 初始化底view
-(UITableView *)myTableView{
    if (!_myTableView) {
        _myTableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-StatusBarAndNavigationBarHeight-TabbarHeight) style:UITableViewStyleGrouped];
        _myTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        //_myTableView.allowsSelection=NO;
        _myTableView.delegate=self;
        _myTableView.dataSource = self;
        _myTableView.showsVerticalScrollIndicator = NO;
        _myTableView.showsHorizontalScrollIndicator = NO;
        [_myTableView setTableFooterView:[UIView new]];
        _myTableView.separatorColor=CellBackgroundColor;
        _myTableView.backgroundColor=BackcolorColor;
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
- (void)initBottomView {
    
    CGFloat bottomHeight = BottomViewHeight;
    _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - bottomHeight - StatusBarAndNavigationBarHeight, [UIScreen mainScreen].bounds.size.width, bottomHeight)];
    _bottomView.layer.shadowColor = [UIColor blackColor].CGColor;
    _bottomView.layer.shadowOffset = CGSizeMake(0, 0);
    _bottomView.layer.shadowOpacity = .5f;
    _bottomView.layer.shadowRadius = 3.f;
    _bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_bottomView];
    
    CGFloat littleWidth = bottomHeight;
    CGFloat littleHeight = littleWidth - 18;
    CGFloat littleMargin = bottomHeight;
    CGFloat littleY = (bottomHeight - littleHeight)/2;
    UIButton *imageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat imageX = ([UIScreen mainScreen].bounds.size.width - littleHeight*2 - littleMargin)/2;
    imageBtn.frame = CGRectMake(imageX, littleY, littleHeight, littleHeight);
    [imageBtn addTarget:self action:@selector(insertImageCell:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:imageBtn];
    
    _addTextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat textX = CGRectGetMaxX(imageBtn.frame) + littleMargin;
    _addTextBtn.frame = CGRectMake(textX, littleY, littleHeight, littleHeight);
    [_addTextBtn addTarget:self action:@selector(insertTextCell:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:_addTextBtn];
    
    [imageBtn setImage:[UIImage imageNamed:@"post01_icon_b.png"] forState:UIControlStateNormal];
    [_addTextBtn setImage:[UIImage imageNamed:@"post01_icon_c.png"] forState:UIControlStateNormal];
}
-(void)insertImageCell:(UIButton *)sender
{
    [self _addImg];
}

-(void)insertTextCell:(UIButton *)sender
{
    WEAKSELF;
    self.mytextview.hidden=NO;
    [self.mytextview.textView becomeFirstResponder];
    [self.mytextview setRetublock:^(NSString * _Nonnull textstr)
    {
        [weakSelf.view endEditing:YES];
        weakSelf.mytextview.hidden=YES;
        EditContentModel *model =[[EditContentModel alloc] init];
        model.inputStr=textstr;
        model.cellType=EditContentCellTypeText;
        if (model.inputStr.length!=0) {
            [weakSelf.dataArr addObject:model];
            [weakSelf reloadtableview];
        }
    }];
}
-(void)reloadtableview
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.myTableView reloadData];
    });
    [self performSelector:@selector(scrollTableToFoot) withObject:nil afterDelay:0.1];
    
}
- (void)scrollTableToFoot
{
    NSInteger s = [self.myTableView numberOfSections];  //有多少组
    if (s<1) return;  //无数据时不执行 要不会crash
    NSInteger r = [self.myTableView numberOfRowsInSection:s-1]; //最后一组有多少行
    if (r<1) return;
    NSIndexPath *ip = [NSIndexPath indexPathForRow:r-1 inSection:s-1];  //取最后一行数据
    [self.myTableView scrollToRowAtIndexPath:ip atScrollPosition:UITableViewScrollPositionBottom animated:YES   ]; //滚动到最后一行
}
-(void)loadrequest
{
    
    
   
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self _initSubViews];
    [self initBottomView];
   self.myTableView.tableHeaderView = [self gettableHeader];
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
-(UIToolbar *)getbar
{
    UIToolbar *bar=[[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"完成",nil) style:UIBarButtonItemStylePlain target:self action:@selector(hidesBord)];
    bar.items = @[space,doneItem];
    return bar;
}
-(void)hidesBord
{
    [self.view endEditing:YES];
}
#pragma mark - private methods
- (void)_initSubViews {
    self.title = @"图文编辑";
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"下一步" style:UIBarButtonItemStylePlain target:self action:@selector(_publish)];
    self.navigationItem.rightBarButtonItem = rightBarItem;
}

- (void)_initData {
    _testUrls = @[@"http://farm4.static.flickr.com/3567/3523321514_371d9ac42f_b.jpg",
                  @"http://farm4.static.flickr.com/3629/3339128908_7aecabc34b_b.jpg",
                  @"http://farm4.static.flickr.com/3364/3338617424_7ff836d55f_b.jpg"];
    EditContentModel *textModel = [[EditContentModel alloc] init];
    textModel.inputStr = @"";
    textModel.cellType = EditContentCellTypeText;
    [self.dataArr addObject:textModel];
    [self reloadtableview];
}

- (void)_uploadWithImage:(UIImage *)image index:(NSInteger)index {
    NSLog(@"%zi", index);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        EditContentModel *model = self.dataArr[index];
        // 模拟上传返回的图片路径
        model.imageUrl = _testUrls[arc4random() % 3];
    });
}

#pragma mark - <UITableViewDelegate, UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EditContentModel *model = self.dataArr[indexPath.row];
    static NSString *onecellid=@"EditContentImgViewCell";
    EditContentImgViewCell *cell=[tableView dequeueReusableCellWithIdentifier:onecellid];
    cell=[[EditContentImgViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:onecellid celltype:model.cellType];
    
    //对于cell设置长按点击事件
    cell.Model=model;
    UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    [cell addGestureRecognizer:longPressGestureRecognizer];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    EditContentModel *model = self.dataArr[indexPath.row];
    if (model.cellType == EditContentCellTypeImage) {
        return model.imageH*((SCREEN_WIDTH-30*KWidth_Scale)/model.imageW)+20*KWidth_Scale;
    } else {
        return [EditContentImgViewCell getmyheight:model.inputStr];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    return;
}
-(void)longPress:(UILongPressGestureRecognizer *)gestureRecognizer
{
    EditContentImgViewCell *cell = (EditContentImgViewCell *) gestureRecognizer.view;
    CGPoint point = [gestureRecognizer locationInView:self.myTableView];
    NSIndexPath * indexPath = [self.myTableView indexPathForRowAtPoint:point];
    self.selectindex=indexPath.row;
    self.selectdmodel=self.dataArr[indexPath.row];
    [cell becomeFirstResponder];
     self.menu = [UIMenuController sharedMenuController];
    UIMenuItem *withDraw = [[UIMenuItem alloc] initWithTitle:@"编辑" action:@selector(withDrawAction:)];
    UIMenuItem *delete = [[UIMenuItem alloc] initWithTitle:@"删除" action:@selector(deleteAction:)];
    //设定菜单显示的区域，显示再Rect的最上面居中
    [self.menu setTargetRect:cell.frame inView:self.myTableView];
    if (self.selectdmodel.cellType==EditContentCellTypeImage) {
       [self.menu setMenuItems:@[delete]];
    }
    else{
       [self.menu setMenuItems:@[withDraw,delete]];
    }
    [self.menu setMenuVisible:YES animated:YES];
    
}
#pragma mark 编辑
-(void)withDrawAction:(id)sender
{
    WEAKSELF;
    self.mytextview.hidden=NO;
    self.mytextview.textView.text=self.selectdmodel.inputStr;
    [self.mytextview.textView becomeFirstResponder];
    [self.mytextview setRetublock:^(NSString * _Nonnull textstr)
     {
         [weakSelf.view endEditing:YES];
         weakSelf.mytextview.hidden=YES;
         EditContentModel *model =weakSelf.selectdmodel;
         model.inputStr=textstr;
         if (model.inputStr.length!=0) {
             [weakSelf.dataArr replaceObjectAtIndex:weakSelf.selectindex withObject:model];
             [weakSelf reloadtableview];
         }
         else{
             [weakSelf.dataArr removeObjectAtIndex:weakSelf.selectindex];
             [weakSelf reloadtableview];
         }
     }];
}
#pragma mark 删除
-(void)deleteAction:(id)sender
{
    [self.dataArr removeObjectAtIndex:self.selectindex];
    [self reloadtableview];
}
#pragma mark - event response
- (void)_addImg {
    TZImagePickerController *imagePickerVC = [[TZImagePickerController alloc] initWithMaxImagesCount:100 delegate:self];
    imagePickerVC.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:16],
                                                        NSForegroundColorAttributeName:[UIColor whiteColor]};
    if ([imagePickerVC.navigationBar respondsToSelector:@selector(setBarTintColor:)]) {
        [imagePickerVC.navigationBar setBarTintColor:NaviBackgroundColor];
        [imagePickerVC.navigationBar setTranslucent:NO];
        [imagePickerVC.navigationBar setTintColor:NaviBackgroundColor];
    }else{
        [imagePickerVC.navigationBar setBackgroundColor:NaviBackgroundColor];
    }

    @weakify(self);
    [imagePickerVC setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        @strongify(self);
        if (photos.count==0) {
            return ;
        }
        for (NSInteger i = 0; i < photos.count; i ++) {
            EditContentModel *imgModel = [[EditContentModel alloc] init];
            imgModel.img = photos[i];
            imgModel.imageH=imgModel.img.size.height;
            imgModel.imageW=imgModel.img.size.width;
            imgModel.cellType = EditContentCellTypeImage;
            [self.dataArr addObject:imgModel];
        }
        [self reloadtableview];
        self.insertImg = NO;
    }];
    [self presentViewController:imagePickerVC animated:YES completion:nil];
}
- (void)_publish {
    if (self.textView.text.length==0) {
        [self showInfoWithStatus:@"图文标题还是空的哦!"];
        return;
    }
    if (self.dataArr.count==0) {
         [self showInfoWithStatus:@"图文内容还是空的哦!"];
        return;
    }
    CreatealbumController *bumController =[[CreatealbumController alloc] initwitdata:self.dataArr type:graphic_type];
    bumController.albumTitle=self.textView.text;
    [self.navigationController pushViewController:bumController animated:YES];
}
-(PlaceholderTextView *)textView{
    if (!_textView) {
        _textView = [[PlaceholderTextView alloc]initWithFrame:CGRectMake(15*KWidth_Scale, 10*KWidth_Scale,SCREEN_WIDTH - 30*KWidth_Scale, 40*KWidth_Scale)];
        _textView.backgroundColor = [UIColor whiteColor];
        _textView.delegate = self;
        _textView.font =[UIFont fontWithName:@"Helvetica-Bold" size:18.0];
        _textView.textColor = [UIColor blackColor];
        _textView.textAlignment = NSTextAlignmentLeft;
        _textView.editable = YES;
        _textView.layer.cornerRadius = 4.0f;
        _textView.layer.borderColor = RGB(227,224,216).CGColor;
        _textView.layer.borderWidth = 0.5;
        _textView.placeholderColor = RGB(89, 89, 89);
        _textView.placeholder = @"请输入您的标题";
         _textView.inputAccessoryView = [self getbar];
    }
    return _textView;
}
- (UIView *)gettableHeader {
    UIView *head=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60*KWidth_Scale)];
    head.backgroundColor=[UIColor whiteColor];
    [head addSubview:self.textView];
    return head;
}

- (NSMutableArray<EditContentModel *> *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //[self.view endEditing:YES];
}
@end
