//
//  ELSearchTableViewCell.m
//  Eleenoe
//
//  Created by HuiLu on 2019/4/1.
//  Copyright © 2019 FaceBook. All rights reserved.
//

#import "ELSearchTableViewCell.h"
#import "SLTagView.h"
#import "ELSearchModel.h"
@interface ELSearchTableViewCell()<SLTagViewDelegate>
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)SLTagView *tagView;
@property(nonatomic,strong)ELSearchModel *model;
@end
@implementation ELSearchTableViewCell
+(ELSearchTableViewCell *)CellWithTableView:(UITableView *)tableview{
    static NSString *ID =@"ELSearchTableViewCell";
    ELSearchTableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[ELSearchTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

-(void)ELSinitConfingViews{
    _titleLabel= ({
        UILabel *iv = [[UILabel alloc] init];
        iv.font = [UIFont ELPingFangSCRegularFontOfSize:12];
        iv.textColor = MainTitleColor;
        [self.contentView addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(10);
            make.right.mas_equalTo(-15);
            make.height.mas_equalTo(20);
        }];
        iv;
    });
    
    _tagView = ({
        SLTagView *iv = [[SLTagView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, 0)];
        [self.contentView addSubview:iv];
        iv.tagFont = [UIFont ELPingFangSCRegularFontOfSize:12];;
        iv.tagSelectedFont = [UIFont ELPingFangSCRegularFontOfSize:12];
        iv.tagHeight = 25;
        iv.allowsSelection = YES;
        iv.allowsMultipleSelection  = NO;
        iv.contenBGColor  = [UIColor whiteColor];
        iv.tagNormaBackgroundlColor  = [UIColor whiteColor];
        iv.tagSelectedBackgroundColor  = [UIColor whiteColor];
        iv.tagSelectedTextColor  =  UIColorFromRGB(0x848484);
        iv.tagNormaTextColor  = UIColorFromRGB(0x848484);
        iv.tagSelectedBoaderColor  = UIColorFromRGB(0xf1f1f1);
        iv.tagNormalBoaderColor  =  UIColorFromRGB(0xf1f1f1);
        iv.tagBorderWidth  = 0.5;
        iv.tagcornerRadius  = 5;
        iv.longPressMove = NO;
        iv.delegate  = self;
        iv.backgroundColor = [UIColor whiteColor];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(self.titleLabel.mas_bottom);
            make.bottom.mas_equalTo(0);
            make.right.mas_equalTo(0);
        }];
        iv;
    });
}
-(void)tagView:(SLTagView *)tagView didSelectTagAtIndex:(NSUInteger)index{
   
}
-(void)InitDataWithModel:(ELSearchModel *)model{
    self.titleLabel.text = model.title;
    self.model = model;
    NSMutableArray *tags = [NSMutableArray arrayWithCapacity:0];
    [model.dataSoucre enumerateObjectsUsingBlock:^(ELSearchModel  * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [tags addObject:convertToString(obj.title)];
    }];
    self.tagView.tags = tags.copy;
}

+(CGFloat)getCellHeight:(ELSearchModel *)model{
    SLTagView *iv = [[SLTagView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, 0)];
    iv.tagFont = [UIFont ELPingFangSCRegularFontOfSize:12];
    iv.tagSelectedFont = [UIFont ELPingFangSCRegularFontOfSize:12];
    iv.tagHeight = 25;
    NSMutableArray *tags = [NSMutableArray arrayWithCapacity:0];
    [model.dataSoucre enumerateObjectsUsingBlock:^(ELSearchModel  * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [tags addObject:convertToString(obj.title)];
    }];
    iv.tags =  tags.copy;
    return  35 + [iv contentHeigth];
}
@end
