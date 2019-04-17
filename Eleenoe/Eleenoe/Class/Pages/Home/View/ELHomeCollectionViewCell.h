//
//  ELHomeTableViewCell.h
//  Eleenoe
//
//  Created by HuiLu on 2019/3/30.
//  Copyright © 2019 FaceBook. All rights reserved.
//

#import "ELBaseCollectionViewCell.h"
NS_ASSUME_NONNULL_BEGIN

@interface ELHomeCollectionViewCell : ELBaseCollectionViewCell

-(void)InitDataWithModel:(ELBaseModel *)model Atindex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
