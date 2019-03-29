//
//  ELCommonDefines.h
//  Eleenoe
//
//  Created by FaceBook on 2019/3/12.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#ifndef ELCommonDefines_h
#define ELCommonDefines_h


#ifndef weakify
#if __has_feature(objc_arc)
#define weakify(self) autoreleasepool {} __attribute__((objc_ownership(weak))) __typeof__(self) weakSelf = (self)
#endif
#endif

#ifndef strongify
#if __has_feature(objc_arc)
#define strongify(self) try {} @finally {} _Pragma("clang diagnostic push") _Pragma("clang diagnostic ignored \"-Wunused-variable\"") __attribute__((objc_ownership(strong))) __typeof__(self) self = weakSelf; _Pragma("clang diagnostic pop")
#endif
#endif


#define  ELImageNamed(imageName)   [UIImage imageNamed:imageName]

#define  ELUserDefaults        [NSUserDefaults standardUserDefaults]

#define  ELNotificationCenter      [NSNotificationCenter defaultCenter]


#define delay(block)\
dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{\
block();\
});\


#define AppVersion  [[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleShortVersionString"]

#define AppBuildVersion  [[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleVersion"]

#define  ELSharedApplication  [UIApplication sharedApplication].delegate

#define FormatString(string, args...)       [NSString stringWithFormat:string, args]

#define URLFromString(str)                      [NSURL URLWithString:str]


#define ELLocalString(key) NSLocalizedStringFromTable(key, @"Localizable", nil)

#define ALERT(msg) [[[UIAlertView alloc] initWithTitle:nil message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show]

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

#define WSSTRONG(strongSelf) __strong typeof(weakSelf) strongSelf = weakSelf;

#define iOS7      ((floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1)? NO:YES)

#define iOS9Later ([UIDevice currentDevice].systemVersion.floatValue >= 9.0f)

#define iOS11 @available(iOS 11.0, *)

#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)



#define AutomaticallyAdjustsScrollViewInsetsNO(view) if (@available(iOS 11.0, *)) {view.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;}else{self.automaticallyAdjustsScrollViewInsets = NO;}


#define UTF8Data(str) [str dataUsingEncoding:NSUTF8StringEncoding]


#ifdef __OBJC__
#ifdef DEBUG
# define NSLog(fmt, ...) NSLog((@"[文件名:%s]\n" "[函数名:%s]\n" "[行号:%d] \n" fmt), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
# define NSLog(...);
#endif

#endif

#endif /* ELCommonDefines_h */
