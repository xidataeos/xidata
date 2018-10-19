//
//  NoContentView.m
//  Woo
//
//  Created by 王起锋 on 2018/8/21.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import "NoContentView.h"
@interface NoContentView ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UILabel *topLabel;
@property (nonatomic,strong) UILabel *bottomLabel;

@end

@implementation NoContentView
#pragma mark - 构造方法

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        // UI搭建
        [self setUpUI];
    }
    return self;
}

#pragma mark - UI搭建
/** UI搭建 */
- (void)setUpUI{
    self.backgroundColor = [UIColor whiteColor];
    
    //------- 图片 -------//
    self.imageView = [[UIImageView alloc]init];
    [self addSubview:self.imageView];
    
    //------- 内容描述 -------//
    self.topLabel = [[UILabel alloc]init];
    [self addSubview:self.topLabel];
    self.topLabel.textAlignment = NSTextAlignmentCenter;
    self.topLabel.font = [UIFont systemFontOfSize:15];
    self.topLabel.textColor = [PublicFunction colorWithHexString:@"484848"];
    
    //------- 提示点击重新加载 -------//
    self.bottomLabel = [[UILabel alloc]init];
    [self addSubview:self.bottomLabel];
    self.bottomLabel.textAlignment = NSTextAlignmentCenter;
    self.bottomLabel.font = [UIFont systemFontOfSize:15];
    self.bottomLabel.textColor = [PublicFunction colorWithHexString:@"484848"];
    
    //------- 建立约束 -------//
    self.imageView.frame=CGRectMake((SCREEN_WIDTH-100)/2.0,0, 100, 100);
    self.topLabel.frame=CGRectMake(0, CGRectGetMaxY(self.imageView.frame)+10, SCREEN_WIDTH, 20);
    self.bottomLabel.frame=CGRectMake(0, CGRectGetMaxY(self.topLabel.frame)+10, SCREEN_WIDTH, 20);
}

#pragma mark - 根据传入的值创建相应的UI
/** 根据传入的值创建相应的UI */
- (void)setType:(NSInteger)type{
    switch (type) {
            
            case 0: // 没网
        {
            [self setImage:@"sorry" topLabelText:@"貌似没有网络" bottomLabelText:@"点击重试"];
        }
            break;
            
            case 1:
        {
            [self setImage:@"sorry" topLabelText:@"暂时没有数据稍后再试" bottomLabelText:@""];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - 设置图片和文字
/** 设置图片和文字 */
- (void)setImage:(NSString *)imageName topLabelText:(NSString *)topLabelText bottomLabelText:(NSString *)bottomLabelText{
    self.imageView.image = [UIImage imageNamed:imageName];
    self.topLabel.text = topLabelText;
    self.bottomLabel.text = bottomLabelText;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
