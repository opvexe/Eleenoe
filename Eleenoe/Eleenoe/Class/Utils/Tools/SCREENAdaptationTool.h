//
//  SCREENAdaptationTool.h
//  Eleenoe
//
//  Created by FaceBook on 2019/3/22.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

#define kSAdap(h) (h * [SCREENAdaptationTool shareInstance].Horizontal)
#define kSAdap_V(v) (v * [SCREENAdaptationTool shareInstance].vertical)
#define kSaFont(f) (f * [SCREENAdaptationTool shareInstance].font)

@interface SCREENAdaptationTool : NSObject

+ (instancetype)shareInstance;
@property (nonatomic, assign, readonly) CGFloat vertical;
@property (nonatomic, assign, readonly) CGFloat Horizontal;
@property (nonatomic, assign, readonly) CGFloat font;

/**
 设置效果图参考尺寸 (默认 6s)
 @param width 参考宽度
 @param height 参考高度
 */
- (void)setReference:(CGFloat)width height:(CGFloat)height;

@end

NS_ASSUME_NONNULL_END
