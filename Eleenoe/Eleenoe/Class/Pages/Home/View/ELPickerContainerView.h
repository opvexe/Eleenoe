//
//  ELPickerContainerView.h
//  Eleenoe
//
//  Created by FaceBook on 2019/4/3.
//  Copyright © 2019 FaceBook. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ELPickerContainerView : UIView

- (instancetype)initWithFrame:(CGRect)frame itemsSize:(CGSize)itemsSize;

- (void)selectRow:(NSInteger)row animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
