//
//  ELTriggerAnalyzeFloatingView.h
//  Eleenoe
//
//  Created by FaceBook on 2019/3/31.
//  Copyright © 2019 FaceBook. All rights reserved.
//

#import "ELBaseView.h"

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, TriggerAnalyzeType) {
    TriggerAnalyzeTypeClose,
    TriggerAnalyzeTypeDownload,
};

@interface ELTriggerAnalyzeFloatingView : ELBaseView

+ (instancetype)showInitDataModel:(ELBaseModel *)model Complete:(void(^)(ELBaseModel *model))complete;

@end

NS_ASSUME_NONNULL_END
