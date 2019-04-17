//
//  ELMyofascialContentModel.h
//  Eleenoe
//
//  Created by FaceBook on 2019/4/17.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import "ELBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ELMyofascialContentModel : ELBaseModel
/**
 *  是否显示
 */
@property(nonatomic,assign)BOOL isShow;
/**
 *  疼痛
 */
@property(nonatomic,strong)NSArray *pains;

@end

@interface ELMyofascialContentListModel : ELBaseModel

@property(nonatomic,copy)NSString *title;

@property(nonatomic,copy)NSString *selectedImageName;

@property (nonatomic, assign) BOOL choose;

@end

NS_ASSUME_NONNULL_END
