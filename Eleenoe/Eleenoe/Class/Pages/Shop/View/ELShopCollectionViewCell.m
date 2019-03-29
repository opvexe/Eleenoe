//
//  ELShopCollectionViewCell.m
//  Eleenoe
//
//  Created by FaceBook on 2019/3/29.
//  Copyright © 2019 FaceBook. All rights reserved.
//

#import "ELShopCollectionViewCell.h"

@interface ELShopCollectionViewCell()
@property (nonatomic,strong) FLAnimatedImageView *shopImageView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *describeLabel;
@property (nonatomic,strong) UILabel *priceLabel;
@end

@implementation ELShopCollectionViewCell

-(void)ELSinitConfingViews{
    
    _shopImageView = ({
        FLAnimatedImageView *iv = [[FLAnimatedImageView alloc]initWithFrame:CGRectZero];
        iv.clipsToBounds = YES;
        iv.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(self.contentView);
            make.height.mas_equalTo(kSAdap_V(80.0));
        }];
        iv;
    });
    
    _titleLabel = ({
        UILabel *iv = [[UILabel alloc]init];
        iv.textColor  = MainBlackTitleColor;
        iv.textAlignment = NSTextAlignmentLeft;
        iv.font = [UIFont ELPingFangSCRegularFontOfSize:kSaFont(14.0)];
        [self.contentView addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(kSAdap(5.0));
            make.right.mas_equalTo(-kSAdap(5.0));
            make.top.mas_equalTo(self.shopImageView.mas_bottom);
            make.height.mas_equalTo(kSAdap_V(20.0));
        }];
        iv;
    });
    
    _describeLabel = ({
        UILabel *iv = [[UILabel alloc]init];
        iv.numberOfLines = 0;
        iv.textColor  = MainLightGrayTitleColor;
        iv.textAlignment = NSTextAlignmentLeft;
        iv.font = [UIFont ELPingFangSCRegularFontOfSize:kSaFont(12.0)];
        [self.contentView addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self.titleLabel);
            make.top.mas_equalTo(self.titleLabel.mas_bottom);
        }];
        iv;
    });
    
    _priceLabel = ({
        UILabel *iv = [[UILabel alloc]init];
        iv.textAlignment = NSTextAlignmentLeft;
        iv.font = [UIFont ELPingFangSCRegularFontOfSize:kSaFont(14.0)];
        iv.textColor = MainThemColor;
        [self.contentView addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self.titleLabel);
            make.top.mas_equalTo(self.describeLabel.mas_bottom);
        }];
        iv;
    });
}

@end
