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
#import "ELDefaultContentViewController.h"

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
    
    ELDefaultContentViewController *shopViewController = [[ELDefaultContentViewController alloc]init];
    UIViewController *shopNavigationController = [[ELBaseNavigationViewController alloc]
                                                  initWithRootViewController:shopViewController];
    
    ELMineViewController *mineViewController = [[ELMineViewController alloc] init];
    UIViewController *mineNavigationController = [[ELBaseNavigationViewController alloc]
                                                  initWithRootViewController:mineViewController];
    
    NSArray *viewControllers = @[
                                 homeNavigationController,
                                 shopNavigationController,
                                 mineNavigationController
                                 ];
    return viewControllers;
}

- (NSArray *)tabBarItemsAttributesForController {
    NSDictionary *homeTabBarItemsAttributes = @{
                                                CYLTabBarItemTitle : @"首页",
                                                CYLTabBarItemImage : @"home_normal",
                                                CYLTabBarItemSelectedImage : @"home_select",
                                                };
    NSDictionary *shopTabBarItemsAttributes = @{
                                                CYLTabBarItemTitle : @"商城",
                                                CYLTabBarItemImage : @"shop_normal",
                                                CYLTabBarItemSelectedImage : @"shop_select",
                                                };
    
    NSDictionary *mineTabBarItemsAttributes = @{
                                                CYLTabBarItemTitle : @"我的",
                                                CYLTabBarItemImage : @"mine_normal",
                                                CYLTabBarItemSelectedImage : @"mine_select",
                                                };
    NSArray *tabBarItemsAttributes = @[
                                       homeTabBarItemsAttributes,
                                       shopTabBarItemsAttributes,
                                       mineTabBarItemsAttributes
                                       ];
    return tabBarItemsAttributes;
}

- (void)customizeTabBarAppearance:(CYLTabBarController *)tabBarController {

    ///普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = TabbarNormalColor;
    normalAttrs[NSFontAttributeName] = [UIFont ELPingFangSCRegularFontOfSize:kSaFont(10.0)];
    
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = TabbarHightColor;
    selectedAttrs[NSFontAttributeName] = [UIFont ELPingFangSCRegularFontOfSize:kSaFont(10.0)];
    
    // 设置文字属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    // 设置背景图片
    [[UITabBar appearance] setBackgroundImage:[UIImage imageWithColor:UIColorFromRGB(0xFFFFFF)]];
    [[UITabBar appearance] setShadowImage:[UIImage new]];
}

@end
