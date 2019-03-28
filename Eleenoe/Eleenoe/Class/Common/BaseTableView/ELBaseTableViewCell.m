//
//  ELBaseTableViewCell.m
//  Eleenoe
//
//  Created by FaceBook on 2019/3/12.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import "ELBaseTableViewCell.h"

@implementation ELBaseTableViewCell

+(id)CellWithTableView:(UITableView *)tableview{
    return nil;
};

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle  = UITableViewCellSelectionStyleNone;
        
        [self ELSinitConfingViews];
        [self ELSConfigSignalDataSoucre];
    }
    return  self ;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    
    [self ELSinitConfingViews];
    [self ELSConfigSignalDataSoucre];
}

- (void)ELSConfigSignalDataSoucre {
    
}

- (void)ELSinitConfingViews {
    _bottomlineView = ({
        UIView *iv = [[UIView alloc] init];
        iv.backgroundColor = MainGrayBorderColor;
        [self.contentView addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0.5);
            make.bottom.mas_equalTo(self.contentView.mas_bottom);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
        }];
        iv;
    });
}

- (void)InitDataWithModel:(nonnull ELBaseModel *)model {
    
}

+ (CGFloat)getCellHeight:(nonnull ELBaseModel *)model {
    return 0.0;
}



@end
