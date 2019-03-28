//
//  ELBaseViewController.h
//  Eleenoe
//
//  Created by FaceBook on 2019/3/12.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIView+Toast.h>
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, ToastPositionType) {
    ToastPositionTypeTop,
    ToastPositionTypeCenter,
    ToastPositionTypeBottom,
};

@interface ELBaseViewController : UIViewController

/**
 * 导航
 */
@property (nonatomic,strong) UIView *navigationRightView;
@property (nonatomic,strong) UIView *navigationleftView;
/**
 * 加载视图
 
 @param message 返回错误弹框提示
 */
-(void)makeToast:(NSString *)message;
-(void)makeToast:(NSString *)message backImageView:(NSString *)image;
-(void)makeToast:(NSString *)message duration:(NSTimeInterval)duration position:(ToastPositionType )position;

/**
 * 网络失败展示图
 
 @param view 网络失败展示图
 */
-(void)networkErrorWithView:(UIView*)view;


#pragma mark  占位图
- (void)createPlaceholderView:(nullable NSString *) title
                      message:(nullable NSString *)message
                        image:(nullable UIImage *)image
                     withView:(nullable UIView *)superView;

- (void)createPlaceholderView:(nullable NSString *) title
                      message:(nullable NSString *)message
                        image:(nullable UIImage *)image
                     withView:(nullable UIView *)superView action:(nullable SEL)reloadAction;

- (void)createPlaceholderView:(nullable NSString *) title
                      message:(nullable NSString *)message
                        image:(nullable UIImage *)image
                     withView:(nullable UIView *)superView refTitle:(NSString *)reftitle action:(nullable SEL)reloadAction;

/**
 * 移除展位图
 
 */
- (void)removePlaceholderView;


///MARK: TOOD
-(void)dismissKeyBoard;
-(void)reloadDataSoucre;

@end

NS_ASSUME_NONNULL_END
