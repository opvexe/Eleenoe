//
//  ELShopCollectionViewCell.m
//  Eleenoe
//
//  Created by FaceBook on 2019/3/29.
//  Copyright © 2019 FaceBook. All rights reserved.
//

#import "ELShopCollectionViewCell.h"
#import "ELShopModel.h"
@interface ELShopCollectionViewCell()
@property (nonatomic,strong) FLAnimatedImageView *shopImageView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *describeLabel;
@property (nonatomic,strong) UILabel *priceLabel;
@end

@implementation ELShopCollectionViewCell

+(instancetype)cellWithCollectionView:(UICollectionView*)collectionView indexpath:(NSIndexPath *)indexPath{
    ELShopCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ELShopCollectionViewCell class]) forIndexPath:indexPath];
    return cell;
}

-(void)ELSinitConfingViews{
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    _shopImageView = ({
        FLAnimatedImageView *iv = [[FLAnimatedImageView alloc]initWithFrame:CGRectZero];
        iv.clipsToBounds = YES;
        iv.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(self.contentView);
            make.height.mas_equalTo(kSAdap_V(120.0));
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
            make.top.mas_equalTo(self.shopImageView.mas_bottom).mas_offset(kSAdap_V(10.0));
            make.height.mas_equalTo(kSAdap_V(20.0));
        }];
        iv;
    });
    
    _describeLabel = ({
        UILabel *iv = [[UILabel alloc]init];
        iv.numberOfLines = 2;
        iv.textColor  = MainLightGrayTitleColor;
        iv.textAlignment = NSTextAlignmentLeft;
        iv.font = [UIFont ELPingFangSCRegularFontOfSize:kSaFont(12.0)];
        [self.contentView addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.titleLabel);
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(self.titleLabel.mas_bottom);
        }];
        iv;
    });
    
    _priceLabel = ({
        UILabel *iv = [[UILabel alloc]init];
        iv.textAlignment = NSTextAlignmentLeft;
        iv.font = [UIFont ELPingFangSCMediumFontOfSize:kSaFont(14.0)];
        iv.textColor = MainThemColor;
        [self.contentView addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.titleLabel);
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(self.describeLabel.mas_bottom).mas_offset(kSAdap_V(5.0));
            make.height.mas_equalTo(kSAdap_V(20.0));
        }];
        iv;
    });
}

-(void)InitDataWithModel:(ELShopContentModel *)model{
    
    if ([model.items_url hasSuffix:@"http"]) {
        [self.shopImageView sd_setImageWithURL:[NSURL URLWithString:convertToString(model.items_url)] placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
    }else{
        UIImage *image = [UIImage imageNamed:convertToString(model.items_url)];
        if (!image) {
            image = [UIImage imageWithContentsOfFile:convertToString(model.items_url)];
        }
        self.shopImageView.image = image;
    }
    self.titleLabel.text = convertToString(model.title);
    self.describeLabel.text = convertToString(model.describe_shop);
    self.priceLabel.text =[NSString stringWithFormat:@"￥：%@",convertToString(model.price_shop)];
}

@end
