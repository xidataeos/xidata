//
//  WooHeader.h
//  Woo
//
//  Created by 风外杏林香 on 2018/7/25.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#ifndef WooHeader_h
#define WooHeader_h
#import "Custtextview.h"
#import "MJRefresh.h"
#import "MJExtension.h"
#import "MBProgressHUD.h"
#import "SDCycleScrollView.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"
#import "Reachability.h"
#import "JSONKit.h"
#import "MadeViewController.h"
#import "WooLoginViewController.h"
#import "TZImagePickerController.h"
#import "WooBaseViewController.h"
#import "WooFriendViewController.h"
#import "baseview.h"
#import "baseobject.h"
#import "baseWebViewController.h"
#import <MBProgressHUD.h>
#import <FMDB.h>
#import "AfnetHttpsTool.h"
#import "UserRequestToo.h"
#import "AfnetHttpsTool.h"
#import "PacketHandler.h"
#import <RongIMKit/RongIMKit.h>
#import "ContactModel.h"
#import <MLMenu/MLMenuView.h>
#import "CustomTableViewCell.h"
#import "Sharemangerview.h"
#import "Showerwimaview.h"
#import "SearchViewController.h"
#import "WooBaseNavigationViewController.h"
#import "HCScanQRViewController.h"
#import "UIImage+QRCode.h"
#import "WOOConversationViewController.h"
#import "SelectContactViewController.h"
#import "MyfriendsViewController.h"
#import "ChatmangerObject.h"
#import "RCDSearchBar.h"
#import "CustAlertview.h"
#import "Watchobject.h"
#import "Watchuserobject.h"
#import "WooSearchmanger.h"
#import "RCDataBaseManager.h"
#import "JMConfig.h"
#import "BaseTableView.h"

#import "CYPhotoPreviewer.h"
#import "PayCustView.h"
#import "ShareObject.h"
#import "RedmessageModle.h"
#import "ContactdetailViewController.h"
#import "UIColor+Extension.h"
#import "ZFPlayerController.h"
#import "ZFPlayerControlView.h"
#import "ZFAVPlayerManager.h"
#import "ZFPlayer.h"
#import "UIView+Extension.h"
#import "ReactiveCocoa.h"
#import "YYModel.h"
#import "madecollectionViewCell.h"
#import "audioViewController.h"
#import "BaseHelper.h"
#import <SDWebImage/UIButton+WebCache.h>
#import "Theselectorview.h"
#import "CommentsView.h"
#import "GGActionSheet.h"
#import "TocreatealiveController.h"
#import "HomeModel.h"
#import "AlbumdetailsController.h"
#import "UIViewController+XHPhoto.h"
#define UserDefaults [NSUserDefaults standardUserDefaults]
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define ScreenWidth  [UIScreen mainScreen].bounds.size.width
#define SCREEN_BOUNDS [UIScreen mainScreen].bounds
#define IsPortrait ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationPortrait || [[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationPortraitUpsideDown)


#define ScreenScale  (ScreenWidth / 375)
#define  iPhoneX (ScreenWidth == 375.f && ScreenHeight == 812.f ? YES : NO)
// Status bar height.
#define  StatusBarHeight      (iPhoneX ? 44.f : 20.f)
// Navigation bar height.
#define  NavigationBarHeight  44.f
// Tabbar height.
#define  TabbarHeight         (iPhoneX ? (49.f + 34.f) : 49.f)
// Tabbar safe bottom margin.
#define  TabbarSafeBottomMargin         (iPhoneX ? 34.f : 0.f)
// Status bar & navigation bar height.
#define  StatusBarAndNavigationBarHeight  (iPhoneX ? 88.f : 64.f)
#define RCLOUD_ID [UserDefaults objectForKey:@"userId"]
#define GAME_POST @"gamepost"
#define WOWOInvitationCode [UserDefaults objectForKey:@"invitationCode"]
#define UPDATE_GROUP_FRIEND @"UPDATE_GROUP_FRIEND"
#define PostKey [UserDefaults objectForKey:@"token"]
typedef enum {
    shar_type_gif = 1,   /**GIF */
    shar_type_defel       /** 图片*/
} shareimagetype;
typedef NS_ENUM(NSInteger, UpdataType) {
    all_album = 0,//专辑
    graphic_type ,//图文
    audio_type//音频
};
typedef NS_ENUM(NSInteger, SelectType) {
    payAndfree_type, //全部
    pay_type ,//付费
    free_type,//免费
};
typedef NS_ENUM(NSInteger, screeningType) {
    screening_all, //综合
    screening_popular ,//流行
    screening_new,//最新
    screening_hot
};
typedef void (^publicclickblock) (NSInteger indexrow);
typedef void (^publiselectstatusblock) (BOOL selectstatus);
typedef void (^publicnoamlblock) (void);
#endif /* WooHeader_h */
