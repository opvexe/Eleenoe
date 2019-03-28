//
//  CJXBarButtonItem.h
//  SuperstarUser
//
//  Created by snowlu on 2017/9/29.
//  Copyright © 2017年 CJX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CJXBarButtonItem : UIButton

@property(nonatomic,assign)BOOL isHideBadValue;

+ (instancetype)BadValueButtonWithImageNormal:(NSString *)imageNormal imageSelected:(NSString *)imageSelected target:(id)target selector:(SEL)sel;
//创建文字按钮
+ (instancetype)buttonWithTitle:(NSString *)buttonTitle target:(id)target selector:(SEL)sel;

//创建图标按钮
+ (instancetype)buttonWithImageNormal:(NSString *)imageNormal imageSelected:(NSString *)imageSelected target:(id)target selector:(SEL)sel;

+ (instancetype)buttonWithImageNormal:(NSString *)imageNormal imageSelected:(NSString *)imageSelected imageHightlight:(NSString *)imageHighlight target:(id)target selector:(SEL)sel;

//创建带文字和图片的按钮
+ (instancetype)buttonWithTitle:(NSString *)buttonTitle ImageNormal:(NSString *)imageNormal imageSelected:(NSString *)imageSelected target:(id)target selector:(SEL)sel;
//高度制定的按钮

+ (instancetype)buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font backgroundColor:(UIColor *)backgroundColor image:(NSString *)image target:(id)target selector:(SEL)sel;

+ (instancetype)buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font backgroundColor:(UIColor *)backgroundColor target:(id)target selector:(SEL)sel;

+ (instancetype)newbuttonWithImageNormal:(NSString *)imageNormal imageSelected:(NSString *)imageSelected target:(id)target selector:(SEL)sel;
@end
