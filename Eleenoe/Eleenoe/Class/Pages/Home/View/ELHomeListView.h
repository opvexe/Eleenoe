//
//  ELHomeListView.h
//  Eleenoe
//
//  Created by HuiLu on 2019/3/30.
//  Copyright © 2019 FaceBook. All rights reserved.
//

#import "ELBaseCollectionView.h"

NS_ASSUME_NONNULL_BEGIN

@class ELHomeListView;

@protocol ELHomeListViewDelegate <NSObject>
@optional
/**
 *  联动 ELHomeListView 的方法
 *
 *  @param pageContentCollectionView      ELHomeListView
 *  @param progress             ELHomeListView 内部视图滚动时的偏移量
 *  @param originalIndex        原始视图所在下标
 *  @param targetIndex          目标视图所在下标
 */
- (void)pageContentCollectionView:(ELHomeListView *)pageContentCollectionView progress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex;
/**
 *  获取 ELHomeListView 当前子控制器的下标值
 *
 *  @param pageContentCollectionView     ELHomeListView
 *  @param index                         ELHomeListView 当前子控制器的下标值
 */
- (void)pageContentCollectionView:(ELHomeListView *)pageContentCollectionView index:(NSInteger)index;
/** ELHomeListView 内容开始拖拽方法 */
- (void)pageContentCollectionViewWillBeginDragging;
/** ELHomeListView 内容结束拖拽方法 */
- (void)pageContentCollectionViewDidEndDecelerating;
@end


@interface ELHomeListView : ELBaseCollectionView
/** ELHomeListViewDelegate */
@property (nonatomic, weak) id<ELHomeListViewDelegate> delegatePageContentCollectionView;
/** 给外界提供的方法，根据 ELHomeListView 标题选中时的下标并显示相应的子控制器 */
- (void)setPageContentCollectionViewCurrentIndex:(NSInteger)currentIndex;
@end

NS_ASSUME_NONNULL_END
