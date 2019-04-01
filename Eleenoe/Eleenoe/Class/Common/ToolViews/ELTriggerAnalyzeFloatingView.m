//
//  ELTriggerAnalyzeFloatingView.m
//  Eleenoe
//
//  Created by FaceBook on 2019/3/31.
//  Copyright © 2019 FaceBook. All rights reserved.
//

#import "ELTriggerAnalyzeFloatingView.h"
#import "UIButton+ButtonStyle.h"
#import <KLCPopup.h>
@interface ELTriggerAnalyzeFloatingView()
@property(nonatomic,strong) KLCPopup *popup;
@property(nonatomic,copy)void(^CompleteBlock)(ELBaseModel *model);
@property(nonatomic,strong) FLAnimatedImageView *triggerImageView;
@property(nonatomic,strong) UIView *analyzeView;
@property(nonatomic,strong) UIButton *downloadButton;
@property(nonatomic,strong) UIButton *close;
@property (nonatomic,strong) ELBaseModel *model;
@property (nonatomic,strong) UILabel *analyzeLabel;
@property (nonatomic,strong) UILabel *treatLabel;
@property (nonatomic,strong) UILabel *placeLabel;
@property (nonatomic,strong) UILabel *contentLabel;
@end
@implementation ELTriggerAnalyzeFloatingView

+ (instancetype)showInitDataModel:(ELBaseModel *)model Complete:(void(^)(ELBaseModel *model))complete{
    
    ELTriggerAnalyzeFloatingView *view = [[ELTriggerAnalyzeFloatingView alloc] initWithFrame:CGRectZero];
    
    KLCPopup *popup = [KLCPopup popupWithContentView:view
                                            showType:KLCPopupShowTypeSlideInFromBottom
                                         dismissType:KLCPopupDismissTypeSlideOutToBottom
                                            maskType:KLCPopupMaskTypeDimmed
                            dismissOnBackgroundTouch:YES
                               dismissOnContentTouch:NO];
    
    [popup  showWithLayout:KLCPopupLayoutMake(KLCPopupHorizontalLayoutCenter, KLCPopupVerticalLayoutBottom)];
    
    view.CompleteBlock = complete;
    
    view.popup = popup;
    
    view.model = model;
    
    return view;
}

- (instancetype)initWithFrame:(CGRect)frame{
    frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-kSAdap(82) - iPhone_X_Navigation_Bar_Heigth);
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupViews];
    }
    return self;
}

-(void)setupViews{
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, SCREEN_HEIGHT-kSAdap(82) - iPhone_X_Navigation_Bar_Heigth) byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(15.0f, 15.0f)];
    CAShapeLayer *layer =[[CAShapeLayer alloc] init];
    [layer setPath:path.CGPath];
    self.layer.mask = layer;
    
    _close = ({
        UIButton *iv = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *icon = [UIImage imageNamed:@"shop_close"];
        [iv setImage:icon forState:UIControlStateNormal];
        [iv setImage:icon forState:UIControlStateSelected];
        [iv setImage:icon forState:UIControlStateHighlighted];
        [iv addTarget:self action:@selector(Click:) forControlEvents:UIControlEventTouchUpInside];
        iv.tag = TriggerAnalyzeTypeClose;
        [self addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-kSAdap(15.0));
            make.top.mas_equalTo(kSAdap_V(15.0));
            make.size.mas_equalTo(icon.size);
        }];
        iv;
    });
    
    _triggerImageView = ({
        FLAnimatedImageView *iv = [[FLAnimatedImageView alloc]initWithFrame:CGRectZero];
        UIImage *icon  = [UIImage imageNamed:@"body_main"];
        iv.image = icon ;
        [self addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(kSAdap_V(30.0));
            make.centerX.mas_equalTo(self);
            make.size.mas_equalTo(icon.size);
        }];
        iv;
    });
    
    _analyzeView = ({
        UIView *iv = [[UIView alloc]init];
        iv.backgroundColor = [UIColor colorWithRed:249.0/255.0f green:254.0/255.0f blue:236.0/255.0f alpha:1.0];
        iv.layer.borderColor = MainThemColor.CGColor;
        iv.layer.borderWidth = 0.5f;
        iv.cornerRadius = kSAdap(12);
        [self addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(kSAdap(20.0));
            make.right.mas_equalTo(-kSAdap(20));
            make.top.mas_equalTo(self.triggerImageView.mas_bottom).mas_offset(kSAdap_V(32.0));
            make.height.mas_equalTo(kSAdap_V(120));
        }];
        iv;
    });
    
    _analyzeLabel = ({
        UILabel *iv = [[UILabel alloc]init];
        iv.text = @"成因分析";
        iv.textColor = MainThemColor;
        iv.textAlignment = NSTextAlignmentLeft;
        iv.font = [UIFont ELPingFangSCRegularFontOfSize:kSaFont(14)];
        [self.analyzeView addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(kSAdap(12));
            make.top.mas_equalTo(kSAdap_V(10));
            make.width.mas_equalTo(kSaFont(60));
            make.height.mas_equalTo(kSAdap_V(20));
        }];
        iv;
    });
    
    _treatLabel = ({
        UILabel *iv = [[UILabel alloc]init];
        iv.text = @"治疗原则";
        iv.textColor = UIColorFromRGB(0x666666);
        iv.textAlignment = NSTextAlignmentLeft;
        iv.font = [UIFont ELPingFangSCRegularFontOfSize:kSaFont(14)];
        [self.analyzeView addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.analyzeLabel.mas_right).mas_offset(kSAdap(25));
            make.top.mas_equalTo(self.analyzeLabel);
            make.width.mas_equalTo(kSaFont(60));
            make.height.mas_equalTo(kSAdap_V(20));
        }];
        iv;
    });
    
    _treatLabel = ({
        UILabel *iv = [[UILabel alloc]init];
        iv.text = @"扳机点位置";
        iv.textColor = UIColorFromRGB(0x666666);
        iv.textAlignment = NSTextAlignmentLeft;
        iv.font = [UIFont ELPingFangSCRegularFontOfSize:kSaFont(14)];
        [self.analyzeView addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.treatLabel.mas_right).mas_offset(kSAdap(25));
            make.top.mas_equalTo(self.analyzeLabel);
            make.width.mas_equalTo(kSaFont(80));
            make.height.mas_equalTo(kSAdap_V(20));
        }];
        iv;
    });
    
    UIView *spliteLine = [[UIView alloc] init];
    spliteLine.backgroundColor = MainThemColor;
    [self.analyzeView addSubview:spliteLine];
    [spliteLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kSAdap(12));
        make.right.mas_equalTo(-kSAdap(12));
        make.height.mas_equalTo(0.5);
        make.top.mas_equalTo(self.analyzeLabel.mas_bottom).mas_offset(kSAdap_V(5));
    }];
    
    _contentLabel = ({
        UILabel *iv = [[UILabel alloc]init];
        iv.numberOfLines = 0;
        iv.textColor = MainThemColor;
        iv.textAlignment = NSTextAlignmentLeft;
        iv.font = [UIFont ELPingFangSCRegularFontOfSize:kSaFont(12)];
        [iv sizeToFit];
        iv.text = @"在电脑或办公桌保持一个姿势或从事体力劳动，进行大量运动等导致腰部过度劳累而引起。";
        [self.analyzeView addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(kSAdap(12));
            make.right.mas_equalTo(-kSAdap(12));
            make.top.mas_equalTo(self.analyzeLabel.mas_bottom).mas_offset(kSAdap_V(14));
        }];
        iv;
    });
    
    
    _downloadButton = ({
        UIButton *iv = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *icon = [UIImage imageNamed:@"home_download"];
        [iv setImage:icon forState:UIControlStateNormal];
        [iv setImage:icon forState:UIControlStateSelected];
        [iv setImage:icon forState:UIControlStateHighlighted];
        [iv setTitle:@"程序下载" forState:UIControlStateNormal];
        [iv setTitle:@"程序下载" forState:UIControlStateSelected];
        [iv setTitle:@"程序下载" forState:UIControlStateHighlighted];
        [iv setTitleColor:MainThemColor forState:UIControlStateNormal];
        [iv setTitleColor:MainThemColor forState:UIControlStateSelected];
        [iv setTitleColor:MainThemColor forState:UIControlStateHighlighted];
        iv.adjustsImageWhenHighlighted =NO;
        iv.showsTouchWhenHighlighted =NO;
        [iv.titleLabel setFont:[UIFont ELPingFangSCRegularFontOfSize:kSaFont(16.0)]];
        [iv addTarget:self action:@selector(Click:) forControlEvents:UIControlEventTouchUpInside];
        [iv layoutTextWithImageButtonStyle:layoutTextRightImageButton withSpace:5.0];
        iv.tag = TriggerAnalyzeTypeDownload;
        [self addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.bottom.mas_equalTo(-kSAdap_V(45));
            make.width.mas_equalTo(kSAdap(120));
            make.height.mas_equalTo(kSAdap_V(25));
        }];
        iv;
    });
}

-(void)Click:(UIButton *)sender{
    switch (sender.tag) {
        case TriggerAnalyzeTypeClose:{
            [self dismiss];
        }
            break;
        case TriggerAnalyzeTypeDownload:{
            if (self.CompleteBlock) {
                self.CompleteBlock(_model);
            }
        }
            break;
        default:
            break;
    }
}

- (void)dismiss {
    [self.popup dismiss:YES];
}

@end
