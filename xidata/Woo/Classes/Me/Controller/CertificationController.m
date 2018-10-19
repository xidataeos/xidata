//
//  certification certification CertificationController.m
//  Woo
//
//  Created by 王起锋 on 2018/10/12.
//  Copyright © 2018年 杭州蜂布式. All rights reserved.
//

#import "CertificationController.h"
#import "UIViewController+XHPhoto.h"
@interface CertificationController ()<UIScrollViewDelegate,UITextFieldDelegate>
@property(nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic, strong) UITextField *nameField;
@property (nonatomic, strong) UITextField *phoneField;
@property (nonatomic, strong) UIButton *mangerBtn;
@property (nonatomic, strong) UIView *botomoview;
@property (nonatomic, strong) UIImageView *backCard;
@property (nonatomic, strong) UIImageView *righekCard;
@property (nonatomic, strong) UIImageView *Myphoto;
@property (nonatomic, strong) UIImage *backphoto;
@property (nonatomic, strong) UIImage *righekhoto;
@property (nonatomic, strong) UIImage *userphoto;
@end

@implementation CertificationController
-(UIImageView *)backCard
{
    if (_backCard==nil) {
        _backCard=[[UIImageView alloc] initWithFrame:CGRectMake(15*KWidth_Scale, CGRectGetMaxY(self.righekCard.frame)+40*KWidth_Scale, SCREEN_WIDTH-30*KWidth_Scale, (SCREEN_WIDTH-30*KWidth_Scale)*0.562)];
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapright)];
        _backCard.contentMode=UIViewContentModeScaleAspectFill;
        _backCard.clipsToBounds=YES;
        _backCard.userInteractionEnabled=YES;
        [_backCard addGestureRecognizer:tap];
    }
    return _backCard;
}
-(void)tapright
{
    WEAKSELF;
    /*
     edit:照片需要裁剪:传YES,不需要裁剪传NO(默认NO)
     */
    [self showCanEdit:NO photo:^(UIImage *photo) {
        weakSelf.backphoto=photo;
        weakSelf.backCard.image=photo;
    }];
}
-(UIImageView *)righekCard
{
    if (_righekCard==nil) {
        _righekCard=[[UIImageView alloc] initWithFrame:CGRectMake(15*KWidth_Scale, CGRectGetMaxY(self.botomoview.frame)+40*KWidth_Scale, SCREEN_WIDTH-30*KWidth_Scale, (SCREEN_WIDTH-30*KWidth_Scale)*0.562)];
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rightclick)];
        _righekCard.userInteractionEnabled=YES;
        _righekCard.contentMode=UIViewContentModeScaleAspectFill;
        _righekCard.clipsToBounds=YES;
        [_righekCard addGestureRecognizer:tap];
    }
    return _righekCard;
}
-(void)rightclick
{
    WEAKSELF;
    /*
     edit:照片需要裁剪:传YES,不需要裁剪传NO(默认NO)
     */
    [self showCanEdit:NO photo:^(UIImage *photo) {
        weakSelf.righekhoto=photo;
        weakSelf.righekCard.image=photo;
        
    }];
}
-(UIImageView *)Myphoto
{
    if (_Myphoto==nil) {
        _Myphoto=[[UIImageView alloc] initWithFrame:CGRectMake(15*KWidth_Scale, CGRectGetMaxY(self.backCard.frame)+40*KWidth_Scale, SCREEN_WIDTH-30*KWidth_Scale, (SCREEN_WIDTH-30*KWidth_Scale)*0.562)];
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Myphotoclick)];
        _Myphoto.userInteractionEnabled=YES;
        _Myphoto.contentMode=UIViewContentModeScaleAspectFill;
        _Myphoto.clipsToBounds=YES;
        [_Myphoto addGestureRecognizer:tap];
    }
    return _Myphoto;
}
-(void)Myphotoclick
{
    WEAKSELF;
    /*
     edit:照片需要裁剪:传YES,不需要裁剪传NO(默认NO)
     */
    [self showCanEdit:NO photo:^(UIImage *photo) {
        weakSelf.userphoto=photo;
        weakSelf.Myphoto.image=photo;
    }];
}
-(UIButton *)getBtn
{
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button.frame = CGRectMake(15*KWidth_Scale, CGRectGetMaxY(self.Myphoto.frame) + 25*KWidth_Scale, ScreenWidth - 30*KWidth_Scale, 40*KWidth_Scale);
    button.backgroundColor = UIColorFromRGB(0xff6400);
    button.layer.cornerRadius = 5;
    button.layer.masksToBounds = YES;
    [button setTitle:@"提交认证" forState:(UIControlStateNormal)];
    [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    button.titleLabel.font = UIFont(18);
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    return button;
}
-(void)buttonAction:(UIButton *)sender
{
    
}
-(UITextField *)nameField
{
    if (_nameField==nil) {
        _nameField=[[UITextField alloc] initWithFrame:CGRectMake(95*KWidth_Scale,0*KWidth_Scale, SCREEN_WIDTH-100*KWidth_Scale,50*KWidth_Scale)];
        _nameField.placeholder=@"输入真实姓名";
        _nameField.textColor=NaviBackgroundColor;
        _nameField.font=[UIFont systemFontOfSize:15];
        _nameField.delegate=self;
        [_nameField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _nameField;
}
-(UITextField *)phoneField
{
    if (_phoneField==nil) {
        _phoneField=[[UITextField alloc] initWithFrame:CGRectMake(95*KWidth_Scale,CGRectGetMaxY(self.nameField.frame)+1*KWidth_Scale, SCREEN_WIDTH-100*KWidth_Scale,50*KWidth_Scale)];
        _phoneField.placeholder=@"输入手机号码";
        _phoneField.keyboardType=UIKeyboardTypeNumberPad;
        _phoneField.textColor=NaviBackgroundColor;
        _phoneField.font=[UIFont systemFontOfSize:15];
        _phoneField.delegate=self;
        [_phoneField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _phoneField;
}
-(void)textFieldDidChange:(UITextField *)textField
{
    if (textField == self.phoneField) {
        if (textField.text.length >11) {
            textField.text = [textField.text substringToIndex:11];
        }
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"认证";
    [self creatscroller];
    [self.scrollView addSubview:self.botomoview];
    [self creatBotomoview];
    // Do any additional setup after loading the view.
}
-(void)creatBotomoview
{
    UILabel *titleLabel=[PublicFunction getlabelwithtexttitle:@"身份证正面" fram:CGRectMake(15*KWidth_Scale,CGRectGetMaxY(self.botomoview.frame)+15*KWidth_Scale,SCREEN_WIDTH-30*KWidth_Scale, 20*KWidth_Scale) cornerRadius:0 textcolor:WordsofcolorColor textfont:UIFont(13) backcolor:[UIColor clearColor] textAlignment:NSTextAlignmentCenter];
    UILabel *titleLabel1=[PublicFunction getlabelwithtexttitle:@"身份证反面" fram:CGRectMake(15*KWidth_Scale,CGRectGetMaxY(self.righekCard.frame)+15*KWidth_Scale, SCREEN_WIDTH-30*KWidth_Scale, 20*KWidth_Scale) cornerRadius:0 textcolor:WordsofcolorColor textfont:UIFont(13) backcolor:[UIColor clearColor] textAlignment:NSTextAlignmentCenter];
    UILabel *titleLabel2=[PublicFunction getlabelwithtexttitle:@"手持身份证正面" fram:CGRectMake(15*KWidth_Scale,CGRectGetMaxY(self.backCard.frame)+15*KWidth_Scale, SCREEN_WIDTH-30*KWidth_Scale, 20*KWidth_Scale) cornerRadius:0 textcolor:WordsofcolorColor textfont:UIFont(13) backcolor:[UIColor clearColor] textAlignment:NSTextAlignmentCenter];
    [self.scrollView addSubview:titleLabel];
    [self.scrollView addSubview:self.righekCard];
    [self.scrollView addSubview:titleLabel1];
    [self.scrollView addSubview:self.backCard];
    [self.scrollView addSubview:titleLabel2];
    [self.scrollView addSubview:self.Myphoto];
    
    [self.righekCard sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1539325995891&di=7e5a2521da1dfb1cd01d32bf57861e5a&imgtype=0&src=http%3A%2F%2F5b0988e595225.cdn.sohucs.com%2Fimages%2F20171111%2F8a2058c30d614674a4fa7e40cf171ebf.jpeg"]];
    [self.backCard sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1539325995891&di=7e5a2521da1dfb1cd01d32bf57861e5a&imgtype=0&src=http%3A%2F%2F5b0988e595225.cdn.sohucs.com%2Fimages%2F20171111%2F8a2058c30d614674a4fa7e40cf171ebf.jpeg"]];
    [self.Myphoto sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1539325995891&di=7e5a2521da1dfb1cd01d32bf57861e5a&imgtype=0&src=http%3A%2F%2F5b0988e595225.cdn.sohucs.com%2Fimages%2F20171111%2F8a2058c30d614674a4fa7e40cf171ebf.jpeg"]];
    [self.scrollView addSubview:self.mangerBtn];
    _scrollView.contentSize=CGSizeMake(SCREEN_WIDTH, self.mangerBtn.center.y+60*KWidth_Scale);
}
-(UIView *)botomoview
{
    if (_botomoview==nil) {
        _botomoview=[[UIView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 110*KWidth_Scale)];
        UILabel *nameLabel=[PublicFunction getlabelwithtexttitle:@"姓名" fram:CGRectMake(15*KWidth_Scale, 0, 65*KWidth_Scale, 50*KWidth_Scale) cornerRadius:0 textcolor:WordsofcolorColor textfont:UIFont(15) backcolor:[UIColor clearColor] textAlignment:NSTextAlignmentLeft];
        UILabel *phoneLabel=[PublicFunction getlabelwithtexttitle:@"身份证号" fram:CGRectMake(15*KWidth_Scale,50*KWidth_Scale, 65*KWidth_Scale, 50*KWidth_Scale) cornerRadius:0 textcolor:WordsofcolorColor textfont:UIFont(15) backcolor:[UIColor clearColor] textAlignment:NSTextAlignmentLeft];
        UIView *cell=[[UIView alloc] initWithFrame:CGRectMake(0, 49*KWidth_Scale, SCREEN_WIDTH, 1.0)];
        cell.backgroundColor=CellBackgroundColor;
        
        UIView *cell1=[[UIView alloc] initWithFrame:CGRectMake(0, 50*2*KWidth_Scale, SCREEN_WIDTH, 10*KWidth_Scale)];
        cell1.backgroundColor=CellBackgroundColor;
        
        [_botomoview addSubview:nameLabel];
        [_botomoview addSubview:phoneLabel];
        [_botomoview addSubview:self.nameField];
        [_botomoview addSubview:self.phoneField];
        self.mangerBtn=[self getBtn];
        [_botomoview addSubview:cell];
        [_botomoview addSubview:cell1];
    }
    return _botomoview;
}
-(void)creatscroller
{
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.view.frame.size.height-StatusBarAndNavigationBarHeight)];
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.bounces = NO;
    self.scrollView.delegate = self;
    _scrollView.backgroundColor=RGB(242, 242, 242);
    _scrollView.scrollEnabled = YES;
    [self.view addSubview:self.scrollView];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
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
