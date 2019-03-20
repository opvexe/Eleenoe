//
//  ELTabBarControllerConfig.m
//  Eleenoe
//
//  Created by FaceBook on 2019/3/12.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import "ELTabBarControllerConfig.h"
#import "ELBaseNavigationViewController.h"
#import "ELRootViewController.h"
#import "ELHomeViewController.h"
#import "ELMineViewController.h"

@interface ELTabBarControllerConfig ()

@property (nonatomic, strong) CYLTabBarController *tabBarController;

@end

@implementation ELTabBarControllerConfig

- (CYLTabBarController *)tabBarController {
    if (!_tabBarController) {
        UIEdgeInsets imageInsets = UIEdgeInsetsZero;
        UIOffset titlePositionAdjustment = UIOffsetZero;
        ELRootViewController *tabBarController = [ELRootViewController tabBarControllerWithViewControllers:self.viewControllers
                                                                                     tabBarItemsAttributes:self.tabBarItemsAttributesForController
                                                                                               imageInsets:imageInsets
                                                                                   titlePositionAdjustment:titlePositionAdjustment];
        [self customizeTabBarAppearance:tabBarController];
        _tabBarController = tabBarController;
    }
    return _tabBarController;
}

- (NSArray *)viewControllers {
    ELHomeViewController *homeViewController = [[ELHomeViewController alloc] init];
    UIViewController *homeNavigationController = [[ELBaseNavigationViewController alloc]
                                                  initWithRootViewController:homeViewController];
    
    ELMineViewController *mineViewController = [[ELMineViewController alloc] init];
    UIViewController *mineNavigationController = [[ELBaseNavigationViewController alloc]
                                                     initWithRootViewController:mineViewController];
    
    NSArray *viewControllers = @[
                                 homeNavigationController,
                                 mineNavigationController
                                 ];
    return viewControllers;
}

- (NSArray *)tabBarItemsAttributesForController {
    NSDictionary *homeTabBarItemsAttributes = @{
                                                CYLTabBarItemTitle : @"首页",
                                                CYLTabBarItemImage : @"Home_Icon_Normal",
                                                CYLTabBarItemSelectedImage : @"Home_Icon_Selected",
                                                };
    NSDictionary *mineTabBarItemsAttributes = @{
                                                   CYLTabBarItemTitle : @"我的",
                                                   CYLTabBarItemImage : @"Message_Icon_Normal",
                                                   CYLTabBarItemSelectedImage : @"Message_Icon_Selected",
                                                   };
    NSArray *tabBarItemsAttributes = @[
                                       homeTabBarItemsAttributes,
                                       mineTabBarItemsAttributes
                                       ];
    return tabBarItemsAttributes;
}

- (void)customizeTabBarAppearance:(CYLTabBarController *)tabBarController {
    tabBarController.tabBarHeight = EL_TabbarHeight;
    ///普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = TabbarNormalColor;
    normalAttrs[NSFontAttributeName] = [UIFont ELPingFangSCLightFontOfSize:Number(12.0f)];
    
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = TabbarHightColor;
    selectedAttrs[NSFontAttributeName] = [UIFont ELPingFangSCLightFontOfSize:Number(12.0f)];
    
    // 设置文字属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    // 设置背景图片
    [[UITabBar appearance] setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]]];
    [[UITabBar appearance] setShadowImage:[UIImage new]];
}

@end
