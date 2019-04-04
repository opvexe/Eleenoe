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
        iv.image = icon ;
        [self addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.top.mas_equalTo(kSAdap_V(40));
            make.width.mas_equalTo(icon.size.width);
            make.bottom.mas_equalTo(0);
        }];
        iv;
    });
    
    _bodyListView = ({
        ELPickerContainerView *iv = [[ELPickerContainerView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-kSAdap(70), kSAdap_V(60), kSAdap(55), kSAdap_V(210)) itemsSize:CGSizeMake(kSAdap(60), kSAdap_V(32))];
        iv.backgroundColor = [UIColor clearColor];
        [self addSubview:iv];
        iv;
    });
    
    [self.bodyListView selectRow:3 animated:YES];
    
    _rankListView= ({
        ELPickerContainerView *iv = [[ELPickerContainerView alloc]initWithFrame:CGRectMake(kSAdap(15), kSAdap_V(60), kSAdap(55), kSAdap_V(210)) itemsSize:CGSizeMake(kSAdap(60), kSAdap_V(32))];
        iv.backgroundColor = [UIColor clearColor];
        [self addSubview:iv];
        iv;
    });
    [self.rankListView selectRow:3 animated:YES];
}

@end
