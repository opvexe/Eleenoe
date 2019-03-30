//
//  ELMyofascialMenuModel.h
//  Eleenoe
//
//  Created by FaceBook on 2019/3/30.
//  Copyright © 2019 FaceBook. All rights reserved.
//

#import "ELBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ELMyofascialMenuModel : ELBaseModel

/**
 * 标题
 */
@property (nonatomic, copy) NSString *title;

/**
 * 选中
 */
@property (nonatomic, assign) BOOL choice;

@end

NS_ASSUME_NONNULL_END
