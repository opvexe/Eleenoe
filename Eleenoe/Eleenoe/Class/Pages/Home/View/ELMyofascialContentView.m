//
//  ELMyofascialContentView.m
//  Eleenoe
//
//  Created by HuiLu on 2019/3/30.
//  Copyright © 2019 FaceBook. All rights reserved.
//

#import "ELMyofascialContentView.h"
#import "ELMyofascialPickView.h"
#import "ELMyofascialContentModel.h"
#import "ELPickerContainerView.h"
#import "ELMarqueLabel.h"
@interface ELMyofascialContentView()
@property(nonatomic,strong)UIImageView *contentImageView;
@property(nonatomic,strong) ELMyofascialPickView *bodyListView;
@property(nonatomic,strong) ELMyofascialPickView *rankListView;
@property(nonatomic,strong) ELMarqueLabel *marqueLabel;
@property(nonatomic,strong) ELMyofascialContentModel *model;
@property(nonatomic,assign)NSInteger atIndex;
@end

@implementation ELMyofascialContentView
-(void)ELSinitConfingViews{
    
    _marqueLabel = ({
        ELMarqueLabel *iv = [[ELMarqueLabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30) font:[UIFont ELPingFangSCRegularFontOfSize:kSaFont(12)] textColor:MainThemColor];
        iv.backgroundColor = MainLightThemColor;
        [self addSubview:iv];
        iv;
    });
    
    _contentImageView = ({
        UIImageView *iv = [[UIImageView alloc]init];
        iv.clipsToBounds = YES;
        UIImage *icon  = [UIImage imageNamed:@"mysofac_newbody"];
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
        ELMyofascialPickView *iv = [[ELMyofascialPickView alloc]init];
        iv.backgroundColor = [UIColor clearColor];
        [self addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-kSAdap(15));
            make.top.mas_equalTo(kSAdap_V(60));
            make.width.mas_equalTo(kSAdap(60));
            make.height.mas_equalTo(kSAdap_V(210));
        }];
        iv;
    });
    
//    self.bodyListView.selectedIndex = 5;
    
//    _bodyListView = ({
//        ELPickerContainerView *iv = [[ELPickerContainerView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-kSAdap(70), kSAdap_V(60), kSAdap(55), kSAdap_V(210)) itemsSize:CGSizeMake(kSAdap(60), kSAdap_V(32))];
//        iv.backgroundColor = [UIColor clearColor];
//        [self addSubview:iv];
//        iv;
//    });
    
    _rankListView = ({
        ELMyofascialPickView *iv = [[ELMyofascialPickView alloc]init];
        iv.backgroundColor = [UIColor clearColor];
        [self addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(kSAdap(15));
            make.top.mas_equalTo(kSAdap_V(60));
            make.width.mas_equalTo(kSAdap(50));
            make.height.mas_equalTo(kSAdap_V(210));
        }];
        iv;
    });
    
//    @weakify(self);
//    self.bodyListView.ContainerChioceBlock = ^(ELPickerContainerView * _Nonnull pickview, NSInteger index, ELMyofascialContentListModel * _Nonnull model) {
//        @strongify(self);
//        self.contentImageView.image = ELImageNamed(model.selectedImageName);
//        [ELNotificationCenter postNotificationName:TriggerAnalyzeNotificationCenter object:nil userInfo:@{@"model":model}];
//    };
    
//    self.rankListView.ContainerChioceBlock = ^(ELPickerContainerView * _Nonnull pickview, NSInteger index, ELMyofascialContentListModel * _Nonnull model) {
//        @strongify(self);
//        self.marqueLabel.text = model.ads;
//    };
}

-(void)InitDataWithModel:(ELMyofascialContentModel *)model{
     _model = model;
    [self.rankListView setHidden:!model.isShow];
    [self.marqueLabel setHidden:!model.isShow];
    [self.bodyListView InitDataSouce:model.datas];
    if (model.isShow) {
        [self.rankListView InitDataSouce:model.pains];
    }
}

@end
