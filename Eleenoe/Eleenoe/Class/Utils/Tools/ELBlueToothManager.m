//
//  ELBlueToothManager.m
//  Eleenoe
//
//  Created by FaceBook on 2019/3/15.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import "ELBlueToothManager.h"

@interface ELBlueToothManager ()<CBCentralManagerDelegate, CBPeripheralDelegate>
/**
 手机设备
 */
@property (nonatomic, strong) CBCentralManager *centralManager;
/**
 外设设备
 */
@property (nonatomic, strong) CBPeripheral *peripheral;
/**
 特征值
 */
@property (nonatomic, strong) CBCharacteristic *characteristic;
/**
 服务
 */
@property (nonatomic, strong) CBService *service;
/**
 描述
 */
@property (nonatomic, strong) CBDescriptor *descriptor;
/**
 蓝牙状态
 */
@property(nonatomic,copy)ELBleLocalStateBlock state;

@end

@implementation ELBlueToothManager

+ (ELBlueToothManager *)shareInstance {
    static ELBlueToothManager *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[[self class] alloc] init];
        
    });
    return instance;
}

- (void)checkBlueToothPowerOn:(ELBleLocalStateBlock)state{
    _state = state;
}

- (void)registerBlueToothManager{
    _centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
}

- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    switch (central.state) {
        case CBCentralManagerStatePoweredOff:
            NSLog(@"尚未打开蓝牙，请在设置中打开……");
            if (self.state) {self.state(ELBleLocalStatePowerOff);}
            break;
        case CBCentralManagerStatePoweredOn: {
            NSLog(@"蓝牙已经成功开启，稍后……");
            if (self.state) {self.state(ELBleLocalStatePowerOn);}
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.centralManager scanForPeripheralsWithServices:nil options:@{CBCentralManagerScanOptionAllowDuplicatesKey:@YES}];
            });
            break;
        }
        default:
            if (self.state) {self.state(ELBleLocalStateUnsupported);}
            break;
    }
}

///MARK: 外设设备连接代理
#pragma mark CBCentralManagerDelegate
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *,id> *)advertisementData RSSI:(NSNumber *)RSSI {
    NSLog(@"扫描连接外设：%@ %@ %@",peripheral.name,RSSI,advertisementData);
    if([peripheral.name rangeOfString:BLE_Suffix].location != NSNotFound){
        self.peripheral = peripheral;  //外界设备
        [self.centralManager connectPeripheral:_peripheral options:nil];
    }
}

- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    NSLog(@"设备连接成功:%@", peripheral.name);
    [_peripheral setDelegate:self];
    [_peripheral discoverServices:nil];
}

- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    NSLog(@"设备连接失败:%@", peripheral.name);
    [self.centralManager scanForPeripheralsWithServices:nil options:@{CBCentralManagerScanOptionAllowDuplicatesKey:@YES}];
}

- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    NSLog(@"设备丢失连接:%@", peripheral.name);
    [self.centralManager connectPeripheral:_peripheral options:nil];  //重连
}


///MARK:获取外设设备特征值代理
#pragma mark CBPeripheralDelegate
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error {
    if (!error) {
        for (CBService *service in peripheral.services) {
            [peripheral discoverCharacteristics:nil forService:service];
            NSLog(@"外设设备特征值：%@",service);
        }
    }else{
        NSLog(@"发现外设服务错误信息：%@",[error localizedDescription]);
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error {
    if (!error) {
        for (CBCharacteristic *characteristic in service.characteristics) {
            [_peripheral discoverDescriptorsForCharacteristic:characteristic];
            [_peripheral readValueForCharacteristic:characteristic];
            [_peripheral setNotifyValue:YES forCharacteristic:characteristic]; //打开外设的通知，否则无法接受数据
            if ([characteristic.UUID.UUIDString isEqualToString:BLE_CBUUID]){
                [_peripheral readValueForCharacteristic:characteristic];
            }
        }
    }else{
        NSLog(@"扫描外设的特征失败:%@",error.description);
    }
}


///MARK: 订阅外设设备值发生改变代理
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForDescriptor:(CBDescriptor *)descriptor error:(NSError *)error {
    NSLog(@"更新描述值:%@",descriptor.description);
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    NSString *value = [[NSString alloc] initWithData:characteristic.value encoding:NSUTF8StringEncoding];
    NSLog(@"获取蓝牙发回的数据:%@",value);
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"FFE2"]]) {
        NSData *data =characteristic.value;
        NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding]);
    }
}

-(void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    NSLog(@"改变通知状态:%@",characteristic.service);
}

//- (void)peripheral:(CBPeripheral *)peripheral didDiscoverDescriptorsForCharacteristic:(nonnull CBCharacteristic *)characteristic error:(nullable NSError *)error{
//    NSLog(@"发现外设的特征的描述数组:%@",characteristic.descriptors);
//    if (!error) {
//        for (CBDescriptor *descriptor in characteristic.descriptors) {
//            self.descriptor = descriptor;
//            [peripheral readValueForDescriptor:descriptor];
//        }
//    }
//}

-(void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    if (error) {
        NSLog(@"发送数据失败:%@",error.description);
    }else{
        NSLog(@"发送数据成功回调:%@",characteristic);
    }
}


//Mac地址解析
- (NSString *)convertToNSStringWithNSData:(NSData *)data {
    NSMutableString *strTemp = [NSMutableString stringWithCapacity:[data length]*2];
    const unsigned char *szBuffer = [data bytes];
    for (NSInteger i=0; i < [data length]; ++i) {
        [strTemp appendFormat:@"%02lx",(unsigned long)szBuffer[i]];
    }
    return strTemp;
}


-(void)sendDate{
    unsigned char send[4] = {0x5d, 0x08, 0x01, 0x3b};
    NSData *sendData = [NSData dataWithBytes:send length:4];
}

@end
