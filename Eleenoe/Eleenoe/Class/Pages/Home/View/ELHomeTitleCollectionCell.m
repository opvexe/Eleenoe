//
//  ELHomeTitleTableCell.m
//  Eleenoe
//
//  Created by HuiLu on 2019/3/30.
//  Copyright © 2019 FaceBook. All rights reserved.
//

#import "ELHomeTitleCollectionCell.h"

@implementation ELHomeTitleCollectionCell

+(instancetype)cellWithCollectionView:(UICollectionView*)collectionView indexpath:(NSIndexPath *)indexPath{
    ELHomeTitleCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ELHomeTitleCollectionCell class]) forIndexPath:indexPath];
    return cell;
}

@end
