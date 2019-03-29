//
//  ELBluetoothConnectionFloatingView.m
//  Eleenoe
//
//  Created by zhanglu on 2019/3/29.
//  Copyright © 2019 FaceBook. All rights reserved.
//

#import "ELBluetoothConnectionFloatingView.h"
#import <KLCPopup.h>

@interface ELBluetoothConnectionFloatingView()
@property(nonatomic,strong) KLCPopup *popup;
@property(nonatomic,copy)void(^CompleteBlock)(ConnectionStatusType);
@end
@implementation ELBluetoothConnectionFloatingView
+(instancetype)showComplete:(void(^)(ConnectionStatusType))complete{
    
    ELBluetoothConnectionFloatingView *view = [[ELBluetoothConnectionFloatingView alloc] initWithFrame:CGRectZero];
    
    KLCPopup *popup = [KLCPopup popupWithContentView:view
                                            showType:KLCPopupShowTypeSlideInFromBottom
                                         dismissType:KLCPopupDismissTypeSlideOutToBottom
                                            maskType:KLCPopupMaskTypeDimmed
                            dismissOnBackgroundTouch:YES
                               dismissOnContentTouch:NO];
    
    [popup  show];
    
    view.CompleteBlock = complete;
    
    view.popup = popup;
    
    return view;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    frame = CGRectMake(0, 0, SCREEN_WIDTH, 100);
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}
-(void)setupViews{
    
    
}
+(void)updateStatus:(ConnectionStatusType)status{
    
    
}

@end
