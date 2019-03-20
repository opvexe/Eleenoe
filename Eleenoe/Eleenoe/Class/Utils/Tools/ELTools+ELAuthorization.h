//
//  ELTools+ELAuthorization.h
//  Eleenoe
//
//  Created by FaceBook on 2019/3/13.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import "ELTools.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, PrivatePermissionStatus) {
    Authorized = 1,  //用户允许
    AuthorRestricted,//被限制修改不了状态,比如家长控制选项等
    Denied,          //用户拒绝
    NotDetermined    //用户尚未选择
};

@interface ELTools (ELAuthorization)

/**
 * 申请麦克风权限
 */
+(void)requestAVMediaTypeAudioPermissionComplelte:(void(^)(PrivatePermissionStatus type))complete;


/**
 * 申请拍照权限
 */
+(void)requestAVMediaTypeVideoPermissionComplelte:(void(^)(PrivatePermissionStatus type))complete;

/**
 * 申请相册权限
 */
+(void)requestPhotoLibraryPermissionComplelte:(void(^)(PrivatePermissionStatus type))complete;

/**
 * 打开系统设置
 */
+(void)openSystemSetting;

@end

NS_ASSUME_NONNULL_END
