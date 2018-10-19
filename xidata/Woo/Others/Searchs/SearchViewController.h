//
//  SearchViewController.h
//  Woo
//
//  Created by 王起锋 on 2018/8/6.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import "WooBaseViewController.h"
typedef enum {
    Seatch_self_allviews, /**添加好哟搜索*/
    Seatch_self_addsomeone, /**添加好哟搜索*/
    Seatch_self_groupmember, /**搜索群组成员*/
    begin_search_group,//搜群组
    begin_search_frien ,//搜好友
    
    Seatch_content_shequn ,   /**全局搜索社群 */
    Seatch_content_friend,/**全局搜索好友 */
    Seatch_content_whacth,/**全局搜索看点 */
    Seatch_content_meeting,/***//**全局搜索会议 */
    Seatch_content_education/***//**全局搜索教育 */
} SearchType;

@protocol SearchViewDelegate <NSObject>
- (void)onSearchCancelClick;
@end
@interface SearchViewController : WooBaseViewController
@property(nonatomic,assign)SearchType searchtype;
@property(nonatomic, weak) id<SearchViewDelegate> delegate;
@end
