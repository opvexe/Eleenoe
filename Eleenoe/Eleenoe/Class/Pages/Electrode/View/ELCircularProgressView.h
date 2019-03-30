//
//  ELCircularProgressView.h
//  Eleenoe
//
//  Created by FaceBook on 2019/3/30.
//  Copyright © 2019 FaceBook. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ELCircularProgressView : UIView

- (instancetype)initWithFrame:(CGRect)frame lineWidth:(CGFloat)lineWidth;
/**
 * 进度
 */
@property (nonatomic) float progress;

/**
 * 圆环宽度
 */
@property (assign,nonatomic) CGFloat lineWidth;

/**
 * 原点大小
 */
@property (assign,nonatomic) CGFloat pointWidth;

@end

NS_ASSUME_NONNULL_END
