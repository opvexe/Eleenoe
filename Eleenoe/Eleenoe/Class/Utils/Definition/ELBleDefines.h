//
//  ELBleDefines.h
//  Eleenoe
//
//  Created by FaceBook on 2019/3/21.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#ifndef ELBleDefines_h
#define ELBleDefines_h

/**
 蓝牙通讯协议 - 开始
 */

#define Ble_F0   @"0xF0" //开始

/**
 蓝牙通讯协议 - 通讯命令
 */

#define Ble_00   @"0x00"  //空命令
#define Ble_01   @"0x01"  //停止命令
#define Ble_02   @"0x02"  //设置命令
#define Ble_03   @"0x03"  //自动模式
#define Ble_04   @"0x04"  //手动模式
#define Ble_05   @"0x05"  //固件升级

/**
 蓝牙通讯协议 - 参数1为模式选择: 0x03
 */

#define BleParamp01_00  @"0x00"  //0x00    空参数，不改变上一个命令此参数值
#define BleParamp01_01  @"0x01"  //0x01    固定自动程序1 （如 肌肉放松）
#define BleParamp01_02  @"0x02"  //0x02    固定自动程序2 （如 疼痛控制）
#define BleParamp01_03  @"0x03"  //0x03    固定自动程序3
#define BleParamp01_04  @"0x04"  //0x04    固定自动程序4
#define BleParamp01_05  @"0x05"  //0x05    固定自动程序5
#define BleParamp01_06  @"0x06"  //0x06    固定自动程序6
#define BleParamp01_11  @"0x11"  //0x11    固定手法1（如 揉捏）
#define BleParamp01_12  @"0x12"  //0x12    固定手法2（如 敲击）
#define BleParamp01_13  @"0x13"  //0x13    固定手法3（如 针灸）
#define BleParamp01_14  @"0x14"  //0x14    固定手法4（如 推拿）

/**
 蓝牙通讯协议 - 参数2为强度: 0x03
 */
#define BleParamp02_00  @"0x00"  //0x00  空参数
#define BleParamp02_01  @"0x01"
#define BleParamp02_02  @"0x02"
#define BleParamp02_03  @"0x03"
#define BleParamp02_04  @"0x04"
#define BleParamp02_05  @"0x05"
#define BleParamp02_06  @"0x06"
#define BleParamp02_07  @"0x07"
#define BleParamp02_08  @"0x08"
#define BleParamp02_09  @"0x09"
#define BleParamp02_10  @"0x10"
#define BleParamp02_11  @"0x11"
#define BleParamp02_12  @"0x12"
#define BleParamp02_13  @"0x13"
#define BleParamp02_14  @"0x14"
#define BleParamp02_15  @"0x0F"


/**
 蓝牙通讯协议 - 参数3为部位选择: 0x03
 */

#define BleParamp03_00  @"0x00"  //0x00    空参数，不改变上一个命令此参数值
#define BleParamp03_01  @"0x01"  //0x01    肩部
#define BleParamp03_02  @"0x02" //0x02    背部
#define BleParamp03_03  @"0x03" //0x03    臀部
#define BleParamp03_04  @"0x04" //0x04    大腿
#define BleParamp03_05  @"0x05" //0x05    小腿
#define BleParamp03_06  @"0x06" //0x06    颈部
#define BleParamp03_07  @"0x07" //0x07    手臂

/**
 蓝牙通讯协议 - 参数4和参数5预留，不解析。 :0x03
 */
#define BleParamp045_00 @"0x00"

/**
 蓝牙通讯协议 - 参数6为时间设置:0x03  (0x01到0x14为时间1到20分钟的设置)
 */

#define BleParamp06_00  @"0x00"  //0x00  空参数
#define BleParamp06_01  @"0x01"
#define BleParamp06_02  @"0x02"
#define BleParamp06_03  @"0x03"
#define BleParamp06_04  @"0x04"
#define BleParamp06_05  @"0x05"
#define BleParamp06_06  @"0x06"
#define BleParamp06_07  @"0x07"
#define BleParamp06_08  @"0x08"
#define BleParamp06_09  @"0x09"
#define BleParamp06_10  @"0x10"
#define BleParamp06_11  @"0x11"
#define BleParamp06_12  @"0x12"
#define BleParamp06_13  @"0x13"
#define BleParamp06_14  @"0x14"

/**
 蓝牙通讯协议 - 参数7和参数8预留，不解析。 :0x03
 */
#define BleParamp078_00 @"0x00"

/**
 蓝牙通讯协议 - 参数9校验位: 0x03 (去除最高位的1)
 */
#define BleParamp09_00 @"0x00"

/**
 蓝牙通讯协议 - 参数10结束位
 */
#define Ble_F1  @"0xF1"  //结束位

#endif /* ELBleDefines_h */
