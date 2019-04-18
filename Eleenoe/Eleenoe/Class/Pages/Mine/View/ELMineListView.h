//
//  ELMineListView.h
//  Eleenoe
//
//  Created by FaceBook on 2019/3/31.
//  Copyright © 2019 FaceBook. All rights reserved.
//

#import "ELBaseTableView.h"

NS_ASSUME_NONNULL_BEGIN

@class ELMineListView;
@protocol ELMineListViewDelegate <NSObject>
@optional
- (void)pageListView:(ELMineListView *)listView AtModel:(ELBaseModel *)model;
@end

@interface ELMineListView : ELBaseTableView

@property(nonatomic,weak) id <ELMineListViewDelegate>listDelegate;

@end

NS_ASSUME_NONNULL_END
