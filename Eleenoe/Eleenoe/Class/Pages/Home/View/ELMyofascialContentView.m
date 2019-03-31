//
//  ELMyofascialContentView.m
//  Eleenoe
//
//  Created by HuiLu on 2019/3/30.
//  Copyright © 2019 FaceBook. All rights reserved.
//

#import "ELMyofascialContentView.h"

@interface ELMyofascialContentView()
@property(nonatomic,strong)UIImageView *contentImageView;
@end

@implementation ELMyofascialContentView
-(void)ELSinitConfingViews{
    _contentImageView = ({
        UIImageView *iv = [[UIImageView alloc]init];
        iv.clipsToBounds = YES;
        UIImage *icon  = [UIImage imageNamed:@"mysofac_body"];
        iv.image = icon ;
        [self addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.top.mas_equalTo(kSAdap_V(30.0));
            make.size.mas_equalTo(icon.size);
        }];
        iv;
    });
    
}
@end
