
//
//  AccountSettingsController.m
//  Woo
//
//  Created by 王起锋 on 2018/10/11.
//  Copyright © 2018年 杭州蜂布式. All rights reserved.
//

#import "AccountSettingsController.h"
#import "Acountsetingcell.h"
@interface AccountSettingsController ()
<UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate>
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UIView *botomoview;
@property (nonatomic, strong) UITextField *nameField;
@property (nonatomic, strong) UITextField *countnameField;
@property (nonatomic, strong) UILabel *countLabel;
@property (nonatomic, strong) UIButton *mangerBtn;
@end

@implementation AccountSettingsController
-(UILabel *)countLabel
{
    if (_countLabel==nil) {
        _countLabel=[[UILabel alloc] initWithFrame:CGRectMake(15*KWidth_Scale, 60*KWidth_Scale, 80*KWidth_Scale, 50*KWidth_Scale)];
        _countLabel.textColor=WordsofcolorColor;
        _countLabel.font=UIFont(15);
    }
    return _countLabel;
}
-(UITextField *)nameField
{
    if (_nameField==nil) {
        _nameField=[[UITextField alloc] initWithFrame:CGRectMake(85*KWidth_Scale,10*KWidth_Scale, SCREEN_WIDTH-100*KWidth_Scale,50*KWidth_Scale)];
        _nameField.placeholder=@"输入真实姓名";
        _nameField.textColor=WordsofcolorColor;
        _nameField.font=[UIFont systemFontOfSize:15];
        _nameField.delegate=self;
        [_nameField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        _nameField.inputAccessoryView = [self getbar];
    }
    return _nameField;
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
-(UITextField *)countnameField
{
    if (_countnameField==nil) {
        _countnameField=[[UITextField alloc] initWithFrame:CGRectMake(100*KWidth_Scale,CGRectGetMaxY(self.nameField.frame)+1*KWidth_Scale, SCREEN_WIDTH-100*KWidth_Scale,50*KWidth_Scale)];
        _countnameField.placeholder=@"你的账号";
        _countnameField.font=[UIFont systemFontOfSize:15];
        _countLabel.textColor=WordsofcolorColor;
        _countnameField.delegate=self;
        [_countnameField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        _countnameField.inputAccessoryView = [self getbar];
    }
    return _countnameField;
}
-(void)textFieldDidChange:(UITextField *)textField
{
    if (textField == self.countnameField) {
        if (textField.text.length >11) {
            textField.text = [textField.text substringToIndex:11];
        }
    }
}
-(UIButton *)gettipsBtn
{
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button.frame = CGRectMake(15*KWidth_Scale, CGRectGetMaxY(self.countnameField.frame) + 30*KWidth_Scale+50*KWidth_Scale, ScreenWidth - 30*KWidth_Scale, 15*KWidth_Scale);
    [button setTitle:@"无法设置提现账户？请联系喜数客服  0571-0236985" forState:(UIControlStateNormal)];
    [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    button.titleLabel.font = UIFont(12);
    [button addTarget:self action:@selector(setMyServiceVC) forControlEvents:(UIControlEventTouchUpInside)];
    return button;
}
-(void)setMyServiceVC{
    /**
     拨打400电话
     */
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"联系客服" message:[NSString stringWithFormat:@"拨打 0571-0236985"] preferredStyle:UIAlertControllerStyleAlert];//UIAlertControllerStyleAlert视图在中央
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString *callPhone = [NSString stringWithFormat:@"tel://0571-0236985"];
        CGFloat version = [[[UIDevice currentDevice]systemVersion]floatValue];
        if (version >= 10.0) {
            /// 大于等于10.0系统使用此openURL方法
            if (@available(iOS 10.0, *)) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone] options:@{} completionHandler:nil];
            } else {
                // Fallback on earlier versions
            }
        } else {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone]];
        }
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}
-(UIButton *)getBtn
{
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button.frame = CGRectMake(15*KWidth_Scale, CGRectGetMaxY(self.countnameField.frame) + 30*KWidth_Scale, ScreenWidth - 30*KWidth_Scale, 40*KWidth_Scale);
    button.backgroundColor = UIColorFromRGB(0xff6400);
    button.layer.cornerRadius = 5;
    button.layer.masksToBounds = YES;
    [button setTitle:@"完成" forState:(UIControlStateNormal)];
    [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    button.titleLabel.font = UIFont(18);
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    return button;
}
-(void)buttonAction:(UIButton *)sender
{
    [self hideInputview];
}
-(UIView *)botomoview
{
    if (_botomoview==nil) {
        _botomoview=[[UIView alloc] initWithFrame:CGRectMake(0,SCREEN_HEIGHT, SCREEN_WIDTH, 250*KWidth_Scale)];
        _botomoview.backgroundColor=NaviBackgroundColor;
        UILabel *nameLabel=[PublicFunction getlabelwithtexttitle:@"真实姓名" fram:CGRectMake(15*KWidth_Scale, 10*KWidth_Scale, 65*KWidth_Scale, 50*KWidth_Scale) cornerRadius:0 textcolor:WordsofcolorColor textfont:UIFont(15) backcolor:[UIColor clearColor] textAlignment:NSTextAlignmentLeft];
        UIView *cell=[[UIView alloc] initWithFrame:CGRectMake(15*KWidth_Scale, 59*KWidth_Scale, SCREEN_WIDTH-30*KWidth_Scale, 0.7)];
        cell.backgroundColor=CellBackgroundColor;
        UIView *cell1=[[UIView alloc] initWithFrame:CGRectMake(15*KWidth_Scale, 49*2*KWidth_Scale+10*KWidth_Scale, SCREEN_WIDTH-30*KWidth_Scale, 0.7)];
        cell1.backgroundColor=CellBackgroundColor;
        [_botomoview addSubview:nameLabel];
        [_botomoview addSubview:self.countLabel];
        [_botomoview addSubview:self.nameField];
        [_botomoview addSubview:self.nameField];
        [_botomoview addSubview:self.countnameField];
        self.mangerBtn=[self getBtn];
        [_botomoview addSubview:self.mangerBtn];
        [_botomoview addSubview:[self gettipsBtn]];
        [_botomoview addSubview:cell];
        [_botomoview addSubview:cell1];
    }
    return _botomoview;
}
-(UILabel *)tipLabel
{
    if (_tipLabel==nil) {
        _tipLabel=[[UILabel alloc] initWithFrame:CGRectMake(15*KWidth_Scale, 10*KWidth_Scale, SCREEN_WIDTH-30*KWidth_Scale, 55*KWidth_Scale)];
        _tipLabel.textColor=[PublicFunction colorWithHexString:@"#E51C23"];
        _tipLabel.font=UIFont(12);
        _tipLabel.text=@"友情提示：请正确填写提现资料，确保此处真实姓名和提现账户身份证姓名（或机构名称）一致，因资料不正确导致提现失败或其他情况，喜数概不负责";
        _tipLabel.numberOfLines=0;
    }
    return _tipLabel;
}
-(UITableView *)myTableView{
    if (!_myTableView) {
        _myTableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-StatusBarAndNavigationBarHeight) style:UITableViewStyleGrouped];
        //_myTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
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
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [self unregNotification];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self regNotification];
    self.title=@"账户设置";
    [self.view addSubview:self.myTableView];
    UIView *heaview=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100*KWidth_Scale)];
    heaview.backgroundColor=CellBackgroundColor;
    UIView *cellview=[[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.tipLabel.frame),SCREEN_WIDTH, 35*KWidth_Scale)];
    cellview.backgroundColor=[UIColor whiteColor];
    UILabel *setLabel=[[UILabel alloc] initWithFrame:CGRectMake(15*KWidth_Scale, 0, SCREEN_WIDTH-30*KWidth_Scale, 35*KWidth_Scale)];
    setLabel.textColor=WordsofcolorColor;
    setLabel.font=UIFont(15);
    setLabel.text=@"请设置提现账户";
    [cellview addSubview:setLabel];
    [heaview addSubview:self.tipLabel];
    [heaview addSubview:cellview];
    [self.myTableView setTableHeaderView:heaview];
    [self loadata];
    [self.view addSubview:self.botomoview];
}
-(void)loadata
{
    [self.myTableView reloadData];
}
#pragma mark - <UITableViewDelegate, UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *onecellid=@"Acountsetingcell";
    Acountsetingcell *Commentcell=[tableView dequeueReusableCellWithIdentifier:onecellid];
    Commentcell=[[Acountsetingcell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:onecellid];
    if (indexPath.row==0) {
        Commentcell.titllabel.text=@"支付宝";
        Commentcell.iconimage.image=[UIImage imageNamed:@"pic_alipay"];
        Commentcell.cellLabel.text=@"未绑定";
    }
    else{
        Commentcell.titllabel.text=@"微信";
        Commentcell.iconimage.image=[UIImage imageNamed:@"pic_wxpay"];
        Commentcell.cellLabel.text=@"未绑定";
    }
    return Commentcell;
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
    return 0.01f;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row==0) {
        _countLabel.text=@"支付宝账户";
    }
    else{
        if (indexPath.row==1) {
            _countLabel.text=@"微信账户";
        }
    }
    [self showInputview];
}
-(void)showInputview
{
    CGPoint newcenter=self.botomoview.center;
    newcenter.y-=300*KWidth_Scale;
    self.myTableView.allowsSelection=NO;
    [UIView animateWithDuration:0.5 animations:^{
        self.botomoview.center=newcenter;
    }];
}
-(void)hideInputview
{
    self.myTableView.allowsSelection=YES;
    CGRect newcenter=self.botomoview.frame;
    newcenter.origin.y=SCREEN_HEIGHT;
    [UIView animateWithDuration:0.5 animations:^{
        self.botomoview.frame=newcenter;
    }];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}
#pragma mark - reg & unreg notification

- (void)regNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)unregNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
}

#pragma mark - notification handler

- (void)keyboardWillChangeFrame:(NSNotification *)notification
{
    NSDictionary *info = [notification userInfo];
    CGFloat duration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    CGRect beginKeyboardRect = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGRect endKeyboardRect = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGFloat yOffset = endKeyboardRect.origin.y - beginKeyboardRect.origin.y;
    
    CGRect inputFieldRect = self.botomoview.frame;
    
    inputFieldRect.origin.y += yOffset;
    
    [UIView animateWithDuration:duration animations:^{
        self.botomoview.frame = inputFieldRect;
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
