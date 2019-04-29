//
//  ELBannerCollectionViewCell.m
//  Eleenoe
//
//  Created by FaceBook on 2019/3/29.
//  Copyright © 2019 FaceBook. All rights reserved.
//

#import "ELBannerCollectionViewCell.h"

@implementation ELBannerCollectionViewCell

-(void)ELSinitConfingViews{
    
    _imageView = ({
        UIImageView *iv = [[UIImageView alloc]initWithFrame:CGRectZero];
        iv.clipsToBounds = YES;
        iv.contentMode  = UIViewContentModeScaleAspectFill;
        iv.backgroundColor = [UIColor redColor];
        iv.layer.cornerRadius = 5.0f;
        [self.contentView addSubview:iv];
        iv;
    });
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
}

@end
