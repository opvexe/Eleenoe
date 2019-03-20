//
//  UIView+WDBlocksKit.m
//  AcneTreatment
//
//  Created by Facebook on 2018/8/3.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "UIView+WDBlocksKit.h"
#import "UIGestureRecognizer+WDExtension.h"
@implementation UIView (WDBlocksKit)

- (void)WH_whenTouches:(NSUInteger)numberOfTouches tapped:(NSUInteger)numberOfTaps handler:(void (^)(void))block
{
    if (!block) return;
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithActionBlock:^(UITapGestureRecognizer *sender) {
        if (sender.state == UIGestureRecognizerStateRecognized) block();
    }];
    
    self.userInteractionEnabled = YES;
    gesture.numberOfTouchesRequired = numberOfTouches;
    gesture.numberOfTapsRequired = numberOfTaps;
    
    [self.gestureRecognizers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (![obj isKindOfClass:[UITapGestureRecognizer class]]) return;
        
        UITapGestureRecognizer *tap = obj;
        BOOL rightTouches = (tap.numberOfTouchesRequired == numberOfTouches);
        BOOL rightTaps = (tap.numberOfTapsRequired == numberOfTaps);
        if (rightTouches && rightTaps) {
            [gesture requireGestureRecognizerToFail:tap];
        }
    }];
    
    [self addGestureRecognizer:gesture];
}

- (void)WH_whenTapped:(void (^)(void))block
{
    [self WH_whenTouches:1 tapped:1 handler:block];
}

- (void)WH_whenDoubleTapped:(void (^)(void))block
{
    [self WH_whenTouches:1 tapped:2 handler:block];
}

- (void)WH_eachSubview:(void (^)(UIView *subview))block
{
    NSParameterAssert(block != nil);
    
    [self.subviews enumerateObjectsUsingBlock:^(UIView *subview, NSUInteger idx, BOOL *stop) {
        block(subview);
    }];
}

@end
