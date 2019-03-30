//
//  ELBaseCollectionViewCell.h
//  Eleenoe
//
//  Created by FaceBook on 2019/3/12.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ELBaseCollectionViewCellProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@interface ELBaseCollectionViewCell : UICollectionViewCell<ELBaseCollectionViewCellProtocol>


+(instancetype)cellWithCollectionView:(UICollectionView*)collectionView indexpath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
