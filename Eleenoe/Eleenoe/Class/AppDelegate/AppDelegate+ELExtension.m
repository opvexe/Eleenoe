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
    
    [self umengTrack];
    
}

-(void)umengTrack{
    
    [MobClick setLogEnabled:YES];

    [MobClick setAppVersion:XcodeAppVersion];

    UMConfigInstance.ePolicy = REALTIME;

    UMConfigInstance.appKey  = UMENG_APPKEY;
    
    UMConfigInstance.channelId = @"App Store";
    
    UMConfigInstance.eSType  = E_UM_NORMAL;

    [MobClick startWithConfigure:UMConfigInstance];
    
    [[UMSocialManager defaultManager]setUmSocialAppkey:UMENG_APPKEY];
    
    [[UMSocialManager defaultManager] openLog:YES];
    
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:WEIXIN_APPKEY appSecret:WEXIN_SECRET redirectURL:nil];
}


@end
