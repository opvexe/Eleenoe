//
//  ELHomeTitleTableCell.m
//  Eleenoe
//
//  Created by HuiLu on 2019/3/30.
//  Copyright © 2019 FaceBook. All rights reserved.
//

#import "ELHomeTitleCollectionCell.h"
#import "ELMyofascialMenuModel.h"


@interface ELHomeTitleCollectionCell()
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UILabel *titleLabel;
@end


@implementation ELHomeTitleCollectionCell

+(instancetype)cellWithCollectionView:(UICollectionView*)collectionView indexpath:(NSIndexPath *)indexPath{
    ELHomeTitleCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ELHomeTitleCollectionCell class]) forIndexPath:indexPath];
    return cell;
}

-(void)ELSinitConfingViews{
    
    _imageView = ({
        UIImageView *iv = [[UIImageView alloc]init];
        iv.clipsToBounds = YES;
        UIImage *icon  = [UIImage imageNamed:@"MyofascialTimeIcon"];
        iv.image = icon ;
        [self.contentView addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(kSAdap(28), kSAdap_V(28)));
        }];
        iv;
    });
    
    _titleLabel = ({
        UILabel *iv = [[UILabel alloc] init];
        iv.textColor = MainBlackTitleColor;
        iv.textAlignment = NSTextAlignmentCenter;
        UIFont *contenFont =[UIFont ELPingFangSCRegularFontOfSize:kSaFont(12.0)];
        iv.font = contenFont;
        [self.contentView addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(kSAdap(17));
            make.right.and.left.mas_equalTo(0);
            make.top.mas_equalTo(self.imageView.mas_bottom).offset(kSAdap(7));
        }];
        iv;
    });
}
-(void)InitDataWithModel:(ELMyofascialTitleModel *)model{
    self.titleLabel.text = model.title;
    if (model.choose) {
        self.titleLabel.textColor = CellSelectedColor;
        self.imageView.image = [UIImage imageNamed:model.selectedImageName];
    }else{
        self.imageView.image = [UIImage imageNamed:model.imageName];
        self.titleLabel.textColor = CellNormallColor;
    }
}
@end
