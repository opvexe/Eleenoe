//
//  ELTools+ELAuthorization.m
//  Eleenoe
//
//  Created by FaceBook on 2019/3/13.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import "ELTools+ELAuthorization.h"
#import <Photos/Photos.h>

@implementation ELTools (ELAuthorization)


/**
 * 申请麦克风权限
 */
+ (void)requestAVMediaTypeAudioPermissionComplelte:(void(^)(PrivatePermissionStatus type))complete{
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio completionHandler:^(BOOL granted) {
        PrivatePermissionStatus permissionStatus;
        if (granted) {
            permissionStatus = Authorized;
        } else{
            permissionStatus = Denied;
        }
        if (complete) {
            complete(permissionStatus);
        }
    }];
}


/**
 * 申请拍照权限
 */
+(void)requestAVMediaTypeVideoPermissionComplelte:(void(^)(PrivatePermissionStatus type))complete{
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
        PrivatePermissionStatus permissionStatus;
        if (granted) {
            permissionStatus = Authorized;
        } else {
            permissionStatus = Denied;
        }
        if (complete) {
            complete(permissionStatus);
        }
    }];
}

/**
 * 申请相册权限
 */
+ (void)requestPhotoLibraryPermissionComplelte:(void(^)(PrivatePermissionStatus type))complete{
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        PrivatePermissionStatus permissionStatus;
        if (status == PHAuthorizationStatusAuthorized) {
            permissionStatus = Authorized;
        } else if (status == PHAuthorizationStatusNotDetermined) {
            permissionStatus = NotDetermined;
        } else if (status == PHAuthorizationStatusRestricted) {
            permissionStatus = AuthorRestricted;
        } else {
            permissionStatus = Denied;
        }
        if (complete) {
            complete(permissionStatus);
        }
    }];
}

/**
 * 打开系统设置
 */
+ (void)openSystemSetting{
    NSURL *settingUrl = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if ([[UIApplication sharedApplication] canOpenURL:settingUrl]) {
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:settingUrl options:[NSDictionary dictionary] completionHandler:nil];
        } else {
            [[UIApplication sharedApplication] openURL:settingUrl];
        }
    }
}

@end
