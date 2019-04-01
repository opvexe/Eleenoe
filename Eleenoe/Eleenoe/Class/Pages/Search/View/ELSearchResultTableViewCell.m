//
//  ELSearchResultTableViewCell.m
//  Eleenoe
//
//  Created by HuiLu on 2019/4/1.
//  Copyright © 2019 FaceBook. All rights reserved.
//

#import "ELSearchResultTableViewCell.h"
@interface ELSearchResultTableViewCell()
@property(nonatomic,strong)UILabel *searchTitle;
@property(nonatomic,strong)UIView *bottonLineView;
@end

@implementation ELSearchResultTableViewCell
+(ELSearchResultTableViewCell *)CellWithTableView:(UITableView *)tableview{
    static NSString *ID =@"ELSearchResultTableViewCell";
    ELSearchResultTableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[ELSearchResultTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.selectionStyle              = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)SYSinitConfingViews{
    self.contentView.backgroundColor   = [UIColor whiteColor];
    _searchTitle = ({
        UILabel *iv = [[UILabel alloc] init];
        iv.textColor = UIColorFromRGB(0x333333);
        iv.font = [UIFont ELPingFangSCRegularFontOfSize:14];
        [self addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.height.mas_equalTo(20);
        }];
        iv;
    });
    
    _bottonLineView = ({
        UIView *iv = [[UIView alloc] init];
        iv.backgroundColor = UIColorFromRGB(0xDBDBDB);
        [self.contentView addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(self.contentView);
            make.height.equalTo(@(0.5));
        }];
        iv;
    });
}
-(void)InitDataWithModel:(ELBaseModel *)model{
    
}
+(CGFloat)getCellHeight:(ELBaseModel *)model{
    return 50;
}

@end
