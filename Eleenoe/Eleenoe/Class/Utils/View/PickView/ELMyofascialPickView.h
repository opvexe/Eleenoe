//
//  ELMyofascialPickView.h
//  Eleenoe
//
//  Created by FaceBook on 2019/4/18.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import "ELBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ELMyofascialPickView : ELBaseView

//默认选中
@property (assign, nonatomic) NSUInteger selectedIndex;

-(void)InitDataSouce:(NSArray *)souce;
@end

NS_ASSUME_NONNULL_END
