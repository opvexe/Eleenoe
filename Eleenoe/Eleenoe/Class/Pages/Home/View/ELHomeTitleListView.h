//
//  ELHomeTitleListView.h
//  Eleenoe
//
//  Created by HuiLu on 2019/3/30.
//  Copyright © 2019 FaceBook. All rights reserved.
//

#import "ELBaseCollectionView.h"

NS_ASSUME_NONNULL_BEGIN


@class ELHomeTitleListView;
@protocol ELHomeTitleListViewDelegate <NSObject>
@optional
- (void)pageTitleListView:(ELHomeTitleListView *)pageContentCollectionView index:(NSInteger)index;
@end

@interface ELHomeTitleListView : ELBaseCollectionView
/** ELHomeTitleListViewDelegate */
@property (nonatomic, weak) id<ELHomeTitleListViewDelegate> delegatePageContentCollectionView;

- (void)setELHomeTitleListViewCurrentIndex:(NSInteger)currentIndex ;
@end

NS_ASSUME_NONNULL_END
