//
//  ELMyofascialPickView.h
//  Eleenoe
//
//  Created by FaceBook on 2019/4/18.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import "ELBaseView.h"
#import "ELMyofascialContentModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ELMyofascialPickView : ELBaseView

-(void)InitDataSouce:(NSArray *)souce;


@property(nonatomic,copy)void(^MyofascialPickBlock)(ELMyofascialPickView *pickview,NSInteger index,ELMyofascialContentListModel *model);

@end

NS_ASSUME_NONNULL_END
