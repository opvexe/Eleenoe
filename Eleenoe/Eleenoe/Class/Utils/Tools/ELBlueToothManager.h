//
//  ELBlueToothManager.h
//  Eleenoe
//
//  Created by FaceBook on 2019/3/15.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

#define  BLE_Suffix  @"HJ"     //过滤设备前缀 (HJ_580XP_EE)
#define  BLE_CBUUID  @"FFF0"   //服务的UUID
#define  BLE_READ    @"0xFFF1" //读特性
#define  BLE_WRITE   @"0xFFF2" //写特性
#define  BLE_NOTICE  @"0xFFF3" //通知特性


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
