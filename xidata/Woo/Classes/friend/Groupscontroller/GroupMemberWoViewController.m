//
//  GroupMemberWoViewController.m
//  Woo
//
//  Created by 王起锋 on 2018/9/6.
//  Copyright © 2018年 杭州蜂布式. All rights reserved.
//

#import "GroupMemberWoViewController.h"
#import "FriendTableViewCell.h"
@interface GroupMemberWoViewController ()
<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,SearchViewDelegate>
@property (nonatomic, strong)  BaseTableView * myTableView;
@end

@implementation GroupMemberWoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"社群成员列表";
    [self.myTableView reloadData];
}
    // Do any additional setup after loading the view.
-(BaseTableView *)myTableView{
    if (!_myTableView) {
        _myTableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-StatusBarAndNavigationBarHeight) style:UITableViewStyleGrouped];
        //_myTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _myTableView.separatorColor=CellBackgroundColor;
        _myTableView.delegate=self;
        _myTableView.dataSource = self;
        _myTableView.showsVerticalScrollIndicator = NO;
        _myTableView.showsHorizontalScrollIndicator = NO;
        [_myTableView setTableFooterView:[UIView new]];
        _myTableView.backgroundColor=RGB(255, 255, 255);
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

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
}
#pragma mark tableview的代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 12*KWidth_Scale;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55*KWidth_Scale;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *mycellid=@"FriendTableViewCell";
    FriendTableViewCell *newcell=[tableView dequeueReusableCellWithIdentifier:mycellid];
    if (newcell==nil) {
        newcell=[[FriendTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:mycellid];
    }
    RCDUserInfo *model;
    model=self.dataArray[indexPath.row];

    newcell.selectionStyle = UITableViewCellSelectionStyleNone;
    newcell.celltitlable.textColor=RGB(102, 102, 102);
    newcell.celltitlable.font=DefleFuont;
    
    [newcell.userimageview sd_setImageWithURL:[NSURL URLWithString:model.portraitUri] placeholderImage:[UIImage imageNamed:@"photo_boy"]];
        if (![PublicFunction isEmpty:model.displayName]) {
            newcell.celltitlable.text=model.displayName;
        }
        else{
            newcell.celltitlable.text=model.name;
        }
    newcell.accessoryType = UITableViewCellAccessoryNone;
    newcell.selectionStyle = UITableViewCellSelectionStyleNone;
    return newcell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self getFriendRelationship:self.dataArray[indexPath.row]];
        return;
}
-(void)getFriendRelationship:(RCDUserInfo *)model
{
    [[ChatmangerObject ShareManger] getFriendRelationship:model.userId successBlock:^(id returnData) {
        RCDUserInfo *userinfomodel=(RCDUserInfo *)returnData;
        ContactdetailViewController *contact=[[ContactdetailViewController alloc] init];
        contact.userinfo=userinfomodel;
        if ([userinfomodel.status isEqualToString:@"1"]) {
            contact.ismyfriend=YES;
            [self.navigationController pushViewController:contact animated:YES];
            return ;
        }
        else{
            contact.ismyfriend=NO;
            [self.navigationController pushViewController:contact animated:YES];
            return;
        }
    } failureBlock:^(NSError *error) {
        
    }];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return CGFLOAT_MIN;
    }
    else if (section==1){
        return CGFLOAT_MIN;
    }
    return 0.1*KWidth_Scale;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footview=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 13*KWidth_Scale)];
    footview.backgroundColor=CellBackgroundColor;
    if (section!=2) {
        return [UIView new];
    }
    return [UIView new];
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *backview=[[UIView alloc] initWithFrame:CGRectMake(0, 0*KWidth_Scale, SCREEN_WIDTH, 50*KWidth_Scale)];
    backview.backgroundColor=[UIColor whiteColor];
    UILabel *nametitle=[PublicFunction getlabelwithtexttitle:@"聊天" fram:CGRectMake(15*KWidth_Scale,0, SCREEN_WIDTH*0.5, 50*KWidth_Scale) cornerRadius:0 textcolor:WordsofcolorColor textfont:DefleFuont backcolor:[UIColor whiteColor] textAlignment:NSTextAlignmentLeft];
    [backview
     addSubview:nametitle];
    UIView *cellview=[[UIView alloc] initWithFrame:CGRectMake(0, 50*KWidth_Scale, SCREEN_WIDTH, 0.7*KWidth_Scale)];
    cellview.backgroundColor=CellBackgroundColor;
    [backview addSubview:cellview];
    return [UIView new];
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
