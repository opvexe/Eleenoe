//
//  ELBaseTableView.h
//  Eleenoe
//
//  Created by HuiLu on 2019/3/30.
//  Copyright © 2019 FaceBook. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol ELBaseTableViewDelegate <NSObject>

- (void)refreshDataSyn;

- (void)refreshLoadMoreData;

@end

@interface ELBaseTableView : UITableView<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, weak) id<ELBaseTableViewDelegate> baseDelegate;

- (void)setMJRefreshHeaderFooter;

- (void)endRefreshing;

@end

NS_ASSUME_NONNULL_END
