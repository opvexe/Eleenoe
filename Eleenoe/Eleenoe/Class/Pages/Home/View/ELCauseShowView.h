//
//  ELCauseShowView.h
//  Eleenoe
//
//  Created by FaceBook on 2019/3/28.
//  Copyright © 2019 FaceBook. All rights reserved.
//

#import "ELBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ELCauseShowView : ELBaseView

- (instancetype)initWithCauseModel:(id)model;

-(void)show;

-(void)dismiss;

@end

NS_ASSUME_NONNULL_END
