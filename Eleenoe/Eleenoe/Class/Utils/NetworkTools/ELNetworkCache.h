//
//  ELNetworkCache.h
//  Eleenoe
//
//  Created by FaceBook on 2019/3/13.
//  Copyright © 2019 FaceBook. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ELNetworkCache : NSObject

/**
 *  缓存数据
 *
 *  @param httpCache  服务器数据
 *  @param key   缓存数据库对应Key
 */
+(void)saveHttpCache:(id)httpCache  forKey:(NSString *)key;
/**
 *  获取缓存数据
 *
 *  @param key  缓存键值
 *
 *  @return 缓存数据库对应Key
 */
+(id)getHttpCacheForKey:(NSString *)key ;
/**
 *  获取缓存大小
 *
 *  @return  获取缓存大小
 */
+(NSInteger)getAllHttpCacheSize;
/**
 *  删除所有缓存数据
 */
+(void)removeAllHttpCache;

@end

NS_ASSUME_NONNULL_END
