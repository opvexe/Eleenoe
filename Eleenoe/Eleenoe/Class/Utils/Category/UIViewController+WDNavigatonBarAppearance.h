//
//  UIViewController+WDNavigatonBarAppearance.h
//  AcneTreatment
//
//  Created by Facebook on 2018/8/3.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (WDNavigatonBarAppearance)
/**
 *  返回上一页
 */
-(void)popBack;
/**
 *  导航左侧返回按钮
 */
- (void)addPopBackBarButtonItem;
/**
 *  导航View标题
 */
- (UILabel *)navTitleLabelWithTitle:(NSString *)title;

/**
 * 跳转下一个控制器

 @param viewControllerClass 下一个控制器VC
 */
- (void)pushViewControllerWithViewControllerClass:(Class)viewControllerClass ;

/**
 * 导航左侧按钮

 @param view 自定义视图
 @return 左侧导航
 */
- (UIBarButtonItem *)lefButtonWithView:(UIView *)view;

/**
 * 返回按钮标题文字

 @param title 标题文字
 @param target target description
 @param action action description
 @return 左侧导航
 */
- (UIBarButtonItem *)backBarButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action;

/**
 * 导航左侧按钮

 @param title title description
 @param target target description
 @param action action description
 @return return value description
 */
- (UIBarButtonItem *)leftBarButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action;

/**
 * 导航左侧按钮

 @param image 图片
 @param target target description
 @param action action description
 @return return value description
 */
- (UIBarButtonItem *)leftBarButtonWithImage:(UIImage *)image target:(id)target action:(SEL)action;
- (UIBarButtonItem *)leftBarButtonWithImage:(UIImage *)image  selected:(UIImage *)selectedImage target:(id)target action:(SEL)action;

/**
 * 导航右侧视图

 @param view 自定义视图
 @return return value description
 */
- (UIBarButtonItem *)rightBarButtonWithView:(UIView *)view;

/**
 * 右侧导航按钮

 @param title title description
 @param titleColor titleColor description
 @param target target description
 @param action action description
 @return return value description
 */
- (UIBarButtonItem *)rightBarButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor target:(id)target action:(SEL)action;
- (UIBarButtonItem *)rightBarButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font target:(id)target action:(SEL)action;

/**
 * 右侧导航按钮图片

 @param image 自定义图片
 @param target target description
 @param action action description
 @return return value description
 */
- (UIBarButtonItem *)rightBarButtonWithImage:(UIImage *)image target:(id)target action:(SEL)action;
- (UIBarButtonItem *)rightBarButtonWithImage:(UIImage *)image  selected:(UIImage *)selectedImage target:(id)target action:(SEL)action;

@end
