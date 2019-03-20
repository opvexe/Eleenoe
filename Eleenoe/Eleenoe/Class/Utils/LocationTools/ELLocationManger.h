//
//  ELLocationManger.h
//  Eleenoe
//
//  Created by FaceBook on 2019/3/18.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ELPlacemark.h"
NS_ASSUME_NONNULL_BEGIN

typedef void(^LocationCoorBlock)(CLLocationDegrees latitude, CLLocationDegrees longitude);
typedef void(^LocationPlacemarkBlock)(ELPlacemark *placemark);
typedef void(^LocationFailBlock)(NSError *error);

@interface ELLocationManger : NSObject
/// 定位回调
+ (void)getLocation:(LocationCoorBlock)complete;
/// 停止定位
+ (void)stop;
/// 是否启用定位服务
+ (BOOL)locationServicesEnabled;
/// 反向地理编码获取地址信息
+ (void)getPlacemarkWithLatitude:(NSString *)latitude longitude:(NSString *)longitude completed:(LocationPlacemarkBlock)completed;
/// 反向地理编码获取地址信息
+ (void)getPlacemarkWithCoordinate2D:(CLLocationCoordinate2D)coor complete:(LocationPlacemarkBlock)completed;
/// 地理编码获取经纬度
+ (void)getLocationWithAddress:(NSString *)address complete:(LocationCoorBlock)completed;
/// 获取定位失败
+ (void)getLocationFailComplete:(LocationFailBlock)FailComplete;
/// 获取定位信息
+(void)getLocationComplete:(LocationPlacemarkBlock)completed;

@end

NS_ASSUME_NONNULL_END
