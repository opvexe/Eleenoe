//
//  ELBaseCollectionReusableView.m
//  Eleenoe
//
//  Created by FaceBook on 2019/3/29.
//  Copyright © 2019 FaceBook. All rights reserved.
//

#import "ELBaseCollectionReusableView.h"

@implementation ELBaseCollectionReusableView

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
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

+(CGSize)getHeight:(ELBaseModel *)model{
    return CGSizeZero;
}

-(void)dealloc{
    NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
}

@end
