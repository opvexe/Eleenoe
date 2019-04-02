//
//  ELSearchListView.h
//  Eleenoe
//
//  Created by HuiLu on 2019/4/1.
//  Copyright © 2019 FaceBook. All rights reserved.
//

#import "ELBaseTableView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ELSearchListView : ELBaseTableView
-(void)refreshDataSyn:(void (^)( BOOL isData))comlete;

-(void)didSelectRowAtModelCompleteBlock:(void(^)(ELSearchListView*listView ,id model))completeBlock;

@end

NS_ASSUME_NONNULL_END
