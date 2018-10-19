//
//  PoPovWooViewController.m
//  Woo
//
//  Created by 王起锋 on 2018/9/20.
//  Copyright © 2018年 杭州蜂布式. All rights reserved.
//

#import "PoPovWooViewController.h"
#import "PopMenu.h"
#import "EditContentViewController.h"
#import <IQAudioRecorderController/IQAudioRecorderViewController.h>
#import <IQAudioRecorderController/IQAudioCropperViewController.h>
#import <MediaPlayer/MediaPlayer.h>
#import "CertificationController.h"
#import "CreatealbumController.h"
@interface PoPovWooViewController ()<IQAudioRecorderViewControllerDelegate,IQAudioCropperViewControllerDelegate>
{
    NSString *audioFilePath;
}
@property (nonatomic, strong) PopMenu *popMenu;
@property (nonatomic, assign) BOOL ishidenavibar;;
@end

@implementation PoPovWooViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:YES];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    if (self.ishidenavibar) {
       [self.navigationController setNavigationBarHidden:NO];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.ishidenavibar=YES;
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"playback"]];
    /* * 模糊效果的三种风格
     *
     *  @param UIBlurEffectStyle
     *
     * UIBlurEffectStyleExtraLight,  //高亮
     * UIBlurEffectStyleLight,       //亮
     * UIBlurEffectStyleDark         //暗
     * */
    UIBlurEffect *blurEffect =[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView =[[UIVisualEffectView alloc]initWithEffect:blurEffect];
    effectView.frame = self.view.bounds;
    [self.view addSubview:effectView];
    [self showMenu];
    [self addcloseBtn];
    // Do any additional setup after loading the view.
}
-(void)addcloseBtn
{
    UIButton *closebtn=[UIButton buttonWithType:UIButtonTypeCustom];
    closebtn.frame=CGRectMake((SCREEN_WIDTH-45)/2.0,SCREEN_HEIGHT-StatusBarAndNavigationBarHeight,45, 45);
    [closebtn setImage:[UIImage imageNamed:@"closered"] forState:UIControlStateNormal];
    [closebtn setImageEdgeInsets:UIEdgeInsetsMake(15, 15, 15, 15)];
    [self.view addSubview:closebtn];
    [closebtn addTarget:self action:@selector(canleclick) forControlEvents:UIControlEventTouchUpInside];
}
-(void)canleclick
{
    self.ishidenavibar=NO;
    [_popMenu dismissMenu];
    [self performSelector:@selector(dismissself) withObject:nil afterDelay:0.2];
}
-(void)dismissself
{
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}
- (void)showMenu {
    NSMutableArray *items = [[NSMutableArray alloc] initWithCapacity:3];
    
    MenuItem *menuItem = [MenuItem itemWithTitle:@"发图文" iconName:@"weixin_icon" glowColor:RGBAColor(255, 100, 0, 0.3)];
    [items addObject:menuItem];
    
    menuItem = [MenuItem itemWithTitle:@"录音棚" iconName:@"weixin_icon" glowColor:RGBAColor(255, 100, 0, 0.3)];
    [items addObject:menuItem];
    
    menuItem = [MenuItem itemWithTitle:@"电台直播" iconName:@"weixin_icon" glowColor:RGBAColor(255, 100, 0, 0.3)];
    [items addObject:menuItem];
    
    menuItem = [MenuItem itemWithTitle:@"实名认证" iconName:@"weixin_icon" glowColor:RGBAColor(255, 100, 0, 0.3)];
    [items addObject:menuItem];
    if (!_popMenu) {
        _popMenu = [[PopMenu alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-SCREEN_WIDTH, SCREEN_WIDTH, SCREEN_WIDTH) items:items];
        _popMenu.menuAnimationType = kPopMenuAnimationTypeNetEase;
    }
    if (_popMenu.isShowed) {
        return;
    }
    WEAKSELF;
    _popMenu.didSelectedItemCompletion = ^(MenuItem *selectedItem) {
        if (selectedItem.index==0) {
           [weakSelf Edittuwen];
        }
        else if (selectedItem.index==1)
        {
           [weakSelf recoddoudio];
        }
        else if (selectedItem.index==2)
        {
            [weakSelf live];
        }
        else if (selectedItem.index==3)
        {
            [weakSelf Certification];
        }
        
    };
    [_popMenu showMenuAtView:self.view];
}
#pragma mark 图文
-(void)Edittuwen
{
    EditContentViewController *conteol=[[EditContentViewController alloc] init];
    [self.navigationController pushViewController:conteol animated:YES];
}
#pragma mark 录音
-(void)recoddoudio
{
    IQAudioRecorderViewController *controller = [[IQAudioRecorderViewController alloc] init];
    controller.delegate = self;
    controller.title = @"录音棚";
    controller.maximumRecordDuration = 0;
    controller.allowCropping =YES;
    controller.normalTintColor =[UIColor whiteColor];
    controller.highlightedTintColor = [UIColor blueColor];
    
    controller.barStyle = UIBarStyleBlack;

    [self presentBlurredAudioRecorderViewControllerAnimated:controller];
}
#pragma mark 直播
-(void)live
{
    TocreatealiveController *conteol=[[TocreatealiveController alloc] init];
    [self.navigationController pushViewController:conteol animated:YES];
}
#pragma mark 实名认证
-(void)Certification
{
    CertificationController *conteol=[[CertificationController alloc] init];
    [self.navigationController pushViewController:conteol animated:YES];
}
-(void)audioRecorderController:(IQAudioRecorderViewController *)controller didFinishWithAudioAtPath:(NSString *)filePath
{
    WEAKSELF;
    audioFilePath = filePath;
    [controller dismissViewControllerAnimated:NO completion:^{
        CreatealbumController *bumController =[[CreatealbumController alloc] initwitdata:self.dataArray type:audio_type];
        bumController.audioFilstr=filePath;
        [weakSelf.navigationController pushViewController:bumController animated:YES];
    }];
}
-(void)audioCropperController:(IQAudioCropperViewController *)controller didFinishWithAudioAtPath:(NSString *)filePath
{
    audioFilePath = filePath;
    [controller dismissViewControllerAnimated:YES completion:nil];
}
-(void)audioCropperControllerDidCancel:(IQAudioCropperViewController *)controller
{
    [controller dismissViewControllerAnimated:YES completion:nil];
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
