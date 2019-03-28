//
//  ELMineTableViewCell.m
//  Eleenoe
//
//  Created by FaceBook on 2019/3/28.
//  Copyright © 2019 FaceBook. All rights reserved.
//

#import "ELMineTableViewCell.h"

@interface ELMineTableViewCell()
@property (nonatomic, strong) FLAnimatedImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) FLAnimatedImageView *itemImageView;
@end
@implementation ELMineTableViewCell

+(instancetype)CellWithTableView:(UITableView *)tableview{
    static NSString *ID = @"ELMineTableViewCell";
    ELMineTableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[ELMineTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

-(void)ELSinitConfingViews{
    
    _iconImageView = ({
        FLAnimatedImageView *iv = [[FLAnimatedImageView alloc]init];
        [self.contentView addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(kSAdap(15.0));
            make.centerY.mas_equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(kSAdap(20.0), kSAdap_V(20.0)));
        }];
        iv;
    });
    
    _itemImageView = ({
        FLAnimatedImageView *iv = [[FLAnimatedImageView alloc]init];
        [self.contentView addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(kSAdap(-15.0));
            make.centerY.mas_equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(kSAdap(20.0), kSAdap_V(20.0)));
        }];
        iv;
    });
    
    _titleLabel = ({
        UILabel *iv = [[UILabel alloc]init];
        iv.textColor = [UIColor blackColor];
        iv.numberOfLines = 1;
        iv.textAlignment = NSTextAlignmentLeft;
        [iv setFont:[UIFont ELHelveticaFontOfSize:kSaFont(14.0)]];
        [self.contentView addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.iconImageView.mas_right).mas_offset(kSAdap(8.0));
            make.centerY.mas_equalTo(self.contentView);
            make.right.mas_equalTo(self.itemImageView.mas_left).mas_offset(-kSAdap(8.0));
        }];
        iv;
    });
}

-(void)InitDataWithModel:(ELSettingModel *)model{
    self.iconImageView.image = [UIImage imageNamed:model.icon];
    self.titleLabel.text = model.title;
    if (model.itemType == WDSettingItemTypeArrow) {
        self.itemImageView.image = [UIImage imageNamed:@"setting_enter"];
    }
}

@end
