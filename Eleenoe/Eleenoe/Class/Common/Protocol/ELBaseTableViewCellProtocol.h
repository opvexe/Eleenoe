//
//  ELBaseTableViewCellProtocol.h
//  Eleenoe
//
//  Created by FaceBook on 2019/3/13.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class ELBaseModel;
@protocol ELBaseTableViewCellProtocol <NSObject>
/**
 *  初始视图
 */
- (void)ELSinitConfingViews;

/**
 *  配置信号数据
 */
-(void)ELSConfigSignalDataSoucre;

/**
 *  配置数据
 */
-(void)InitDataWithModel:(ELBaseModel *)model;

/**
 *  获取高度
 */
+(CGFloat)getCellHeight:(ELBaseModel *)model;
@end

NS_ASSUME_NONNULL_END
