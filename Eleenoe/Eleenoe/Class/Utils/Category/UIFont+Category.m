//
//  UIFont+Category.m
//  AcneTreatment
//
//  Created by Facebook on 2018/7/31.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "UIFont+Category.h"

@implementation UIFont (Category)
+ (UIFont *)ELMediumFontOfSize:(CGFloat)fontSize{
    return [UIFont boldSystemFontOfSize:fontSize];
}

+ (UIFont *)ELFontOfSize:(CGFloat)fontSize{
    return [UIFont systemFontOfSize:fontSize];
}

+ (UIFont *)ELPingFangSCLightFontOfSize:(CGFloat)fontSize{
    return [UIFont fontWithName:@"PingFangSC-Light" size:fontSize];
}

+ (UIFont *)ELPingFangSCRegularFontOfSize:(CGFloat)fontSize{
    return [UIFont fontWithName:@"PingFangSC-Regular" size:fontSize];
}

+ (UIFont *)ELPingFangSCMediumFontOfSize:(CGFloat)fontSize{
    return [UIFont fontWithName:@"PingFangSC-Medium" size:fontSize];
}

+ (UIFont *)ELPingFangSCSemiboldFontOfSize:(CGFloat)fontSize{
    return [UIFont fontWithName:@"PingFangSC-Semibold" size:fontSize];
}

+ (UIFont *)ELHelveticaFontOfSize:(CGFloat)fontSize{
    return [UIFont fontWithName:@"Helvetica" size:fontSize];
}
@end
