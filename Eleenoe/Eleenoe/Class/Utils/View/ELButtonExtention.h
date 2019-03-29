//
//  ELButtonExtention.h
//  Eleenoe
//
//  Created by zhanglu on 2019/3/29.
//  Copyright © 2019 FaceBook. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, ButtonDisplayType) {
    ButtonDisplayTypeNone,
    ButtonDisplayTypeImageLeftTileRight,
    ButtonDisplayTypeImageUpTileDown,
    ButtonDisplayTypeImageUpTile,
    ButtonDisplayTypeImageRightTileleft
};

@interface ELButtonExtention : UIButton

@property(nonatomic,assign)IBInspectable ButtonDisplayType type;

/**
 扩大点击
 */
@property(nonatomic,assign)BOOL isExpandClick;
@end

NS_ASSUME_NONNULL_END
