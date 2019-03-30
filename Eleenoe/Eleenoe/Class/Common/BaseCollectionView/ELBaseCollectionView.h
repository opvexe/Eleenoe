//
//  ELBaseCollectionView.h
//  Eleenoe
//
//  Created by FaceBook on 2019/3/30.
//  Copyright © 2019 FaceBook. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol ELBaseCollectionViewDelegate <NSObject>

- (void)refreshDataSyn;

- (void)refreshLoadMoreData;

@end

@interface ELBaseCollectionView : UICollectionView<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, weak) id<ELBaseCollectionViewDelegate> baseDelegate;

- (void)setMJRefreshHeaderFooter;

- (void)endRefreshing;

@end

NS_ASSUME_NONNULL_END
