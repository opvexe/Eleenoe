//
//  ELBlueToothManager.m
//  Eleenoe
//
//  Created by FaceBook on 2019/3/15.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import "ELBlueToothManager.h"
@interface ELBlueToothManager ()<CBCentralManagerDelegate, CBPeripheralDelegate>
@property (nonatomic, strong) CBCentralManager *centralManager;
@property (nonatomic, strong) CBPeripheral *peripheral;
@property (nonatomic, strong) CBCharacteristic *characteristic;
@property (nonatomic, strong) dispatch_queue_t queue;
@property (nonatomic, copy) ELConnectPeripheralStateBlock connectStateCallback;
@property (nonatomic, copy) ELExameBluetoothStateBlock  stateBLECallback;
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

- (void)connectPeripheralWithStateCallback:(ELConnectPeripheralStateBlock)connectStateCallback
                           examBLECallback:(ELExameBluetoothStateBlock)stateCallback{
    self.connectStateCallback = connectStateCallback;
    self.stateBLECallback = stateCallback;
    [self connectPeripheral];
}

-(void)connectPeripheral{
    [self stopScan];
    self.queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    self.centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:self.queue];
}

- (void)stopScan{
    if (self.centralManager){
        [self.centralManager stopScan];
        if (self.peripheral){
            [self.centralManager cancelPeripheralConnection:self.peripheral];
        }
        self.centralManager = nil;
    }
}

- (void)reScanPeripheral{
    [self connectPeripheral];
}

- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    switch (central.state) {
        case CBCentralManagerStateUnknown:
            NSLog(@">>>CBCentralManagerStateUnknown");
            break;
        case CBCentralManagerStateResetting:
            NSLog(@">>>CBCentralManagerStateResetting");
            break;
        case CBCentralManagerStateUnsupported:
            NSLog(@">>>CBCentralManagerStateUnsupported");
            break;
        case CBCentralManagerStateUnauthorized:
            NSLog(@">>>CBCentralManagerStateUnauthorized");
            break;
        case CBCentralManagerStatePoweredOff:
            NSLog(@"尚未打开蓝牙，请在设置中打开……");
            if (self.stateBLECallback) {
                self.stateBLECallback(ELBleLocalStatePowerOff);
            }
            break;
        case CBCentralManagerStatePoweredOn: {
            NSLog(@">>>蓝牙已经成功开启，稍后……");
            [self.centralManager scanForPeripheralsWithServices:nil options:nil];
            break;
        }
        default:
            if (self.stateBLECallback) {self.stateBLECallback(ELBleLocalStateUnsupported);}
            break;
    }
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *,id> *)advertisementData RSSI:(NSNumber *)RSSI {
    BOOL hasSevice = [self hasServiceWithAdvertisementData:advertisementData];
    if (hasSevice/*&& [peripheral.name hasPrefix:BLE_Suffix]*/) {
        NSLog(@">>>当扫描到设备:%@", peripheral);
        if (self.connectStateCallback) {
            self.connectStateCallback(ELResultTypeLoading);
        }
        if (peripheral.state == CBPeripheralStateDisconnected){
            self.peripheral = peripheral;
            [self.centralManager connectPeripheral:self.peripheral options:nil];
        }
    }
}

- (BOOL)hasServiceWithAdvertisementData:(NSDictionary *)advertisementData{
    NSArray *serviceUUIDs = [advertisementData valueForKey:@"kCBAdvDataServiceUUIDs"];
    if (serviceUUIDs && [serviceUUIDs isKindOfClass:[NSArray class]]){
        CBUUID *uuid = [CBUUID UUIDWithString:BLE_SEVICEID_UUID];
        if ([serviceUUIDs containsObject:uuid]){
            return YES;
        }
    }
    return NO;
}

- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    NSLog(@">>>连接ok...%@", peripheral);
    [self.peripheral setDelegate:self];
    
    NSLog(@">>>扫描服务...");
    [self.peripheral discoverServices:nil];
    
    if (self.connectStateCallback) {
        self.connectStateCallback(ELResultTypeSuccess);
    }
}

- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    NSLog(@">>>连接设备（%@）失败,原因:%@",[peripheral name],[error localizedDescription]);
    if (self.connectStateCallback) {
        self.connectStateCallback(ELResultTypeFailed);
    }
}

- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    NSLog(@">>>外设断开连接 %@: %@\n", [peripheral name], [error localizedDescription]);
    if (self.connectStateCallback) {
        self.connectStateCallback(ELResultTypeFailed);
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error {
    for (CBService *service in peripheral.services) {
        NSLog(@">>>所有的服务: %@", service);
        [peripheral discoverCharacteristics:nil forService:service];
    }
    
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error {
    
    for (CBCharacteristic *characteristic in service.characteristics){
        NSLog(@">>>所有特征：%@", characteristic);
        // 读取特征数据
        [peripheral readValueForCharacteristic:self.characteristic];
        // 订阅通知
        [peripheral setNotifyValue:YES forCharacteristic:self.characteristic];
        
        if ([characteristic.UUID.UUIDString isEqualToString:BLE_WRITE]&&CBCharacteristicPropertyWrite){
            
            self.characteristic = characteristic;
        }
    }
}


-(void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    if (characteristic.isNotifying) {
        NSLog(@">>>订阅成功");
    } else {
        NSLog(@">>>取消订阅");
    }
}


- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    
    NSLog(@">>>外设发送过来的数据: %@ %@",characteristic.UUID.UUIDString,characteristic.value);
}

-(void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    if (error) {
        NSLog(@">>>发送数据失败:%@",error.description);
    }else{
        NSLog(@">>>发送数据成功回调:%@",characteristic);
    }
}

- (void)send:(NSData *)data{
    Byte b[] = {0XF0,0X03,0X01,0X00,0X00,0X00,0X00,0X00,0X04,0XF1};
    NSData *datas = [NSData dataWithBytes:&b length:sizeof(b)];
    [self.peripheral writeValue:datas forCharacteristic:self.characteristic type:CBCharacteristicWriteWithoutResponse];
    
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
