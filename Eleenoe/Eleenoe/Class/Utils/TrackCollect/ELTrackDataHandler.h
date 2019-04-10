//
//  ELTrackDataHandler.h
//  Eleenoe
//
//  Created by FaceBook on 2019/4/10.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ELTrackDataHandler : NSObject

@property (nonatomic, strong) NSDictionary *dataDict;

+ (instancetype)shareInstance;

@end

NS_ASSUME_NONNULL_END
