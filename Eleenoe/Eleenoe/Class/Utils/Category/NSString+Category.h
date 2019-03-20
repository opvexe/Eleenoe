//
//  NSString+Category.h
//  AcneTreatment
//
//  Created by Facebook on 2018/7/31.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Category)
/**
 * 判断对象是否为空

 @param object 输入判断对象
 @return 返回对象是否为空
 */
BOOL is_null(id object);
/**
 * 将对象转换成字符

 @param object 输入判断对象
 @return 返回字符
 */
NSString *convertToString(id object);
/**
 * 判断字符是否为空

 @param string 输入字符
 @return 返回字符是否为空
 */
+(BOOL)is_nullString:(NSString *)string;
/**
 * 字符转JSON

 @param aString 输入字符
 @return 返回字符jason
 */
NSString *JSONString(NSString *aString);
/**
 * MD5加密

 @param input 输入加密的字符
 @return 返回MD5加密的字符
 */
NSString* md5(NSString* input);
/**
 * MD5 32位小写加密

 @param input 输入加密字符
 @return 返回MD5 32位小写加密
 */
NSString* MD5_32Bit_Lower(NSString* input);
/**
 * MD5 32位大写加密

 @param input 输入加密字符
 @return 返回MD5 32位大写加密
 */
NSString* MD5_32Bit_Upper(NSString* input);
/**
 *  Base64加密
 */
NSString *base64Encoding(NSString *string);
/**
 *  Base64解密
 */
NSString *decodingBase64(NSString *sourceString);
/**
 *  URL编码

 @param url 输入编码的URL
 @return 返回编码后的URL
 */
NSString *urlEncodedString(NSString *url);
/**
 * URL编码

 @param encodedString 输入解码URL
 @return 返回编码后的URL
 */
NSString *URLDecodeString(NSString*encodedString);
/**
 * HTTP_URL编码

 @param url 输入编码的URL
 @return 返回HTTP编码
 */
NSString *http_URLEncode(NSString *url);
/**
 * 去掉尾部空格

 @param input 输入字符
 @return 返回去除尾部空格字符
 */
NSString* trimString (NSString* input);
/**
 * BASE 64加密

 @param content 输入加密字符
 @return 返回BASE 64加密字符
 */
NSString *base64EncodeWith(NSString * content);
/**
 * BASE 64解密

 @param content 输入解密字符
 @return 返回BASE 64解密字符
 */
NSString *base64DecodeWith(NSString * content);
/**
 * 是否为表情字符

 @return 返回YES 为表情字符，反之则NO
 */
- (BOOL)isEmoji;
/**
 * 将十六进制的编码转为emoji字符

 @param intCode 16进制编码
 @return 返回16进制编码转为emoji字符
 */
+ (NSString *)emojiWithIntCode:(int)intCode;
/**
 *  将十六进制的编码转为emoji字符

 @param stringCode 将十六进制的编码转为emoji字符
 @return 将十六进制的编码转为emoji字符
 */
+ (NSString *)emojiWithStringCode:(NSString *)stringCode;
/**
 *  校验6位验证码

 @param code 输入验证码
 @return YES,反之则NO
 */
BOOL validateEcode(NSString* code);
/**
 *  密码规则

 @param password 输入密码
 @return 返回校验密码规则是否正确
 */
BOOL validatePassword(NSString *password);
/**
 *  身份证正则校验

 @param value 输入身份证号码
 @return 返回校验身份证
 */
+ (BOOL)accurateVerifyIDCardNumber:(NSString *)value;
/**
 *  手机号码正则校验

 @param phone 输入手机号码
 @return 返回校验的手机号码
 */
+(BOOL)phoneNumberValidity:(NSString *)phone;
/**
 * 手机号码显示 136*****8676

 @param phone 输入手机号码
 @return 返回手机号码格式：136*****8676
 */
+(NSString *)ChangedHandsImmediately:(NSString *)phone;
/**
 * 计算文件大小

 @param contentLength 输入文件长度
 @return 返回计算文件大小
 */
NSString *calculateFileSizeInUnit(unsigned long long contentLength);
/**
 *  字符串显示两种颜色

 @param string 输入字符串
 @param myColor 例如金额颜色【红色】
 @param originalString 红色字符
 @return 返回富文本字符
 */
+(NSMutableAttributedString *)getOtherColorString:(NSString *)string Color:(UIColor *)myColor withString:(NSString *)originalString;
/**
 *  字符串显示两种颜色

 @param string  输入字符串
 @param font 字体大小
 @param myColor 例如金额颜色【红色】
 @param originalString 红色字符
 @return 返回富文本字符
 */
+(NSMutableAttributedString *)getOtherColorString:(NSString *)string  font:(UIFont *)font Color:(UIColor *)myColor withString:(NSString *)originalString;
/**
 * 字符串横线

 @param string 输入字符
 @param myColor 例如金额颜色【红色】
 @param font 字体大小
 @return 返回富文本字符
 */
+(NSMutableAttributedString *)lineStyleSingleString:(NSString *)string Color:(UIColor *)myColor font:(UIFont *)font;
/**
 * 字符串横线

 @param string 输入字符
 @param myColor 例如金额颜色【红色】
 @param font 字体大小
 @param originalString 显示【红色】字体
 @param newString newString description
 @return 返回富文本字符
 */
+(NSMutableAttributedString *)lineStyleSingleString:(NSString *)string Color:(UIColor *)myColor font:(UIFont *)font  withString:(NSString *)originalString newString:(NSString *)newString;
/**
 *  HTML转富文本

 @param object HTML对象
 @return 返回HTML富文本
 */
NSAttributedString *htmlConvertToString( NSString *object);
/**
 *  日期格式

 @param fromate 日期格式 yyyy-MM-dd HH:mm:ss
 @param date 格式日期
 @return 返回日期字符
 */
NSString * dateTransformString(NSString* fromate,NSDate*date);
/**
 *   longlong类型日期，转换为字符串

 @param fromate 设置时间格式
 @param longdate 时间戳
 @return 返回时间格式字符
 */
NSString * longdateTransformString(NSString* fromate,long long longdate);
/**
 *   字符转时间

 @param stringDate 时间字符串
 @return 返回时间格式
 */
NSDate * stringFormateDate(NSString * stringDate);
/**
 * 计算日期与当前时间的差

 @param theDate 时间字符串
 @return 返回 1秒前 1天前
 */
NSString *intervalSinceNow(NSString *theDate);
/**
 *  计算公里数

 @param distance 输入的字符公里数
 @return 返回公里字符 1KM 100M
 */
NSString *DistanceConversion(NSString *distance);
/**
 * 计算文件大小

 @param _totalSize 总字节
 @return 文件大小
 */
NSString *cacheSizeStr(NSInteger _totalSize);


@end
