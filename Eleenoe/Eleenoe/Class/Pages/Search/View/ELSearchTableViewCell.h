//
//  ELSearchTableViewCell.h
//  Eleenoe
//
//  Created by HuiLu on 2019/4/1.
//  Copyright © 2019 FaceBook. All rights reserved.
//

#import "ELBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN
@class ELSearchTableViewCell;
@protocol ELSearchTableViewCellDelegate <NSObject>
@optional
- (void)cell:(ELSearchTableViewCell *)cell didSelectRowAtModel:(ELBaseModel *)model;
@end


@interface ELSearchTableViewCell : ELBaseTableViewCell

@property(nonatomic,weak)id<ELSearchTableViewCellDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
