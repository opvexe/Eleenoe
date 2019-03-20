//
//  ELUserDataSocure.h
//  Eleenoe
//
//  Created by FaceBook on 2019/3/13.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define  WithEleenoeVersion  @"WithEleenoeVersion"

@interface ELUserDataSocure : NSObject

+ (ELUserDataSocure *)shareInstance;

+(BOOL)isNewVersion;

@end

NS_ASSUME_NONNULL_END
