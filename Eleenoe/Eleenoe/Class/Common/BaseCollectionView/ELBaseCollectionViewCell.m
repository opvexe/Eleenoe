//
//  ELBaseCollectionViewCell.m
//  Eleenoe
//
//  Created by FaceBook on 2019/3/12.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import "ELBaseCollectionViewCell.h"

@implementation ELBaseCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]) {
        
        [self ELSinitConfingViews];
        [self ELSConfigSignalDataSoucre];
    }
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    
    [self ELSinitConfingViews];
    [self ELSConfigSignalDataSoucre];
}

- (void)ELSConfigSignalDataSoucre {
    
}

- (void)ELSinitConfingViews {
    
}

- (void)InitDataWithModel:(nonnull ELBaseModel *)model {
    
}

+(CGSize)getCellHeight:(ELBaseModel *)model{
    return CGSizeZero;
}

@end
