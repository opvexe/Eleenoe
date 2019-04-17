//
//  ELPickerContainerView.h
//  Eleenoe
//
//  Created by FaceBook on 2019/4/3.
//  Copyright © 2019 FaceBook. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class ELPickerContainerView;
@protocol ELPickerContainerChioceDelegate <NSObject>
@optional

-(void)pickView:(ELPickerContainerView *)pickview AtIndex:(NSInteger)index model:(ELBaseModel *)model;

@end

@interface ELPickerContainerView : UIView

- (instancetype)initWithFrame:(CGRect)frame itemsSize:(CGSize)itemsSize;


-(void)InitDataSouce:(NSArray *)souce;

@property(nonatomic,weak) id <ELPickerContainerChioceDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
