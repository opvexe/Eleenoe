//
//  ELTools+Ble.h
//  Eleenoe
//
//  Created by FaceBook on 2019/4/24.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import "ELTools.h"

NS_ASSUME_NONNULL_BEGIN

@interface ELTools (Ble)

/**
 *  根据强度值获取强度命令
 */

+(NSString *)setStrength:(NSString *)strength;
/**
 * 根据设置时长获取时间命令
 */
+(NSString *)setDuration:(NSString *)duration;
/**
 * 根据设置模式获取模式命令
 */
+(NSString *)setCommunication:(NSString *)communication;


//大端与小端互转
+(NSData *)dataTransfromBigOrSmall:(NSData *)data;

//16进制字符转(带0x),转NSData
+ (NSMutableData *)convertHexStrToData:(NSString *)str;

/**
 @see 16进制字符串转2进制数据
 @param hex 16进制字符串
 @return 2进制数据
 */
+(NSData *)hex2data:(NSString *)hex;

@end

NS_ASSUME_NONNULL_END
