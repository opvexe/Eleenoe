//
//  ELBluetoothConnectionFloatingView.m
//  Eleenoe
//
//  Created by zhanglu on 2019/3/29.
//  Copyright © 2019 FaceBook. All rights reserved.
//

#import "ELBluetoothConnectionFloatingView.h"
#import "ELBlueToothManager.h"
#import "ELButtonExtention.h"
#import <MLEmojiLabel.h>
@interface ELBluetoothConnectionFloatingView()<MLEmojiLabelDelegate>
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
                            dismissOnBackgroundTouch:NO
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
            make.left.mas_lessThanOrEqualTo(kSAdap(78.0));
            make.centerY.mas_equalTo(self);
        }];
        iv;
    });
    
    _closeButton = ({
        ELButtonExtention *iv = [ELButtonExtention buttonWithType:UIButtonTypeCustom];
        UIImage *icon = [UIImage imageNamed:@"shop_close"];
        [iv setImage:icon forState:UIControlStateNormal];
        [iv setImage:icon forState:UIControlStateSelected];
        [iv setImage:icon forState:UIControlStateHighlighted];
        iv.adjustsImageWhenHighlighted = NO;
        iv.showsTouchWhenHighlighted = NO;
        iv.isExpandClick = YES;
        [iv addTarget:self action:@selector(CloseAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(icon.size);
            make.centerY.mas_equalTo(self.bluetoothImageView);
            make.right.mas_equalTo(-kSAdap(15));
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
        iv.delegate = self;
        iv.shadowOffset = CGSizeMake(0.0f, 1.0f);
        iv.maximumLineHeight = contenFont.lineHeight;
        iv.minimumLineHeight = contenFont.lineHeight;
        iv.lineSpacing = kSAdap(2);
        iv.customEmojiRegex = @"#";
        iv.lineBreakMode = NSLineBreakByCharWrapping;
        iv.isNeedAtAndPoundSign = YES;
        [iv setLinkColor:MainThemColor];
        [self addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.bluetoothImageView);
            make.left.mas_equalTo(self.bluetoothImageView.mas_right).mas_offset(kSAdap(10.0));
            make.height.mas_equalTo(kSAdap_V(20.0));
            make.right.mas_lessThanOrEqualTo(self.closeButton.mas_left).mas_offset(-kSAdap(10));
        }];
        iv;
    });
    
}

-(void)updateStatus:(ConnectionStatusType)status{
    switch (status) {
        case ConnectionStatusTypeNone:{
            [_closeButton setHidden:NO];
            _bluetoothImageView.image = ELImageNamed(@"blueBloth_close");
            _statueLabel.text = @"设备当前处于未连接状态、是否 立即连接?";
            [_statueLabel addLinkToURL:[NSURL URLWithString:@"http://connection.com"] withRange:[_statueLabel.text rangeOfString:@"立即连接?"]];
            break;
        }
        case ConnectionStatusTypeLoading:{
            [_closeButton setHidden:YES];
            self.bluetoothImageView.image = ELImageNamed(@"blueBloth_open");
            self.statueLabel.text = @"设备链接中、请稍后...";
            break;
        }
        case ConnectionStatusTypeFailure:{
            [_closeButton setHidden:NO];
            _bluetoothImageView.image = ELImageNamed(@"blueBloth_close");
            _statueLabel.text = @"设备连接失败、是否 重新连接?";
            [_statueLabel addLinkToURL:[NSURL URLWithString:@"http://connection.com"] withRange:[_statueLabel.text rangeOfString:@"重新连接?"]];
            break;
        }
        case ConnectionStatusTypeSuccess:{
            [_closeButton setHidden:YES];
            _bluetoothImageView.image = ELImageNamed(@"blueBloth_close");
            _statueLabel.text = @"设备连接成功...";
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self dismiss];
            });
            break;
        }
        default:
            break;
    }
}

//mark:关闭事件
-(void)CloseAction:(UIButton *)sender{
    [self dismiss];
}

-(void)show{
    [self.popup showWithLayout:KLCPopupLayoutMake(KLCPopupHorizontalLayoutCenter, KLCPopupVerticalLayoutBottom)];
}

//mark: 关闭视图
- (void)dismiss {
    [self.popup dismiss:YES];
}

- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithURL:(NSURL *)url
{
    NSLog(@">>>>立即重连蓝牙：%@",url);
    [[ELBlueToothManager shareInstance]reScanPeripheral];
}
@end
