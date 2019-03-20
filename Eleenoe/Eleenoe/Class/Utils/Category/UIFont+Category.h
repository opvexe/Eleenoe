//
//  UIFont+Category.h
//  AcneTreatment
//
//  Created by Facebook on 2018/7/31.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (Category)

/**
 粗体字体
 
 @param fontSize 设置字体大小
 @return return value description
 */
+ (UIFont *)ELMediumFontOfSize:(CGFloat)fontSize;

/**
 正常字体
 @param fontSize 设置字体大小
 @return return value description
 */
+ (UIFont *)ELFontOfSize:(CGFloat)fontSize;

/**
 PingFangSC-Light
 
 @param fontSize 设置字体大小
 @return return value description
 */
+ (UIFont *)ELPingFangSCLightFontOfSize:(CGFloat)fontSize;


/**
 PingFangSC
 
 @param fontSize  设置字体大小
 @return return value description
 */
+ (UIFont *)ELPingFangSCRegularFontOfSize:(CGFloat)fontSize;

/**
 PingFangSC-Medium
 
 @param fontSize 设置字体大小
 @return return value description
 */
+ (UIFont *)ELPingFangSCMediumFontOfSize:(CGFloat)fontSize;

/**
 PingFangSC-Semibold
 
 @param fontSize 设置字体大小
 @return return value description
 */
+ (UIFont *)ELPingFangSCSemiboldFontOfSize:(CGFloat)fontSize;

/**
 SYHelveticaFontOfSize
 
 @param fontSize 设置字体大小
 @return return value description
 */
+ (UIFont *)ELHelveticaFontOfSize:(CGFloat)fontSize;

@end
