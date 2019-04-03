//
//  ELMyofascialContentView.m
//  Eleenoe
//
//  Created by HuiLu on 2019/3/30.
//  Copyright © 2019 FaceBook. All rights reserved.
//

#import "ELMyofascialContentView.h"
#import "ELPickerContainerView.h"
#import "ELMarqueLabel.h"
@interface ELMyofascialContentView()
@property(nonatomic,strong)UIImageView *contentImageView;
@property(nonatomic,strong) ELPickerContainerView *bodyListView;
@property(nonatomic,strong) ELPickerContainerView *rankListView;
@property(nonatomic,strong) ELMarqueLabel *marqueLabel;
@property (nonatomic,strong) UIView *bodyCircleView;
@property (nonatomic,strong) UIView *rankCircleView;
@end

@implementation ELMyofascialContentView
-(void)ELSinitConfingViews{
    
    _marqueLabel = ({
        ELMarqueLabel *iv = [[ELMarqueLabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30) font:[UIFont ELPingFangSCRegularFontOfSize:kSaFont(12)] textColor:MainThemColor];
        iv.backgroundColor = MainLightThemColor;
        [self addSubview:iv];
        iv;
    });
    
    self.marqueLabel.text = @"【四级】明显痛，如被人打耳光，或者被热水烫了一引发的一度烫伤。一引发的一度烫伤。一引发的一度烫伤。";
    
    _contentImageView = ({
        UIImageView *iv = [[UIImageView alloc]init];
        iv.clipsToBounds = YES;
        UIImage *icon  = [UIImage imageNamed:@"mysofac_body"];
        iv.contentMode = UIViewContentModeScaleAspectFill;
        iv.image = icon ;
        [self addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.top.mas_equalTo(kSAdap_V(40));
            make.size.mas_equalTo(icon.size);
        }];
        iv;
    });
    
    _bodyListView = ({
        ELPickerContainerView *iv = [[ELPickerContainerView alloc]initWithFrame:CGRectZero itemsSize:CGSizeMake(kSAdap(60), kSAdap_V(32))];
        iv.backgroundColor = [UIColor clearColor];
        [self addSubview:iv];
//        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(kSAdap_V(55.0));
//            make.right.mas_equalTo(-kSAdap(15));
//            make.bottom.mas_equalTo(-kSAdap_V(52));
//            make.width.mas_equalTo(kSAdap(80));
//        }];
        iv;
    });
    
//    _rankListView = ({
//        ELBodyPickerView *iv = [[ELBodyPickerView alloc]init];
////        iv.forceItemTypeText = YES;
////        iv.selectionIndicatorStyle = STDPickerViewSelectionIndicatorStyleNone;
////        iv.showVerticalDivisionLine = NO;
//        [self addSubview:iv];
//        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(kSAdap_V(55.0));
//            make.left.mas_equalTo(kSAdap(15));
//            make.bottom.mas_equalTo(-kSAdap_V(52));
//            make.width.mas_equalTo(kSAdap(80));
//        }];
//        iv;
//    });
    
    
//    _bodyCircleView = ({
//        UIView *iv = [[UIView alloc] init];
//        [self addSubview:iv];
//        iv.cornerRadius = kSAdap(14);
//        iv.clipsToBounds = YES;
//        iv.userInteractionEnabled = YES;
//        iv.layer.borderColor = [UIColor whiteColor].CGColor;
//        iv.layer.borderWidth = 1;
//        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.height.mas_equalTo(kSAdap_V(28));
//            make.width.mas_equalTo(kSAdap(55));
//            make.centerY.mas_equalTo(self.bodyListView).mas_offset(-kSAdap(31));
//            make.centerX.mas_equalTo(self.bodyListView);
//        }];
//        iv;
//    });
//
//    _rankCircleView = ({
//        UIView *iv = [[UIView alloc] init];
//        [self addSubview:iv];
//        iv.cornerRadius = kSAdap(14);
//        iv.clipsToBounds = YES;
//        iv.layer.borderColor = [UIColor whiteColor].CGColor;
//        iv.layer.borderWidth = 1;
//        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.height.mas_equalTo(kSAdap_V(28));
//            make.width.mas_equalTo(kSAdap(55));
//            make.centerY.mas_equalTo(self.rankListView).mas_offset(kSAdap(15));
//            make.centerX.mas_equalTo(self.rankListView);
//        }];
//        iv;
//    });
    
//    [self sendSubviewToBack:self.rankCircleView];
//    [self sendSubviewToBack:self.bodyCircleView];
}

@end
