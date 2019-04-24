//
//  ELTools+EzlString.m
//  Eleenoe
//
//  Created by FaceBook on 2019/4/24.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import "ELTools+EzlString.h"

@implementation ELTools (EzlString)

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


-(NSData *)hex2data:(NSString *)hex
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


@end
