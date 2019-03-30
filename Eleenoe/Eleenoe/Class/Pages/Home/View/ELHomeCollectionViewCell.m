//
//  ELHomeTableViewCell.m
//  Eleenoe
//
//  Created by HuiLu on 2019/3/30.
//  Copyright © 2019 FaceBook. All rights reserved.
//

#import "ELHomeCollectionViewCell.h"

@implementation ELHomeCollectionViewCell
+(instancetype)cellWithCollectionView:(UICollectionView*)collectionView indexpath:(NSIndexPath *)indexPath{
    ELHomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ELHomeCollectionViewCell class]) forIndexPath:indexPath];
    return cell;
}

@end
