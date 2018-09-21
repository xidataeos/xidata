//
//  SearchViewController.h
//  Woo
//
//  Created by 王起锋 on 2018/8/6.
//  Copyright © 2018年 风外杏林香. All rights reserved.
//

#import "WooBaseViewController.h"
typedef enum {
    Seatch_allviews = 1,   /**全局搜索 */
    Addfread_search, /**添加好哟搜索*/
    begin_search_frien
} SearchType;
typedef enum {
    Seatch_content_shequn = 1,   /**全局搜索社群 */
    Seatch_content_friend,/**全局搜索好友 */
    Seatch_content_whacth,/**全局搜索看点 */
    Seatch_content_meeting,/***//**全局搜索会议 */
    Seatch_content_all/***//**全局搜索会议 */
} Searchcontenttype;

@protocol SearchViewDelegate <NSObject>
- (void)onSearchCancelClick;
@end
@interface SearchViewController : WooBaseViewController
@property(nonatomic,assign)SearchType searchtype;
@property(nonatomic,assign)Searchcontenttype searchcontenttype;
@property(nonatomic, weak) id<SearchViewDelegate> delegate;
@end
