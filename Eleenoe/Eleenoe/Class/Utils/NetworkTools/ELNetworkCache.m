//
//  ELNetworkCache.m
//  Eleenoe
//
//  Created by FaceBook on 2019/3/13.
//  Copyright © 2019 FaceBook. All rights reserved.
//

#import "ELNetworkCache.h"
#import "YYCache.h"
static NSString *const ELNetworkResponseCache = @"ELNetworkResponseCache";
static YYCache *_dataCache;

@implementation ELNetworkCache

+(void)initialize{
    
    _dataCache = [YYCache cacheWithName:ELNetworkResponseCache];
}

+(void)saveHttpCache:(id)httpCache forKey:(NSString *)key{
    
    [_dataCache setObject:httpCache forKey:key withBlock:nil];
}

+(id)getHttpCacheForKey:(NSString *)key{
    
    return  [_dataCache objectForKey:key];
}

+(NSInteger)getAllHttpCacheSize{
    
    return  [_dataCache.diskCache totalCost];
}

+(void)removeAllHttpCache{
    
    [_dataCache.diskCache removeAllObjects];
}

@end
