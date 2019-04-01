//
//  ELMyofascialMenuScrolloView.h
//  Eleenoe
//
//  Created by FaceBook on 2019/3/30.
//  Copyright © 2019 FaceBook. All rights reserved.
//

#import "ELBaseCollectionView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ELMyofascialMenuScrolloView : ELBaseCollectionView

/**
 * 赋值
 
 @param lists 数组数据
 */
-(void)initWithSouce:(NSArray *)lists;


- (void)setCurrentIndex:(NSIndexPath *)currentIndex;

@end

NS_ASSUME_NONNULL_END
