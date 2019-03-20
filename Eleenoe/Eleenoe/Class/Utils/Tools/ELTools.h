//
//  ELTools.h
//  Eleenoe
//
//  Created by FaceBook on 2019/3/13.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ELTools : NSObject

+(CGFloat)getHeightContain:(NSString *)string font:(UIFont *)font Width:(CGFloat) width;

+(CGFloat)getWidthContain:(NSString *)string font:(UIFont *)font Height:(CGFloat) height;

+ (UIImage *)getImageWithColor:(UIColor *)color andHeight:(CGFloat)height;

/**
 *  获取对应宽度 (中文 + 数字 组合 计算高度)
 */
+ (CGRect)getTextRectWith:(NSString *)str WithMaxWidth:(CGFloat)width  WithlineSpacing:(CGFloat)LineSpacing AddLabel:(UILabel *)label;

+(CGRect)getTextRectWith:(NSString *)str WithMaxWidth:(CGFloat)width WithTextFont:(UIFont*)font  WithlineSpacing:(CGFloat)LineSpacing AddLabel:(UILabel *)label;

@end

NS_ASSUME_NONNULL_END
