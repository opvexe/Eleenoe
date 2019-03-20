//
//  ELBaseViewProtocol.h
//  Eleenoe
//
//  Created by FaceBook on 2019/3/12.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class ELBaseModel;
@protocol ELBaseViewProtocol <NSObject>

/**
 *  初始化视图
 */
- (void)ELSinitConfingViews;
/**
 *  添加视图
 */
-(void)ELAddSubviews;
/**
 *  配置信号数据
 */
-(void)ELSConfigSignalDataSoucre;
/**
 *  配置数据
 */
-(void)InitDataWithModel:(ELBaseModel *)model;

@end

NS_ASSUME_NONNULL_END
