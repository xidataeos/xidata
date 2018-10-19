//
//  SendRedpocketWooViewController.m
//  Woo
//
//  Created by 王起锋 on 2018/8/24.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import "SendRedpocketWooViewController.h"

@interface SendRedpocketWooViewController ()<UITextFieldDelegate>
@property(nonatomic,strong)UITextField *redfield;
@property(nonatomic,strong)UITextField *Leavefield;
@property(nonatomic,strong)UITextField *countfield;
@property(nonatomic,strong)UILabel *redlable;
@property(nonatomic,strong)UIButton *sendbtn;
@end

@implementation SendRedpocketWooViewController
-(UITextField *)countfield
{
    if (_countfield==nil) {
        _countfield=[[UITextField alloc] initWithFrame:CGRectMake(90*KWidth_Scale,0, 320*KWidth_Scale-100*KWidth_Scale-23*KWidth_Scale,45*KWidth_Scale)];
        _countfield.placeholder=@"红包个数";
        _countfield.keyboardType=UIKeyboardTypeNumberPad;
        _countfield.textAlignment=NSTextAlignmentRight;
        _countfield.textColor=RGB(51, 51, 51);
        _countfield.font=[UIFont systemFontOfSize:15];
        _countfield.delegate=self;
        [_countfield addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _countfield;
}
-(UITextField *)Leavefield
{
    if (_Leavefield==nil) {
        _Leavefield=[[UITextField alloc] initWithFrame:CGRectMake(90*KWidth_Scale,0, 320*KWidth_Scale-100*KWidth_Scale,45*KWidth_Scale)];
        _Leavefield.placeholder=@"恭喜发财,大吉大利";
        _Leavefield.textAlignment=NSTextAlignmentRight;
        _Leavefield.textColor=RGB(51, 51, 51);
        _Leavefield.font=[UIFont systemFontOfSize:15];
        _Leavefield.delegate=self;
        [_Leavefield addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _Leavefield;
}
-(UITextField *)redfield
{
    if (_redfield==nil) {
        _redfield=[[UITextField alloc] initWithFrame:CGRectMake(90*KWidth_Scale,0, 320*KWidth_Scale-100*KWidth_Scale,45*KWidth_Scale)];
        _redfield.placeholder=@"0.00";
        _redfield.textAlignment=NSTextAlignmentRight;
        _redfield.textColor=RGB(51, 51, 51);
        _redfield.font=[UIFont systemFontOfSize:17];
        _redfield.delegate=self;
        _redfield.keyboardType=UIKeyboardTypeNumberPad;
        [_redfield addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _redfield;
}
-(void)textFieldDidChange:(UITextField *)textField
{
    if (textField == self.redfield) {
        if (textField.text.length > 20) {
            textField.text = [textField.text substringToIndex:15];
        }
        self.redlable.text=textField.text;
    }
    else if (textField==self.countfield)
    {
        self.countfield.text=textField.text;
    }
    else if (textField == self.Leavefield)
    {
        if (textField.text.length > 20) {
            textField.text = [textField.text substringToIndex:20];
        }
    }
    if (self.convertype==ConversationType_PRIVATE) {
        if (textField==self.redfield) {
            if (self.redfield.text.length==0||[self.redfield.text integerValue]==0) {
                _sendbtn.userInteractionEnabled=NO;
                _sendbtn.backgroundColor=RGB(252, 127, 92);
            }
            else{
                _sendbtn.userInteractionEnabled=YES;
                _sendbtn.backgroundColor=RGB(250, 60, 0);
            }
        }
    }
    else if (self.convertype==ConversationType_GROUP)
    {
        if (self.redfield.text.length==0||[self.redfield.text integerValue]==0||self.countfield.text.length==0||[self.countfield.text integerValue]==0) {
            _sendbtn.userInteractionEnabled=NO;
            _sendbtn.backgroundColor=RGB(252, 127, 92);
        }
        else{
            _sendbtn.userInteractionEnabled=YES;
            _sendbtn.backgroundColor=RGB(250, 60, 0);
        }
    }
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"发红包";
    if (self.convertype==ConversationType_PRIVATE) {
       [self setUI];
    }
    else if (self.convertype==ConversationType_GROUP)
    {
       [self GroupsetUI];
    }
    [self.redfield becomeFirstResponder];
    // Do any additional setup after loading the view.
}
-(void)GroupsetUI
{
    UIView *redview=[[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-320*KWidth_Scale)/2.0,20*KWidth_Scale,320*KWidth_Scale, 45*KWidth_Scale)];
    redview.backgroundColor=[UIColor whiteColor];
    redview.layer.cornerRadius=5;
    redview.clipsToBounds=YES;
    UILabel*redtitle=[[UILabel alloc] initWithFrame:CGRectMake(15*KWidth_Scale, 0,80, 45*KWidth_Scale)];
    redtitle.textColor=WordsofcolorColor;
    redtitle.font=UIFont(15);
    redtitle.text=@"彩蛋数量";
    [redview addSubview:redtitle];
    [redview addSubview:self.redfield];
    [self.view addSubview:redview];
    UILabel*redinstructions=[[UILabel alloc] initWithFrame:CGRectMake(5*KWidth_Scale+(SCREEN_WIDTH-320*KWidth_Scale)/2.0,CGRectGetMaxY(redview.frame)+3,SCREEN_WIDTH*0.5, 15*KWidth_Scale)];
    redinstructions.textColor=[PublicFunction colorWithHexString:@"999999"];
    redinstructions.font=UIFont(13);
    redinstructions.text=@"每人抽到数量随机";
    [self.view addSubview:redinstructions];
    
    
    UIView *countview=[[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-320*KWidth_Scale)/2.0,CGRectGetMaxY(redview.frame)+40*KWidth_Scale,320*KWidth_Scale, 45*KWidth_Scale)];
    countview.backgroundColor=[UIColor whiteColor];
    countview.layer.cornerRadius=5;
    countview.clipsToBounds=YES;
    UILabel*counttitle=[[UILabel alloc] initWithFrame:CGRectMake(15*KWidth_Scale, 0,80, 45*KWidth_Scale)];
    counttitle.textColor=WordsofcolorColor;
    counttitle.font=UIFont(15);
    counttitle.text=@"红包个数";
    [countview addSubview:counttitle];
    [countview addSubview:self.countfield];
    [self.view addSubview:countview];

    UILabel*counend=[[UILabel alloc] initWithFrame:CGRectMake(320*KWidth_Scale-30*KWidth_Scale, 0,80, 45*KWidth_Scale)];
    counend.textColor=WordsofcolorColor;
    counend.font=UIFont(15);
    counend.text=@"个";
    [countview addSubview:counend];
    [countview addSubview:self.countfield];
    UILabel*countinstructions=[[UILabel alloc] initWithFrame:CGRectMake(5*KWidth_Scale+(SCREEN_WIDTH-320*KWidth_Scale)/2.0,CGRectGetMaxY(countview.frame)+3,SCREEN_WIDTH*0.5, 15*KWidth_Scale)];
    countinstructions.textColor=[PublicFunction colorWithHexString:@"999999"];
    countinstructions.font=UIFont(13);
    countinstructions.text=[NSString stringWithFormat:@"本群共%@人",self.selfcount];
    [self.view addSubview:countinstructions];
    
    
    UIView *Leaveview=[[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-320*KWidth_Scale)/2.0,CGRectGetMaxY(countview.frame)+40*KWidth_Scale,320*KWidth_Scale, 45*KWidth_Scale)];
    Leaveview.backgroundColor=[UIColor whiteColor];
    Leaveview.layer.cornerRadius=5;
    Leaveview.clipsToBounds=YES;
    UILabel*leavetitle=[[UILabel alloc] initWithFrame:CGRectMake(15*KWidth_Scale, 0, 50, 45*KWidth_Scale)];
    leavetitle.textColor=WordsofcolorColor;
    leavetitle.font=UIFont(15);
    leavetitle.text=@"留言";
    [Leaveview addSubview:leavetitle];
    [Leaveview addSubview:self.Leavefield];
    [self.view addSubview:Leaveview];
    
    self.redlable=[[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(Leaveview.frame), SCREEN_WIDTH, 90*KWidth_Scale)];
    self.redlable.textColor=WordsofcolorColor;
    self.redlable.text=@"0.00";
    self.redlable.font=UIFont(30);
    self.redlable.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:self.redlable];
    
    [self.view addSubview:self.sendbtn];
}
-(void)setUI
{
    UIView *redview=[[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-320*KWidth_Scale)/2.0,20*KWidth_Scale,320*KWidth_Scale, 45*KWidth_Scale)];
    redview.backgroundColor=[UIColor whiteColor];
    redview.layer.cornerRadius=5;
    redview.clipsToBounds=YES;
    UILabel*redtitle=[[UILabel alloc] initWithFrame:CGRectMake(15*KWidth_Scale, 0,80, 45*KWidth_Scale)];
    redtitle.textColor=WordsofcolorColor;
    redtitle.font=UIFont(15);
    redtitle.text=@"彩蛋数量";
    [redview addSubview:redtitle];
    [redview addSubview:self.redfield];
    [self.view addSubview:redview];
    
    UIView *Leaveview=[[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-320*KWidth_Scale)/2.0,CGRectGetMaxY(redview.frame)+20*KWidth_Scale,320*KWidth_Scale, 45*KWidth_Scale)];
    Leaveview.backgroundColor=[UIColor whiteColor];
    Leaveview.layer.cornerRadius=5;
    Leaveview.clipsToBounds=YES;
    UILabel*leavetitle=[[UILabel alloc] initWithFrame:CGRectMake(15*KWidth_Scale, 0, 50, 45*KWidth_Scale)];
    leavetitle.textColor=WordsofcolorColor;
    leavetitle.font=UIFont(15);
    leavetitle.text=@"留言";
    [Leaveview addSubview:leavetitle];
    [Leaveview addSubview:self.Leavefield];
    [self.view addSubview:Leaveview];
    
    self.redlable=[[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(Leaveview.frame), SCREEN_WIDTH, 90*KWidth_Scale)];
    self.redlable.textColor=WordsofcolorColor;
    self.redlable.text=@"0.00";
    self.redlable.font=UIFont(30);
    self.redlable.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:self.redlable];
    
    [self.view addSubview:self.sendbtn];
}
-(UIButton *)sendbtn
{
    if (_sendbtn==nil) {
        _sendbtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _sendbtn.frame=CGRectMake((SCREEN_WIDTH-320*KWidth_Scale)/2.0, CGRectGetMaxY(self.redlable.frame), 320*KWidth_Scale, 45*KWidth_Scale);
        _sendbtn.layer.cornerRadius=5;
        _sendbtn.clipsToBounds=YES;
        _sendbtn.userInteractionEnabled=NO;
        _sendbtn.backgroundColor=RGB(252, 127, 92);
        [_sendbtn setTitle:@"塞进红包" forState:UIControlStateNormal];
        [_sendbtn addTarget:self action:@selector(sendrenmessage:) forControlEvents:UIControlEventTouchUpInside];
        [_sendbtn.titleLabel setFont:UIFont(16)];
    }
    return _sendbtn;
}
-(void)sendrenmessage:(UIButton *)sender
{
    WEAKSELF;
//    NSString *titletext=[NSString stringWithFormat:@"<font size=5  color='#333333'>请输入支付密码</font>"];
//    PayCustView *pass=[[PayCustView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) title:titletext detailstr:nil];
//    [pass shareviewShow];
//    [pass setMyblock:^(NSString *password) {
        [weakSelf beginsendRedmessage];
   // }];
    
}
-(void)beginsendRedmessage
{
    NSString *textstr=self.Leavefield.text;
    if (self.Leavefield.text.length==0) {
        textstr=@"恭喜发财,大吉大利";
    }
    if (self.convertype==ConversationType_PRIVATE) {
        if ([self.delegate respondsToSelector:@selector(sendRedmessage:leavemessage:)]) {
            [self.delegate sendRedmessage:self.redlable.text leavemessage:textstr];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    else if (self.convertype==ConversationType_GROUP)
    {
        if ([self.delegate respondsToSelector:@selector(GroupsendRedmessage:redcount:leavemessage:)]) {
            [self.delegate GroupsendRedmessage:self.redlable.text redcount:self.countfield.text leavemessage:textstr];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
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
