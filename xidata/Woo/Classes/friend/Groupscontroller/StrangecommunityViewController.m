
//
//  StrangecommunityViewController.m
//  Woo
//
//  Created by 王起锋 on 2018/8/7.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import "StrangecommunityViewController.h"
#import "Gropudetailheadview.h"
@interface StrangecommunityViewController ()
@property (nonatomic, strong)  UIButton * addgroup;
@end

@implementation StrangecommunityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self settableviewheadview];
    [self.view addSubview:self.addgroup];
    // Do any additional setup after loading the view.
}
-(UIButton *)addgroup
{
    NSString *title=@"申请加群";
  
    CGFloat offy=0;
    if (iPhoneX) {
        offy=44;
    }
    if (_addgroup==nil) {
        _addgroup=[UIButton buttonWithType:UIButtonTypeCustom];
        _addgroup.frame=CGRectMake(15,ScreenHeight-20-44-15-44-offy, SCREEN_WIDTH-30, 44);
        _addgroup.backgroundColor=NaviBackgroundColor;
        _addgroup.layer.cornerRadius=5;
        _addgroup.clipsToBounds=YES;
        [_addgroup setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_addgroup setTitle:title forState:UIControlStateNormal];
        [_addgroup addTarget:self action:@selector(addfriend:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addgroup;
}
-(void)addfriend:(UIButton *)sender
{
    NSString *title=@"确定加入该群组？";
        CustAlertview *alert=[[CustAlertview alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) title:@"提示" detailstr:title];
        [alert shareviewShow];
        [alert setMyblock:^{
            [self sendJionGroup];
        }];
        return;
}
-(void)sendJionGroup
{
    [[ChatmangerObject ShareManger] sendJionGroup:self.groups.groupId frome:self];
}
-(void)settableviewheadview
{
    CGFloat heightY=[Gropudetailheadview getmyheight:[NSString stringWithFormat:@"      %@",self.groups.introduce]];
    Gropudetailheadview *headview=[[Gropudetailheadview alloc] initWithFrame:CGRectMake(0, 15*KWidth_Scale, SCREEN_WIDTH, heightY) withgroupmodel:self.groups];
    [self.view addSubview:headview];
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
