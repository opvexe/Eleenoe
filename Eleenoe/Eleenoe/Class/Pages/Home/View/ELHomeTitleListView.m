//
//  ELHomeTitleListView.m
//  Eleenoe
//
//  Created by HuiLu on 2019/3/30.
//  Copyright © 2019 FaceBook. All rights reserved.
//

#import "ELHomeTitleListView.h"
#import "ELHomeTitleCollectionCell.h"
#import "ELMyofascialMenuModel.h"
@interface ELHomeTitleListView()
@property(nonatomic,strong)NSMutableArray *titleList;
@end
@implementation ELHomeTitleListView
-(instancetype)initWithFrame:(CGRect)frame  collectionViewLayout:(nonnull UICollectionViewLayout *)layout{
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.dataSource = self;
        self.delegate = self;
        self.pagingEnabled = YES;
        self.backgroundColor = [UIColor whiteColor];
        [self registerClass:[ELHomeTitleCollectionCell class] forCellWithReuseIdentifier:NSStringFromClass([ELHomeTitleCollectionCell class])];
        NSArray *lists = @[@{@"title":@"肌肉放松",@"imageName":@"relax_normal",@"choose":@(YES),@"selectedImageName":@"relax_select"},
                           @{@"title":@"筋膜松解",@"imageName":@"muscle_select",@"choose":@(NO),@"selectedImageName":@"muscle_normal"},
                           @{@"title":@"疼痛控制",@"imageName":@"pain_normal",@"choose":@(NO),@"selectedImageName":@"pain_select"},
                           @{@"title":@"损伤康复",@"imageName":@"recovery_normal",@"choose":@(NO),@"selectedImageName":@"recovery_select"}];
       self.titleList =[ELMyofascialTitleModel mj_objectArrayWithKeyValuesArray:lists];
    }
    return self;
}
//设置分区
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView*)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.titleList.count;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(kSAdap(50),kSAdap(51));
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ELHomeTitleCollectionCell *cell =  [ELHomeTitleCollectionCell cellWithCollectionView:collectionView indexpath:indexPath];
    [cell InitDataWithModel:self.titleList[indexPath.row]];
    return cell;
}
#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    ELMyofascialTitleModel *model =   self.titleList [indexPath.row];
    [self.titleList enumerateObjectsUsingBlock:^(ELMyofascialTitleModel  * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isEqual:model]) {
            obj.choose = YES;
        }else{
            obj.choose = NO;
        }
    }];
    [self reloadData];
    
    if (self.delegatePageContentCollectionView &&[self.delegatePageContentCollectionView respondsToSelector:@selector(pageTitleListView:index:)]) {
        [self.delegatePageContentCollectionView pageTitleListView:self index:indexPath.row];
    }
}
- (void)setELHomeTitleListViewCurrentIndex:(NSInteger)currentIndex {
    if (self.titleList.count<currentIndex) {
        return;
    }
    ELMyofascialTitleModel *model =   self.titleList [currentIndex];
    [self.titleList enumerateObjectsUsingBlock:^(ELMyofascialTitleModel  * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isEqual:model]) {
            obj.choose = YES;
        }else{
            obj.choose = NO;
        }
    }];
    [self reloadData];
}
@end
