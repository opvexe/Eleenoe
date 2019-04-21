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
#define Ble_F0   @"0xF0"

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
//#define Ble_ //0x03    0x00    空参数，不改变上一个命令此参数值
//0x01    固定自动程序1 （如 肌肉放松）
//0x02    固定自动程序2 （如 疼痛控制）
//0x03    固定自动程序3
//0x04    固定自动程序4
//0x05    固定自动程序5
//0x06    固定自动程序6
//0x11    固定手法1（如 揉捏）
//0x12    固定手法2（如 敲击）
//0x13    固定手法3（如 针灸）
//0x14    固定手法4（如 推拿）

#endif /* ELBleDefines_h */
