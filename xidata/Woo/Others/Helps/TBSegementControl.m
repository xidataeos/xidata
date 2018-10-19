//
//  TBSegementContrl.m
//  DefineSegementControl
//
//  Created by Pengfei_Luo on 15/11/9.
//  Copyright © 2015年 骆朋飞. All rights reserved.
//

#import "TBSegementControl.h"

#define kSegementWith [UIScreen mainScreen].bounds.size.width
#define kSegementHeight self.frame.size.height

#define kSegement_origin_tag 1000

#define RGBColor(x,y,z) [UIColor colorWithRed:(x)/255.0f green:(y)/255.0f blue:(z)/255.0f                                                                                  alpha:1.0]

#define NormalColorR 102
#define NormalColorG 102
#define NormalColorB 102

#define SelectedColorR 255
#define SelectedColorG 75
#define SelectedColorB 0

#define kNormalColor RGBColor(NormalColorR,NormalColorG,NormalColorB)
#define kSelectedColor RGBColor(SelectedColorR,SelectedColorG,SelectedColorB)

@interface TBSegementControl (){
    UIButton *_selectedButton; // 选中的按钮
    UIView   *_moveLineView;
    CGFloat _bottomLineLongWidth;
}
@property (nonatomic, strong) UIView *lineView;
@end


@implementation TBSegementControl

-(instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.lineView];
        _selectedButton = 0;
        self.selectedColor = kSelectedColor;
        self.normalColor = kNormalColor;
    }
    
    return self;
}

-(void)awakeFromNib {
    [self addSubview:self.lineView];
    _selectedButton = 0;
    self.selectedColor = kSelectedColor;
    self.normalColor = kNormalColor;
}

-(void)setItemsArray:(NSArray *)itemsArray {
    if (_itemsArray != itemsArray) {
        _itemsArray = itemsArray;
    }
    NSInteger segementCount = itemsArray.count;
    CGFloat btnWith = kSegementWith / segementCount;
    for (int i = 0; i < segementCount; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        if (i == 0) {
         [btn setTitleColor:self.selectedColor forState:UIControlStateNormal];
        }else{
         [btn setTitleColor:self.normalColor forState:UIControlStateNormal];
        }
        
        [btn setTitle:itemsArray[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(segementButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(btnWith * i, 0, btnWith, kSegementHeight);
        [self addSubview:btn];
        
        btn.titleLabel.font = [UIFont systemFontOfSize:16.0];
        [btn setExclusiveTouch:YES];
        btn.tag = kSegement_origin_tag + i;
        [btn.titleLabel sizeToFit];
        
        if (i == _selectedIndex) {
            _selectedButton = btn;
            [_selectedButton setTintColor:self.selectedColor];
            _moveLineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.frame) - 1,SCREEN_WIDTH/2.0, 2)];
            _moveLineView.backgroundColor = self.selectedColor;
            //[self addSubview:_moveLineView];
        }

    }
    
}

-(void)setSelectedIndex:(NSInteger)selectedIndex {
    if (_selectedIndex != selectedIndex) {
        _selectedIndex = selectedIndex;
    }
    [self lineViewAnimationWithIndex:selectedIndex];
}

- (void)segementButtonClicked:(UIButton*)sender {
    self.selectedIndex = (sender.tag - kSegement_origin_tag);
    [self lineViewAnimationWithIndex:(sender.tag - kSegement_origin_tag)];
    if (self.delegate && [self.delegate respondsToSelector:@selector(segementButtonClickedAtIndex:)]) {
        [self.delegate segementButtonClickedAtIndex:self.selectedIndex];
    }

}

- (void)setAnimationWithOffSet:(CGFloat)offSet totalWidth:(CGFloat)width {
    // 1. 得到当前比例
    CGFloat degress = offSet/width;
    UIButton *button0, *button1;
    NSInteger itemsCount = self.itemsArray.count;
    for (int i = 0; i < itemsCount; ++i) {
        if (i < degress && degress < i+1) {
            button0 = (UIButton*)[self viewWithTag:(kSegement_origin_tag+i)];
            button1 = (UIButton*)[self viewWithTag:(kSegement_origin_tag + i + 1)];
        }
    }
    UIButton *buttonChangeToNormal, *buttonChangeToSelected;
    if (degress > 0.5) {
        buttonChangeToNormal = button0;
        buttonChangeToSelected = button1;
    } else {
        buttonChangeToNormal = button1;
        buttonChangeToSelected = button0;
    }
  
        [self button:buttonChangeToNormal changeColor:fabs(buttonChangeToSelected.tag - kSegement_origin_tag - degress)];
        [self button:buttonChangeToSelected changeColor:fabs(degress - buttonChangeToNormal.tag + kSegement_origin_tag)];
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)lineViewAnimationWithIndex:(NSInteger)index {
    UIButton *tmpButton = (UIButton*)[self viewWithTag:(kSegement_origin_tag+index)];
    if (_selectedButton != tmpButton) {
        [UIView animateWithDuration:0.2 animations:^{
            [_selectedButton setTintColor:self.normalColor];
        [tmpButton setTintColor:self.selectedColor];
        _selectedButton = tmpButton;
        }];
    }
    
    NSInteger arrayCount = self.itemsArray.count;
    CGFloat btnWidth = kSegementWith / arrayCount;
    [UIView animateWithDuration:0.1 animations:^{
        _moveLineView.frame = CGRectMake(btnWidth * index, CGRectGetHeight(self.frame) - 1,SCREEN_WIDTH/2.0, 2);
        _bottomLineLongWidth = CGRectGetWidth(_selectedButton.titleLabel.frame);
    }];
}



// 颜色转换
- (void)button:(UIButton *)button changeColor:(CGFloat)degress {
    CGFloat r = degress * (SelectedColorR-NormalColorR);
    CGFloat g = degress * (NormalColorG-SelectedColorG);
    CGFloat b = degress * (NormalColorB-SelectedColorB);
      dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    if (button.selected) {
        [button setTitleColor:RGBColor(NormalColorR+r, NormalColorG-g, NormalColorB-b) forState:UIControlStateSelected];
    }
    else {
        [button setTitleColor:RGBColor(NormalColorR+r, NormalColorG-g, NormalColorB-b) forState:UIControlStateNormal];
    }
          });
}


-(UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, kSegementHeight - 0.5, kSegementWith, 0.5)];
        _lineView.backgroundColor = self.normalColor;
    }
    
    return _lineView;
}

@end
