//
//  ELSearchModel.h
//  Eleenoe
//
//  Created by HuiLu on 2019/4/1.
//  Copyright © 2019 FaceBook. All rights reserved.
//

#import "ELBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ELSearchModel : ELBaseModel
@property(nonatomic,copy)NSString *title;
@property(nonatomic,strong)NSArray *dataSoucre;
@end

NS_ASSUME_NONNULL_END
