//
//  ELMyofascialContentModel.h
//  Eleenoe
//
//  Created by FaceBook on 2019/4/17.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import "ELBaseModel.h"

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, MyofascialContentType) {
    MyofascialContentTypeRelax, //放松
    MyofascialContentTypeAnadesma, //筋膜
    MyofascialContentTypePains, //疼痛
    MyofascialContentTypeDamage, //损伤
};

@interface ELMyofascialContentModel : ELBaseModel
/**
 *  是否显示
 */
@property(nonatomic,assign)BOOL isShow;
/**
 *  疼痛
 */
@property(nonatomic,strong)NSArray *pains;
/**
 *  类型
 */
@property(nonatomic,assign)MyofascialContentType MyofascialType;

@end

@interface ELMyofascialContentListModel : ELBaseModel
/**
 *  标题
 */
@property(nonatomic,copy)NSString *title;
/**
 *  图片
 */
@property(nonatomic,copy)NSString *selectedImageName;
/**
 *  选中
 */
@property (nonatomic, assign) BOOL choose;
/**
 *  跑马灯
 */
@property(nonatomic,strong)NSString *ads;

@end

NS_ASSUME_NONNULL_END
