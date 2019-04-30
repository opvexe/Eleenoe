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
    
    [MobClick setAppVersion:XcodeAppVersion];
    
    UMConfigInstance.ePolicy = REALTIME;
    
    UMConfigInstance.appKey  = UMENG_APPKEY;
    
    UMConfigInstance.channelId = @"App Store";
    
    UMConfigInstance.eSType  = E_UM_NORMAL;
    
    [MobClick startWithConfigure:UMConfigInstance];
    
    [MobClick setCrashReportEnabled:YES];  //开启崩溃日志采集
    
    [[UMSocialManager defaultManager]setUmSocialAppkey:UMENG_APPKEY];
    
#if kReleaseAPI
    [[UMSocialManager defaultManager] openLog:NO];
    [MobClick setLogEnabled:NO];
#elif kTestAPI
    [[UMSocialManager defaultManager] openLog:YES];
     [MobClick setLogEnabled:YES];
#else
    [[UMSocialManager defaultManager] openLog:NO];
    [MobClick setLogEnabled:NO];
#endif
    
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:WEIXIN_APPKEY appSecret:WEXIN_SECRET redirectURL:nil];
    
}


@end
