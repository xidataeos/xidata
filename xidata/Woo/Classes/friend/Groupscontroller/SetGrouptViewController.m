
//
//  SetGrouptViewController.m
//  Woo
//
//  Created by 王起锋 on 2018/8/7.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import "SetGrouptViewController.h"
#define BTN_TAG 336
@interface SetGrouptViewController ()<UITextFieldDelegate,UITextViewDelegate,UINavigationBarDelegate,UIImagePickerControllerDelegate>
@property(nonatomic,strong)UITextField *groupnamefield;
@property(nonatomic,strong)UITextView *jianjiefield;
@property(nonatomic,strong)UIImageView *useriamge;
@property(nonatomic,strong)UILabel *namecount;
@property(nonatomic,strong)UILabel *jianjiecount;
@property(nonatomic,strong)UIView *cell;
@property(nonatomic,strong)UIView *midcell;
@property(nonatomic,strong)NSMutableArray *selectarr;
@property(nonatomic,strong)UIView *topmidbackview;
@property(nonatomic,assign)NSInteger selectindex;
@end

@implementation SetGrouptViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=@"信息设置";
    [self settopview];
    [self setbotomoview];
    [self setnavigation];
    // Do any additional setup after loading the view.
}
-(void)setnavigation
{
    UIButton *  rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setTitle:@"完成" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(setgroup) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.frame = CGRectMake(SCREEN_WIDTH - 45, 25, 20, 20);
    UIBarButtonItem *right=[[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem=right;
}
-(void)setgroup
{
    NSMutableDictionary *parametDic = [[NSMutableDictionary alloc] init];
    NSData *dataImage = UIImageJPEGRepresentation(self.useriamge.image, 0.5);
    //生成签名
    [parametDic setObject:self.froupmodel.groupId forKey:@"cid"];
    [parametDic setObject:self.froupmodel.creatorId forKey:@"ownerId"];
    [parametDic setObject:self.groupnamefield.text forKey:@"name"];
    NSString *pub;
    if (self.selectindex==0) {
        pub=@"1";
    }
    else{
        pub=@"0";
    }
    [parametDic setObject:pub forKey:@"pub"];
    [parametDic setValue:dataImage forKey:@"photoFile"];
    WQUploadParam *loadimag=[[WQUploadParam alloc] init];
    loadimag.data=dataImage;
    loadimag.name=@"photoFile";
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0),^{
        
    [AfnetHttpsTool uploadFileWithURL:Modifythegroup params:parametDic successBlock:^(id returnData) {
            [self dismiss];
            if([returnData[@"status"] isEqualToString:@"200"]) {
                NSDictionary *dic=returnData[@"data"];
                if (dic) {
               self.froupmodel.introduce=self.jianjiefield.text;
                self.froupmodel.groupName=self.groupnamefield.text;
                    self.froupmodel.portraitUri=dic[@"urlPhoto"];
                    [[RCDataBaseManager shareInstance] insertGroupToDB:self.froupmodel];
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }
            else{
                [self showErrorWithStatus:returnData[@"message"]];
            }
        } failureBlock:^(NSError *error) {
            [self showErrorWithStatus:@"群信息设置失败"];
            [self dismiss];
            if (error) {
                return ;
            }
        } uploadParam:loadimag];
        
    });
}

-(NSMutableArray *)selectarr
{
    if (_selectarr==nil) {
        _selectarr=[[NSMutableArray alloc] init];
    }
    return _selectarr;
}
-(UIView *)midcell
{
    if (_midcell==nil) {
        _midcell=[[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topmidbackview.frame)+20*KWidth_Scale, SCREEN_WIDTH, 12*KWidth_Scale)];
        _midcell.backgroundColor=CellBackgroundColor;
    }
    return _midcell;
}
-(UILabel *)namecount
{
    if (_namecount==nil) {
        _namecount=[[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-15*KWidth_Scale-50*KWidth_Scale, 62*KWidth_Scale, 50*KWidth_Scale, 20*KWidth_Scale)];
        NSString *titletext=[NSString stringWithFormat:@"<font color='#ff8170'>%d</font><font color='#999999'>/15</font>",0];
        [_namecount setAttributedText:[PublicFunction attributedStringWithHTMLString:titletext]];
        _namecount.textAlignment=NSTextAlignmentRight;
        _namecount.font=UIFont(13);
    }
    return _namecount;
}
-(UILabel *)jianjiecount
{
    if (_jianjiecount==nil) {
        _jianjiecount=[[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-30*KWidth_Scale-105*KWidth_Scale, 130*KWidth_Scale, 100*KWidth_Scale, 20*KWidth_Scale)];
        NSString *titletext=[NSString stringWithFormat:@"<font color='#ff8170'>%d</font><font color='#999999'>/200</font>",0];
        [_jianjiecount setAttributedText:[PublicFunction attributedStringWithHTMLString:titletext]];
        _jianjiecount.textAlignment=NSTextAlignmentRight;
        _jianjiecount.font=UIFont(13);
    }
    return _jianjiecount;
}
-(UIView *)cell
{
    if (_cell==nil) {
        _cell=[[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.useriamge.frame)+15*KWidth_Scale, CGRectGetMaxY(self.groupnamefield.frame)+3, SCREEN_WIDTH-45*KWidth_Scale, 0.7)];
        _cell.backgroundColor=CellBackgroundColor;
    }
    return _cell;
}
-(UITextView *)jianjiefield
{
    if (_jianjiefield==nil) {
        _jianjiefield=[[UITextView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH-30*KWidth_Scale, 130*KWidth_Scale)];
        _jianjiefield.textColor=WordsofcolorColor;
        _jianjiefield.font=UIFont(14);
        _jianjiefield.text=self.froupmodel.introduce;
        _jianjiefield.delegate=self;
    }
    return _jianjiefield;
}
-(UITextField *)groupnamefield
{
    if (_groupnamefield==nil) {
        _groupnamefield=[[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.useriamge.frame)+15*KWidth_Scale,62*KWidth_Scale, SCREEN_WIDTH-55-70*KWidth_Scale-15*KWidth_Scale,20*KWidth_Scale)];
        _groupnamefield.placeholder=@"请输入社群名称";
        _groupnamefield.textAlignment=NSTextAlignmentLeft;
        _groupnamefield.textColor=WordsofcolorColor;
        _groupnamefield.font=[UIFont systemFontOfSize:14];
        _groupnamefield.delegate=self;
        //_editorfield.keyboardType=UIKeyboardTypeNumberPad;
        [_groupnamefield addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        _groupnamefield.text=self.froupmodel.groupName;
    }
    return _groupnamefield;
}
-(void)textFieldDidChange:(UITextField *)textField
{
    if (textField == self.groupnamefield) {
        if (textField.text.length > 20) {
            textField.text = [textField.text substringToIndex:15];
        }
        [self setnamecount:textField.text.length];
    }
}
-(void)textViewDidChange:(UITextView *)textView
{
    if (textView == self.jianjiefield) {
        if (textView.text.length > 200) {
            textView.text = [textView.text substringToIndex:15];
        }
        [self setjianjiecount:textView.text.length];
    }
}
-(void)setjianjiecount:(NSInteger)index
{
    NSString *titletext=[NSString stringWithFormat:@"<font color='#ff8170'>%ld</font><font color='#999999'>/200</font>",(long)index];
    [_jianjiecount setAttributedText:[PublicFunction attributedStringWithHTMLString:titletext]];
    _jianjiecount.textAlignment=NSTextAlignmentRight;
    _jianjiecount.font=UIFont(13);
}
-(void)setnamecount:(NSInteger)index
{
    NSString *titletext=[NSString stringWithFormat:@"<font color='#ff8170'>%ld</font><font color='#999999'>/15</font>",(long)index];
    [_namecount setAttributedText:[PublicFunction attributedStringWithHTMLString:titletext]];
    _namecount.textAlignment=NSTextAlignmentRight;
    _namecount.font=UIFont(13);
}
-(UIImageView *)useriamge
{
    if (_useriamge==nil) {
        _useriamge=[[UIImageView alloc] initWithFrame:CGRectMake(15*KWidth_Scale, 25*KWidth_Scale, 70*KWidth_Scale, 70*KWidth_Scale)];
        _useriamge.clipsToBounds=YES;
        _useriamge.layer.cornerRadius=35*KWidth_Scale;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editeimage)];
        _useriamge.userInteractionEnabled=YES;
        [_useriamge addGestureRecognizer:tap];
    }
    return _useriamge;
}
-(void)editeimage
{
    WEAKSELF;
    /*
     edit:照片需要裁剪:传YES,不需要裁剪传NO(默认NO)
     */
    [self showCanEdit:NO photo:^(UIImage *photo) {
       weakSelf.useriamge.image = photo;
    }];

}
-(void)settopview
{
    [self.view addSubview:self.useriamge];
    [self.useriamge sd_setImageWithURL:[NSURL URLWithString:self.froupmodel.portraitUri] placeholderImage:[UIImage imageNamed:@"photo_boy"]];
    UILabel *mingcheng=[self getcustlabel:CGRectMake(CGRectGetMaxX(self.useriamge.frame)+15*KWidth_Scale,35*KWidth_Scale, SCREEN_WIDTH*0.4, 20*KWidth_Scale) text:@"请编辑社群名称"];
    [self.view addSubview:mingcheng];
    [self.view addSubview:self.groupnamefield];
    [self.view addSubview:self.namecount];
    [self.view addSubview:self.cell];
    
    UILabel *jianjieeditor=[self getcustlabel:CGRectMake(15*KWidth_Scale, CGRectGetMaxY(self.useriamge.frame)+35*KWidth_Scale, SCREEN_WIDTH*0.7, 20*KWidth_Scale) text:@"可增加一段话来介绍你的社群"];
    [self.view addSubview:jianjieeditor];
    
    self.topmidbackview=[[UIView alloc] initWithFrame:CGRectMake(15*KWidth_Scale,CGRectGetMaxY(self.useriamge.frame)+60*KWidth_Scale, SCREEN_WIDTH-30*KWidth_Scale, 150*KWidth_Scale)];
    _topmidbackview.backgroundColor=[UIColor whiteColor];
    _topmidbackview.layer.borderWidth=1.0;
    _topmidbackview.layer.borderColor=RGB(153, 153, 153).CGColor;
    [self.view addSubview:_topmidbackview];
    [_topmidbackview addSubview:self.jianjiefield];
    [_topmidbackview addSubview:self.jianjiecount];
    
}
-(UILabel *)getcustlabel:(CGRect)rect text:(NSString *)text
{
    UILabel *label=[[UILabel alloc] initWithFrame:rect];
    label.text=text;
    label.font=DefleFuont;
    label.textColor=RGB(153, 153, 153);
    return label;
}

-(void)setbotomoview
{
    [self.view addSubview:self.midcell];
    UILabel *titlelabel=[self getcustlabel:CGRectMake(15*KWidth_Scale,CGRectGetMaxY(self.midcell.frame)+10*KWidth_Scale, SCREEN_WIDTH*0.4, 30*KWidth_Scale) text:@"基本设置"];
    [self.view addSubview:titlelabel];
    
    NSArray *title=[[NSArray alloc] initWithObjects:@"公开社群",@"私人社群", nil];
    NSArray *descrtion=[[NSArray alloc] initWithObjects:@"无需验证直接进群",@"加群申请需要群主同意", nil];
    UIView *botomoview=[[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titlelabel.frame)+15*KWidth_Scale, SCREEN_WIDTH, 120*KWidth_Scale)];
    [self.view addSubview:botomoview];
    for (int i=0; i<2; i++) {
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(0,i*60*KWidth_Scale , 60*KWidth_Scale, 60*KWidth_Scale);
        [btn setImage:[UIImage imageNamed:@"unsekecticon"] forState:UIControlStateNormal];
         [btn setImage:[UIImage imageNamed:@"selecticon"] forState:UIControlStateSelected];
        [btn setImageEdgeInsets:UIEdgeInsetsMake(20*KWidth_Scale, 20*KWidth_Scale, 20*KWidth_Scale, 20*KWidth_Scale)];
        [botomoview addSubview:btn];
        [self.selectarr addObject:btn];
        [btn addTarget:self action:@selector(btnclick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag=BTN_TAG+i;
        if (i==0) {
            self.selectindex=i;
            btn.selected=YES;
        }
        
        UILabel *nametitle=[PublicFunction getlabelwithtexttitle:title[i] fram:CGRectMake(CGRectGetMaxX(btn.frame)+10*KWidth_Scale, 10*KWidth_Scale+i*60*KWidth_Scale, SCREEN_WIDTH*0.5, 20*KWidth_Scale) cornerRadius:0 textcolor:WordsofcolorColor textfont:DefleFuont backcolor:[UIColor whiteColor] textAlignment:NSTextAlignmentLeft];
        [botomoview addSubview:nametitle];
        
        UILabel *desctiontitle=[PublicFunction getlabelwithtexttitle:descrtion[i] fram:CGRectMake(CGRectGetMaxX(btn.frame)+10*KWidth_Scale, CGRectGetMaxY(nametitle.frame), SCREEN_WIDTH*0.5, 20*KWidth_Scale) cornerRadius:0 textcolor:RGB(153, 153, 153) textfont:UIFont(13) backcolor:[UIColor whiteColor] textAlignment:NSTextAlignmentLeft];
        [botomoview addSubview:desctiontitle];
    }
}
-(void)btnclick:(UIButton *)sender
{
    for (int i=0; i<self.selectarr.count; i++) {
        UIButton *btn=self.selectarr[i];
        if (i==sender.tag-BTN_TAG) {
            self.selectindex=i;
            btn.selected=YES;
        }
        else{
            btn.selected=NO;
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
