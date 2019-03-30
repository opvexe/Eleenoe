//
//  ELElectrodeViewController.h
//  Eleenoe
//
//  Created by FaceBook on 2019/3/30.
//  Copyright © 2019 FaceBook. All rights reserved.
//

#import "ELBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * 贴片
 
 - ELElectrodeTypeChange: 更换贴片
 - ELElectrodeTypeReset: 重置贴片
 */
typedef NS_ENUM(NSInteger, ELElectrodeType) {
    ELElectrodeTypeChange,
    ELElectrodeTypeReset,
};

@interface ELElectrodeViewController : ELBaseViewController

@end

NS_ASSUME_NONNULL_END
