//
//  CPProgressHUD.m
//  ChargingPile
//
//  Created by ZL on 16/10/12.
//  Copyright © 2016年 LittleShrimp. All rights reserved.
//

#import "CPProgressHUD.h"

@implementation CPProgressHUD
+ (void)initialize
{
    [self setSuccessImage:[UIImage imageNamed:@"HUD_success"]];
    [self setInfoImage:[UIImage imageNamed:@"HUD_info"]];
    [self setErrorImage:[UIImage imageNamed:@"HUD_error"]];
    [self setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [self setDefaultStyle:SVProgressHUDStyleDark];
    [self setCornerRadius:8.0];
    [self setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
}
// 根据 提示文字字数，判断 HUD 显示时间
- (NSTimeInterval)displayDurationForString:(NSString*)string
{
    return MIN((float)string.length*0.06 + 0.5, 2.0);
}

// 修改 HUD 颜色，需要取消混合效果(使`backgroundColroForStyle`方法有效)
- (void)updateBlurBounds{
}

// HUD 颜色
- (UIColor*)backgroundColorForStyle{
    return [UIColor colorWithWhite:0 alpha:0.9];
}
@end
