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
@property(nonatomic,strong) FLAnimatedImageView *bluetoothImageView;
@property(nonatomic,strong) UILabel *statueLabel;
@property(nonatomic,strong) UIButton *closeButton;
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
    frame = CGRectMake(0, 0, SCREEN_WIDTH, 80.0);
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}
-(void)setupViews{
    
    self.backgroundColor = [UIColor whiteColor];
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, 80.0) byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(15.0f, 15.0f)];
    CAShapeLayer *layer =[[CAShapeLayer alloc] init];
    [layer setPath:path.CGPath];
    self.layer.mask = layer;
    
    _bluetoothImageView = ({
        FLAnimatedImageView *iv = [[FLAnimatedImageView alloc]initWithFrame:CGRectZero];
        iv.clipsToBounds = YES;
        iv.image = [UIImage imageNamed:@"blueBloth_close"];
        iv.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kSAdap(15.0), kSAdap_V(17.0)));
            make.left.mas_equalTo(kSAdap(20.0));
            make.centerY.mas_equalTo(self);
        }];
        iv;
    });
    
    _statueLabel = ({
        UILabel *iv = [[UILabel alloc]init];
        iv.textColor = MainBlackTitleColor;
        iv.textAlignment = NSTextAlignmentCenter;
        [iv setFont:[UIFont ELPingFangSCRegularFontOfSize:kSaFont(14.0)]];
        [self addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.bluetoothImageView);
            make.left.mas_equalTo(self.bluetoothImageView.mas_right).mas_offset(kSAdap(10.0));
            make.height.mas_equalTo(kSAdap_V(20.0));
        }];
        iv;
    });
    
    _closeButton = ({
        UIButton *iv = [UIButton buttonWithType:UIButtonTypeCustom];
        [iv setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [iv setImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
        iv.adjustsImageWhenHighlighted =NO;
        iv.showsTouchWhenHighlighted =NO;
        [iv addTarget:self action:@selector(Click:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kSAdap(19.0), kSAdap_V(19.0)));
            make.centerY.mas_equalTo(self.statueLabel);
            make.right.mas_equalTo(kSAdap(20.0));
        }];
        iv;
    });
}

+(void)updateStatus:(ConnectionStatusType)status{
    switch (status) {
        case ConnectionStatusTypeNone:{
            
        }
            break;
        case ConnectionStatusTypeLoading:{
            
        }
            break;
        case ConnectionStatusTypeFailure:{
            
        }
            break;
        case ConnectionStatusTypeSuccess:{
            
        }
            break;
        default:
            break;
    }
}

#pragma mark - 关闭
-(void)Click:(UIButton *)sender{
    
}

@end
