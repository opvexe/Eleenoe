//
//  ELTrackDataHandler.m
//  Eleenoe
//
//  Created by FaceBook on 2019/4/10.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import "ELTrackDataHandler.h"

@implementation ELTrackDataHandler

+ (instancetype)shareInstance
{
    static ELTrackDataHandler *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        instance = [[ELTrackDataHandler alloc] init];
    });
    
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.dataDict = [NSString readJson2DicWithFileName:@"TrackCollect"];
        
    }
    return self;
}


@end
