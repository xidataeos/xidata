//
//  MessagetWooTableViewCell.m
//  Woo
//
//  Created by 王起锋 on 2018/8/22.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import "MessagetWooTableViewCell.h"

@implementation MessagetWooTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self==[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.namelabel];
        [self addSubview:self.messagelabel];
        [self addSubview:self.tipslabel];
        [self addSubview:self.avrimage];
    }
    return self;
}
-(UILabel *)messagelabel
{
    if (_messagelabel==nil) {
        _messagelabel=[[UILabel alloc] init];
        _messagelabel.textColor=[UIColor lightGrayColor];
        _messagelabel.font=UIFont(12);
        _messagelabel.backgroundColor=[UIColor whiteColor];
        _messagelabel.frame=CGRectMake(CGRectGetMaxX(self.avrimage.frame)+10, CGRectGetMaxY(self.namelabel.frame)+5, ScreenWidth-44-25-80, 20);
    }
    return _messagelabel;
}
-(UILabel *)namelabel
{
    if (_namelabel==nil) {
        _namelabel=[[UILabel alloc] init];
        _namelabel.textColor=[UIColor blackColor];
        _namelabel.font=DefleFuont;
        _namelabel.backgroundColor=[UIColor whiteColor];
        _namelabel.frame=CGRectMake(CGRectGetMaxX(self.avrimage.frame)+10, 10, ScreenWidth*0.5, 20);
    }
    return _namelabel;
}
-(UIButton *)tipslabel
{
    if (_tipslabel==nil) {
        _tipslabel = [PublicFunction getbtnwithtexttitle:@"" fram:CGRectMake(SCREEN_WIDTH-15*KWidth_Scale-50*KWidth_Scale, 20, 50, 30) cornerRadius:5 textcolor:[UIColor whiteColor] textfont:UIFont(14) backcolor:[UIColor whiteColor]];
        [self.tipslabel addTarget:self action:@selector(jieshou) forControlEvents:UIControlEventTouchUpInside];
    }
    return _tipslabel;
}

-(void)setdata:(NSString *)unreadcountstr
{
    if ([unreadcountstr isEqualToString:@"0"]) {
        self.tipslabel.backgroundColor=[UIColor clearColor];
        [self.tipslabel setTitle:@"已接受" forState:UIControlStateNormal];
        [self.tipslabel setTitleColor:WordsofcolorColor forState:UIControlStateNormal];
        self.tipslabel.backgroundColor=[UIColor whiteColor];
        self.tipslabel.userInteractionEnabled=NO;
        return;
    }
    else{
        self.tipslabel.backgroundColor=[UIColor clearColor];
        [self.tipslabel setTitle:@"接受" forState:UIControlStateNormal];
        self.tipslabel.backgroundColor=NaviBackgroundColor;
        [self.tipslabel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.tipslabel.userInteractionEnabled=YES;
    }
}
-(void)jieshou
{
    if (self.myblock) {
        self.myblock();
    }
}
-(UIImageView *)avrimage
{
    if (_avrimage==nil) {
        _avrimage=[[UIImageView alloc] initWithFrame:CGRectMake(15, 13, 44, 44)];
    }
    return _avrimage;
}
-(void)setModel:(RCConversation *)model
{
     RCTextMessage *lasttext=(RCTextMessage *)model.lastestMessage;
    NSDictionary *seldic=[PublicFunction dictionaryWithJsonString:lasttext.extra];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    if (![PublicFunction isEmpty:model.conversationTitle]) {
        self.namelabel.text=model.conversationTitle;
    }
    else{
        self.namelabel.text=model.targetId;
    }
    
    
    if ([model.objectName isEqualToString:@"RC:ImgMsg"]) {
        self.messagelabel.text=@"[图片]";
    }
    else if ([model.objectName isEqualToString:@"RC:LBSMsg"])
    {
        self.messagelabel.text=@"[位置]";
    }
    else if ([model.objectName isEqualToString:@"Draft"])
    {
        self.messagelabel.text=@"[草稿]";
    }
    else if ([model.objectName isEqualToString:@"RC:SightMsg"])
    {
        self.messagelabel.text=@"[小视频]";
    }
    else{
        
        if ([seldic[@"isGroup"] isEqualToString:@"0"]) {
            NSString *titletext=[NSString stringWithFormat:@"<font color='#ff8170'>好友验证  </font><font color='#999999'>%@</font>",model.lastestMessage.conversationDigest];
            self.messagelabel.attributedText=[PublicFunction attributedStringWithHTMLString:titletext];
        }
        else if ([seldic[@"isGroup"] isEqualToString:@"1"])
        {
            NSString *titletext=[NSString stringWithFormat:@"<font color='#ff8170'>社群验证 </font><font color='#999999'>%@</font>",model.lastestMessage.conversationDigest];
            self.messagelabel.attributedText=[PublicFunction attributedStringWithHTMLString:titletext];
        }
    }
    self.accessoryType = UITableViewCellAccessoryNone;
    [self setdata:[NSString stringWithFormat:@"%d",model.unreadMessageCount]];
    if ([seldic[@"isGroup"] isEqualToString:@"0"]) {
        RCDUserInfo *info=[[RCDataBaseManager shareInstance] getFriendInfo:model.targetId];
        if (info) {
            [self.avrimage sd_setImageWithURL:[NSURL URLWithString:info.portraitUri] placeholderImage:[UIImage imageNamed:@"photo_boy"]];
            if ([PublicFunction isEmpty:info.displayName]) {
                self.namelabel.text=info.name;
            }
            else{
                self.namelabel.text=info.displayName;
            }
        }
        else{
             [self getFriendRelationship:model.targetId];
        }
       
    }
    else{
        
    }
}
-(void)getFriendRelationship:(NSString *)fid
{
    //[self showhudmessage:@"群成员加载中..." offy:-100];
    NSMutableDictionary *parametDic = [NSMutableDictionary dictionaryWithCapacity:9];
    [parametDic setObject:RCLOUD_ID forKey:@"mid"];
    [parametDic setObject:fid forKey:@"fid"];
    [UserRequestToo shareInstance].rquesturl=getfriendRelationshipRequrl;
    [UserRequestToo shareInstance].params=parametDic;
    [[UserRequestToo shareInstance] statrrequestgetwith:MHAsiNetWorkGET successBlock:^(id returnData) {
        if (returnData[@"success"]) {
            
            if([returnData[@"status"] isEqualToString:@"200"])
            {
                NSDictionary *dic=returnData[@"data"];
                [self.avrimage sd_setImageWithURL:[NSURL URLWithString:dic[@"photo"]] placeholderImage:[UIImage imageNamed:@"photo_boy"]];
                if ([PublicFunction isEmpty:dic[@"nickname"]]) {
                    self.namelabel.text=dic[@"name"];
                }
                else{
                    self.namelabel.text=dic[@"nickname"];
                }
            }
        }
    } failureBlock:^(NSError *error) {
    }];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
