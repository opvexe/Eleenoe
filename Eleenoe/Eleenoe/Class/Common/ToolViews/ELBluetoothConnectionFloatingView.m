//
//  ELBluetoothConnectionFloatingView.m
//  Eleenoe
//
//  Created by zhanglu on 2019/3/29.
//  Copyright © 2019 FaceBook. All rights reserved.
//

#import "ELBluetoothConnectionFloatingView.h"
#import <KLCPopup.h>
#import "ELButtonExtention.h"
#import <MLEmojiLabel.h>
@interface ELBluetoothConnectionFloatingView()
@property(nonatomic,strong) KLCPopup *popup;
@property(nonatomic,copy)void(^CompleteBlock)(ConnectionStatusType);
@property(nonatomic,strong) FLAnimatedImageView *bluetoothImageView;
@property(nonatomic,strong) MLEmojiLabel *statueLabel;
@property(nonatomic,strong) UIButton *closeButton;
@end
@implementation ELBluetoothConnectionFloatingView
+(instancetype)showComplete:(void(^)(ConnectionStatusType status))complete{
    
    ELBluetoothConnectionFloatingView *view = [[ELBluetoothConnectionFloatingView alloc] initWithFrame:CGRectZero];
    
    KLCPopup *popup = [KLCPopup popupWithContentView:view
                                            showType:KLCPopupShowTypeSlideInFromBottom
                                         dismissType:KLCPopupDismissTypeSlideOutToBottom
                                            maskType:KLCPopupMaskTypeDimmed
                            dismissOnBackgroundTouch:YES
                               dismissOnContentTouch:NO];
    
    [popup  showWithLayout:KLCPopupLayoutMake(KLCPopupHorizontalLayoutCenter, KLCPopupVerticalLayoutBottom)];
    
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
            make.left.mas_equalTo(kSAdap(78.0));
            make.centerY.mas_equalTo(self);
        }];
        iv;
    });
    
    _statueLabel = ({
        MLEmojiLabel *iv = [[MLEmojiLabel alloc] initWithFrame:CGRectZero];
        iv.textColor = MainBlackTitleColor;
        iv.textAlignment = NSTextAlignmentCenter;
        UIFont *contenFont =[UIFont ELPingFangSCRegularFontOfSize:kSaFont(14.0)];
        iv.font = contenFont;
        iv.disableThreeCommon = YES;
        iv.shadowOffset = CGSizeMake(0.0f, 1.0f);
        iv.maximumLineHeight = contenFont.lineHeight;
        iv.minimumLineHeight = contenFont.lineHeight;
        iv.lineSpacing = kSAdap(2);
        iv.customEmojiRegex = @"#";
        iv.lineBreakMode = NSLineBreakByCharWrapping;
        iv.isNeedAtAndPoundSign = YES;
        [iv setLinkColor:MainThemColor];
        iv.text = @"设备连接失败、是#否重新连接?#";
        [self addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.bluetoothImageView);
            make.left.mas_equalTo(self.bluetoothImageView.mas_right).mas_offset(kSAdap(10.0));
            make.height.mas_equalTo(kSAdap_V(20.0));
        }];
        iv;
    });
    
    _closeButton = ({
        ELButtonExtention *iv = [ELButtonExtention buttonWithType:UIButtonTypeCustom];
        [iv setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [iv setImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
        iv.adjustsImageWhenHighlighted = NO;
        iv.showsTouchWhenHighlighted = NO;
        iv.isExpandClick = YES;
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
            
            break;
        }
        case ConnectionStatusTypeLoading:{
            
            break;
        }
        case ConnectionStatusTypeFailure:{
            
            break;
        }
        case ConnectionStatusTypeSuccess:{
            
            break;
        }
        default:
            break;
    }
}

#pragma mark - 关闭
-(void)Click:(UIButton *)sender{
    
}

@end
