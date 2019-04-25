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
/*
 * 异或运算 0x7F :9位验证码
 */
-(void)exclusive;

+ (instancetype)shareInstance;

- (void)connectPeripheralWithStateCallback:(ELConnectPeripheralStateBlock)connectStateCallback
                           examBLECallback:(ELExameBluetoothStateBlock)stateCallback;

- (void)reScanPeripheral;
- (void)stopScan;
- (void)sendCommand;

/*
 *  返回数据 <f0000100 09015200 5df1>
 
 f0起始位，
 00表明正常运行状态，
 01表明自动程序1（为0表示未运行），
 00表示按摩部位，
 09表示时间，
 01表示强度（强度为0表示未运行）
 52是电池容量百分比，
 00是与皮肤接触度，
 5d为检验码
 */
@end

NS_ASSUME_NONNULL_END
