//
//  UIView+WDBlocksKit.h
//  AcneTreatment
//
//  Created by Facebook on 2018/8/3.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (WDBlocksKit)

- (void)WH_whenTouches:(NSUInteger)numberOfTouches tapped:(NSUInteger)numberOfTaps handler:(void (^)(void))block;


- (void)WH_whenTapped:(void (^)(void))block;


- (void)WH_whenDoubleTapped:(void (^)(void))block;


- (void)WH_eachSubview:(void (^)(UIView *subview))block;

@end

NS_ASSUME_NONNULL_END
