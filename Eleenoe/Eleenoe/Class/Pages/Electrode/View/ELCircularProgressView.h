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

/**
 * 时间文本
 */
@property(nonatomic,copy)NSString *text;
/**
 * 时间文本字体
 */
@property (nonatomic,strong) UIFont * textFont;

/**
 * 时间文本颜色
 */
@property (nonatomic,strong) UIColor * textColor;
@end

NS_ASSUME_NONNULL_END
