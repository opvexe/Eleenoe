//
//  ELMyofascialContentView.m
//  Eleenoe
//
//  Created by HuiLu on 2019/3/30.
//  Copyright © 2019 FaceBook. All rights reserved.
//

#import "ELMyofascialContentView.h"
#import "ELMarqueLabel.h"
#import "ELMyofascialMenuScrolloView.h"
#import "ELMyofascialMenuModel.h"
@interface ELMyofascialContentView()
@property(nonatomic,strong)UIImageView *contentImageView;
@property(nonatomic,strong) ELMyofascialMenuScrolloView *bodyListView;
@property(nonatomic,strong) ELMyofascialMenuScrolloView *rankListView;
@property(nonatomic,strong)UIView *bodyCircleView;
@property(nonatomic,strong)UIView *rankCircleView;
@property(nonatomic,strong) ELMarqueLabel *marqueLabel;
@end

@implementation ELMyofascialContentView
-(void)ELSinitConfingViews{
    
    _marqueLabel = ({
        ELMarqueLabel *iv = [[ELMarqueLabel alloc]init];
        iv.backgroundColor = MainLightThemColor;
        iv.text = @"【四级】明显痛，如被人打耳光，或者被热水烫了一引发的一度烫伤。";
        [self addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(15);
            make.height.mas_equalTo(20);
        }];
        iv;
    });
    
    _contentImageView = ({
        UIImageView *iv = [[UIImageView alloc]init];
        iv.clipsToBounds = YES;
        UIImage *icon  = [UIImage imageNamed:@"mysofac_body"];
        iv.image = icon ;
        [self addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.top.mas_equalTo(kSAdap_V(60.0));
            make.size.mas_equalTo(icon.size);
        }];
        iv;
    });
    
    _bodyListView = ({
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        flowLayout.minimumInteritemSpacing = 0.f;
        flowLayout.minimumLineSpacing = kSAdap(15);
        flowLayout.sectionInset = UIEdgeInsetsMake(kSAdap_V(10), 0, kSAdap_V(10), 0);
        flowLayout.itemSize = CGSizeMake(kSAdap(50), kSAdap_V(32));
        ELMyofascialMenuScrolloView *iv = [[ELMyofascialMenuScrolloView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        [self addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(kSAdap_V(55.0));
            make.right.mas_equalTo(-kSAdap(15));
            make.bottom.mas_equalTo(-kSAdap_V(52));
            make.width.mas_equalTo(kSAdap(80));
        }];
        iv;
    });
    
    NSMutableArray *list = [NSMutableArray arrayWithCapacity:0];
    for (NSInteger i = 0; i< 10; i++) {
        ELMyofascialMenuModel *model = [[ELMyofascialMenuModel alloc]init];
        model.title = [NSString stringWithFormat:@"肩部%ld",i];
        [list addObject:model];
    }
    [self.bodyListView initWithSouce:list];
    
    
    _rankListView = ({
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        flowLayout.minimumInteritemSpacing = 0.f;
        flowLayout.minimumLineSpacing = kSAdap(15);
        flowLayout.sectionInset = UIEdgeInsetsMake(kSAdap_V(10), 0, kSAdap_V(10), 0);
        flowLayout.itemSize = CGSizeMake(kSAdap(50), kSAdap_V(32));
        ELMyofascialMenuScrolloView *iv = [[ELMyofascialMenuScrolloView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        [self addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(kSAdap_V(55.0));
            make.left.mas_equalTo(kSAdap(15));
            make.bottom.mas_equalTo(-kSAdap_V(52));
            make.width.mas_equalTo(kSAdap(80));
        }];
        iv;
    });
    
    NSMutableArray *rank = [NSMutableArray arrayWithCapacity:0];
    for (NSInteger i = 0; i< 10; i++) {
        ELMyofascialMenuModel *model = [[ELMyofascialMenuModel alloc]init];
        model.title = [NSString stringWithFormat:@"%ld",i];
        [rank addObject:model];
    }
    [self.rankListView initWithSouce:rank];
    
    
    _bodyCircleView = ({
        UIView *iv = [[UIView alloc] init];
        [self addSubview:iv];
        iv.cornerRadius = kSAdap(14);
        iv.clipsToBounds = YES;
        iv.layer.borderColor = [UIColor whiteColor].CGColor;
        iv.layer.borderWidth = 1;
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(kSAdap_V(28));
            make.width.mas_equalTo(kSAdap(55));
            make.center.mas_equalTo(self.bodyListView);
        }];
        iv;
    });
    
    _rankCircleView = ({
        UIView *iv = [[UIView alloc] init];
        [self addSubview:iv];
        iv.cornerRadius = kSAdap(14);
        iv.clipsToBounds = YES;
        iv.layer.borderColor = [UIColor whiteColor].CGColor;
        iv.layer.borderWidth = 1;
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(kSAdap_V(28));
            make.width.mas_equalTo(kSAdap(55));
            make.center.mas_equalTo(self.rankListView);
        }];
        iv;
    });
    
}

@end
