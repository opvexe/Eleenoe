//
//  ELHomeTableViewCell.m
//  Eleenoe
//
//  Created by HuiLu on 2019/3/30.
//  Copyright © 2019 FaceBook. All rights reserved.
//

#import "ELHomeCollectionViewCell.h"
#import "ELMyofascialContentModel.h"
#import "ELMyofascialContentView.h"
@interface ELHomeCollectionViewCell()
@property(nonatomic,strong)ELMyofascialContentView *contentImageView;

@end

@implementation ELHomeCollectionViewCell
+(instancetype)cellWithCollectionView:(UICollectionView*)collectionView indexpath:(NSIndexPath *)indexPath{
    ELHomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ELHomeCollectionViewCell class]) forIndexPath:indexPath];
    return cell;
}
-(void)ELSinitConfingViews{
    _contentImageView = ({
        ELMyofascialContentView *iv = [[ELMyofascialContentView alloc]init];
        [self.contentView addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(kSAdap_V(-8));
        }];
        iv;
    });
}

-(void)InitDataWithModel:(ELMyofascialContentModel *)model Atindex:(NSInteger)index{
    [self.contentImageView InitDataWithModel:model Atindex:index];
}

@end
