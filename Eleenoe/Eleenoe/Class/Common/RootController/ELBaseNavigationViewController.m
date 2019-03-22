//
//  ELBaseNavigationViewController.m
//  Eleenoe
//
//  Created by FaceBook on 2019/3/12.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import "ELBaseNavigationViewController.h"

@interface ELBaseNavigationViewController ()<UIGestureRecognizerDelegate,UINavigationControllerDelegate>

@end

@implementation ELBaseNavigationViewController

+ (void)load{
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    UIImage *backgroundImage = nil;
    NSDictionary *textAttributes = nil;
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont systemFontOfSize:16],NSFontAttributeName, nil]];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [navigationBarAppearance setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [navigationBarAppearance setShadowImage:[UIImage new]];
    if (@available(iOS 11.0, *)) {
        [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-2.0, -0.4) forBarMetrics:UIBarMetricsDefault];
    } else {
        [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -2) forBarMetrics:UIBarMetricsDefault];
    }
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
        backgroundImage = [UIImage imageWithColor:UIColorFromRGB(0xffffff)];
        
        textAttributes = @{
                           NSFontAttributeName :[UIFont ELPingFangSCLightFontOfSize:kSaFont(14.0f)],
                           NSForegroundColorAttributeName :UIColorFromRGB(0x646464),
                           };
        
    } else {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
        backgroundImage = [UIImage imageWithColor:UIColorFromRGB(0xffffff)];
        textAttributes = @{
                           UITextAttributeFont : [UIFont ELPingFangSCLightFontOfSize:kSaFont(14.0f)]),
                           UITextAttributeTextColor :UIColorFromRGB(0x646464),
                           UITextAttributeTextShadowColor : [UIColor clearColor],
                           UITextAttributeTextShadowOffset : [NSValue valueWithUIOffset:UIOffsetZero],
                           };
#endif
    }
    [navigationBarAppearance setBackgroundImage:backgroundImage
                                  forBarMetrics:UIBarMetricsDefault];
    [navigationBarAppearance setTitleTextAttributes:textAttributes];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.interactivePopGestureRecognizer.delegate = self;
    self.interactivePopGestureRecognizer.enabled = YES;
    self.delegate = self;
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (navigationController.viewControllers.count == 1) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.childViewControllers.count > 0) {
        [viewController addPopBackBarButtonItem];
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
