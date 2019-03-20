//
//  ELBaseModel.h
//  Eleenoe
//
//  Created by FaceBook on 2019/3/12.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ELBaseModel : NSObject

@property (nonatomic,copy) NSString *ID;

@property(nonatomic,copy)NSString *CellClass;

@property(nonatomic,copy)NSString *ClassName;

@property(nonatomic,strong)NSArray *sections;

@property(nonatomic,strong)NSArray *datas;

@end

NS_ASSUME_NONNULL_END
