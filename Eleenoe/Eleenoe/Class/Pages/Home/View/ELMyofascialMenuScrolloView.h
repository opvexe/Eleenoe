//
//  ELMyofascialMenuScrolloView.h
//  Eleenoe
//
//  Created by FaceBook on 2019/3/30.
//  Copyright © 2019 FaceBook. All rights reserved.
//

#import "ELBaseCollectionView.h"

NS_ASSUME_NONNULL_BEGIN


/**
 * 滚动方向
 
 - MyofascialMenuTypeHorizontal: 水平方向
 - MyofascialMenuTypeVertical: 垂直方向
 */
typedef NS_ENUM(NSInteger, MyofascialMenuType) {
    MyofascialMenuTypeHorizontal,
    MyofascialMenuTypeVertical,
};

@interface ELMyofascialMenuScrolloView : ELBaseCollectionView

/**
 * 默认选中垂直方向
 
 */
@property(nonatomic, assign) MyofascialMenuType type;

/**
 * 默认选中
 
 */
@property(nonatomic, assign) NSInteger defaultChoice;

/**
 * 赋值
 
 @param lists 数组数据
 */
-(void)initWithSouce:(NSArray *)lists;

@end

NS_ASSUME_NONNULL_END
