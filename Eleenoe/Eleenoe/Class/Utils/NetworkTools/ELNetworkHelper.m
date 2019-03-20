//
//  ELNetworkHelper.m
//  Eleenoe
//
//  Created by FaceBook on 2019/3/13.
//  Copyright © 2019 FaceBook. All rights reserved.
//

#import "ELNetworkHelper.h"
#import "AFNetworkReachabilityManager.h"
#import "AFNetworkActivityIndicatorManager.h"
#import <netinet6/in6.h>
#import <netinet/in.h>

#import <AVFoundation/AVAsset.h>
#import <AVFoundation/AVAssetExportSession.h>
#import <AVFoundation/AVMediaFormat.h>
#import "ELSessionManager.h"

#define CP_ERROR [NSError errorWithDomain:@"com.Networking.ErrorDomain" code:-999 userInfo:@{ NSLocalizedDescriptionKey:@"网络出现错误，请检查网络连接"}]

static NetworkReachabilityStatus _status;

static BOOL _isNetwork;

static CPNetworkResponseType _responseType = CPNetworkResponseTypeJSON;

static CPNetworkRequestType  _requestType  = CPNetworkRequestTypeJSON;

static BOOL _shouldAutoEncode = NO;

static BOOL _isEnableInterfaceDebug = NO;

static NSDictionary *_httpHeaders = nil;

static CPNetworkStatus  networkStatus;

static NSMutableArray   *requestTasks;

typedef NS_ENUM(NSUInteger,HTTPMethodType ) {
    HTTPMethodTypeGET=1,
    HTTPMethodTypePOST,
};

@implementation ELNetworkHelper

+ (void)startListeningNetwork{
    
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status){
            case AFNetworkReachabilityStatusUnknown:
                _status ? _status(CPNetworkStatusUnknown) : nil;
                _isNetwork = NO;
                NSLog(@"未知网络");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                _status ? _status(CPNetworkStatusNotReachable) : nil;
                _isNetwork = NO;
                NSLog(@"无网络");
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:{
                //延迟0.5秒，等待状态栏改变后再获取
                CPNetworkStatus status =   [self currentNetWorkStatus];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    _status ? _status(CPNetworkStatusReachableViaReachableViaWWAN) : nil;
                    _isNetwork = YES;
                });
                
                break;}
            case AFNetworkReachabilityStatusReachableViaWiFi:
                _status ? _status(CPNetworkStatusReachableViaWiFi) : nil;
                _isNetwork = YES;
                NSLog(@"WIFI");
                break;
        }
    }];
    [manager startMonitoring];
}

+ (void)checkNetworkStatusWithBlock:(NetworkReachabilityStatus)status{
    
    _status = status;
    
}
+ (BOOL)currentNetworkStatus{
    
    return _isNetwork;
}

+(NSString *)currentNetworkTypeStatus{
    
    NSString *type =@"";
    switch ( [self currentNetWorkStatus]) {
        case CPNetworkStatusUnknown:
            
            type =@"Unknown";
            break;
        case CPNetworkStatusNotReachable:
            
            type =@"无网络";
            break;
        case CPNetworkStatusReachableVia2G:
            
            type =@"2";
            break;
        case CPNetworkStatusReachableVia3G:
            
            type =@"3";
            break;
        case CPNetworkStatusReachableVia4G:
            
            type =@"4";
            break;
        case CPNetworkStatusReachableViaWiFi:
            
            type =@"1";
            break;
        default:
            break;
    }
    return  type;
}
+(void)enableInterfaceDebug:(BOOL)isDebug{
    
    _isEnableInterfaceDebug = isDebug;
    
}
+(BOOL)isDebug{
    
    return _isEnableInterfaceDebug;
}

+(void)configResponseType:(CPNetworkResponseType)responseType{
    
    _responseType =responseType;
    
}

+(void)configRequestType:(CPNetworkRequestType)requestType{
    
    _requestType =requestType;
}

+(BOOL)shouldEncode{
    
    return _shouldAutoEncode;
}
+(void)shouldAutoEncodeUrl:(BOOL)shouldAutoEncode{
    
    _shouldAutoEncode =shouldAutoEncode;
}
+(void)configPublicHttpHeaders:(NSDictionary *)httpHeaders
{
    _httpHeaders =httpHeaders;
    
}
+ (NSString *)encodeUrl:(NSString *)url {
    return [self http_URLEncode:url];
}

+(NSString *)http_URLEncode:(NSString *)url{
    NSString *newString = CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,(CFStringRef)url,NULL,CFSTR(":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"),CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding)));
    if (newString) {
        return newString;
    }
    return url;
}

+ (void)cancleAllRequest {
    @synchronized (self) {
        [[self allTasks] enumerateObjectsUsingBlock:^(NSURLSessionTask  *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[NSURLSessionTask class]]) {
                [obj cancel];
            }
        }];
        [[self allTasks] removeAllObjects];
    }
}

+ (void)cancelRequestWithURL:(NSString *)url {
    if (!url) return;
    @synchronized (self) {
        [[self allTasks] enumerateObjectsUsingBlock:^(NSURLSessionTask * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[NSURLSessionTask class]]) {
                if ([obj.currentRequest.URL.absoluteString hasSuffix:url]) {
                    [obj cancel];
                    *stop = YES;
                }
            }
        }];
    }
}

+ (NSMutableArray *)allTasks {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (requestTasks == nil) requestTasks = [NSMutableArray array];
    });
    return requestTasks;
}

///MARK: GET 请求
+ (NSURLSessionDataTask *)GET:(NSString *)URL
                   parameters:(NSDictionary *)parameters
                responseCache:(CPNetworkRequestCache)responseCache
                      success:(CPNetworkRequestSuccess)success
                      failure:(CPNetworkRequestFailed)failure{
    return  [self WithMethodType:HTTPMethodTypeGET isCache:YES URL:URL parameters:parameters headDic:nil responseCache:responseCache success:success failure:failure];
    
}

+ (NSURLSessionDataTask *)GET:(NSString *)URL
                   parameters:(NSDictionary *)parameters headDic:(NSMutableDictionary *)headDic
                responseCache:(CPNetworkRequestCache)responseCache
                      success:(CPNetworkRequestSuccess)success
                      failure:(CPNetworkRequestFailed)failure{
    return  [self WithMethodType:HTTPMethodTypeGET isCache:YES URL:URL parameters:parameters headDic:headDic responseCache:responseCache success:success failure:failure];
}

+ (NSURLSessionDataTask *)GET:(NSString *)URL
                   parameters:(NSDictionary *)parameters headDic:(NSMutableDictionary *)headDic
                      success:(CPNetworkRequestSuccess)success
                      failure:(CPNetworkRequestFailed)failure{
    return  [self WithMethodType:HTTPMethodTypeGET isCache:NO URL:URL parameters:parameters headDic:headDic responseCache:nil success:success failure:failure];
}

+ (NSURLSessionDataTask *)GET:(NSString *)URL
                   parameters:(NSDictionary *)parameters
                      success:(CPNetworkRequestSuccess)success
                      failure:(CPNetworkRequestFailed)failure{
    return  [self WithMethodType:HTTPMethodTypeGET isCache:NO URL:URL parameters:parameters headDic:nil responseCache:nil success:success failure:failure];
}

///MARK: POST 请求
+ (NSURLSessionDataTask *)POST:(NSString *)URL
                    parameters:(NSDictionary *)parameters
                 responseCache:(CPNetworkRequestCache)responseCache
                       success:(CPNetworkRequestSuccess)success
                       failure:(CPNetworkRequestFailed)failure{
    return  [self WithMethodType:HTTPMethodTypePOST isCache:YES URL:URL parameters:parameters headDic:nil responseCache:responseCache success:success failure:failure];
}

+ (NSURLSessionDataTask *)POST:(NSString *)URL
                    parameters:(NSDictionary *)parameters headDic:(NSMutableDictionary *)headDic
                 responseCache:(CPNetworkRequestCache)responseCache
                       success:(CPNetworkRequestSuccess)success
                       failure:(CPNetworkRequestFailed)failure{
    return  [self WithMethodType:HTTPMethodTypePOST isCache:YES URL:URL parameters:parameters headDic:headDic responseCache:responseCache success:success failure:failure];
}

+ (NSURLSessionDataTask *)POST:(NSString *)URL
                    parameters:(NSDictionary *)parameters headDic:(NSMutableDictionary *)headDic
                       success:(CPNetworkRequestSuccess)success
                       failure:(CPNetworkRequestFailed)failure{
    return  [self WithMethodType:HTTPMethodTypePOST isCache:NO URL:URL parameters:parameters headDic:headDic responseCache:nil success:success failure:failure];
}

+ (NSURLSessionDataTask *)POST:(NSString *)URL
                    parameters:(NSDictionary *)parameters
                       success:(CPNetworkRequestSuccess)success
                       failure:(CPNetworkRequestFailed)failure{
    return  [self WithMethodType:HTTPMethodTypePOST isCache:NO URL:URL parameters:parameters headDic:nil responseCache:nil success:success failure:failure];
}

#pragma mark 公共请求
+ (NSURLSessionDataTask *)WithMethodType:(HTTPMethodType) type  isCache:(BOOL) isCache URL:(NSString *)URL
                              parameters:(NSDictionary *)parameters headDic:(NSMutableDictionary *)headDic
                           responseCache:(CPNetworkRequestCache)responseCache
                                 success:(CPNetworkRequestSuccess)success
                                 failure:(CPNetworkRequestFailed)failure{
    
    NSURLSessionDataTask *task ;
    if (networkStatus == CPNetworkStatusNotReachable) { //查看网络状态
        failure?failure(CP_ERROR):nil;
        return task;
    }
    
    responseCache ? responseCache([ELNetworkCache getHttpCacheForKey:URL]) : nil;
    AFHTTPSessionManager *manger = [self manager];
    
    if ([self shouldEncode]) {  //设置编码UTF8
        URL = [self encodeUrl:URL];
    }
    
    if (headDic.count) {  //设置请求头
        [headDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [manger.requestSerializer setValue:obj forHTTPHeaderField:key];
        }];
    }
    
    switch (type) {
        case HTTPMethodTypeGET:{
            task =  [manger GET:URL parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self successResponse:responseObject complete:success];
                if (isCache) {
                    [ELNetworkCache saveHttpCache:responseObject forKey:URL];
                }
                
                if ([self isDebug]) {
                    [self logWithSuccessResponse:responseObject
                                             url:task.response.URL.absoluteString
                                          params:parameters];
                }
                
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                failure ? failure(error) : nil;
                if ([self isDebug]) {
                    [self logWithFailError:error url:task.response.URL.absoluteString params:parameters];
                }
            }];
            
            break;
        }
        case HTTPMethodTypePOST:{
            task =   [manger POST:URL parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (isCache) {
                    [ELNetworkCache saveHttpCache:responseObject forKey:URL];
                }
                [self successResponse:responseObject complete:success];
                if ([self isDebug]) {
                    [self logWithSuccessResponse:responseObject
                                             url:task.response.URL.absoluteString
                                          params:parameters];
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                failure ? failure(error) : nil;
                if ([self isDebug]) {
                    [self logWithFailError:error url:task.response.URL.absoluteString params:parameters];
                }
                
            }];
            break;
        }
        default:
            break;
    }
    if (task) [[self allTasks] addObject:task];
    return  task ;
}

///MARK: 上传 图片
+ (NSURLSessionDataTask *)uploadWithURL:(NSString *)URL
                             parameters:(NSDictionary *)parameters
                                 images:(NSArray<UIImage *> *)images
                                   name:(NSString *)name
                               fileName:(NSString *)fileName
                               mimeType:(NSString *)mimeType
                               progress:(CPNetworkProgress)progress
                                success:(CPNetworkRequestSuccess)success
                                failure:(CPNetworkRequestFailed)failure{
    
    NSURLSessionDataTask *dataTask;
    AFHTTPSessionManager *manager = [self manager];
    if (networkStatus == CPNetworkStatusNotReachable) {
        failure?failure(CP_ERROR):nil;
        return dataTask;
    }
    
    dataTask = [manager POST:URL parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {         //压缩-添加-上传图片
        [images enumerateObjectsUsingBlock:^(UIImage * _Nonnull image, NSUInteger idx, BOOL * _Nonnull stop) {
            NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
            [formData appendPartWithFileData:imageData name:name fileName:[NSString stringWithFormat:@"%@%lu.%@",fileName,(unsigned long)idx,mimeType?mimeType:@"jpeg"] mimeType:[NSString stringWithFormat:@"image/%@",mimeType?mimeType:@"jpeg"]];
        }];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        progress ? progress(uploadProgress) : nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self successResponse:responseObject complete:success];
        if ([self isDebug]) {
            [self logWithSuccessResponse:responseObject
                                     url:task.response.URL.absoluteString
                                  params:parameters];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure ? failure(error) : nil;
        if ([self isDebug]) {
            [self logWithFailError:error url:task.response.URL.absoluteString params:parameters];
        }
    }];
    
    if (dataTask) [[self allTasks] addObject:dataTask];
    return  dataTask;
}

//MARK: 上传文件
+ (NSURLSessionDataTask *)uploadWithURL:(NSString *)URL
                             parameters:(NSDictionary *)parameters
                               fileData:(NSData *)data
                                   name:(NSString *)name
                                   type:(NSString *)type
                               mimeType:(NSString *)mimeType
                               progress:(CPNetworkProgress)progress
                                success:(CPNetworkRequestSuccess)success
                                failure:(CPNetworkRequestFailed)failure{
    
    NSURLSessionDataTask *session = nil;
    AFHTTPSessionManager *manager = [self manager];
    if (networkStatus == CPNetworkStatusNotReachable) {
        failure?failure(CP_ERROR):nil;
        return session;
    }
    
    session  = [manager POST:URL parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSString *fileName = nil;
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *day = [formatter stringFromDate:[NSDate date]];
        fileName = [NSString stringWithFormat:@"%@.%@",day,type];
        [formData appendPartWithFileData:data name:name fileName:fileName mimeType:mimeType];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        progress ? progress(uploadProgress) : nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self successResponse:responseObject complete:success];
        if ([self isDebug]) {
            [self logWithSuccessResponse:responseObject
                                     url:task.response.URL.absoluteString
                                  params:parameters];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure ? failure(error) : nil;
        if ([self isDebug]) {
            [self logWithFailError:error url:task.response.URL.absoluteString params:parameters];
        }
    }];
    [session resume];
    if (session) [[self allTasks] addObject:session];
    return session;
}

///MARK: 上传视频
+(void)uploadVideoWithParameters:(NSDictionary *)parameters withVideoPath:(NSString *)videoPath withURL:(NSString *)URL withSuccess:(CPNetworkRequestSuccess)success withFailure:(CPNetworkRequestFailed)failure withProgress:(CPNetworkProgress)progress{
    
    AVURLAsset * avAsset = [AVURLAsset assetWithURL:[NSURL URLWithString:videoPath]];
    /*
     压缩
     NSString *const AVAssetExportPreset640x480;
     NSString *const AVAssetExportPreset960x540;
     NSString *const AVAssetExportPreset1280x720;
     NSString *const AVAssetExportPreset1920x1080;
     NSString *const AVAssetExportPreset3840x2160;
     */
    AVAssetExportSession  *  avAssetExport = [[AVAssetExportSession alloc] initWithAsset:avAsset presetName:AVAssetExportPreset640x480];
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd-HH:mm:ss"];
    NSString *  videoWritePath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingString:[NSString stringWithFormat:@"/SPI-%@.mp4",[formatter stringFromDate:[NSDate date]]]];
    avAssetExport.outputURL = [NSURL URLWithString:videoWritePath];
    avAssetExport.outputFileType =  AVFileTypeMPEG4;
    [avAssetExport exportAsynchronouslyWithCompletionHandler:^{
        switch ([avAssetExport status]) {
            case AVAssetExportSessionStatusCompleted:{
                if (networkStatus == CPNetworkStatusNotReachable) {
                    failure?failure(CP_ERROR):nil;
                }
                AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
                [manager POST:URL parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                    //获得沙盒中的视频内容
                    [formData appendPartWithFileURL:[NSURL fileURLWithPath:videoWritePath] name:@"哈哈" fileName:videoWritePath mimeType:@"video/mpeg4" error:nil];
                } progress:^(NSProgress * _Nonnull uploadProgress) {
                    progress(uploadProgress);
                } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
                    success ? success(responseObject) : nil;
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    failure ? failure(error) : nil;
                }];
                
                break;
            }
            default:
                break;
        }
    }];
}

///MARK: 多文件 上传
+ (NSArray *)uploadMultFileWithURL:(NSString *)URL
                        parameters:(NSDictionary *)parameters
                         fileDatas:(NSArray *)dataSoucre
                              type:(NSString *)type
                              name:(NSString *)name
                          mimeType:(NSString *)mimeTypes
                          Progress:(CPNetworkProgress)progress
                           Success:(CPNetworkRequestSuccess)success
                           failure:(CPNetworkRequestFailed)failure{
    
    if (networkStatus == CPNetworkStatusNotReachable) {
        failure?failure(CP_ERROR):nil;
        
        return  nil;
    }
    __block NSMutableArray *sessions = [NSMutableArray array];
    __block NSMutableArray *responses = [NSMutableArray array];
    __block NSMutableArray *failResponse = [NSMutableArray array];
    
    dispatch_group_t uploadGroup = dispatch_group_create();
    for (int i = 0; i<dataSoucre.count; i++) {
        NSURLSessionDataTask *dataTask= nil;
        //group同步
        dispatch_group_enter(uploadGroup);
        dataTask = [self uploadWithURL:URL parameters:parameters fileData:dataSoucre[i] name:name type:type mimeType:mimeTypes progress:^(NSProgress *UPprogress) {
            progress ? progress(UPprogress) : nil;
        } success:^(id responseObject) {
            [responses addObject:responseObject];
            dispatch_group_leave(uploadGroup);
            
            [sessions removeObject:dataTask];
            
        } failure:^(NSError *error) {
            NSError *Error = [NSError errorWithDomain:URL code:-999 userInfo:@{NSLocalizedDescriptionKey:[NSString stringWithFormat:@"第%d次上传失败",i]}];
            [failResponse addObject:Error];
            dispatch_group_leave(uploadGroup);
            [sessions removeObject:dataTask];
            
        }];
        [dataTask resume];
        if (dataTask) [sessions addObject:dataTask];
    }
    [[self allTasks] addObjectsFromArray:sessions];
    
    dispatch_group_notify(uploadGroup, dispatch_get_main_queue(), ^{
        if (responses.count > 0) {
            if (success) {
                success([responses copy]);
                if (sessions.count > 0) {
                    [[self allTasks] removeObjectsInArray:sessions];
                }
            }
        }
        if (failResponse.count > 0) {
            if (failure) {
                failure([failResponse copy]);
                if (sessions.count > 0) {
                    [[self allTasks] removeObjectsInArray:sessions];
                }
            }
        }
    });
    return [sessions copy];
}

///MARK: 下载
+ (NSURLSessionTask *)downloadWithURL:(NSString *)URL
                              fileDir:(NSString *)fileDir
                             progress:(CPNetworkProgress)progress
                              success:(void(^)(NSURLResponse * _Nonnull response, NSString *_Nullable filePath))success
                              failure:(CPNetworkRequestFailed)failure{
    
    NSURLSessionDownloadTask *downloadTask ;
    
    if (networkStatus == CPNetworkStatusNotReachable) {
        failure?failure(CP_ERROR):nil;
        return downloadTask;
    }
    AFHTTPSessionManager *manager = [self manager];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URL]];
    downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        //下载进度
        progress ? progress(downloadProgress) : nil;
        NSLog(@"下载进度:%.2f%%",100.0*downloadProgress.completedUnitCount/downloadProgress.totalUnitCount);
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        
        if (fileDir.length) {
            return [NSURL fileURLWithPath:fileDir];
        }else{
            NSString *downloadDir = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"Download"];
            //打开文件管理器
            NSFileManager *fileManager = [NSFileManager defaultManager];
            //创建Download目录
            [fileManager createDirectoryAtPath:downloadDir withIntermediateDirectories:YES attributes:nil error:nil];
            //拼接文件路径
            NSString *filePath = [downloadDir stringByAppendingPathComponent:response.suggestedFilename];
            NSLog(@"downloadDir = %@",downloadDir);
            //返回文件位置的URL路径
            return [NSURL fileURLWithPath:filePath];
        }
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        success ? success(response,filePath.absoluteString/** NSURL->NSString*/) : nil;
        failure && error ? failure(error) : nil;
        
    }];
    [downloadTask resume];    //开始下载
    if (downloadTask) [[self allTasks] addObject:downloadTask];
    return downloadTask;
    
}

#pragma MARK AFHTTPSessionManager 设置
+(AFHTTPSessionManager *)manager{
    
    [AFNetworkActivityIndicatorManager sharedManager].enabled =[self isNetworkConnect];
    ELSessionManager *manager =  [ELSessionManager manager];
    //设置https单向认证
    //     [manager setSecurityPolicy:[self customSecurityPolicy]];
    
    switch (_requestType) {             //请求头格式默认
        case CPNetworkRequestTypePlainText:{
            manager.requestSerializer = [AFHTTPRequestSerializer serializer];
            break;
        }
        case CPNetworkRequestTypeJSON:{
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
            break;
        }
        default:
            break;
    }
    switch (_responseType) {
        case CPNetworkResponseTypeJSON:{
            AFJSONResponseSerializer *response = [AFJSONResponseSerializer serializer];
            response.removesKeysWithNullValues = YES;
            manager.responseSerializer = response;
            break;
        }
        case CPNetworkResponseTypeXML:{
            manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
            break;
        }
            
        case CPNetworkResponseTypeData:{
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            break;
        }
        default:
            break;
    }
    for (NSString *key in _httpHeaders.allKeys) {
        if (_httpHeaders[key] != nil) {
            [manager.requestSerializer setValue:_httpHeaders[key] forHTTPHeaderField:key];
        }
    }
    manager.responseSerializer.stringEncoding = NSUTF8StringEncoding;
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy = securityPolicy;
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    [manager.requestSerializer setTimeoutInterval:HttpTimeOut];
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json", @"text/json", @"text/javascript",@"text/html", @"text/plain",@"application/atom+xml",@"application/xml",@"text/xml", @"image/*"]];
    manager.operationQueue.maxConcurrentOperationCount = 2;     // 设置允许同时最大并发数量，过大容易出问题
    return manager;
}

+ (void)successResponse:(id)responseData complete:(CPNetworkRequestSuccess)success {
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;// 关闭网络指示器
    });
    success ? success([self tryToParseData:responseData]) : nil;
}

+ (id)tryToParseData:(id)responseData {
    if ([responseData isKindOfClass:[NSData class]]) {
        if (responseData ==nil) {
            return  responseData;
        }else{
            NSError *error = nil;
            NSDictionary *respose = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&error];
            if (error) {
                return  responseData;
            }else{
                return respose;
            }
        }
    }else{
        return responseData;
    }
}

#pragma MARK 打印
+ (void)logWithSuccessResponse:(id)response url:(NSString *)url params:(NSDictionary *)params {
    NSLog(@"\nabsoluteUrl: %@\n params:%@\n response:%@\n\n",
          [self generateGETAbsoluteURL:url params:params],
          params,
          [self tryToParseData:response]);
}

+ (void)logWithFailError:(NSError *)error url:(NSString *)url params:(NSDictionary *)params {
    NSLog(@"\nabsoluteUrl: %@\n params:%@\n errorInfos:%@\n\n",
          [self generateGETAbsoluteURL:url params:params],
          params,
          [error localizedDescription]);
}

// 仅对一级字典结构起作用
+ (NSString *)generateGETAbsoluteURL:(NSString *)url params:(NSDictionary *)params{
    if (params.count ==0) {
        return url;
    }
    NSString *queries = @"";
    for (NSString *key in params) {
        id value = [params objectForKey:key];
        if ([value isKindOfClass:[NSDictionary class]]) {
            continue;
        }else if ([value isKindOfClass:[NSArray class]]){
            continue;
        }else if ([value isKindOfClass:[NSSet class]]){
            continue;
        }else{
            queries = [NSString stringWithFormat:@"%@%@=%@&",(queries.length==0? @"&":queries),key,value];
        }
    }
    
    if (queries.length>1) {
        queries = [queries substringToIndex:queries.length -1];
    }
    
    if (([url rangeOfString:@"http://"].location !=NSNotFound ||[url rangeOfString:@"https://"].location !=NSNotFound)&&queries.length>1) {
        if ([url rangeOfString:@"?"].location !=NSNotFound ||[url rangeOfString:@"#"].location !=NSNotFound) {
            url = [NSString stringWithFormat:@"%@%@",url,queries];
        }else{
            queries = [queries substringFromIndex:1];
            url = [NSString stringWithFormat:@"%@?%@",url,queries];
        }
    }
    return url.length==0?queries:url;
}

///MARK:  获取网络连接
+(BOOL)isNetworkConnect{
#if (defined(__IPHONE_OS_VERSION_MIN_REQUIRED) && __IPHONE_OS_VERSION_MIN_REQUIRED >= 90000) || (defined(__MAC_OS_X_VERSION_MIN_REQUIRED) && __MAC_OS_X_VERSION_MIN_REQUIRED >= 101100)
    struct sockaddr_in6 address;
    bzero(&address, sizeof(address));
    address.sin6_len = sizeof(address);
    address.sin6_family = AF_INET6;
#else
    struct sockaddr_in address;
    bzero(&address, sizeof(address));
    address.sin_len = sizeof(address);
    address.sin_family = AF_INET;
#endif
    //    struct sockaddr zeroAddress;
    //    bzero(&zeroAddress, sizeof(zeroAddress));
    //    zeroAddress.sa_len = sizeof(zeroAddress);
    //    zeroAddress.sa_family = AF_INET;
    SCNetworkReachabilityRef defaultRouteReachability =
    SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&address);
    SCNetworkReachabilityFlags flags;
    BOOL didRetrieveFlags =
    SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    if (!didRetrieveFlags) {
        printf("Error. Count not recover network reachability flags\n");
        return NO;
    }
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    BOOL isNetworkEnable  =(isReachable && !needsConnection) ? YES : NO;
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIApplication sharedApplication].networkActivityIndicatorVisible =isNetworkEnable;/*  网络指示器的状态： 有网络 ： 开  没有网络： 关  */
    });
    return isNetworkEnable;
}


+(CPNetworkStatus )currentNetWorkStatus{
    UIApplication *application = [UIApplication sharedApplication];
    NSMutableArray *chlidrenArray = [NSMutableArray arrayWithCapacity:0];
    if ([[application valueForKeyPath:@"_statusBar"] isKindOfClass:NSClassFromString(@"UIStatusBar_Modern")]) {
        chlidrenArray = [[[[application valueForKeyPath:@"_statusBar"] valueForKeyPath:@"_statusBar"] valueForKeyPath:@"foregroundView"] subviews].mutableCopy;
    } else {
        chlidrenArray =  [[[application valueForKeyPath:@"statusBar"] valueForKeyPath:@"foregroundView"] subviews].mutableCopy;
    }
    NSUInteger state = 0;
    
    NSInteger netType =0;
    
    for (id  child in chlidrenArray) {
        
        if ([child isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
            
            netType = [[child valueForKeyPath:@"dataNetworkType"] integerValue];
            
            switch (netType) {
                case 0:
                    state = CPNetworkStatusNotReachable;
                    break;
                case 1:
                    state = CPNetworkStatusReachableVia2G;
                    break;
                case 2:
                    state = CPNetworkStatusReachableVia3G;
                    break;
                case 3:
                    state = CPNetworkStatusReachableVia4G;
                    break;
                case 5:
                    state = CPNetworkStatusReachableViaWiFi;
                    break;
                default:
                    break;
            }
        }
    }
    return state;
}

@end
