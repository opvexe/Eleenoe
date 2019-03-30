//
//  ELBaseTableView.m
//  Eleenoe
//
//  Created by HuiLu on 2019/3/30.
//  Copyright © 2019 FaceBook. All rights reserved.
//

#import "ELBaseTableView.h"

@implementation ELBaseTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.separatorStyle =  UITableViewCellSeparatorStyleNone;
    }
    return self;
}

- (void)setMJRefreshHeaderFooter {
    __weak __typeof(self)weakSelf = self;
    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf refreshDataSyn];
    }];
    // 设置字体
    if ([self.mj_header isKindOfClass:[MJRefreshNormalHeader class]]) {
        MJRefreshNormalHeader * refreshNormalHeader =  (MJRefreshNormalHeader*)self.mj_header;
        refreshNormalHeader.stateLabel.font = [UIFont systemFontOfSize:11];
        refreshNormalHeader.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:11];
        refreshNormalHeader.stateLabel.textColor = [UIColor lightGrayColor];
        refreshNormalHeader.lastUpdatedTimeLabel.textColor = [UIColor lightGrayColor];
    }
    
    self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf refreshLoadMoreData];
    }];
    if ([self.mj_footer isKindOfClass:[MJRefreshBackNormalFooter class]]) {
        MJRefreshBackNormalFooter * refreshBackNormalFooter =  (MJRefreshBackNormalFooter*)self.mj_footer;
        refreshBackNormalFooter.stateLabel.font = [UIFont systemFontOfSize:11];
        refreshBackNormalFooter.stateLabel.textColor = [UIColor lightGrayColor];
    }
    
    
}

- (void)refreshDataSyn {
    if (self.baseDelegate && [self.baseDelegate respondsToSelector:@selector(refreshDataSyn)]) {
        [self.baseDelegate refreshDataSyn];
    }
}

- (void)refreshLoadMoreData {
    if (self.baseDelegate && [self.baseDelegate respondsToSelector:@selector(refreshLoadMoreData)]) {
        [self.baseDelegate refreshLoadMoreData];
    }
}
- (void)endRefreshing
{
    [self.mj_footer endRefreshing];
    [self.mj_header endRefreshing];
}
@end
