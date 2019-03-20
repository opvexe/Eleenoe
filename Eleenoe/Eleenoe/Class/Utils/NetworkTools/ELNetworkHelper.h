//
//  ELNetworkHelper.h
//  Eleenoe
//
//  Created by FaceBook on 2019/3/13.
//  Copyright © 2019 FaceBook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ELNetworkCache.h"
#define  HttpTimeOut  30.0f

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, CPNetworkStatus) {
    /** 未知网络*/
    CPNetworkStatusUnknown,
    /** 无网络*/
    CPNetworkStatusNotReachable,
    /** 手机网络2G*/
    CPNetworkStatusReachableVia2G,
    /** 手机网络3G*/
    CPNetworkStatusReachableVia3G,
    /** 手机网络4G*/
    CPNetworkStatusReachableVia4G,
    /** WIFI网络*/
    CPNetworkStatusReachableViaWiFi,
    
    CPNetworkStatusReachableViaReachableViaWWAN,
};

/**
 *  请求成功
 *
 */
typedef void(^CPNetworkRequestSuccess)(id responseObject);
/**
 *  请求失败
 *
 */
typedef void(^CPNetworkRequestFailed)(NSError *error);
/**
 *  缓存数据
 *
 */
typedef void(^CPNetworkRequestCache)(id responseCache);
/**
 *  进度
 *
 */
typedef void(^CPNetworkProgress)(NSProgress *progress);
/**
 *  网络状态
 *
 */
typedef void(^NetworkReachabilityStatus)(CPNetworkStatus status);

///MARK: 数据响应格式类型
typedef NS_ENUM(NSUInteger, CPNetworkResponseType) {
    CPNetworkResponseTypeJSON = 1,
    CPNetworkResponseTypeXML  = 2,
    CPNetworkResponseTypeData = 3
};

///MARK: 数据请求格式类型
typedef NS_ENUM(NSUInteger, CPNetworkRequestType) {
    CPNetworkRequestTypePlainText  = 1,
    CPNetworkRequestTypeJSON = 2
};

@interface ELNetworkHelper : NSObject

//监听网络
+ (void)startListeningNetwork;

//获取网络状态
+ (void)checkNetworkStatusWithBlock:(NetworkReachabilityStatus)status;

//当前网络状态
+(NSString *)currentNetworkTypeStatus;

//是否有网络
+ (BOOL)currentNetworkStatus;

//Debug 打印信息
+(void)enableInterfaceDebug:(BOOL)isDebug;

//设置公共参数
+(void)configPublicHttpHeaders:(NSDictionary *)httpHeaders;

//是否编码
+(void)shouldAutoEncodeUrl:(BOOL)shouldAutoEncode;

//设置请求类型
+(void)configRequestType:(CPNetworkRequestType)requestType;

//设置响应类型
+(void)configResponseType:(CPNetworkResponseType)responseType;

//取消所有请求
+(void)cancleAllRequest;

//通过URL取消当前请求
+ (void)cancelRequestWithURL:(NSString *)url;


///MARK: GET 请求
+ (NSURLSessionDataTask *)GET:(NSString *)URL
                   parameters:(NSDictionary *)parameters
                      success:(CPNetworkRequestSuccess)success
                      failure:(CPNetworkRequestFailed)failure;

+ (NSURLSessionDataTask *)GET:(NSString *)URL
                   parameters:(NSDictionary *)parameters headDic:(NSMutableDictionary *)headDic
                      success:(CPNetworkRequestSuccess)success
                      failure:(CPNetworkRequestFailed)failure;

+ (NSURLSessionDataTask *)GET:(NSString *)URL
                   parameters:(NSDictionary *)parameters
                responseCache:(CPNetworkRequestCache)responseCache
                      success:(CPNetworkRequestSuccess)success
                      failure:(CPNetworkRequestFailed)failure;

+ (NSURLSessionDataTask *)GET:(NSString *)URL
                   parameters:(NSDictionary *)parameters headDic:(NSMutableDictionary *)headDic
                responseCache:(CPNetworkRequestCache)responseCache
                      success:(CPNetworkRequestSuccess)success
                      failure:(CPNetworkRequestFailed)failure;

///MARK: POST 请求
+ (NSURLSessionDataTask *)POST:(NSString *)URL
                    parameters:(NSDictionary *)parameters
                       success:(CPNetworkRequestSuccess)success
                       failure:(CPNetworkRequestFailed)failure;

+ (NSURLSessionDataTask *)POST:(NSString *)URL
                    parameters:(NSDictionary *)parameters headDic:(NSMutableDictionary *)headDic
                       success:(CPNetworkRequestSuccess)success
                       failure:(CPNetworkRequestFailed)failure;

+ (NSURLSessionDataTask *)POST:(NSString *)URL
                    parameters:(NSDictionary *)parameters
                 responseCache:(CPNetworkRequestCache)responseCache
                       success:(CPNetworkRequestSuccess)success
                       failure:(CPNetworkRequestFailed)failure;

+ (NSURLSessionDataTask *)POST:(NSString *)URL
                    parameters:(NSDictionary *)parameters headDic:(NSMutableDictionary *)headDic
                 responseCache:(CPNetworkRequestCache)responseCache
                       success:(CPNetworkRequestSuccess)success
                       failure:(CPNetworkRequestFailed)failure;

///MARK: 上传 图片
+ (NSURLSessionDataTask *)uploadWithURL:(NSString *)URL
                             parameters:(NSDictionary *)parameters
                                 images:(NSArray<UIImage *> *)images
                                   name:(NSString *)name
                               fileName:(NSString *)fileName
                               mimeType:(NSString *)mimeType
                               progress:(CPNetworkProgress)progress
                                success:(CPNetworkRequestSuccess)success
                                failure:(CPNetworkRequestFailed)failure;

///MARK: 上传 视频
+(void)uploadVideoWithParameters:(NSDictionary *)parameters
                   withVideoPath:(NSString *)videoPath
                         withURL:(NSString *)URL
                     withSuccess:(CPNetworkRequestSuccess)success
                     withFailure:(CPNetworkRequestFailed)failure
                    withProgress:(CPNetworkProgress)progress;

///MARK: 多文件 上传
+ (NSArray *)uploadMultFileWithURL:(NSString *)URL
                        parameters:(NSDictionary *)parameters
                         fileDatas:(NSArray *)dataSoucre
                              type:(NSString *)type
                              name:(NSString *)name
                          mimeType:(NSString *)mimeTypes
                          Progress:(CPNetworkProgress)progress
                           Success:(CPNetworkRequestSuccess)success
                           failure:(CPNetworkRequestFailed)failure;

///MARK: 下载
+ (NSURLSessionTask *)downloadWithURL:(NSString *)URL
                              fileDir:(NSString *)fileDir
                             progress:(CPNetworkProgress)progress
                              success:(void(^)(NSURLResponse * _Nonnull response,  NSString * _Nullable filePath))success
                              failure:(CPNetworkRequestFailed)failure;


+(NSURLSessionDataTask *)OriginalPOST:(NSString *)URL
                           parameters:(NSDictionary *)parameters headDic:(NSMutableDictionary *)headDic
                              success:(CPNetworkRequestSuccess)success
                              failure:(CPNetworkRequestFailed)failure;

+(NSURLSessionDataTask *)OriginalPOST:(NSString *)URL
                           parameters:(NSDictionary *)parameters
                              success:(CPNetworkRequestSuccess)success
                              failure:(CPNetworkRequestFailed)failure;

@end

NS_ASSUME_NONNULL_END
