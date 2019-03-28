//
//  ELBaseTableViewCell.h
//  Eleenoe
//
//  Created by FaceBook on 2019/3/12.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ELBaseTableViewCellProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@interface ELBaseTableViewCell : UITableViewCell<ELBaseTableViewCellProtocol>

/**
 *  自定义Cell
 */
+(id)CellWithTableView:(UITableView *)tableview;

/**
 * 
 */
@property(nonatomic,strong)UIView *bottomlineView;
@end

NS_ASSUME_NONNULL_END
