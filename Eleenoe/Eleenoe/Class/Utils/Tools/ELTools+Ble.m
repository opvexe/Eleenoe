//
//  ELTools+Ble.m
//  Eleenoe
//
//  Created by FaceBook on 2019/4/24.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import "ELTools+Ble.h"

@implementation ELTools (Ble)
+(NSData *)dataTransfromBigOrSmall:(NSData *)data
{
    NSString *tmpStr = [self dataChangeToString:data];
    NSMutableArray *tmpArra = [NSMutableArray array];
    for (int i = 0 ;i<data.length*2 ;i+=2)
    {
        NSString *str = [tmpStr substringWithRange:NSMakeRange(i, 2)];
        [tmpArra addObject:str];
    }
    NSArray *lastArray = [[tmpArra objectEnumerator] allObjects];
    NSMutableString *lastStr = [NSMutableString string];
    for (NSString *str in lastArray)
    {
        [lastStr appendString:str];
    }
    NSData *lastData = [self HexStringToData:lastStr];
    return lastData;
}


+(NSString*)dataChangeToString:(NSData*)data
{
    NSString * string = [NSString stringWithFormat:@"%@",data];
    string = [string stringByReplacingOccurrencesOfString:@"<" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@">" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    return string;
}

+(NSMutableData*)HexStringToData:(NSString*)str
{
    NSString *command = str;
    command = [command stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSMutableData *commandToSend= [[NSMutableData alloc] init];
    unsigned char whole_byte;
    char byte_chars[3] = {'\0','\0','\0'};
    int i;
    for (i=0; i < [command length]/2; i++) {
        byte_chars[0] = [command characterAtIndex:i*2];
        byte_chars[1] = [command characterAtIndex:i*2+1];
        whole_byte = strtol(byte_chars, NULL, 16);
        [commandToSend appendBytes:&whole_byte length:1];
    }
    return commandToSend;
}


+ (NSMutableData *)convertHexStrToData:(NSString *)str{
    if (!str || [str length] == 0||str.length<=2) {
        return nil;
    }
    
    NSMutableData *hexData = [[NSMutableData alloc] initWithCapacity:8];
    NSRange range;
    if ([str length] %4 == 0) {
        range = NSMakeRange(2,2);
    } else {
        range = NSMakeRange(2,1);
    }
    for (NSInteger i = range.location; i < [str length]; i += 2) {
        unsigned int anInt;
        NSString *hexCharStr = [str substringWithRange:range];
        NSScanner *scanner = [[NSScanner alloc] initWithString:hexCharStr];
        
        [scanner scanHexInt:&anInt];
        NSData *entity = [[NSData alloc] initWithBytes:&anInt length:1];
        [hexData appendData:entity];
        
        range.location += range.length;
        range.length = 2;
    }
    
    return hexData;
}


+(NSData *)hex2data:(NSString *)hex
{
    NSMutableData *data = [NSMutableData dataWithCapacity:hex.length / 2];
    unsigned char whole_byte;
    char byte_chars[3] = {'\0','\0','\0'};
    int i;
    for (i=0; i < hex.length / 2; i++) {
        byte_chars[0] = [hex characterAtIndex:i*2];
        byte_chars[1] = [hex characterAtIndex:i*2+1];
        whole_byte = strtol(byte_chars, NULL, 16);
        [data appendBytes:&whole_byte length:1];
    }
    return data;
}


+(NSString *)setStrength:(NSString *)strength{
    
    if ([strength isEqualToString:@"1"]) {
        
        return BleParamp02_01;
    }else if ([strength isEqualToString:@"2"]){
        
        return BleParamp02_02;
    }else if ([strength isEqualToString:@"3"]){
        
        return BleParamp02_03;
    }else if ([strength isEqualToString:@"4"]){
        
        return BleParamp02_04;
    }else if ([strength isEqualToString:@"5"]){
        
        return BleParamp02_05;
    }else if ([strength isEqualToString:@"6"]){
        
        return BleParamp02_06;
    }else if ([strength isEqualToString:@"7"]){
        
        return BleParamp02_07;
    }else if ([strength isEqualToString:@"8"]){
        
        return BleParamp02_08;
    }else if ([strength isEqualToString:@"9"]){
        
        return BleParamp02_09;
    }else if ([strength isEqualToString:@"10"]){
        
        return BleParamp02_10;
    }else if ([strength isEqualToString:@"11"]){
        
        return BleParamp02_11;
    }else if ([strength isEqualToString:@"12"]){
        
        return BleParamp02_12;
    }else if ([strength isEqualToString:@"13"]){
        
        return BleParamp02_13;
    }else if ([strength isEqualToString:@"14"]){
        
        return BleParamp02_14;
    }else if ([strength isEqualToString:@"15"]){
        
        return BleParamp02_15;
    }else{
        
        return BleParamp02_00;
    }
}

+(NSString *)setDuration:(NSString *)duration{
    
    if ([duration isEqualToString:@"1"]) {
        
        return BleParamp06_01;
    }else if ([duration isEqualToString:@"2"]){
        
        return BleParamp06_02;
    }else if ([duration isEqualToString:@"3"]){
        
        return BleParamp06_03;
    }else if ([duration isEqualToString:@"4"]){
        
        return BleParamp06_04;
    }else if ([duration isEqualToString:@"5"]){
        
        return BleParamp06_05;
    }else if ([duration isEqualToString:@"6"]){
        
        return BleParamp06_06;
    }else if ([duration isEqualToString:@"7"]){
        
        return BleParamp06_07;
    }else if ([duration isEqualToString:@"8"]){
        
        return BleParamp06_08;
    }else if ([duration isEqualToString:@"9"]){
        
        return BleParamp06_09;
    }else if ([duration isEqualToString:@"10"]){
        
        return BleParamp06_10;
    }else if ([duration isEqualToString:@"11"]){
        
        return BleParamp06_11;
    }else if ([duration isEqualToString:@"12"]){
        
        return BleParamp06_12;
    }else if ([duration isEqualToString:@"13"]){
        
        return BleParamp06_13;
    }else if ([duration isEqualToString:@"14"]){
        
        return BleParamp06_14;
    }else{
        
        return BleParamp06_00;
    }
}

+(NSString *)setCommunication:(NSString *)communication{
    
    if ([communication isEqualToString:@"1"]) {
        
        return  Ble_01;
    }else if ([communication isEqualToString:@"2"]){
        
        return  Ble_02;
    }else if ([communication isEqualToString:@"3"]){
        
        return  Ble_03;
    }else if ([communication isEqualToString:@"4"]){
        
        return  Ble_04;
    }else if ([communication isEqualToString:@"5"]){
        
        return  Ble_05;
    }else{
        
        return  Ble_00;
    }
}


@end
