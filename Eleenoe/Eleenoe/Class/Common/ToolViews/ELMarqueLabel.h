//
//  ELMarqueLabel.h
//  Eleenoe
//
//  Created by FaceBook on 2019/3/31.
//  Copyright © 2019 FaceBook. All rights reserved.
//

#import "ELBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ELMarqueLabel : ELBaseView

/**
 * 速度（默认）
 */
@property(nonatomic, assign) CGFloat speed;

/**
 * 滚动内容
 */
@property (nonatomic, copy) NSString *text;

@end

NS_ASSUME_NONNULL_END
