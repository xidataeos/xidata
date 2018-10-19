
//
//  albumSelectview.m
//  Woo
//
//  Created by 王起锋 on 2018/10/12.
//  Copyright © 2018年 杭州蜂布式. All rights reserved.
//
#define LXD_SCREEN_HEIGHT 360
#import "albumSelectview.h"
@interface albumSelectview ()
<UITableViewDelegate,UITableViewDataSource>
{
    NSString *mytitle;
}
@property(nonatomic,strong)baseview *bottomview;
@property(strong,nonatomic)NSMutableArray *listdata;
@end
@implementation albumSelectview
-(instancetype)initWithFrame:(CGRect)frame title:(NSString *)title detailtitle:(NSMutableArray *)detailtitle btntitle:(NSString *)btntitle;

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
    self.bottomview=[[baseview alloc] initWithFrame:CGRectMake(0,(SCREEN_HEIGHT-(80+self.listdata.count*50)-50-15), SCREEN_WIDTH,80+self.listdata.count*50+15+50)];
    self.bottomview.backgroundColor=[UIColor whiteColor];
    self.bottomview.clipsToBounds=YES;
    
    [self addSubview:self.bottomview];
    [self setAlertViewnobtntypewithtitle:title detailtitle:detailtitle btntitle:btntitle];
}
-(void)setAlertViewnobtntypewithtitle:(NSString *)title detailtitle:(NSMutableArray *)detailtitle btntitle:(NSString *)btntitle
{
    mytitle=title;
    self.tableview=[[UITableView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH,80+self.listdata.count*50) style:UITableViewStylePlain];
    self.tableview.backgroundColor=[UIColor whiteColor];
    self.tableview.delegate=self;
    self.tableview.dataSource=self;
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
    static NSString *SimpleTableIdentifier = @"albumTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleTableIdentifier];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SimpleTableIdentifier];
    cell.selectedBackgroundView=[[UIView alloc] initWithFrame:cell.frame];
    NSString *title;
    id object=self.listdata[indexPath.row];
    if ([object isKindOfClass:[NSString class]]) {
        title=(NSString *)object;
    }
    cell.textLabel.font=UIFont(15);
    HomeModel *model=self.listdata[indexPath.row];
    cell.textLabel.text=model.title;
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"logo_icon"]];
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
    return 50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 80;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *mheadview=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80)];
    mheadview.backgroundColor=[UIColor whiteColor];
    
    UIView *headview=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 25)];
    headview.backgroundColor=UIColorFromRGB(0xE51C23);
    UIView *cellline=[[UIView alloc] initWithFrame:CGRectMake(0, 79, SCREEN_WIDTH, 0.7)];
    cellline.backgroundColor=CellBackgroundColor;
    UILabel *titlelabel=[PublicFunction getlabelwithtexttitle:mytitle fram:CGRectMake(15*KWidth_Scale, 0, self.bottomview.witdth, 25) cornerRadius:0 textcolor:[UIColor whiteColor] textfont:[UIFont systemFontOfSize:12] backcolor:[UIColor clearColor] textAlignment:NSTextAlignmentLeft];
    UIButton *icon=[UIButton buttonWithType:UIButtonTypeCustom];
    icon.frame=CGRectMake(0*KWidth_Scale, CGRectGetMaxY(headview.frame),120, 50);
    [icon setTitle:@"创建新专辑" forState:UIControlStateNormal];
    [icon setTitleColor:UIColorFromRGB(0xE51C23) forState:UIControlStateNormal];
    [icon setImageEdgeInsets:UIEdgeInsetsMake(0,0*KWidth_Scale, 0, 0)];
    [icon addTarget:self action:@selector(cgreatnewalim) forControlEvents:UIControlEventTouchUpInside];
    [headview addSubview:titlelabel];
    [mheadview addSubview:headview];
    [mheadview addSubview:icon];
    if (self.listdata.count!=0) {
        [mheadview addSubview:cellline];
    }
    return mheadview;
}
-(void)cgreatnewalim
{
    if (self.creatblock) {
        [self closepage];
        self.creatblock();
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
