//
//  ELUserDataSocure.m
//  Eleenoe
//
//  Created by FaceBook on 2019/3/13.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import "ELUserDataSocure.h"

@implementation ELUserDataSocure

+ (ELUserDataSocure *)shareInstance {
    static ELUserDataSocure *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[[self class] alloc] init];
        
    });
    return instance;
}

- (instancetype)init{
    
    self = [super init];
    if (self) {
        
        
    }
    return self;
}


+(NSString  *)getEleenoeVersion{
    return  [ELUserDefaults valueForKey:WithEleenoeVersion];
}

+(BOOL)isNewVersion{
    if ([convertToString([self getEleenoeVersion]) isEqualToString:AppVersion]) {
        return NO;
    }else{
        [ELUserDefaults setValue:AppVersion forKey:WithEleenoeVersion];
        [ELUserDefaults synchronize];
        return YES;
    }
}

@end
