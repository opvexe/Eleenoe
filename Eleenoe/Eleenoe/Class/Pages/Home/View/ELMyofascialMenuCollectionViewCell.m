//
//  ELMyofascialMenuCollectionViewCell.m
//  Eleenoe
//
//  Created by FaceBook on 2019/3/30.
//  Copyright © 2019 FaceBook. All rights reserved.
//

#import "ELMyofascialMenuCollectionViewCell.h"
#import "ELMyofascialMenuModel.h"
@interface ELMyofascialMenuCollectionViewCell()

@end
@implementation ELMyofascialMenuCollectionViewCell

+(instancetype)cellWithCollectionView:(UICollectionView*)collectionView indexpath:(NSIndexPath *)indexPath{
    ELMyofascialMenuCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ELMyofascialMenuCollectionViewCell class]) forIndexPath:indexPath];
    return cell;
}

-(void)ELSinitConfingViews{
    
    _titleLabel = ({
        UILabel *iv = [[UILabel alloc]init];
        iv.textColor = MainLightThemColor;
        iv.textAlignment = NSTextAlignmentCenter;
        iv.font = [UIFont ELPingFangSCMediumFontOfSize:kSaFont(16.0)];
        [iv sizeToFit];
        [self.contentView addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.contentView);
        }];
        iv;
    });
}

//-(void)InitDataWithModel:(ELMyofascialMenuModel *)model{
//    self.titleLabel.text = model.title;
//}
//
//-(void)setSelected:(BOOL)selected{
//    [super setSelected:selected];
//    if (selected) {
//         self.titleLabel.textColor = MainWhiteTitleColor;
//          self.titleLabel.font = [UIFont ELPingFangSCMediumFontOfSize:kSaFont(16.0)];
//    }else{
//        self.titleLabel.textColor = MainLightThemColor;
//         self.titleLabel.font = [UIFont ELPingFangSCRegularFontOfSize:kSaFont(12.0)];
//    }
//}
@end
