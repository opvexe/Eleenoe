//
//  ELPickerContainerView.h
//  Eleenoe
//
//  Created by FaceBook on 2019/4/3.
//  Copyright © 2019 FaceBook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ELMyofascialContentModel.h"
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, PickCircleType) {
    PickCircleTypeBody,
    PickCircleTypeRank,
};

@interface ELPickerContainerView : UIView

- (instancetype)initWithFrame:(CGRect)frame itemsSize:(CGSize)itemsSize;

@property(nonatomic,assign)PickCircleType type;

-(void)InitDataSouce:(NSArray *)souce;

@property(nonatomic,copy)void(^ContainerChioceBlock)(ELPickerContainerView *pickview,NSInteger index,ELMyofascialContentListModel *model);


@end

NS_ASSUME_NONNULL_END
