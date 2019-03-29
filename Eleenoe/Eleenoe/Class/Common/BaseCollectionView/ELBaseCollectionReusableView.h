//
//  ELBaseCollectionReusableView.h
//  Eleenoe
//
//  Created by FaceBook on 2019/3/29.
//  Copyright © 2019 FaceBook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ELBaseViewProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@class ELBaseModel;
@interface ELBaseCollectionReusableView : UICollectionReusableView<ELBaseViewProtocol>


+(CGSize)getHeight:(ELBaseModel *)model;

@end

NS_ASSUME_NONNULL_END
