
//
//  EditorbeizhuViewController.m
//  Woo
//
//  Created by 王起锋 on 2018/8/7.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import "EditorbeizhuViewController.h"

@interface EditorbeizhuViewController ()<UITextFieldDelegate>
@property(nonatomic,strong)UITextField *editorfield;
@end

@implementation EditorbeizhuViewController
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"备注编辑";
    [self.editorfield becomeFirstResponder];
    self.view.backgroundColor=[UIColor whiteColor];
    [self setnavigation];
    [self setUI];
    // Do any additional setup after loading the view.
}
-(void)setUI
{
    UIView *topview=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 15*KWidth_Scale)];
    topview.backgroundColor=CellBackgroundColor;
    [self.view addSubview:topview];
    
    UIView *backview=[[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(topview.frame), SCREEN_WIDTH, 60)];
    backview.backgroundColor=[UIColor whiteColor];
    UIView *cell=[[UIView alloc] initWithFrame:CGRectMake(15, 59, SCREEN_WIDTH-30, 0.7)];
    cell.backgroundColor=CellBackgroundColor;
    [backview addSubview:cell];
    
    UILabel *beizhu=[[UILabel alloc] initWithFrame:CGRectMake(15, 10, 40, 40)];
    beizhu.textColor=WordsofcolorColor;
    beizhu.font=DefleFuont;
    beizhu.text=@"备注";
    [backview addSubview:beizhu];
    [backview addSubview:self.editorfield];
    [self.view addSubview:backview];
}
-(void)setnavigation
{
    UIButton *  rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setTitle:@"保存" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(setBtnClick) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.frame = CGRectMake(SCREEN_WIDTH - 45, 25, 20, 20);
    UIBarButtonItem *right=[[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem=right;
}
-(UITextField *)editorfield
{
    if (_editorfield==nil) {
        _editorfield=[[UITextField alloc] initWithFrame:CGRectMake(40+15+5,11, SCREEN_WIDTH-55,40)];
        _editorfield.text=self.usermodel.displayName;
        _editorfield.textAlignment=NSTextAlignmentLeft;
        _editorfield.textColor=RGB(102, 102, 102);
        _editorfield.font=[UIFont systemFontOfSize:16];
        _editorfield.delegate=self;
        //_editorfield.keyboardType=UIKeyboardTypeNumberPad;
        [_editorfield addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _editorfield;
}
-(void)textFieldDidChange:(UITextField *)textField
{
    if (textField == self.editorfield) {
        if (textField.text.length > 20) {
            textField.text = [textField.text substringToIndex:20];
        }
    }
}
#pragma mark
-(void)setBtnClick
{
    if (self.editorfield.text.length==0) {
        [self showInfoWithStatus:@"备注信息还是为空的哦!"];
        return;
    }
    else{
        [self noteSave];
    }
}
-(void)noteSave
{
    [self.view endEditing:YES];
    NSMutableDictionary *parametDic = [NSMutableDictionary dictionaryWithCapacity:9];
    [parametDic setObject:RCLOUD_ID forKey:@"mid"];
    [parametDic setObject:self.usermodel.userId forKey:@"fid"];
    [parametDic setObject:self.editorfield.text forKey:@"nickname"];
     [self showWithStatus:@"请求处理中..."];
    [UserRequestToo shareInstance].rquesturl=nickFnameRequrl;
    [UserRequestToo shareInstance].params=parametDic;
    [[UserRequestToo shareInstance] statrrequestgetwith:MHAsiNetWorkPOST successBlock:^(id returnData) {
        [self dismiss];
        if (returnData[@"success"]) {
            if ([returnData[@"status"] isEqualToString:@"200"]) {
                if ([self.delegate respondsToSelector:@selector(savelabel:)]) {
                    [self.delegate savelabel:self.editorfield.text];
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }
            else{
                [self showErrorWithStatus:returnData[@"message"]];
            }
      }
    } failureBlock:^(NSError *error) {
        [self dismiss];
        [self showErrorWithStatus:@"备注信息失败,稍后再试"];
        
    }];
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
