//
//  ELBlueToothManager.h
//  Eleenoe
//
//  Created by FaceBook on 2019/3/15.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

#define  BLE_Suffix    @"HJ"     //过滤设备前缀 (HJ_580XP_EE)
#define  BLE_SEVICEID  @"FFF0"   //服务的UUID
#define  BLE_READ      @"0xFFF1" //读特性
#define  BLE_WRITE     @"0xFFF2" //写特性
#define  BLE_NOTICE    @"0xFFF3" //通知特性


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

@class ELBlueToothManager;

//蓝牙管理代理
@protocol ELBluetoothLEManagerDelegate <NSObject>
@optional
/**
 *  蓝牙状态，仅在本地蓝牙状态为开启时, 即ELBleLocalStatePowerOn，其他函数方可使用
 *
 *  @param ble     蓝牙
 *  @param state   当前蓝牙的状态
 *
 */
- (void)ble:(ELBlueToothManager *)ble didLocalState:(ELBleLocalState)state;

@end


@interface ELBlueToothManager : NSObject

//蓝牙管理代理
@property (nonatomic, weak) id<ELBluetoothLEManagerDelegate> managerDelegate;

//蓝牙本地状态
@property(readonly) ELBleLocalState loaclState;


/**
 *  蓝牙单例
 *
 *  @return 蓝牙单例
 *
 */
+ (instancetype)shareInstance;

/**
 *  开始扫描
 *
 *  @param isPowerSaving      是否为省电模式；true为省电模式即不会更新重复的设备，false为非省电模式
 *  @param serviceUUIDs       仅扫描有该服务的设备
 *
 *  @return 成功true，否则false
 *
 *  @note 结果见回调函数 ble:didScan:advertisementData:rssi:
 */
- (BOOL)startScan:(BOOL)isPowerSaving services:(NSArray <NSString *> *)serviceUUIDs;

/**
 *  发送数据
 *
 */
-(BOOL)send:(NSData *)data;

/**
 *  停止扫描
 *
 */
- (void)stopScan;

@end

NS_ASSUME_NONNULL_END
