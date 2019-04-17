//
//  ELMyofascialBottomView.h
//  Eleenoe
//
//  Created by HuiLu on 2019/3/30.
//  Copyright © 2019 FaceBook. All rights reserved.
//

#import "ELBaseView.h"

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, BottomViewClickType) {
    BottomViewClickTypeElectrode,
    BottomViewClickTypeDownload,
};

typedef void(^BottomBlock)(BottomViewClickType type);

@interface ELMyofascialBottomView : ELBaseView

@property(nonatomic,copy)BottomBlock complete;

@end

NS_ASSUME_NONNULL_END
