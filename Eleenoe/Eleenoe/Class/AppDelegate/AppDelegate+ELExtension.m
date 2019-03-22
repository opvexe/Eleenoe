//
//  AppDelegate+ELExtension.m
//  Eleenoe
//
//  Created by FaceBook on 2019/3/13.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import "AppDelegate+ELExtension.h"
#import "ELBaseNavigationViewController.h"
#import "ELTabBarControllerConfig.h"
#import "ELHomeViewController.h"
#import "ELGuideViewController.h"

@implementation AppDelegate (ELExtension)

-(void)switchRootController{
    
    if ([ELUserDataSocure isNewVersion]) {
        
        self.window.rootViewController = [[ELGuideViewController alloc]init];
        
    }else{
        
        ELTabBarControllerConfig  *tabBarControllerConfig = [[ELTabBarControllerConfig alloc]init];
        self.window.rootViewController = tabBarControllerConfig.tabBarController;
    }
}

-(void)registrationThirdLib{
     NSLog(@"合并测试");
      NSLog(@"合并测试");

    NSLog(@"分支");
    NSLog(@"分支");
    NSLog(@"分支");
    NSLog(@"分支");

}

@end
