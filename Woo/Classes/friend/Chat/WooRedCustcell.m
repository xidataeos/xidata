//
//  WooRedCustcell.m
//  Woo
//
//  Created by 王起锋 on 2018/8/15.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import "WooRedCustcell.h"
#define Test_Message_Font_Size 13
@implementation WooRedCustcell
+ (CGSize)sizeForMessageModel:(RCMessageModel *)model
      withCollectionViewWidth:(CGFloat)collectionViewWidth
         referenceExtraHeight:(CGFloat)extraHeight {
    RedMessage *message = (RedMessage *)model.content;
    CGSize size = [WooRedCustcell getBubbleBackgroundViewSize:message];
    
    CGFloat __messagecontentview_height = size.height;
    __messagecontentview_height += extraHeight;
    
    return CGSizeMake(collectionViewWidth, __messagecontentview_height);
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    self.bubbleBackgroundView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self.messageContentView addSubview:self.bubbleBackgroundView];
    
    self.textLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.textLabel setFont:[UIFont systemFontOfSize:Test_Message_Font_Size]];
    
    self.textLabel.numberOfLines = 0;
    [self.textLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [self.textLabel setTextAlignment:NSTextAlignmentLeft];
    [self.textLabel setTextColor:[UIColor blackColor]];
    [self.bubbleBackgroundView addSubview:self.textLabel];
    
    self.tiplabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.tiplabel setFont:UIFont(10)];
    
    self.tiplabel.numberOfLines = 0;
    [self.tiplabel setLineBreakMode:NSLineBreakByWordWrapping];
    [self.tiplabel setTextAlignment:NSTextAlignmentLeft];
    [self.tiplabel setTextColor:WordsofcolorColor];
    self.tiplabel.text=@"WoWo红包";
    [self.bubbleBackgroundView addSubview:self.tiplabel];
    self.bubbleBackgroundView.userInteractionEnabled = YES;
    UILongPressGestureRecognizer *longPress =
    [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressed:)];
    [self.bubbleBackgroundView addGestureRecognizer:longPress];
    
    UITapGestureRecognizer *textMessageTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTextMessage:)];
    textMessageTap.numberOfTapsRequired = 1;
    textMessageTap.numberOfTouchesRequired = 1;
    [self.textLabel addGestureRecognizer:textMessageTap];
    self.textLabel.userInteractionEnabled = YES;
}

- (void)tapTextMessage:(UIGestureRecognizer *)gestureRecognizer {
    if ([self.delegate respondsToSelector:@selector(didTapMessageCell:)]) {
        [self.delegate didTapMessageCell:self.model];
    }
}

- (void)setDataModel:(RCMessageModel *)model {
    [super setDataModel:model];
    
    [self setAutoLayout];
}

- (void)setAutoLayout {
    RedMessage *testMessage = (RedMessage *)self.model.content;
    if (testMessage) {
        self.textLabel.text = testMessage.tip;
    }
    
    CGSize textLabelSize = [[self class] getTextLabelSize:testMessage];
    CGSize bubbleBackgroundViewSize = [[self class] getBubbleSize:textLabelSize];
    CGRect messageContentViewRect = self.messageContentView.frame;
    //拉伸图片
    if (MessageDirection_RECEIVE == self.messageDirection) {
        self.textLabel.frame = CGRectMake(48*KWidth_Scale, 0, textLabelSize.width, textLabelSize.height-5*KWidth_Scale);
        self.textLabel.textColor=[UIColor whiteColor];
        self.tiplabel.frame=CGRectMake(5*KWidth_Scale,CGRectGetMaxY(self.textLabel.frame), textLabelSize.width, 18*KWidth_Scale);
        messageContentViewRect.size.width = bubbleBackgroundViewSize.width;
        self.messageContentView.frame = messageContentViewRect;
        
        self.bubbleBackgroundView.frame =
        CGRectMake(0, 0, bubbleBackgroundViewSize.width, bubbleBackgroundViewSize.height);
//        if (self.model.receivedStatus ==ReceivedStatus_READ) {
//            self.bubbleBackgroundView.alpha=0.5;
//        }
//        else{
//            self.bubbleBackgroundView.alpha=1.0;
//        }
        UIImage *image = [RCKitUtility imageNamed:@"bg_to_hongbao" ofBundle:@"JResource.bundle"];
        self.bubbleBackgroundView.image =
        [image resizableImageWithCapInsets:UIEdgeInsetsMake(image.size.height, image.size.width,
                                                            image.size.height, image.size.width)];
    } else {
        self.textLabel.frame = CGRectMake(45*KWidth_Scale,0, textLabelSize.width, textLabelSize.height-5*KWidth_Scale);
        self.textLabel.textColor=[UIColor whiteColor];
        self.tiplabel.frame=CGRectMake(5*KWidth_Scale,CGRectGetMaxY(self.textLabel.frame), textLabelSize.width,18*KWidth_Scale);
//        if (self.model.receivedStatus ==ReceivedStatus_READ)
//        {
//            self.bubbleBackgroundView.alpha=0.5;
//        }
//        else{
//            self.bubbleBackgroundView.alpha=1.0;
//        }
        messageContentViewRect.size.width = bubbleBackgroundViewSize.width;
        messageContentViewRect.size.height = bubbleBackgroundViewSize.height;
        messageContentViewRect.origin.x =
        self.baseContentView.bounds.size.width - (messageContentViewRect.size.width + HeadAndContentSpacing +
                                                  [RCIM sharedRCIM].globalMessagePortraitSize.width + 10);
        self.messageContentView.frame = messageContentViewRect;
        
        self.bubbleBackgroundView.frame =
        CGRectMake(0, 0, bubbleBackgroundViewSize.width, bubbleBackgroundViewSize.height);
        UIImage *image = [RCKitUtility imageNamed:@"bg_from_hongbao" ofBundle:@"JResource.bundle"];
        self.bubbleBackgroundView.image =
        [image resizableImageWithCapInsets:UIEdgeInsetsMake(image.size.height, image.size.width,
                                                            image.size.height, image.size.width)];
    }
}

- (void)longPressed:(id)sender {
    UILongPressGestureRecognizer *press = (UILongPressGestureRecognizer *)sender;
    if (press.state == UIGestureRecognizerStateEnded) {
        return;
    } else if (press.state == UIGestureRecognizerStateBegan) {
        [self.delegate didLongTouchMessageCell:self.model inView:self.bubbleBackgroundView];
    }
}

+ (CGSize)getTextLabelSize:(RedMessage *)message {
    if ([message.tip length] > 0) {
        float maxWidth = [UIScreen mainScreen].bounds.size.width -
        (10 + [RCIM sharedRCIM].globalMessagePortraitSize.width + 10) * 2 - 5 - 35;
        CGRect textRect = [message.tip
                           boundingRectWithSize:CGSizeMake(maxWidth, 8000)
                           options:(NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin |
                                    NSStringDrawingUsesFontLeading)
                           attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:Test_Message_Font_Size]}
                           context:nil];
        textRect.size.height = ceilf(textRect.size.height);
        textRect.size.width = ceilf(textRect.size.width);
        return CGSizeMake(SCREEN_WIDTH*0.4 + 5, SCREEN_WIDTH*0.4/2.6 + 5);
    } else {
        return CGSizeZero;
    }
}

+ (CGSize)getBubbleSize:(CGSize)textLabelSize {
    CGSize bubbleSize = CGSizeMake(textLabelSize.width, textLabelSize.height);
    
    if (bubbleSize.width + 12 + 20 > 50) {
        bubbleSize.width = bubbleSize.width + 12 + 20;
    } else {
        bubbleSize.width = 50;
    }
    if (bubbleSize.height + 7 + 7 > 40) {
        bubbleSize.height = bubbleSize.height + 7 + 7;
    } else {
        bubbleSize.height = 40;
    }
    
    return bubbleSize;
}
+ (CGSize)getBubbleBackgroundViewSize:(RedMessage *)message {
    CGSize textLabelSize = [[self class] getTextLabelSize:message];
    return [[self class] getBubbleSize:textLabelSize];
}

@end
