//
//  SCREENAdaptationTool.m
//  Eleenoe
//
//  Created by FaceBook on 2019/3/22.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import "SCREENAdaptationTool.h"

static SCREENAdaptationTool *_instance;

@implementation SCREENAdaptationTool

+ (instancetype)shareInstance
{
    if (_instance == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _instance = [[self alloc] init];
        });
    }
    return _instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setReference:375.0 height:667.0];
    }
    return self;
}

- (void)setReference:(CGFloat)width height:(CGFloat)height
{
    _vertical = [[UIScreen mainScreen]bounds].size.height / height;
    _Horizontal = [[UIScreen mainScreen]bounds].size.width / width;
    _font = floorf([[UIScreen mainScreen]bounds].size.width / width);
}


@end
