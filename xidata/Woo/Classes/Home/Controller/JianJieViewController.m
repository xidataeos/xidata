
//
//  JianJieViewController.m
//  Woo
//
//  Created by 王起锋 on 2018/10/15.
//  Copyright © 2018年 杭州蜂布式. All rights reserved.
//

#import "JianJieViewController.h"

@interface JianJieViewController ()
@property(nonatomic,strong)UILabel *titllabel;
@property(nonatomic,strong)UILabel *mytitllabel;
@property(nonatomic,strong)UIImageView *imageview;
@property (nonatomic, strong) UIButton *closeBtn;
@end

@implementation JianJieViewController
-(UIButton *)closeBtn
{
    if (_closeBtn==nil) {
        _closeBtn= [UIButton buttonWithType:(UIButtonTypeCustom)];
        _closeBtn.frame=CGRectMake(SCREEN_WIDTH-50, StatusBarHeight+5*KWidth_Scale, 50, 50);
        [_closeBtn setImage:[UIImage imageNamed:@"selecticon"] forState:(UIControlStateNormal)];
        _closeBtn.adjustsImageWhenHighlighted = YES;
        [_closeBtn addTarget:self action:@selector(closepage:) forControlEvents:(UIControlEventTouchUpInside)];
        [_closeBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [_closeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _closeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//使图片和文字水平居中显示
    }
    return _closeBtn;
}
-(UILabel *)mytitllabel
{
    if (_mytitllabel==nil) {
        _mytitllabel=[[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*0.2,StatusBarHeight+5*KWidth_Scale, SCREEN_WIDTH*0.6,50)];
        _mytitllabel.font=UIFont(16);
        _mytitllabel.textColor=WordsofcolorColor;
        _mytitllabel.textAlignment=NSTextAlignmentCenter;
        _mytitllabel.numberOfLines=0;
    }
    return _mytitllabel;
}
-(void)closepage:(UIButton *)btn
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(UIImageView *)imageview
{
    if (_imageview==nil) {
        _imageview=[[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-200*KWidth_Scale)/2.0,StatusBarAndNavigationBarHeight+25*KWidth_Scale,200*KWidth_Scale , 200*KWidth_Scale)];
        _imageview.layer.cornerRadius=10;
        _imageview.clipsToBounds=YES;
        [_imageview sd_setImageWithURL:[NSURL URLWithString:self.infoModel.img] placeholderImage:[UIImage imageNamed:@""]];
    }
    return _imageview;
}
-(UILabel *)titllabel
{
    if (_titllabel==nil) {
        _titllabel=[[UILabel alloc] initWithFrame:CGRectMake(10*KWidth_Scale,CGRectGetMaxY(self.imageview.frame)+10, SCREEN_WIDTH-20*KWidth_Scale,SCREEN_WIDTH)];
        _titllabel.font=UIFont(15);
        _titllabel.textColor=WordsofcolorColor;
        _titllabel.numberOfLines=0;
    }
    return _titllabel;
}
+ (CGFloat)getmyheight:(NSString *)introduction
{
    CGSize pricelabelsize=[introduction boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-20*KWidth_Scale, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:UIFont(15) forKey:NSFontAttributeName] context:nil].size;;
    return pricelabelsize.height+10*KWidth_Scale;
}
-(CGFloat)getmyheight:(NSString *)introduction
{
    CGSize pricelabelsize=[introduction boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-30*KWidth_Scale, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:UIFont(15) forKey:NSFontAttributeName] context:nil].size;;
    return pricelabelsize.height+5*KWidth_Scale;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.mytitllabel];
    self.mytitllabel.text=@"我是标题";
    [self.view addSubview:self.imageview];
    [self.view addSubview:self.titllabel];
    self.mytitllabel.text=self.infoModel.title;
    [self.view addSubview:self.closeBtn];
    [UIView animateWithDuration:0.2 animations:^{
        self.titllabel.frame=CGRectMake(10*KWidth_Scale, CGRectGetMaxY(self.imageview.frame)+10, SCREEN_WIDTH-20*KWidth_Scale, [self getmyheight:self.infoModel.intro]);
    }];
    self.titllabel.text=self.infoModel.intro;
   UIImage * newimage=[self imageFromImage:self.imageview.image inRect:CGRectMake(0, 0, 10, 10 )];
   self.view.layer.contents=(id)newimage.CGImage;
    // Do any additional setup after loading the view.
}
// 裁剪图片
-(UIImage *)imageFromImage:(UIImage *)image inRect:(CGRect)rect {
    CGImageRef sourceImageRef = [image CGImage];
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, rect);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    CGImageRelease(newImageRef);
    return newImage;
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
