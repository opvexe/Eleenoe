//
//  ELSearchResultView.h
//  Eleenoe
//
//  Created by HuiLu on 2019/4/1.
//  Copyright © 2019 FaceBook. All rights reserved.
//

#import "ELBaseTableView.h"
#import "ELSearchResultTableViewCell.h"
NS_ASSUME_NONNULL_BEGIN

@class ELSearchResultView;
@class ELBaseTableViewCell;
@class BaseModel;
@protocol ELSearchResultDelegate <NSObject>
@optional
-(void)searchResultView:(ELSearchResultView *)resutVieew  cell:(ELSearchResultTableViewCell *)cell model:(BaseModel *)model ;

-(void)searchResultView:(ELSearchResultView *)resutVieew  loadMoreDataSoucreWithPage:(NSInteger)page;

-(void)searchResultView:(ELSearchResultView *)resutVieew  refreshLoadDataSoucreWithPage:(NSInteger)page;

@end


@interface ELSearchResultView : ELBaseTableView
@property(nonatomic,strong,readonly)NSMutableArray *lists;;

@property(nonatomic,weak)id<ELSearchResultDelegate> resultDelegate;

-(void)InitDataSoucre:(NSArray *)dataSoucre;

@end

NS_ASSUME_NONNULL_END
