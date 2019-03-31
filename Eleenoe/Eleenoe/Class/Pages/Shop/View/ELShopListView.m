//
//  ELShopListView.m
//  Eleenoe
//
//  Created by FaceBook on 2019/3/31.
//  Copyright © 2019 FaceBook. All rights reserved.
//

#import "ELShopListView.h"
#import "ELShopCollectionViewCell.h"
#import "ELBannerCollectionReusableView.h"
#import "ELShopModel.h"
@interface ELShopListView()<ELCycleScrollViewDelegate>
@property (nonatomic,strong) ELShopModel *model;
@property (nonatomic,strong) NSMutableArray *lists;
@end
@implementation ELShopListView

-(instancetype)initWithFrame:(CGRect)frame  collectionViewLayout:(nonnull UICollectionViewLayout *)layout{
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.dataSource = self;
        self.delegate = self;
        self.backgroundColor = MainTableViewColor;
        [self registerClass:[ELShopCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([ELShopCollectionViewCell class])];
        [self registerClass:[ELBannerCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([ELBannerCollectionReusableView class])];
    }
    return self;
}

-(void)initWithSouce:(ELShopModel *)model{
    _model = model;
    [self reloadData];
}

#pragma mark UICollectionViewCellDelegate
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ELShopCollectionViewCell *cell =  [ELShopCollectionViewCell cellWithCollectionView:collectionView indexpath:indexPath];
    [cell InitDataWithModel:_model.goods_datas[indexPath.row]];
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView*)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _model.goods_datas.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return  CGSizeMake((self.width-kSAdap(20.0))/2 -kSAdap(19.0),kSAdap_V(210.0));
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return kSAdap(10.0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return kSAdap(20.0);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(kSAdap_V(10.0), kSAdap(18.0), kSAdap(10.0), kSAdap(18.0));
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark - 区头
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return (CGSize){[UIScreen mainScreen].bounds.size.width,kSAdap_V(210.0)};
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *reusable = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        ELBannerCollectionReusableView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([ELBannerCollectionReusableView class]) forIndexPath:indexPath];
        [reusableView InitDataWithModel:_model];
        reusableView.delegate = self;
        reusable = reusableView;
    }
    return reusable;
}

#pragma mark - ELCycleScrollViewDelegate
-(void)cycleScrollView:(ELBannerCollectionReusableView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index model:(ELShopContentModel *)model{
    NSLog(@"%@",model);
}

@end
