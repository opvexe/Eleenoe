//
//  ELTools+Ble.m
//  Eleenoe
//
//  Created by FaceBook on 2019/4/24.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import "ELTools+Ble.h"

@implementation ELTools (Ble)

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
