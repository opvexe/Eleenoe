//
//  ELBlueToothManager.h
//  Eleenoe
//
//  Created by FaceBook on 2019/3/15.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

#define  BLE_Suffix             @"HJ"   //过滤设备前缀 (HJ_580XP_EE)   后期 iPerMove  试试180A
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

/*
 * [0] 开始命令
 * [1] 通讯命令
 * [2] 模式选择
 * [3] 强度
 * [4] 部位
 * [5-6] 预留，不解析
 * [7] 时间
 * [8-9] 预留，不解析
 * [10] 校验位
 * [11] 结束位
 */
@property(nonatomic,strong)NSMutableArray *operations;

+ (instancetype)shareInstance;

- (void)connectPeripheralWithStateCallback:(ELConnectPeripheralStateBlock)connectStateCallback
                           examBLECallback:(ELExameBluetoothStateBlock)stateCallback;

- (void)reScanPeripheral;
- (void)stopScan;
- (void)sendCommand;

@end

NS_ASSUME_NONNULL_END
