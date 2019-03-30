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
        UIImage *icon  = [UIImage imageNamed:@"MyofascialTimeIcon"];
        iv.image = icon ;
        [self addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.bottom.mas_equalTo(0);
            make.centerX.mas_equalTo(self);
            make.width.mas_equalTo(kSAdap(119));
        }];
        iv;
    });
    
}
@end
