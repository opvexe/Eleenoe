//
//  ELSearchNavigationView.h
//  Eleenoe
//
//  Created by zhanglu on 2019/4/2.
//  Copyright © 2019 FaceBook. All rights reserved.
//

#import "ELBaseView.h"
#import "ELSearchBarView.h"
NS_ASSUME_NONNULL_BEGIN
@class ELSearchNavigationView;
@protocol ELSearchNavigationViewDelegate <NSObject>
@optional

-(void)popSearchBarView:(ELSearchNavigationView*)searchBarView ;

@end


@interface ELSearchNavigationView : ELBaseView

@property(nonatomic,weak)id<ELSearchNavigationViewDelegate>delegate;
@property(nonatomic,strong,readonly)ELSearchBarView *searchBarView;
@end

NS_ASSUME_NONNULL_END
