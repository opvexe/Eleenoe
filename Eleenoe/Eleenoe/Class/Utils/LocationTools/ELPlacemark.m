//
//  ELPlacemark.m
//  Eleenoe
//
//  Created by FaceBook on 2019/3/18.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import "ELPlacemark.h"

@implementation ELPlacemark

- (NSString *)city {
    NSString *cityName = _city;
    if ([cityName hasSuffix:@"市辖区"]) {
        cityName = [cityName substringToIndex:[cityName length] - 3];
    }
    if ([cityName hasSuffix:@"市"]) {
        cityName = [cityName substringToIndex:[cityName length] - 1];
    }
    if ([cityName isEqualToString:@"香港特別行政區"] || [cityName isEqualToString:@"香港特别行政区"]) {
        cityName = @"香港";
    }
    if ([cityName isEqualToString:@"澳門特別行政區"] || [cityName isEqualToString:@"澳门特别行政区"]) {
        cityName = @"澳门";
    }
    return cityName;
}

- (NSString *)province {
    NSString *provinceName = _province;
    if ([provinceName hasSuffix:@"省"]) {
        provinceName = [provinceName substringToIndex:[provinceName length] - 1];
    } else if ([provinceName hasSuffix:@"市"]) {
        provinceName = [provinceName substringToIndex:[provinceName length] - 1];
    }
    return provinceName;
}
- (NSString *)getProvinceAndCity {
    NSString *provinceName = _province ? : @"";
    NSString *cityName = _city ? : @"";
    if ([self.city isEqualToString:self.province]) {
        provinceName = @"";
    }
    if ([cityName hasSuffix:@"市辖区"]) {
        cityName = [cityName substringToIndex:[cityName length] - 3];
    }
    if ([cityName isEqualToString:@"香港特別行政區"] || [cityName isEqualToString:@"香港特别行政区"]) {
        cityName = @"香港";
    }
    if ([cityName isEqualToString:@"澳門特別行政區"] || [cityName isEqualToString:@"澳门特别行政区"]) {
        cityName = @"澳门";
    }
    return [provinceName stringByAppendingString:cityName];
}

+ (ELPlacemark *)initWithCLPlacemark:(CLPlacemark *)placemark {
    ELPlacemark *mark = [[ELPlacemark alloc] init];
    mark.country = placemark.country ? placemark.country : @"";
    mark.province = placemark.administrativeArea ? placemark.administrativeArea : @"";
    mark.city = placemark.locality ? placemark.locality : mark.province;
    mark.county = placemark.subLocality ? placemark.subLocality : @"";
    NSString *formatAddress = [NSString stringWithFormat:@"%@%@", placemark.thoroughfare ? placemark.thoroughfare : @"",
                               placemark.subThoroughfare ? placemark.subThoroughfare:@""];
    mark.address = formatAddress;
    return mark;
}

@end
