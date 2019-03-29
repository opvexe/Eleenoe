//
//  ELBannerCollectionReusableView.h
//  Eleenoe
//
//  Created by FaceBook on 2019/3/29.
//  Copyright © 2019 FaceBook. All rights reserved.
//

#import "ELBaseCollectionReusableView.h"

NS_ASSUME_NONNULL_BEGIN
@class ELBannerCollectionReusableView;
@protocol ELCycleScrollViewDelegate <NSObject>
@optional
- (void)cycleScrollView:(ELBannerCollectionReusableView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index model:(id)model;

@end
@interface ELBannerCollectionReusableView : ELBaseCollectionReusableView

@property (nonatomic, weak) id<ELCycleScrollViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
