//
//  ELCircularProgressView.h
//  Eleenoe
//
//  Created by FaceBook on 2019/3/30.
//  Copyright © 2019 FaceBook. All rights reserved.
//

#import "ELBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ELCircularProgressView : ELBaseView

/**
 * 进度
 */
@property (nonatomic) float progress;

/**
 * 圆环宽度
 */
@property (assign,nonatomic) CGFloat lineWidth;
@end

NS_ASSUME_NONNULL_END
