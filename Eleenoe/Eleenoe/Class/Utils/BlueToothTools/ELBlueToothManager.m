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
        
        self.centralManager =[[CBCentralManager alloc]initWithDelegate:self queue:nil];
        
    }
    return self;
}

//初始化
- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    switch (central.state) {
        case CBCentralManagerStateUnknown:
            NSLog(@"初始化中，请稍后……");
            break;
        case CBCentralManagerStateResetting:
            NSLog(@"设备不支持状态，过会请重试……");
            break;
        case CBCentralManagerStateUnsupported:
            NSLog(@"设备未授权状态，过会请重试……");
            break;
        case CBCentralManagerStateUnauthorized:
            NSLog(@"设备未授权状态，过会请重试……");
            break;
        case CBCentralManagerStatePoweredOff:
            NSLog(@"尚未打开蓝牙，请在设置中打开……");
            break;
        case CBCentralManagerStatePoweredOn: {
            NSLog(@"蓝牙已经成功开启，稍后……");
            [self.centralManager scanForPeripheralsWithServices:nil options:nil]; //options=nil搜索附近所有设备
        }
            break;
        default:
            break;
    }
}


#pragma mark CBCentralManagerDelegate

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *,id> *)advertisementData RSSI:(NSNumber *)RSSI {
    NSLog(@"扫描连接外设：%@ %@ %@",peripheral.name,RSSI,advertisementData);
    if([peripheral.name rangeOfString:M_BLE_Suffix].location != NSNotFound){
        [self.centralManager connectPeripheral:peripheral options:nil];
    }
}
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    NSLog(@"设备连接成功:%@", peripheral.name);
    [self.peripheral setDelegate:self];
    [self.peripheral discoverServices:nil];
    [self.centralManager stopScan];
}

- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    NSLog(@"设备连接失败:%@", peripheral.name);
    [self.centralManager scanForPeripheralsWithServices:nil options:nil];  //重新搜索
}

- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    NSLog(@"设备丢失连接:%@", peripheral.name);
    [self.centralManager scanForPeripheralsWithServices:nil options:nil];
}

#pragma mark CBPeripheralDelegate
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error {
    NSLog(@"发现外设服务:%@",peripheral.services);
    if (error) {
        NSLog(@"设备获取服务失败:%@", peripheral.name);
    }else{
        for (CBService *service in peripheral.services) {
            self.service = service;
            [peripheral discoverCharacteristics:nil forService:service];
            NSLog(@"设备的服务(%@),UUID(%@),count(%lu)",service,service.UUID,peripheral.services.count);
        }
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error {
    NSLog(@"发现外设特征:%@",service);
    if (error) {
        NSLog(@"扫描外设的特征失败:%@ %@ %@",peripheral.name,service.UUID, [error localizedDescription]);
    }else{
        for (CBCharacteristic *characteristic in service.characteristics){
            [peripheral discoverDescriptorsForCharacteristic:characteristic];
            [peripheral readValueForCharacteristic:characteristic];
            [peripheral setNotifyValue:YES forCharacteristic:characteristic]; //打开外设的通知，否则无法接受数据
            if ([characteristic.UUID.UUIDString isEqualToString:DEVICE]){
                [peripheral readValueForCharacteristic:characteristic];
            }
        }
    }
}

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

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverDescriptorsForCharacteristic:(nonnull CBCharacteristic *)characteristic error:(nullable NSError *)error
{
    NSLog(@"发现外设的特征的描述数组:%@",characteristic.descriptors);
    if (!error) {
        for (CBDescriptor *descriptor in characteristic.descriptors) {
            self.descriptor = descriptor;
            [peripheral readValueForDescriptor:descriptor];
        }
    }
}

-(void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    NSLog(@"发送数据成功回调:%@",characteristic);
    if (error) {
         NSLog(@"发送数据失败:(%@)\n error:%@",characteristic,error.userInfo);
    }else{
         [peripheral readValueForCharacteristic:characteristic];
    }
}

#pragma mark 数据发送
-(void)sendDataToBLE:(NSData *)data{
    if (self.characteristic!=nil) {
        [self.peripheral writeValue:data forCharacteristic:self.characteristic type:CBCharacteristicWriteWithoutResponse];
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

@end
