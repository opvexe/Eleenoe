//
//  ELBlueToothManager.h
//  Eleenoe
//
//  Created by FaceBook on 2019/3/15.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

#define  BLE_Suffix             @"HJ"   //过滤设备前缀 (HJ_580XP_EE)
#define  BLE_ADDATESEVICE_UUID  @"6958" //kCBAdvDataServiceUUIDs
#define  BLE_SEVICEID_UUID      @"FFF0" //特征服务的UUID
#define  BLE_NOTICE             @"FFF1" //通知特性
#define  BLE_WRITE              @"FFF2" //写特性
#define  BLE_READ               @"FFF3" //读特性


NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, ELBleLocalState) {
    ELBleLocalStatePowerOff,         //本地蓝牙已关闭
    ELBleLocalStatePowerOn,          //本地蓝牙已开启
    ELBleLocalStateUnsupported,     //本地不支持蓝牙
};

typedef NS_ENUM(NSInteger, ELResultType) {
    ELResultTypeSuccess,     //成功
    ELResultTypeFailed,      //失败
    ELResultTypeTimeOut,     //超时
    ELResultTypeLoading,     //加载中
};

typedef void (^ELConnectPeripheralStateBlock)(ELResultType connectState);
typedef void (^ELExameBluetoothStateBlock)(ELBleLocalState localState);

@interface ELBlueToothManager : NSObject

+ (instancetype)shareInstance;

- (void)connectPeripheralWithStateCallback:(ELConnectPeripheralStateBlock)connectStateCallback
                           examBLECallback:(ELExameBluetoothStateBlock)stateCallback;

- (void)reScanPeripheral;
- (void)stopScan;
- (void)send:(NSData *)data;

@end

NS_ASSUME_NONNULL_END
