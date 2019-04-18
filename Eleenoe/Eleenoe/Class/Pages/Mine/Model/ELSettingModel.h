//
//  ELSeetingModel.h
//  Eleenoe
//
//  Created by FaceBook on 2019/3/28.
//  Copyright © 2019 FaceBook. All rights reserved.
//

#import "ELBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, WDSettingItemType) {
    WDSettingItemTypeNone,  // 默认
    WDSettingItemTypeArrow, // 箭头
    WDSettingItemTypeSwitch, // 开关
};

@interface ELSettingModel : ELBaseModel
/**
 * 头部（标题）
 */
@property (nonatomic, copy) NSString *header;
/**
 * 尾部 (标题)
 */
@property (nonatomic, copy) NSString *footer;
/**
 * 标题
 */
@property (nonatomic, copy) NSString *title;
/**
 * 图标（左侧）
 */
@property (nonatomic, copy) NSString *icon;
/**
 * 右侧 类型
 */
@property (nonatomic, assign) WDSettingItemType itemType;
/**
 * 跳转地址
 */
@property(nonatomic,copy)NSString *url;

@end

NS_ASSUME_NONNULL_END
