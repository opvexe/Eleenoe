//
//  ELMyofascialBottomView.h
//  Eleenoe
//
//  Created by HuiLu on 2019/3/30.
//  Copyright © 2019 FaceBook. All rights reserved.
//

#import "ELBaseView.h"

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, MyofascialBottomActionType) {
    MyofascialBottomActionTypeHandle, //操作
    MyofascialBottomActionTypeBluetooth,//蓝牙
};

typedef void(^BottomBlock)(MyofascialBottomActionType type,UIButton *sender);

@interface ELMyofascialBottomView : ELBaseView

/** 电极视图 ** */
@property(nonatomic,strong)UIView *rightContentView;

@property(nonatomic,copy)BottomBlock complete;

/** 更新蓝牙状态 图标 */
-(void)updateBluetoothStatus:(BOOL)isOpen;

@end

NS_ASSUME_NONNULL_END
