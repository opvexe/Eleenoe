//
//  ELGuideView.h
//  Eleenoe
//
//  Created by FaceBook on 2019/3/13.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ELGuideView : UIView

@property(nonatomic,strong)NSArray* guideImages;

-(void)didEnterCompletetedBlock:(void(^)(void))completetBlock;

@end

NS_ASSUME_NONNULL_END
