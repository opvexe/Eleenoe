//
//  ELSlideTabBar.h
//  Eleenoe
//
//  Created by FaceBook on 2019/4/29.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import "ELBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ELSlideTabBarDelegate
@required
- (void)onTabTapAction:(NSInteger)index;

@end

@interface ELSlideTabBar : ELBaseView

@property(nonatomic,weak) id <ELSlideTabBarDelegate> delegate;

- (void)setLabels:(NSArray<NSString *> *)titles tabIndex:(NSInteger)tabIndex;

@end

NS_ASSUME_NONNULL_END
