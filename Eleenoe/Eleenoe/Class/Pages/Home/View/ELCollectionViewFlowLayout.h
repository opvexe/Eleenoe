//
//  ELCollectionViewFlowLayout.h
//  Eleenoe
//
//  Created by FaceBook on 2019/4/3.
//  Copyright © 2019 FaceBook. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MKJCollectionViewFlowLayoutDelegate <NSObject>

- (void)collectioViewScrollToIndex:(NSInteger)index;

@end
@interface ELCollectionViewFlowLayout : UICollectionViewFlowLayout

@property (nonatomic,assign) id<MKJCollectionViewFlowLayoutDelegate>delegate;

@property (nonatomic,assign) BOOL needAlpha;
@end

NS_ASSUME_NONNULL_END
