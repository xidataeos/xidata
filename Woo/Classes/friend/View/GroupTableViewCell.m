//
//  GroupTableViewCell.m
//  Woo
//
//  Created by 王起锋 on 2018/8/6.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import "GroupTableViewCell.h"

@implementation GroupTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self==[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.namelabel];
        [self addSubview:self.timeslabel];
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
        _messagelabel.textColor=[PublicFunction colorWithHexString:@"999999"];
        _messagelabel.font=UIFont(14);
        _messagelabel.backgroundColor=[UIColor whiteColor];
        _messagelabel.frame=CGRectMake(CGRectGetMaxX(self.avrimage.frame)+10, CGRectGetMaxY(self.namelabel.frame)+5, ScreenWidth-44-25-80, 20);
    }
    return _messagelabel;
}
-(UILabel *)namelabel
{
    if (_namelabel==nil) {
        _namelabel=[[UILabel alloc] init];
        _namelabel.textColor=WordsofcolorColor;
        _namelabel.font=DefleFuont;
        _namelabel.backgroundColor=[UIColor whiteColor];
        _namelabel.frame=CGRectMake(CGRectGetMaxX(self.avrimage.frame)+10, 10, ScreenWidth*0.5, 20);
    }
    return _namelabel;
}
-(KYCuteView *)tipslabel
{
    if (_tipslabel==nil) {
        _tipslabel = [[KYCuteView alloc]initWithPoint:CGPointMake(SCREEN_WIDTH-37, 35) superView:self];
        _tipslabel.viscosity  = 20;
        _tipslabel.bubbleWidth = 20;
        _tipslabel.bubbleColor = [UIColor redColor];
        [_tipslabel setUp];
        [_tipslabel addGesture];
        _tipslabel.bubbleLabel.font=[UIFont systemFontOfSize:12];
    }
   
    return _tipslabel;
}
-(UILabel *)timeslabel
{
    if (_timeslabel==nil) {
        _timeslabel=[[UILabel alloc] init];
        _timeslabel.textColor=[PublicFunction colorWithHexString:@"666666"];
        _timeslabel.font=UIFont(12);
        _timeslabel.backgroundColor=[UIColor whiteColor];
        _timeslabel.textAlignment=NSTextAlignmentCenter;
        _timeslabel.frame=CGRectMake(ScreenWidth*0.6, 12*KWidth_Scale, SCREEN_WIDTH*0.4-12*KWidth_Scale, 15);
        _timeslabel.textAlignment=NSTextAlignmentRight;
    }
    return _timeslabel;
}
-(void)setdata:(NSString *)unreadcountstr
{
    if ([unreadcountstr isEqualToString:@"0"]) {
        self.tipslabel.frontView.hidden=YES;
        return;
    }
    if (unreadcountstr.length<=2) {
        _tipslabel.bubbleWidth = 24;
        _tipslabel.bubbleLabel.text =unreadcountstr;
    }
    else{
        _tipslabel.bubbleWidth = 25;
        _tipslabel.bubbleLabel.text =@"99+";
    }
     self.tipslabel.frontView.hidden=NO;
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
    if (model.lastestMessageDirection==1) {
        //getDateStringByFormateString
        self.timeslabel.text=[PublicFunction getDateStringByFormateString:@"YYYY/MM/dd HH:mm" date:[NSString stringWithFormat:@"%lld",model.sentTime]];
    }
    else{
        self.timeslabel.text=[PublicFunction getDateStringByFormateString:@"YYYY/MM/dd HH:mm" date:[NSString stringWithFormat:@"%lld",model.receivedTime]];
    }
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    if (![PublicFunction isEmpty:model.conversationTitle]) {
       self.namelabel.text=model.conversationTitle;
    }
    else{
        self.namelabel.text=model.targetId;
    }
    
 
    if ([model.objectName isEqualToString:@"RC:ImgMsg"]) {
        self.messagelabel.text=@"[图片]";
        self.messagelabel.textColor=NaviBackgroundColor;
    }
    else if ([model.objectName isEqualToString:@"RC:LBSMsg"])
    {
        self.messagelabel.text=@"[位置]";
        self.messagelabel.textColor=NaviBackgroundColor;
    }
    else if ([model.objectName isEqualToString:@"TransferMsg"])
    {
        self.messagelabel.text=@"转账提醒";
        self.messagelabel.textColor=NaviBackgroundColor;
    }
    else if ([model.objectName isEqualToString:@"Draft"])
    {
        self.messagelabel.text=@"[草稿]";
    }
    else if ([model.objectName isEqualToString:@"RC:SightMsg"])
    {
        self.messagelabel.text=@"[小视频]";
    }
    else if ([model.objectName isEqualToString:@"RedMsg"]){
        self.messagelabel.textColor=NaviBackgroundColor; self.messagelabel.text=[NSString stringWithFormat:@"[红包] %@",model.lastestMessage.conversationDigest];
    }
    else{
    self.messagelabel.text=model.lastestMessage.conversationDigest;
    }
    if (model.conversationType==ConversationType_PRIVATE) {
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
        RCDGroupInfo *group=[[RCDataBaseManager shareInstance] getGroupByGroupId:model.targetId];
         [self.avrimage sd_setImageWithURL:[NSURL URLWithString:group.portraitUri] placeholderImage:[UIImage imageNamed:@"photo_boy"]];
        self.namelabel.text=group.groupName;
    }
    
    self.accessoryType = UITableViewCellAccessoryNone;
    [self setdata:[NSString stringWithFormat:@"%d",model.unreadMessageCount]];
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
