//
//  ELHomeTitleTableCell.m
//  Eleenoe
//
//  Created by HuiLu on 2019/3/30.
//  Copyright © 2019 FaceBook. All rights reserved.
//

#import "ELHomeTitleTableCell.h"

@implementation ELHomeTitleTableCell

+(ELHomeTitleTableCell *)CellWithTableView:(UITableView *)tableview{
    
    static NSString *ID =@"ELHomeTitleTableCell";
    
    ELHomeTitleTableCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[ELHomeTitleTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
    }
    return cell;
}

@end
