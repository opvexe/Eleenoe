//
//  ELTrackCollectTool.m
//  Eleenoe
//
//  Created by FaceBook on 2019/4/10.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import "ELTrackCollectTool.h"
#import "ELTrackDataHandler.h"
#import <objc/runtime.h>
#import <Aspects.h>

@implementation ELTrackCollectTool

- (void)yc_trackHooks{
    
    [self hookViewAppear];
//    [self hookClickEventAction];
}

/**
 *  采集用户页面时长
 
 */
- (void)hookViewAppear{
    
    [UIViewController aspect_hookSelector:@selector(viewWillAppear:) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> info){
        
        NSString *className =NSStringFromClass([[info instance] class]);
        
        NSDictionary *dict = [ELTrackDataHandler shareInstance].dataDict[className];
        
        if (dict[@"isTrue"]) {
            NSString *pageClassName = dict[@"viewWillAppear"];
            [MobClick beginLogPageView:pageClassName];
        }
        
    } error:NULL];
    
    
    [UIViewController aspect_hookSelector:@selector(viewWillDisappear:) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> info){
        
        NSString *className =NSStringFromClass([[info instance] class]);
        
        NSDictionary *dict = [ELTrackDataHandler shareInstance].dataDict[className];
        
        if (dict[@"isTrue"]) {
            NSString *pageClassName = dict[@"viewWillDisappear"];
            [MobClick endLogPageView:pageClassName];
        }
        
    } error:NULL];
    
}


/**
 *  采集用户点击事件
 
 */
-(void)hookClickEventAction{
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        for (NSString *className in [ELTrackDataHandler shareInstance].dataDict.allKeys) {
            
            Class tempClass = objc_getClass([className UTF8String]);
            
            NSDictionary *dict = [[ELTrackDataHandler shareInstance].dataDict objectForKey:className];
            
            NSArray *tempArray = dict[@"subviews"];
            
            if (tempArray.count) {
                
                for (NSDictionary *eventDict in tempArray) {
                    
                    NSString *eventMethodName = eventDict[@"methodName"];
                    
                    SEL seletor = NSSelectorFromString(eventMethodName);
                    
                    NSString *eventId = eventDict[@"eventId"];
                    
                    if (eventDict[@"isTrue"]) {
                        
                        [self hookActionWithParamWithClass:tempClass selector:seletor eventID:eventId];
                        [self hookActionWithClass:tempClass selector:seletor eventID:eventId];
                        [self hookTableViewClass:tempClass didSelectRow:seletor eventId:eventId];
                    }

                }
                
            }
        }
        
    });
}

/**
 *  采集点击事件（无参数）
 
 */

-(void)hookActionWithClass:(Class)tempClass selector:(SEL)selector eventID:(NSString*)eventID {
    
    [tempClass aspect_hookSelector:selector withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo) {
       
        [MobClick event:eventID];
        
    } error:NULL];

}

/**
 *  采集点击事件（有参数）
 
 */
- (void)hookActionWithParamWithClass:(Class)tempClass selector:(SEL)selector eventID:(NSString*)eventID{
    
    [tempClass aspect_hookSelector:selector withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo,UIButton *button) {
        
        [MobClick event:eventID];
        
    } error:NULL];
    
}


/**
 *  采集tableview didSelectRowAtIndexPath事件
 
 */

-(void)hookTableViewClass:(Class)class didSelectRow:(SEL)selector eventId:(NSString *)eventId{
    
    [class aspect_hookSelector:selector withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo,NSSet *touches, UIEvent *event){
        
        NSInteger section = [[event valueForKeyPath:@"section"]integerValue];
        
        NSInteger row = [[event valueForKeyPath:@"row"]integerValue];
        
        [MobClick event:[NSString stringWithFormat:@"%@_%ld_%ld",eventId,section,row]];
        
    }error:NULL];
    
}

@end
