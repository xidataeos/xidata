//
//  VideoWooViewController.h
//  Woo
//
//  Created by 王起锋 on 2018/9/7.
//  Copyright © 2018年 杭州蜂布式. All rights reserved.
//

#import "WooBaseViewController.h"
#import "DOUAudioStreamer.h"
#import "GVUserDefaults+Properties.h"
#import "MusicEntity.h"
@protocol audioViewControllerDelegate <NSObject>
@optional
- (void)updatePlaybackIndicatorOfVisisbleCells;
@end
@interface audioViewController : WooBaseViewController
@property (nonatomic, strong) NSMutableArray *musicEntities;
@property (nonatomic, copy) NSString *musicTitle;
@property (nonatomic, strong) DOUAudioStreamer *streamer;
@property (nonatomic, assign) BOOL dontReloadMusic;
@property (nonatomic, assign) NSInteger specialIndex;
@property (nonatomic, copy) NSNumber *parentId;
@property (nonatomic, weak) id<audioViewControllerDelegate> delegate;
@property (nonatomic, assign) BOOL isNotPresenting;
@property (nonatomic, assign) MusicCycleType musicCycleType;
+ (instancetype)sharedInstance;
- (IBAction)playPreviousMusic:(id)sender;
- (IBAction)playNextMusic:(id)sender;
- (MusicEntity *)currentPlayingMusic;
@end
