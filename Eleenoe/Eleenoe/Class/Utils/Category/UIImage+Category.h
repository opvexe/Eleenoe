//
//  UIImage+Category.h
//  WebBranch
//
//  Created by Facebook on 2018/5/17.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Category)

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size cornerRadius:(CGFloat)radius;

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

+ (UIImage *)imageWithColor:(UIColor *)color;

+ (CGSize )imageWithOriginal:(UIImage *)originalImage ;

@end
