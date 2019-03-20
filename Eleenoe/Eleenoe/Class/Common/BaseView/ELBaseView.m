//
//  ELBaseView.m
//  Eleenoe
//
//  Created by FaceBook on 2019/3/12.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import "ELBaseView.h"

@implementation ELBaseView

-(instancetype)init{
    if (self = [super init]) {
        
        [self ELAddSubviews];
        [self ELSinitConfingViews];
    }
    return  self;
    
}

-(void)awakeFromNib{
    [super awakeFromNib];
    
    [self ELAddSubviews];
    [self ELSinitConfingViews];
}

- (void)ELSinitConfingViews{}

-(void)ELAddSubviews{}

-(void)ELSConfigSignalDataSoucre{}

- (void)InitDataWithModel:(nonnull ELBaseModel *)model {}

-(void)dealloc{
    NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
}


@end
