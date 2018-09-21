//
//  WooHeader.h
//  Woo
//
//  Created by 风外杏林香 on 2018/7/25.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#ifndef WooHeader_h
#define WooHeader_h

#import "SDAutoLayout.h"
#import "MJRefresh.h"
#import "MJExtension.h"
#import "MBProgressHUD.h"
#import "SDCycleScrollView.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"
#import "Reachability.h"
#import "JSONKit.h"
#import "WooWatchViewController.h"
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

#import "BaseTableView.h"

#import "CYPhotoPreviewer.h"
#import "PayCustView.h"
#import "ShareObject.h"
#import "RedmessageModle.h"
#import "ContactdetailViewController.h"
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
#define UPDATE_GROUP_FRIEND @"UPDATE_GROUP_FRIEND"
typedef enum {
    shar_type_gif = 1,   /**GIF */
    shar_type_defel       /** 图片*/
} shareimagetype;
typedef void (^publicclickblock) (NSInteger indexrow);
typedef void (^publiselectstatusblock) (BOOL selectstatus);
typedef void (^publicnoamlblock) (void);
#endif /* WooHeader_h */
