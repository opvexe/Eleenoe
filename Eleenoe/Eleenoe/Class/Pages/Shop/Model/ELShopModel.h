//
//  ELShopModel.h
//  Eleenoe
//
//  Created by FaceBook on 2019/3/29.
//  Copyright © 2019 FaceBook. All rights reserved.
//

#import "ELBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ELShopModel : ELBaseModel
/**
 * 商品轮播
 */
@property (nonatomic, strong) NSArray *goods_img;
/**
 * 商品
 */
@property (nonatomic, strong) NSArray *goods_datas;

@end

@interface ELShopContentModel : ELBaseModel
/**
 * 轮播地址
 */
@property (nonatomic, copy) NSString *img_url;
/**
 * 跳转地址
 */
@property (nonatomic, copy) NSString *jump_url;
/**
 * 商品地址
 */
@property (nonatomic, copy) NSString *items_url;
/**
 * 商品描述
 */
@property (nonatomic, copy) NSString *describe_shop;
/**
 * 标题
 */
@property (nonatomic, copy) NSString *title;
/**
 * 商品价格
 */
@property (nonatomic, copy) NSString *price_shop;
@end


NS_ASSUME_NONNULL_END
