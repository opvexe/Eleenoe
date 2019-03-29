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
#import "ELLoginViewController.h"

@implementation AppDelegate (ELExtension)

-(void)switchRootController{
    
//    if ([ELUserDataSocure isNewVersion]) {
//
        self.window.rootViewController = [[ELLoginViewController alloc]init];
//
//    }else{
//
//        ELTabBarControllerConfig  *tabBarControllerConfig = [[ELTabBarControllerConfig alloc]init];
//        self.window.rootViewController = tabBarControllerConfig.tabBarController;
//    }
    
}

-(void)registrationThirdLib{
    
}

@end
