//
//  ELBlueToothManager.m
//  Eleenoe
//
//  Created by FaceBook on 2019/3/15.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import "ELBlueToothManager.h"
#import "ELTools+EzlString.h"
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

- (instancetype)init{
    self = [super init];
    if (self) {
        _operations = [NSMutableArray arrayWithCapacity:10]; //初始化
        [_operations addObjectsFromArray:@[Ble_F0,
                                           Ble_03,
                                           BleParamp01_00,
                                           BleParamp02_00,
                                           BleParamp03_00,
                                           BleParamp045_00,
                                           BleParamp06_00,
                                           BleParamp078_00,
                                           @"0x03",
                                           Ble_F1]];
    }
    return self;
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
    NSDictionary *dic  = @{CBCentralManagerOptionShowPowerAlertKey:[NSNumber numberWithBool:false]};
    self.centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:self.queue options:dic];
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
            if (self.connectStateCallback) {
                self.connectStateCallback(ELResultTypeFailed);
            }
            break;
        case CBCentralManagerStateResetting:
            NSLog(@">>>CBCentralManagerStateResetting");
            if (self.connectStateCallback) {
                self.connectStateCallback(ELResultTypeFailed);
            }
            break;
        case CBCentralManagerStateUnsupported:
            NSLog(@">>>CBCentralManagerStateUnsupported");
            if (self.connectStateCallback) {
                self.connectStateCallback(ELResultTypeFailed);
            }
            break;
        case CBCentralManagerStateUnauthorized:
            NSLog(@">>>CBCentralManagerStateUnauthorized");
            if (self.connectStateCallback) {
                self.connectStateCallback(ELResultTypeFailed);
            }
            break;
        case CBCentralManagerStatePoweredOff:
            NSLog(@"尚未打开蓝牙，请在设置中打开……");
            if (self.stateBLECallback) {
                self.stateBLECallback(ELBleLocalStatePowerOff);
            }
            if (self.connectStateCallback) {
                self.connectStateCallback(ELResultTypeFailed);
            }
            break;
        case CBCentralManagerStatePoweredOn: {
            NSLog(@">>>蓝牙已经成功开启，稍后……");
            [self.centralManager scanForPeripheralsWithServices:nil options:nil];
            if (self.connectStateCallback) {
                self.connectStateCallback(ELResultTypeLoading);
            }
            break;
        }
        default:
            if (self.stateBLECallback) {self.stateBLECallback(ELBleLocalStateUnsupported);}
            if (self.connectStateCallback) {self.connectStateCallback(ELResultTypeFailed);}
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
        CBUUID *uuid = [CBUUID UUIDWithString:BLE_ADDATESEVICE_UUID];
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
        [peripheral discoverDescriptorsForCharacteristic:characteristic];
        
        if ([characteristic.UUID.UUIDString isEqualToString:BLE_NOTICE]) {
            // 订阅通知
            [peripheral setNotifyValue:YES forCharacteristic:characteristic];
        }else if ([characteristic.UUID.UUIDString isEqualToString:BLE_WRITE]){
            
            self.characteristic = characteristic;
        }else if ([characteristic.UUID.UUIDString isEqualToString:BLE_READ]){
            // 读取特征数据
            [peripheral readValueForCharacteristic:characteristic];
        }else{
            // 读取特征数据
            [peripheral readValueForCharacteristic:characteristic];
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
    
    if ([characteristic.UUID.UUIDString isEqualToString:BLE_NOTICE]) {
        NSString *result = [[NSString alloc] initWithData:[ELTools dataTransfromBigOrSmall:characteristic.value]  encoding:NSUTF8StringEncoding];
        if (result.length) {
            NSMutableDictionary *message = [NSMutableDictionary dictionary];
            [message setValue:result forKey:BlueToothMessageKey];
            [ELNotificationCenter postNotificationName:BlueToothMessageNotificationCenter object:nil userInfo:message];
        }
        NSLog(@">>>外设发送过来的数据: %@ %@",characteristic.UUID.UUIDString,characteristic.value);
    }
}

-(void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    if (error) {
        NSLog(@">>>发送数据失败:%@",error.description);
    }else{
        NSLog(@">>>发送数据成功回调:%@",characteristic);
    }
}

- (void)sendCommand{
    if (self.characteristic==nil) {
        return ;
    }
    if (self.centralManager==nil) {
        return ;
    }
    if (!self.operations.count||self.operations.count!=10) {
        return ;
    }
    
    NSMutableData *datas= [[NSMutableData alloc] init];
    for (int i = 0; i<self.operations.count; i++) {
        [datas appendData:[ELTools convertHexStrToData:self.operations[i]]];
    }
    
    switch (self.characteristic.properties & 0x04) {
        case CBCharacteristicPropertyWriteWithoutResponse:{
            [self.peripheral writeValue:datas forCharacteristic:self.characteristic type:CBCharacteristicWriteWithoutResponse];
            break;
        }
        default:{
            [self.peripheral writeValue:datas forCharacteristic:self.characteristic type:CBCharacteristicWriteWithResponse];
            break;
        }
    }
}


-(void)exclusive{
    if (!self.operations.count||self.operations.count!=10) {
        return ;
    }
    NSInteger sum =  0 ;
    for (int i = 1; i<self.operations.count-2; i++) {
        NSInteger count = [[NSString sixteenChangeTenString:self.operations[i]] integerValue];
        sum +=count;
    }
    NSString *pin = [NSString pinxCreator:[NSString hexStringFromString:sum] withPinv:@"7F"];
    _operations[8] =  [NSString stringWithFormat:@"0x%@",pin];
}

@end
