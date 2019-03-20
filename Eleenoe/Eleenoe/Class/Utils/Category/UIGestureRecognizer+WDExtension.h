//
//  UIGestureRecognizer+WDExtension.h
//  AcneTreatment
//
//  Created by Facebook on 2018/8/3.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIGestureRecognizer (WDExtension)

- (instancetype)initWithActionBlock:(void (^)(id sender))block;


- (void)addActionBlock:(void (^)(id sender))block;


- (void)removeAllActionBlocks;

@end
NS_ASSUME_NONNULL_END
