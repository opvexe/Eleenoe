//
//  NSString+Category.m
//  AcneTreatment
//
//  Created by Facebook on 2018/7/31.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "NSString+Category.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#define EmojiCodeToSymbol(c) ((((0x808080F0 | (c & 0x3F000) >> 4) | (c & 0xFC0) << 10) | (c & 0x1C0000) << 18) | (c & 0x3F) << 24)
#define CURRENT_CALENDAR [NSCalendar currentCalendar]
#define DATE_COMPONENTS (NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekCalendarUnit |  NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSWeekdayCalendarUnit | NSWeekdayOrdinalCalendarUnit)
@implementation NSString (Category)


+ (ELTitleInfo)ELgetInfoWithText:(NSString *)text maxLength:(NSInteger)maxLength{
    
    ELTitleInfo title;
    
    int length = 0;
    int singleNum = 0;
    int totalNum = 0;
    char  *p = (char *)[text cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i = 0; i < [text lengthOfBytesUsingEncoding:NSUnicodeStringEncoding]; i++) {
        if (*p) {
            length++;
            if (length <= maxLength) {
                totalNum++;
            }
        }
        else {
            if (length <= maxLength) {
                singleNum++;
            }
        }
        p++;
    }
    
    title.length = length;
    
    title.number = (totalNum - singleNum) / 2 + singleNum;
    
    return title;
}
BOOL is_null(id object) {
    return (nil == object || [@"" isEqual:object] || [object isKindOfClass:[NSNull class]]);
}

NSString *convertToString(id object){
    if ([object isKindOfClass:[NSNull class]]) {
        return @"";
    }else if(!object){
        return @"";
    }else if([object isKindOfClass:[NSNumber class]]) {
        return [object stringValue];
    }else{
        return [NSString stringWithFormat:@"%@",object];
    }
}

+ (BOOL)is_nullString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

NSString* md5(NSString* input){
    if(isEmpty(input)){
        return @"";
    }
    const char *cStr = [input UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), digest );
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    return  output;
}

BOOL isEmpty(NSString* str) {
    if (is_null(str)) {
        return YES;
    }
    if([str isKindOfClass:[NSString class]]){
        return [trimString(str) length] <= 0;
    }
    return NO;
}

NSString* MD5_32Bit_Lower(NSString* input){
    const char *cStr = [input UTF8String];
    unsigned char result[16];
    NSNumber *num = [NSNumber numberWithUnsignedLong:strlen(cStr)];
    CC_MD5( cStr,[num intValue], result );
    return [[NSString stringWithFormat:
             @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}

NSString* MD5_32Bit_Upper(NSString* input){
    const char *cStr = [input UTF8String];
    unsigned char result[16];
    NSNumber *num = [NSNumber numberWithUnsignedLong:strlen(cStr)];
    CC_MD5( cStr,[num intValue], result );
    return [[NSString stringWithFormat:
             @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] uppercaseString];
}

NSString *base64Encoding(NSString *string){
    if (!string) {
        return nil;
    }
    NSData *sourceData = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSString *resultString = [sourceData base64EncodedStringWithOptions:
                              NSDataBase64Encoding64CharacterLineLength];
    return resultString;
}

NSString *decodingBase64(NSString *sourceString){
    if (!sourceString) {
        return nil;
    }
    NSData *resultData = [[NSData alloc]initWithBase64EncodedString:sourceString options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return [[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
}

NSString *urlEncodedString(NSString *url){
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)url,
                                                              (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",
                                                              NULL,
                                                              kCFStringEncodingUTF8));
    return encodedString;
}

NSString *URLDecodeString(NSString*encodedString){
    NSString *decodedString  = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
                                                                                                                     (__bridge CFStringRef)encodedString,
                                                                                                                     CFSTR(""),
                                                                                                                     CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    return decodedString;
}

NSString *http_URLEncode(NSString *url){
    NSString *newString = CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,(CFStringRef)url,NULL,CFSTR(":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"),CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding)));
    if (newString) {
        return newString;
    }
    return url;
}

NSString* trimString (NSString* input){
    NSMutableString *mStr = [input mutableCopy];
    CFStringTrimWhitespace((CFMutableStringRef)mStr);
    NSString *result = [mStr copy];
    return result;
}

NSString *base64EncodeWith(NSString * content){
    NSData *dataTake2 = [content dataUsingEncoding:NSUTF8StringEncoding];
    NSData *base64Data = [dataTake2 base64EncodedDataWithOptions:0];
    return [[NSString alloc] initWithData:base64Data encoding:NSUTF8StringEncoding];
}

NSString *base64DecodeWith(NSString * content){
    NSData* decodeData = [[NSData alloc] initWithBase64EncodedString:content options:0];
    NSString* decodeStr = [[NSString alloc] initWithData:decodeData encoding:NSUTF8StringEncoding];
    return decodeStr;
}

- (NSString *)emoji{
    return [NSString emojiWithStringCode:self];
}

- (BOOL)isEmoji{
    BOOL returnValue = NO;
    const unichar hs = [self characterAtIndex:0];
    if (0xd800 <= hs && hs <= 0xdbff) {
        if (self.length > 1) {
            const unichar ls = [self characterAtIndex:1];
            const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
            if (0x1d000 <= uc && uc <= 0x1f77f) {
                returnValue = YES;
            }
        }
    } else if (self.length > 1) {
        const unichar ls = [self characterAtIndex:1];
        if (ls == 0x20e3) {
            returnValue = YES;
        }
    } else {
        if (0x2100 <= hs && hs <= 0x27ff) {
            returnValue = YES;
        } else if (0x2B05 <= hs && hs <= 0x2b07) {
            returnValue = YES;
        } else if (0x2934 <= hs && hs <= 0x2935) {
            returnValue = YES;
        } else if (0x3297 <= hs && hs <= 0x3299) {
            returnValue = YES;
        } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
            returnValue = YES;
        }
    }
    return returnValue;
}

+ (NSString *)emojiWithIntCode:(int)intCode{
    int symbol = EmojiCodeToSymbol(intCode);
    NSString *string = [[NSString alloc] initWithBytes:&symbol length:sizeof(symbol) encoding:NSUTF8StringEncoding];
    if (string == nil) { // 新版Emoji
        string = [NSString stringWithFormat:@"%C", (unichar)intCode];
    }
    return string;
}

+ (NSString *)emojiWithStringCode:(NSString *)stringCode{
    char *charCode = (char *)stringCode.UTF8String;
    int intCode = strtol(charCode, NULL, 16);
    return [self emojiWithIntCode:intCode];
}

BOOL validateEcode(NSString* code){
    NSString *phoneRegex = @"^\\d{6}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:code];
}

BOOL validatePassword(NSString *password){
    NSString *regex =@"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,20}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:password];
}

+ (BOOL)accurateVerifyIDCardNumber:(NSString *)value {
    value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    int length =0;
    if (!value) {
        return NO;
    }else {
        length = (int)value.length;
        if (length !=15 && length !=18) {
            return NO;
        }
    }
    NSArray *areasArray =@[@"11",@"12", @"13",@"14", @"15",@"21", @"22",@"23", @"31",@"32", @"33",@"34", @"35",@"36", @"37",@"41", @"42",@"43", @"44",@"45", @"46",@"50", @"51",@"52", @"53",@"54", @"61",@"62", @"63",@"64", @"65",@"71", @"81",@"82", @"91"];
    NSString *valueStart2 = [value substringToIndex:2];
    BOOL areaFlag =NO;
    for (NSString *areaCode in areasArray) {
        if ([areaCode isEqualToString:valueStart2]) {
            areaFlag =YES;
            break;
        }
    }
    if (!areaFlag) {
        return false;
    }
    NSRegularExpression *regularExpression;
    NSUInteger numberofMatch;
    int year =0;
    switch (length) {
        case 15:
            year = [value substringWithRange:NSMakeRange(6,2)].intValue +1900;
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$"
                                                                         options:NSRegularExpressionCaseInsensitive
                                                                           error:nil];//测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];//测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, value.length)];
            if(numberofMatch >0) {
                return YES;
            }else {
                return NO;
            }
        case 18:
            year = [value substringWithRange:NSMakeRange(6,4)].intValue;
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$"
                                                                         options:NSRegularExpressionCaseInsensitive
                                                                           error:nil];//测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$"
                                                                         options:NSRegularExpressionCaseInsensitive
                                                                           error:nil];//测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, value.length)];
            if(numberofMatch >0) {
                int S = ([value substringWithRange:NSMakeRange(0,1)].intValue + [value substringWithRange:NSMakeRange(10,1)].intValue) *7 + ([value substringWithRange:NSMakeRange(1,1)].intValue + [value substringWithRange:NSMakeRange(11,1)].intValue) *9 + ([value substringWithRange:NSMakeRange(2,1)].intValue + [value substringWithRange:NSMakeRange(12,1)].intValue) *10 + ([value substringWithRange:NSMakeRange(3,1)].intValue + [value substringWithRange:NSMakeRange(13,1)].intValue) *5 + ([value substringWithRange:NSMakeRange(4,1)].intValue + [value substringWithRange:NSMakeRange(14,1)].intValue) *8 + ([value substringWithRange:NSMakeRange(5,1)].intValue + [value substringWithRange:NSMakeRange(15,1)].intValue) *4 + ([value substringWithRange:NSMakeRange(6,1)].intValue + [value substringWithRange:NSMakeRange(16,1)].intValue) *2 + [value substringWithRange:NSMakeRange(7,1)].intValue *1 + [value substringWithRange:NSMakeRange(8,1)].intValue *6 + [value substringWithRange:NSMakeRange(9,1)].intValue *3;
                int Y = S %11;
                NSString *M =@"F";
                NSString *JYM =@"10X98765432";
                M = [JYM substringWithRange:NSMakeRange(Y,1)];// 判断校验位
                if ([M isEqualToString:[value substringWithRange:NSMakeRange(17,1)]]) {
                    return YES;// 检测ID的校验位
                }else {
                    return NO;
                }
            }else {
                return NO;
            }
        default:
            return NO;
    }
}

+(BOOL)phoneNumberValidity:(NSString *)phone{
    NSString *regex =@"^((13[0-9])|(15[^4,\\D])|(18[0-9])|(14[0-9])|(17[0-9]))\\d{8}$";
    NSPredicate *mobileTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [mobileTest evaluateWithObject:phone];
}

+(NSString *)ChangedHandsImmediately:(NSString *)phone{
    if (![self phoneNumberValidity:phone]) {
        return  phone;
    }
    return  [phone stringByReplacingCharactersInRange:NSMakeRange(3, 4)  withString:@"****"];
}

NSString * calculateFileSizeInUnit(unsigned long long contentLength){
    if(contentLength >= pow(1024, 3))
        return [NSString stringWithFormat:@"%2.fGB",(float) (contentLength / (float)pow(1024, 3))];
    else if(contentLength >= pow(1024, 2))
        return [NSString stringWithFormat:@"%2.f MB",(float) (contentLength / (float)pow(1024, 2))];
    else if(contentLength >= 1024)
        return [NSString stringWithFormat:@"%2.f KB",(float) (contentLength / (float)1024)];
    else
        return [NSString stringWithFormat:@"%2.f Bytes",(float) (contentLength)];
}

+(NSMutableAttributedString *)getOtherColorString:(NSString *)string Color:(UIColor *)myColor withString:(NSString *)originalString{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:originalString];
    if (string.length) {
        NSRange range = [originalString rangeOfString:string];
        [str addAttribute:NSForegroundColorAttributeName value:myColor range:range];
        return str;
    }
    return str;
}

+(NSMutableAttributedString *)getOtherColorString:(NSString *)string  font:(UIFont *)font Color:(UIColor *)myColor withString:(NSString *)originalString{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:originalString];
    if (string.length) {
        NSRange range = [originalString rangeOfString:string];
        [str addAttribute:NSForegroundColorAttributeName value:myColor range:range];
        [str addAttribute:NSFontAttributeName value:font range:range];
        return str;
    }
    return str;
}

+(NSMutableAttributedString *)lineStyleSingleString:(NSString *)string Color:(UIColor *)myColor font:(UIFont *)font{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:string];
    if (string.length) {
        NSRange range =NSMakeRange(0, string.length);
        [str addAttribute:NSForegroundColorAttributeName value:myColor range:range];
        [str addAttribute:NSFontAttributeName value:font range:range];
        [str addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:range];
        return str;
    }
    return str;
}

+(NSMutableAttributedString *)lineStyleSingleString:(NSString *)string Color:(UIColor *)myColor font:(UIFont *)font  withString:(NSString *)originalString newString:(NSString *)newString{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:originalString];
    if (string.length) {
        NSRange range = [originalString rangeOfString:string];
        if ([string isEqualToString:newString]) {
            range = NSMakeRange(originalString.length-string.length, string.length);
        }
        [str addAttribute:NSForegroundColorAttributeName value:myColor range:range];
        [str addAttribute:NSFontAttributeName value:font range:range];
        [str addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:range];
        return str;
    }
    return str;
}

NSAttributedString *htmlConvertToString( NSString *object){
    if (object.length &&object) {
        return  [[NSAttributedString alloc] initWithData:[object dataUsingEncoding:NSUTF8StringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute:[NSNumber numberWithInt:NSUTF8StringEncoding]} documentAttributes:nil error:nil];
    }
    return nil;
}

NSString *JSONString(NSString *aString){
    if (!aString.length) {
        return  aString;
    }
    NSMutableString *s = [NSMutableString stringWithString:aString];
    [s replaceOccurrencesOfString:@"\n" withString:@"\"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    return [NSString stringWithString:s] ;
}

NSString * dateTransformString(NSString* fromate,NSDate*date){
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:fromate];
    NSString * dateString = [dateFormatter stringForObjectValue:date];
    return dateString;
}

NSString * longdateTransformString(NSString* fromate,long long longdate){
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:longdate/1000];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:fromate];
    NSString * dateString = [dateFormatter stringForObjectValue:date];
    return dateString;
}

NSDate * stringFormateDate(NSString * stringDate){
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss +0000"];
    NSDate *dateFromString = [[NSDate alloc] init];
    dateFromString = [dateFormatter dateFromString:stringDate];
    return dateFromString;
}

NSString *intervalSinceNow(NSString *theDate){
    NSArray *timeArray=[theDate componentsSeparatedByString:@"."];
    theDate=[timeArray objectAtIndex:0];
    NSDateFormatter *date=[[NSDateFormatter alloc] init];
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *d=[date dateFromString:theDate];
    NSTimeInterval late=[d timeIntervalSince1970]*1;
    NSDate* dat = [NSDate date];
    NSTimeInterval now=[dat timeIntervalSince1970]*1;
    NSString *timeString=@"";
    NSTimeInterval cha=now-late;
    if (cha/3600<1) {
        timeString = [NSString stringWithFormat:@"%f", cha/60];
        timeString = [timeString substringToIndex:timeString.length-7];
        if([timeString isEqualToString:@"0"]){
            timeString=[NSString stringWithFormat:@"刚刚"];
        }else{
            timeString=[NSString stringWithFormat:@"%@%@", timeString,@"分钟前"];
        }
    }else if (cha/3600>1&&cha/86400<1) {
        timeString = [NSString stringWithFormat:@"%f", cha/3600];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@%@", timeString,@"小时前"];
    }else if (cha/86400>1 && cha/86400<=7)
    {
        timeString = [NSString stringWithFormat:@"%f", cha/86400];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@%@", timeString,@"天前"];
    }else if(getDataYear(dat)- getDataYear(d)==0){
        timeString=dateTransformString(@"MM-dd HH:mm",d);
    }else{
        timeString=dateTransformString(@"yyyy-MM-dd",d);//[NSString stringWithFormat:@"%@",theDate];
    }
    return timeString;
}

NSInteger getDataYear(NSDate *date){
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:date];
    return components.year;
}

NSInteger getDataDay(NSDate *date){
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:date];
    return components.day;
}

NSString *DistanceConversion(NSString *distance){
    if (distance.length==0) {
        return  nil;
    }
    CGFloat cha =[distance floatValue];
    NSString *distanceString =@"";
    if(cha /1000>1){
        distanceString = [NSString stringWithFormat:@"%.2f", cha/1000.0];
        distanceString=[NSString stringWithFormat:@"%@%@", distanceString,@"公里"];
    }else{
        distanceString=[NSString stringWithFormat:@"%.3f%@", cha,@"米"];
    }
    return distanceString;
}

NSString *cacheSizeStr(NSInteger _totalSize){
    NSInteger totalSize = _totalSize;
    NSString *sizeStr = @"当前缓存大小为：";
    if (totalSize > 1000 * 1000) {
        CGFloat sizeF = totalSize / 1000.0 / 1000.0;
        sizeStr = [NSString stringWithFormat:@"%@(%.1fMB)", sizeStr, sizeF];
    } else if (totalSize > 1000) {
        CGFloat sizeF = totalSize / 1000.0;
        sizeStr = [NSString stringWithFormat:@"%@(%.1fKB)", sizeStr, sizeF];
    } else if (totalSize > 0) {
        sizeStr = [NSString stringWithFormat:@"%@(%.lfdB)", sizeStr, totalSize];
    }
    return sizeStr;
}

+(NSDictionary *)readJson2DicWithFileName:(NSString *)fileName {
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"json"];
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    return dic;
}

- (NSString *)pinxCreator:(NSString *)pan withPinv:(NSString *)pinv
{
    if (pan.length != pinv.length)
    {
        return nil;
    }
    const char *panchar = [pan UTF8String];
    const char *pinvchar = [pinv UTF8String];
    NSString *temp = [[NSString alloc] init];
    for (int i = 0; i < pan.length; i++)
    {
        int panValue = [self charToint:panchar[i]];
        int pinvValue = [self charToint:pinvchar[i]];
        
        temp = [temp stringByAppendingString:[NSString stringWithFormat:@"%X",panValue&pinvValue]];
    }
    return temp;
}
- (int)charToint:(char)tempChar
{
    if (tempChar >= '0' && tempChar <='9') {
        return tempChar - '0';
    } else if (tempChar >= 'A' && tempChar <= 'F') {
        return tempChar - 'A' + 10;
    }
    return 0;
}

@end
