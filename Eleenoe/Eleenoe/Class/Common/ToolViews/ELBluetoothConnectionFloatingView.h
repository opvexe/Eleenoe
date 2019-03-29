//
//  ELBluetoothConnectionFloatingView.h
//  Eleenoe
//
//  Created by zhanglu on 2019/3/29.
//  Copyright © 2019 FaceBook. All rights reserved.
//

#import "ELBaseView.h"

/**
 连接状态

 - ConnectionStatusTypeNone: ConnectionStatusTypeNone 未连接
 - ConnectionStatusTypeLoading: ConnectionStatusTypeLoading 正在连接
 - ConnectionStatusTypeFailure: ConnectionStatusTypeFailure 连接失败
 - ConnectionStatusTypeSuccess: ConnectionStatusTypeSuccess 连接成功
 */
typedef NS_ENUM(NSUInteger, ConnectionStatusType) {
    ConnectionStatusTypeNone,
    ConnectionStatusTypeLoading,
    ConnectionStatusTypeFailure,
    ConnectionStatusTypeSuccess
};

NS_ASSUME_NONNULL_BEGIN


@interface ELBluetoothConnectionFloatingView : ELBaseView

+(instancetype)showComplete:(void(^)(ConnectionStatusType))complete;

+(void)updateStatus:(ConnectionStatusType)status;

@end

NS_ASSUME_NONNULL_END
