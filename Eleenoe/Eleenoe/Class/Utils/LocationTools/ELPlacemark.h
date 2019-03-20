//
//  ELPlacemark.h
//  Eleenoe
//
//  Created by FaceBook on 2019/3/18.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
NS_ASSUME_NONNULL_BEGIN

@interface ELPlacemark : NSObject
@property (nonatomic, copy) NSString *country;
@property (nonatomic, copy) NSString *province;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *county;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, assign) int placemarkId;
@property (nonatomic, copy) NSString *type;

- (NSString *)getProvinceAndCity;
+ (ELPlacemark *)initWithCLPlacemark:(CLPlacemark *)placemark;

@end

NS_ASSUME_NONNULL_END
