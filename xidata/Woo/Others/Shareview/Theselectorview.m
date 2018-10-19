
//
//  uploadalertview.m
//  Backtorent
//
//  Created by 零号007 on 2017/12/9.
//  Copyright © 2017年 零号007. All rights reserved.
//
#define LXD_SCREEN_HEIGHT 360
#import "Theselectorview.h"
#import "Theselectorviewcell.h"
@interface Theselectorview()<UITableViewDelegate,UITableViewDataSource>
{
    NSString *mytitle;
}
@property(nonatomic,strong)baseview *bottomview;
@property(strong,nonatomic)NSMutableArray *listdata;

@end
@implementation Theselectorview
-(instancetype)initWithFrame:(CGRect)frame withWQAlertViewType:(WQAlertViewType)AlertViewType title:(NSString *)title detailtitle:(NSMutableArray *)detailtitle btntitle:(NSString *)btntitle
{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:1.0f];
        self.listdata=detailtitle;
        [self creatalertviewtitle:title detailtitle:detailtitle btntitle:btntitle];
    }
    return self;
}
-(void)creatalertviewtitle:(NSString *)title detailtitle:(NSMutableArray *)detailtitle btntitle:(NSString *)btntitle
{
    self.bottomview=[[baseview alloc] initWithFrame:CGRectMake(0,(SCREEN_HEIGHT-detailtitle.count*44-130), SCREEN_WIDTH, detailtitle.count*44+130)];
    self.bottomview.backgroundColor=[UIColor blackColor];
    self.bottomview.clipsToBounds=YES;
   
    [self addSubview:self.bottomview];
    [self setAlertViewnobtntypewithtitle:title detailtitle:detailtitle btntitle:btntitle];
}
-(void)setAlertViewnobtntypewithtitle:(NSString *)title detailtitle:(NSMutableArray *)detailtitle btntitle:(NSString *)btntitle
{
    mytitle=title;
    self.tableview=[[UITableView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH,detailtitle.count*44+80) style:UITableViewStylePlain];
    self.tableview.backgroundColor=[UIColor whiteColor];
    self.tableview.delegate=self;
    self.tableview.dataSource=self;
 self.tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableview.separatorColor=RGB(238, 238, 238);
    [self.tableview setTableFooterView:[[UIView alloc] init]] ;
    [self.bottomview addSubview:self.tableview];
    UIButton *btn=[PublicFunction getbtnwithtexttitle:btntitle fram:CGRectMake(0,self.bottomview.height-50, self.bottomview.witdth-0, 50) cornerRadius:0 textcolor:RGB(255, 255, 255) textfont:[UIFont systemFontOfSize:15] backcolor:NaviBackgroundColor];
        [self.bottomview addSubview:btn];
    [btn addTarget:self action:@selector(btnclick:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)btnclick:(UIButton *)btn
{
    [self closepage];
}
-(void)show
{
    [UIView animateWithDuration:0.5f animations:^{
        self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.3f];
    } completion:^(BOOL finished) {
        CGPoint center = self.bottomview.center;
        CGPoint startCenter = center;
        startCenter.y += LXD_SCREEN_HEIGHT;
        self.bottomview.center = startCenter;
        [UIView animateWithDuration: 0.5 delay: 0.35  usingSpringWithDamping: 0.6 initialSpringVelocity: 0 options: UIViewAnimationOptionCurveLinear animations: ^{
            self.bottomview.center = center;
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            [window addSubview:self];
            [self.tableview reloadData];
        } completion: nil];
       
    }];
    

}
-(void)closepage
{
    [UIView animateWithDuration:0.5f animations:^{
        self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.3f];
        CGPoint center = self.bottomview.center;
        CGPoint startCenter = center;
        startCenter.y += LXD_SCREEN_HEIGHT;
        self.bottomview.center = startCenter;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration: 0.5 delay: 0.35  usingSpringWithDamping: 0.6 initialSpringVelocity: 0 options: UIViewAnimationOptionCurveLinear animations: ^{
            [self removeFromSuperview];
        } completion: nil];
        
    }];
    
    [UIView animateWithDuration:0.5f animations:^{
        self.alpha = 0.f;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listdata.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *SimpleTableIdentifier = @"Theselectorviewcell";
    Theselectorviewcell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleTableIdentifier];
    cell = [[Theselectorviewcell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SimpleTableIdentifier indexPath:indexPath];
    cell.selectedBackgroundView=[[UIView alloc] initWithFrame:cell.frame];
    NSString *title;
    id object=self.listdata[indexPath.row];
    if ([object isKindOfClass:[NSString class]]) {
       title=(NSString *)object;
    }
    HomeModel *model=self.listdata[indexPath.row];
    cell.nameLabel.text=model.title;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.block) {
        self.block(self.listdata[indexPath.row]);
    }
    [self closepage];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *cellline=[[UIView alloc] initWithFrame:CGRectMake(0, 59, SCREEN_WIDTH, 0.7)];
    cellline.backgroundColor=CellBackgroundColor;
    UILabel *titlelabel=[PublicFunction getlabelwithtexttitle:mytitle fram:CGRectMake(0, 0, self.bottomview.witdth, 60) cornerRadius:0 textcolor:RGB(153, 153, 153) textfont:[UIFont systemFontOfSize:15] backcolor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter];
    [titlelabel addSubview:cellline];
    return titlelabel;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
