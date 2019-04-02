//
//  ELSearchNavigationView.m
//  Eleenoe
//
//  Created by zhanglu on 2019/4/2.
//  Copyright © 2019 FaceBook. All rights reserved.
//

#import "ELSearchNavigationView.h"

#import "ELButtonExtention.h"
@interface ELSearchNavigationView()
@property(nonatomic,strong)ELSearchBarView *searchBarView;
@property(nonatomic,strong)ELButtonExtention *backButton;
@end
@implementation ELSearchNavigationView

-(void)ELSinitConfingViews{
    
    _backButton = ({
        ELButtonExtention *btn = [ELButtonExtention buttonWithType:UIButtonTypeCustom];
        btn.isExpandClick = YES;
        [btn setImage:[UIImage imageNamed:@"navigBarHidden_back"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"navigBarHidden_back"] forState:UIControlStateSelected];
        [btn setImage:[UIImage imageNamed:@"navigBarHidden_back"]  forState:UIControlStateDisabled];
        [btn setImage:[UIImage imageNamed:@"navigBarHidden_back"]  forState:UIControlStateHighlighted];
        btn.adjustsImageWhenHighlighted = NO;
        btn.showsTouchWhenHighlighted = NO;
        [btn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(kSAdap(10));
            make.centerY.mas_equalTo(self);
            make.size.mas_equalTo(CGSizeMake(kSAdap(20), kSAdap_V(30)));
        }];
        btn;
    });
    
    _searchBarView = ({
        ELSearchBarView *btn = [[ELSearchBarView alloc] init];
        btn.backgroundColor = UIColorFromRGB(0xf1f1f1);
        btn.cornerRadius = 5;
        btn.clipsToBounds = YES;
        [self addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.backButton.mas_right).offset(kSAdap(5));
            make.top.mas_equalTo(kSAdap_V(5));
            make.bottom.mas_equalTo(kSAdap_V(-5));
            make.right.mas_equalTo(kSAdap(-5));
        }];
        btn;
    });
}

-(void)backAction:(UIButton*)sender{
    if (self.delegate &&[self.delegate respondsToSelector:@selector(popSearchBarView:)]) {
       [self.delegate popSearchBarView:self];
    }
}
@end
