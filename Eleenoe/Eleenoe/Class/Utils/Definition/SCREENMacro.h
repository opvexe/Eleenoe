//
//  SCREENMacro.h
//  Eleenoe
//
//  Created by zhanglu on 2019/3/29.
//  Copyright © 2019 FaceBook. All rights reserved.
//

#ifndef SCREENMacro_h
#define SCREENMacro_h
// px
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)

#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))

#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define iOS11Later ([UIDevice currentDevice].systemVersion.floatValue >= 11.0f)

#define StatusBar_HEIGHT [[UIApplication sharedApplication] statusBarFrame].size.height

///判断 iPhone X || 判断 iPhone Xs
#define isIPhoneX_Xs (CGSizeEqualToSize(CGSizeMake(375.f, 812.f), [UIScreen mainScreen].bounds.size) || CGSizeEqualToSize(CGSizeMake(812.f, 375.f), [UIScreen mainScreen].bounds.size))
//判断iPHoneXR || 判断iPhoneXs Max
#define isIPhoneXR_XsMax (CGSizeEqualToSize(CGSizeMake(414.f, 896.f), [UIScreen mainScreen].bounds.size) || CGSizeEqualToSize(CGSizeMake(896.f, 414.f), [UIScreen mainScreen].bounds.size))
//判断 iPhoneX 系列设备
#define iS_IPhoneX_All ([UIScreen mainScreen].bounds.size.height == 812 || [UIScreen mainScreen].bounds.size.height == 896)
/** 设置默认 iPhone X 导航栏 安全高度 */
#define iPhoneX_Navigation_Safe_Height (iS_IPhoneX_All ? 24  : 0)
/** 设置默认 iPhone X 底部导航栏 安全高度 */
#define iPhoneX_Bottom_Bar_Safe_Height (iS_IPhoneX_All ? 34  : 0)
/** 设置默认 iPhone X 导航栏 高度 88xp  普通 64xp */
#define iPhone_X_Navigation_Bar_Heigth  (iS_IPhoneX_All ? iPhoneX_Navigation_Safe_Height + 64 : 64)
/** 设置默认 iPhone X 底部导航栏 高度 83xp  普通 49xp */
#define iPhoneX_Bottom_Navigation_Bar_Height (iS_IPhoneX_All ? iPhoneX_Bottom_Bar_Safe_Height + 49 : 49)
/** 设置默认 iPhone X 状态栏高度 */
#define StatusBarHeight ((iS_IPhoneX_All)?44:20)

#endif /* SCREENMacro_h */
