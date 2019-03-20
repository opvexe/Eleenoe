//
//  ELBlueToothManager.h
//  Eleenoe
//
//  Created by FaceBook on 2019/3/15.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

NS_ASSUME_NONNULL_BEGIN

#define M_BLE_Suffix  @""
#define DEVICE @"FF01"

@interface ELBlueToothManager : NSObject

+ (instancetype)shareInstance;

-(void)discoverBlueTooth;

//发送数据
-(void)sendDataToBLE:(NSData *)data;

@end

NS_ASSUME_NONNULL_END
