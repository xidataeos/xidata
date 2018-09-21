//
//  TransFerWooViewController.m
//  Woo
//
//  Created by 王起锋 on 2018/8/27.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//转账

#import "TransFerWooViewController.h"

@interface TransFerWooViewController ()<UITextFieldDelegate>
@property(nonatomic,strong)UIView *botomoview;
@property(nonatomic,strong)UITextField *jineTextfield;
@property(nonatomic,strong)UITextField *instructionsTextfield;
@property(nonatomic,strong)UILabel *jientext;
@property(nonatomic,strong)UIView *cellline;
@property(nonatomic,strong)UIButton *sendbtn;
@end

@implementation TransFerWooViewController
-(UIButton *)sendbtn
{
    if (_sendbtn==nil) {
        _sendbtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _sendbtn.frame=CGRectMake(15*KWidth_Scale, CGRectGetMaxY(self.instructionsTextfield.frame)+35*KWidth_Scale,SCREEN_WIDTH-60*KWidth_Scale, 45*KWidth_Scale);
        _sendbtn.layer.cornerRadius=5;
        _sendbtn.clipsToBounds=YES;
        _sendbtn.userInteractionEnabled=NO;
        _sendbtn.backgroundColor=RGB(252, 127, 92);
        [_sendbtn setTitle:@"转账" forState:UIControlStateNormal];
        [_sendbtn addTarget:self action:@selector(sendrenmessage:) forControlEvents:UIControlEventTouchUpInside];
        [_sendbtn.titleLabel setFont:UIFont(16)];
    }
    return _sendbtn;
}
-(UITextField *)jineTextfield
{
    if (_jineTextfield==nil) {
         _jineTextfield=[[UITextField alloc] initWithFrame:CGRectMake(40*KWidth_Scale,CGRectGetMaxY(self.jientext.frame)+5*KWidth_Scale, SCREEN_WIDTH-62*KWidth_Scale-25,55*KWidth_Scale)];
         _jineTextfield.placeholder=@"";
         _jineTextfield.textColor=RGB(51, 51, 51);
         _jineTextfield.font=[UIFont systemFontOfSize:42];
         _jineTextfield.delegate=self;
         _jineTextfield.keyboardType=UIKeyboardTypeNumberPad;
         [_jineTextfield addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _jineTextfield;
}
-(UITextField *)instructionsTextfield
{
    if (_instructionsTextfield==nil) {
        
        _instructionsTextfield=[[UITextField alloc] initWithFrame:CGRectMake(15*KWidth_Scale,CGRectGetMaxY(self.cellline.frame)+17*KWidth_Scale,SCREEN_WIDTH-60*KWidth_Scale,55*KWidth_Scale)];
        _instructionsTextfield.placeholder=@"";
        _instructionsTextfield.textColor=RGB(51, 51, 51);
        _instructionsTextfield.font=[UIFont systemFontOfSize:15];
        _instructionsTextfield.delegate=self;
        [_instructionsTextfield addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _instructionsTextfield;
}
-(void)textFieldDidChange:(UITextField *)textField
{
    if (textField == self.jineTextfield) {
        if (textField.text.length >15) {
            textField.text = [textField.text substringToIndex:15];
        }
        if (self.jineTextfield.text.length==0||[self.jineTextfield.text integerValue]==0) {
            _sendbtn.userInteractionEnabled=NO;
            _sendbtn.backgroundColor=RGB(252, 127, 92);
        }
        else{
            _sendbtn.userInteractionEnabled=YES;
            _sendbtn.backgroundColor=RGB(250, 60, 0);
        }
        self.jineTextfield.text=textField.text;
    }
    else if (textField==self.instructionsTextfield){
        if (textField.text.length > 10) {
            textField.text = [textField.text substringToIndex:10];
        }
    }

    
    
}
-(UIView *)botomoview
{
    if (_botomoview==nil) {
        _botomoview=[[UIView alloc] initWithFrame:CGRectMake(15*KWidth_Scale, 15*KWidth_Scale, SCREEN_WIDTH-30*KWidth_Scale, SCREEN_HEIGHT*0.5)];
        _botomoview.layer.cornerRadius=5;
        _botomoview.clipsToBounds=YES;
        _botomoview.backgroundColor=[UIColor whiteColor];
    }
    return _botomoview;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"转账给朋友";
    [self.view addSubview:self.botomoview];
    [self cgreatUI];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.view endEditing:NO];
     [_jineTextfield becomeFirstResponder];
}
-(void)cgreatUI
{
    UIImageView *avrimage=[self getavrimage];
    [self.botomoview addSubview:[self getavrimage]];
    UILabel *name=[[UILabel alloc] initWithFrame:CGRectMake(15*KWidth_Scale, CGRectGetMaxY(avrimage.frame)+5*KWidth_Scale, SCREEN_WIDTH*0.8, 15*KWidth_Scale)];
    name.textAlignment=NSTextAlignmentCenter;
    name.textColor=WordsofcolorColor;
    name.font=UIFont(15);
    name.text=self.userinfo.displayName;
    
    self.jientext=[[UILabel alloc] initWithFrame:CGRectMake(15*KWidth_Scale, CGRectGetMaxY(name.frame)+5*KWidth_Scale, SCREEN_WIDTH*0.8, 15*KWidth_Scale)];
    _jientext.textAlignment=NSTextAlignmentLeft;
    _jientext.textColor=WordsofcolorColor;
    _jientext.font=UIFont(14);
    _jientext.text=@"转账金额";
    [self.botomoview addSubview:self.jientext];
    
    UILabel *money=[[UILabel alloc] initWithFrame:CGRectMake(15*KWidth_Scale, CGRectGetMaxY(self.jientext.frame)+3*KWidth_Scale,25, 55*KWidth_Scale)];
    money.textAlignment=NSTextAlignmentLeft;
    money.textColor=WordsofcolorColor;
    money.font=UIFont(41);
    money.text=@"¥";
    [self.botomoview addSubview:money];
    [self.botomoview addSubview:self.jineTextfield];
    self.cellline=[self getcellline:CGRectMake(15*KWidth_Scale, CGRectGetMaxY(self.jineTextfield.frame), SCREEN_WIDTH-60*KWidth_Scale, 0.8)];
    [self.botomoview addSubview:self.cellline];
    
    UILabel *shuoming=[[UILabel alloc] initWithFrame:CGRectMake(15*KWidth_Scale, CGRectGetMaxY(self.cellline.frame)+5*KWidth_Scale, SCREEN_WIDTH*0.6, 15*KWidth_Scale)];
    shuoming.textAlignment=NSTextAlignmentLeft;
    shuoming.textColor=WordsofcolorColor;
    shuoming.font=UIFont(12);
    shuoming.text=@"转账说明";
    [self.botomoview addSubview:shuoming];
    [self.botomoview addSubview:self.instructionsTextfield];
    UIView *celltwo=[self getcellline:CGRectMake(15*KWidth_Scale, CGRectGetMaxY(self.instructionsTextfield.frame), SCREEN_WIDTH-60*KWidth_Scale, 0.7)];
    [self.botomoview addSubview:celltwo];
    
    UILabel *inputcount=[[UILabel alloc] initWithFrame:CGRectMake(15*KWidth_Scale, CGRectGetMaxY(celltwo.frame)+3*KWidth_Scale, SCREEN_WIDTH*0.6, 15*KWidth_Scale)];
    inputcount.textAlignment=NSTextAlignmentLeft;
    inputcount.textColor=[PublicFunction colorWithHexString:@"999999"];
    inputcount.font=UIFont(11);
    inputcount.text=@"最多输入10个字";
    [self.botomoview addSubview:inputcount];
    
    [self.botomoview addSubview:self.sendbtn];
    
}
-(UIView *)getcellline:(CGRect)rect;
{
    UIView *cell=[[UIView alloc] initWithFrame:rect];
    cell.backgroundColor=CellBackgroundColor;
    return cell;
}
-(UIImageView *)getavrimage
{
    UIImageView *avimage=[[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-50*KWidth_Scale)/2.0, 15*KWidth_Scale, 50*KWidth_Scale, 50*KWidth_Scale)];
    [avimage sd_setImageWithURL:[NSURL URLWithString:self.userinfo.portraitUri] placeholderImage:[UIImage imageNamed:@"pgoto_girl"]];
    return avimage;
}
#pragma mark 点击转账事件
-(void)sendrenmessage:(UIButton *)sender
{
    WEAKSELF;
    [self.view endEditing:YES];
    PayCustView *pass=[[PayCustView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) title:@"请输入支付密码" detailstr:nil];
    [pass shareviewShow];
    [pass setMyblock:^(NSString *password) {
        if ([weakSelf.delegate respondsToSelector:@selector(TransFerDelegatemessage:leavemessage:)]) {
            [weakSelf.delegate TransFerDelegatemessage:weakSelf.jineTextfield.text leavemessage:weakSelf.instructionsTextfield.text];
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
    }];
   
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
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
