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


@end

@implementation ELBlueToothManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        _centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    }
    return self;
}

/**
 *  蓝牙单例
 *
 *  @return 蓝牙单例
 *
 */
+ (ELBlueToothManager *)shareInstance {
    static ELBlueToothManager *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[[self class] alloc] init];
        
    });
    return instance;
}

#pragma mark - CBCentralManager代理函数

//本地蓝牙设备状态更新代理
- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    switch (central.state) {
        case CBCentralManagerStatePoweredOff:
            NSLog(@"尚未打开蓝牙，请在设置中打开……");
            _loaclState = ELBleLocalStatePowerOff;
            break;
        case CBCentralManagerStatePoweredOn: {
            NSLog(@"蓝牙已经成功开启，稍后……");
            _loaclState = ELBleLocalStatePowerOn;
            break;
        }
        default:
            _loaclState = ELBleLocalStateUnsupported;
            break;
    }
    
    if([self.managerDelegate respondsToSelector:@selector(ble:didLocalState:)]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.managerDelegate ble:self didLocalState:self.loaclState];
        });
    }
}

/**
 *  开始扫描
 *
 *  @param isPowerSaving      是否为省电模式；true为省电模式即不会更新重复的设备，false为非省电模式
 *  @param serviceUUIDs       仅扫描有该服务的设备
 *
 *  @return 成功true，否则false
 *
 */
- (BOOL)startScan:(BOOL)isPowerSaving services:(NSArray <NSString *> *)serviceUUIDs{
    if (_centralManager.state != CBCentralManagerStatePoweredOn) {
        return NO;
    }
    
    NSMutableArray<CBUUID *> * uuids = nil;
    if (serviceUUIDs!=nil) {
        for (NSString *str in serviceUUIDs) {
            CBUUID *temp = [CBUUID UUIDWithString:str];
            if (temp==nil) {
                return NO;
            }else{
                [uuids addObject:temp];
            }
        }
    }
    
    if (isPowerSaving) {
        [_centralManager scanForPeripheralsWithServices:uuids options:nil];
    }else{
        [_centralManager scanForPeripheralsWithServices:uuids options:@{CBCentralManagerScanOptionAllowDuplicatesKey:@YES}];
    }
    
    return YES;
}


/**
 *  停止扫描
 *
 */
- (void)stopScan{
    [_centralManager stopScan];
}


//扫描信息代理
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *,id> *)advertisementData RSSI:(NSNumber *)RSSI {
    NSLog(@"扫描连接外设：%@ %@ %@",peripheral.name,RSSI,advertisementData);
    if([peripheral.name rangeOfString:BLE_Suffix].location != NSNotFound){
        self.peripheral = peripheral;  //外界设备
        [self.centralManager connectPeripheral:_peripheral options:nil];
    }
}

//外围蓝牙设备连接代理
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    NSLog(@"连接ok...%@", peripheral);
    [_peripheral setDelegate:self];
    
    NSLog(@"扫描服务...");
    [_peripheral discoverServices:nil];
}

- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    NSLog(@"设备连接失败:%@", peripheral.name);
    [_centralManager scanForPeripheralsWithServices:nil options:@{CBCentralManagerScanOptionAllowDuplicatesKey:@YES}];
}

- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    NSLog(@"设备断开连接:%@", peripheral.name);
    [_centralManager connectPeripheral:_peripheral options:nil];  //重连
}


#pragma mark - CBPeripheral代理函数

//搜索服务
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error {
    if (!error) {
        for (CBService *service in peripheral.services) {
            [peripheral discoverCharacteristics:nil forService:service];
            NSLog(@"开始扫描外设服务的特征 %@...",peripheral.name);
        }
    }else{
        NSLog(@"发现外设服务错误信息：%@",[error localizedDescription]);
    }
}

//扫描到特征
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error {
//    if (!error) {
//        for (CBCharacteristic *characteristic in service.characteristics) {
//            [_peripheral discoverDescriptorsForCharacteristic:characteristic];
//            [_peripheral readValueForCharacteristic:characteristic];
//            [_peripheral setNotifyValue:YES forCharacteristic:characteristic]; //打开外设的通知，否则无法接受数据
//            if ([characteristic.UUID.UUIDString isEqualToString:BLE_SEVICEID]){
//                [_peripheral readValueForCharacteristic:characteristic];
//            }
//        }
//    }else{
//        NSLog(@"扫描外设的特征失败:%@",error.description);
//    }
}


///设备信息处理
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    NSString *value = [[NSString alloc] initWithData:characteristic.value encoding:NSUTF8StringEncoding];
    NSLog(@"获取蓝牙发回的数据:%@",value);
    //    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"FFE2"]]) {
    //        NSData *data =characteristic.value;
    //        NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding]);
    //    }
}

//-(void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
//    NSLog(@"改变通知状态:%@",characteristic.service);
//}

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



-(BOOL)send:(NSData *)data{
    
    //    unsigned char send[4] = {0x5d, 0x08, 0x01, 0x3b};
    //    NSData *sendData = [NSData dataWithBytes:send length:4];
    
    if (self.characteristic ==nil) {
        return NO;
    }
    
    if (data==nil) {
        return NO;
    }
    
    if (self.peripheral.state!=CBPeripheralStateConnected) {
        return NO;
    }
    
    [self.peripheral writeValue:data forCharacteristic:self.characteristic type:CBCharacteristicWriteWithoutResponse];
    
    return YES;
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

@end
