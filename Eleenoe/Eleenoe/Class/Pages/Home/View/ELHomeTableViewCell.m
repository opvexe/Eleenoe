//
//  ELHomeTableViewCell.m
//  Eleenoe
//
//  Created by HuiLu on 2019/3/30.
//  Copyright © 2019 FaceBook. All rights reserved.
//

#import "ELHomeTableViewCell.h"

@implementation ELHomeTableViewCell
+(ELHomeTableViewCell *)CellWithTableView:(UITableView *)tableview{
    
    static NSString *ID =@"ELHomeTableViewCell";
    
    ELHomeTableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[ELHomeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
    }
    return cell;
}
@end
