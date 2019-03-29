//
//  UIView+Category.h
//  AcneTreatment
//
//  Created by Facebook on 2018/7/31.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>

// 理想线宽
#define LINE_WIDTH                  1
// 实际应该显示的线宽
#define SINGLE_LINE_WIDTH           floor((LINE_WIDTH / [UIScreen mainScreen].scale)*100) / 100
//偏移的宽度
#define SINGLE_LINE_ADJUST_OFFSET   floor(((LINE_WIDTH / [UIScreen mainScreen].scale) / 2)*100) / 100
typedef NS_ENUM(NSInteger,UILayoutCornerRadiusType) {
    UILayoutCornerRadiusTop    = 0,
    UILayoutCornerRadiusLeft   = 1,
    UILayoutCornerRadiusBottom = 2,
    UILayoutCornerRadiusRight  = 3,
    UILayoutCornerRadiusAll    = 4,
};
@interface UIView (Category)

/**
 
 */
@property (nonatomic, assign) CGFloat x;

/**
 
 */
@property (nonatomic, assign) CGFloat y;

/**
 
 */
@property (nonatomic, assign) CGFloat centerX;

/**
 
 */
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGFloat cornerRadius;
/**
 * Shortcut for frame.origin.x.
 *
 * Sets frame.origin.x = left
 */
@property (nonatomic) CGFloat left;

/**
 * Shortcut for frame.origin.y
 *
 * Sets frame.origin.y = top
 */
@property (nonatomic) CGFloat top;

/**
 * Shortcut for frame.origin.x + frame.size.width
 *
 * Sets frame.origin.x = right - frame.size.width
 */
@property (nonatomic) CGFloat right;

/**
 * Shortcut for frame.origin.y + frame.size.height
 *
 * Sets frame.origin.y = bottom - frame.size.height
 */
@property (nonatomic) CGFloat bottom;

/**
 * Return the x coordinate on the screen.
 */
@property (nonatomic, readonly) CGFloat ttScreenX;

/**
 * Return the y coordinate on the screen.
 */
@property (nonatomic, readonly) CGFloat ttScreenY;

/**
 * Return the x coordinate on the screen, taking into account scroll views.
 */
@property (nonatomic, readonly) CGFloat screenViewX;

/**
 * Return the y coordinate on the screen, taking into account scroll views.
 */
@property (nonatomic, readonly) CGFloat screenViewY;

/**
 * Return the view frame on the screen, taking into account scroll views.
 */
@property (nonatomic, readonly) CGRect screenFrame;


- (void)addBottomBorderWithColor: (UIColor *) color andWidth:(CGFloat) borderWidth;
- (void)addBottomBorderWithColor:(UIColor *)color andWidth:(CGFloat) borderWidth andViewWidth:(CGFloat)viewWidth;
- (void)addLeftBorderWithColor: (UIColor *) color andWidth:(CGFloat) borderWidth;
- (void)addRightBorderWithColor: (UIColor *) color andWidth:(CGFloat) borderWidth;
- (void)addTopBorderWithColor: (UIColor *) color andWidth:(CGFloat) borderWidth;
- (void)addTopBorderWithColor: (UIColor *) color andWidth:(CGFloat) borderWidth andViewWidth:(CGFloat) viewWidth;
- (void)UILayoutCornerRadiusType:(UILayoutCornerRadiusType)sideType withCornerRadius:(CGFloat)cornerRadius;

//得到当前view所在的控制器
- (UIViewController *)getCurrentController;
/**
 添加单击手势
 */
- (void)addTapGestureRecognizerWithTarget:(id)target action:(SEL)sel;
/**
 添加长按手势
 */
- (void)addLongGestureRecognizerWithTarget:(id)target action:(SEL)sel;

/**
 添加拖拽手势
 */
- (void)addPanGestureRecognizerWithTarget:(id)target action:(SEL)sel;

/**
 添加左滑手势
 */
- (void)addLeftSwipeGestureRecognizerWithTarget:(id)target action:(SEL)sel;

/**
 添加右滑手势
 */
- (void)addRightSwipeGestureRecognizerWithTarget:(id)target action:(SEL)sel;

/**
 添加上滑手势
 */
- (void)addUpSwipeGestureRecognizerWithTarget:(id)target action:(SEL)sel;

/**
 添加下滑手势
 */
- (void)addDownSwipeGestureRecognizerWithTarget:(id)target action:(SEL)sel;

/**
 删除view上所有手势
 */
- (void)removeAllGestureRecognizer;


- (void)removeAllSubviews;

- (UIViewController *)viewController;

+ (instancetype) viewFromDefaultNibName;

- (UITableView *)findSuperTabView;


@end
