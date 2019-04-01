//
//  ELMyofascialMenuScrolloView.h
//  Eleenoe
//
//  Created by FaceBook on 2019/3/30.
//  Copyright © 2019 FaceBook. All rights reserved.
//

#import "ELBaseCollectionView.h"

NS_ASSUME_NONNULL_BEGIN

@class ELBaseModel;
@class ELMyofascialMenuScrolloView;
@protocol ELMyofascialMenuPickerDelegate <NSObject>

- (void)myofascialMenuView:(ELMyofascialMenuScrolloView *)pickView willSelectItems:(ELBaseModel *)model;


@end

@interface ELMyofascialMenuScrolloView : ELBaseCollectionView

@property (nonatomic, weak) id<ELMyofascialMenuPickerDelegate> pickDelegate;
/**
 * 赋值
 
 @param lists 数组数据
 */
-(void)initWithSouce:(NSArray *)lists;


/**
 * 设置当前显示的位置

 @param currentIndex 当前IndexPath位置
 */
- (void)setCurrentIndex:(NSIndexPath *)currentIndex;

@end

NS_ASSUME_NONNULL_END
