//
//  CommentsView.m
//  Woo
//
//  Created by 王起锋 on 2018/10/14.
//  Copyright © 2018年 杭州蜂布式. All rights reserved.
//

#import "CommentsView.h"
#import "CommentTableViewCell.h"
@interface CommentsView()
<UITableViewDelegate,UITableViewDataSource>
{
    UIView *moreView;
}
@property(nonatomic,strong)Custtextview *mytextview;
@property (nonatomic, strong) UITableView *myTableView;
@property(nonatomic,strong)UIButton *closeBtn;//打赏;
@end
@implementation CommentsView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self==[super initWithFrame:frame]) {
        self.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.3];
        [self addSubview:self.myTableView];
    }
    return self;
}
-(UITableView *)myTableView{
    if (!_myTableView) {
        _myTableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.height) style:UITableViewStyleGrouped];
        //_myTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _myTableView.allowsSelection=NO;
        //_myTableView.allowsSelection=NO;
        _myTableView.delegate=self;
        _myTableView.dataSource = self;
        _myTableView.showsVerticalScrollIndicator = NO;
        _myTableView.showsHorizontalScrollIndicator = NO;
        [_myTableView setTableFooterView:[UIView new]];
        _myTableView.separatorColor=CellBackgroundColor;
        _myTableView.backgroundColor=[UIColor whiteColor];
        _myTableView.layer.cornerRadius=10;
        _myTableView.clipsToBounds=YES;
        if (@available(iOS 11.0, *)) {
            _myTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _myTableView.estimatedRowHeight = 0;
            _myTableView.estimatedSectionFooterHeight = 0;
            _myTableView.estimatedSectionHeaderHeight = 0;
        }
    }
    return _myTableView;
}
#pragma mark - <UITableViewDelegate, UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 13;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        static NSString *onecellid=@"CommentTableViewCell";
        CommentTableViewCell *Commentcell=[tableView dequeueReusableCellWithIdentifier:onecellid];
        Commentcell=[[CommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:onecellid];
        return Commentcell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 100*KWidth_Scale;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50*KWidth_Scale;
  
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headview=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50*KWidth_Scale)];
    self.closeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.closeBtn.frame=CGRectMake(0, 0, 50*KWidth_Scale, 50*KWidth_Scale);
    [self.closeBtn setImage:[UIImage imageNamed:@"closered"] forState:UIControlStateNormal];
    [self.closeBtn addTarget:self action:@selector(closeMyself) forControlEvents:UIControlEventTouchUpInside];
    [headview addSubview:self.closeBtn];
    UILabel *commentLabel=[[UILabel alloc] initWithFrame:CGRectMake(70*KWidth_Scale, 0, SCREEN_WIDTH-140*KWidth_Scale, 50*KWidth_Scale)];
    commentLabel.textColor=WordsofcolorColor;
    commentLabel.font=UIFont(15);
    commentLabel.text=@"全部评论";
    commentLabel.textAlignment=NSTextAlignmentCenter;
    [headview addSubview:commentLabel];
    return headview;

}
-(void)closeMyself
{
    if (self.closepageBlock) {
        self.closepageBlock();
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    CGFloat offy=scrollView.contentOffset.y;
//    if (offy<0) {
//       self.myTableView.userInteractionEnabled=NO;
//    }
//    else{
//        self.myTableView.userInteractionEnabled=YES;
//    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
