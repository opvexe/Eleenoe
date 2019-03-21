//
//  ELBlueToothManager.h
//  Eleenoe
//
//  Created by FaceBook on 2019/3/15.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

#define  M_BLE_Suffix @""
#define  DEVICE @""
NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger,ELBlueToothPowerType) {
    ELBlueToothPowerTypeON,
    ELBlueToothPowerTypeOFF,
};

typedef void(^ELBlueToothPowerBlock)(ELBlueToothPowerType PowerType);

@interface ELBlueToothManager : NSObject

/**
 *  获取连接管理对象
 *
 */
+ (instancetype)shareInstance;

/**
 *  注册中央maneger
 */
- (void)registerBlueToothManager;

/**
 *  检测蓝牙是否打开或者关闭
 *
 */
- (void)checkBlueToothPowerOn:(ELBlueToothPowerBlock)blueToothPowerblock;


@end

NS_ASSUME_NONNULL_END
