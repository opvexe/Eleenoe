//
//  ELMyofascialMenuScrolloView.h
//  Eleenoe
//
//  Created by FaceBook on 2019/3/30.
//  Copyright © 2019 FaceBook. All rights reserved.
//

#import "ELBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@class ELBaseModel;
@class ELMyofascialMenuScrolloView;
@protocol ELMyofascialMenuPickerDelegate <NSObject>

- (void)myofascialMenuView:(ELMyofascialMenuScrolloView *)pickView didSelectItems:(ELBaseModel *)model;
@end

@interface ELMyofascialMenuScrolloView : ELBaseView

- (void)setCurrentIndex:(NSInteger )row;


@end

NS_ASSUME_NONNULL_END
