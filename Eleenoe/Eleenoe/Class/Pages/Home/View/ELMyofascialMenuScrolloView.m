//
//  ELMyofascialMenuScrolloView.m
//  Eleenoe
//
//  Created by FaceBook on 2019/3/30.
//  Copyright © 2019 FaceBook. All rights reserved.
//

#import "ELMyofascialMenuScrolloView.h"
#import "ELCollectionViewFlowLayout.h"
#import "ELMyofascialMenuCollectionViewCell.h"
@interface ELMyofascialMenuScrolloView()<UICollectionViewDelegate,UICollectionViewDataSource,MKJCollectionViewFlowLayoutDelegate>
@property (nonatomic,strong) NSMutableArray *lists;
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) UIView *circleView;
@end
@implementation ELMyofascialMenuScrolloView

-(void)ELSinitConfingViews{
    
    _collectionView = ({
        ELCollectionViewFlowLayout *  flowLayout = [[ELCollectionViewFlowLayout alloc] init];
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.itemSize = CGSizeMake(kSAdap(20), kSAdap_V(32));
        flowLayout.needAlpha = YES;
        flowLayout.delegate = self;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        UICollectionView*collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.showsVerticalScrollIndicator = NO;
        collectionView.backgroundColor = [UIColor clearColor];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        [self addSubview:collectionView];
        [collectionView registerClass:[ELMyofascialMenuCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([ELMyofascialMenuCollectionViewCell class])];
        [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self);
        }];
        collectionView;
    });
    
    
    _circleView = ({
        UIView *iv = [[UIView alloc] init];
        [self addSubview:iv];
        iv.cornerRadius = kSAdap(10);
        iv.clipsToBounds = YES;
        iv.layer.borderColor = MainThemColor.CGColor;
        iv.layer.borderWidth = 1;
        iv.userInteractionEnabled = YES;
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(kSAdap_V(32));
            make.width.mas_equalTo(kSAdap(22));
            make.center.mas_equalTo(self.collectionView);
        }];
        iv;
    });
    
    [self sendSubviewToBack:self.circleView];
    
    [self.collectionView reloadData];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.collectionView setContentOffset:CGPointMake(5, 0)];
    });
}

-(void)InitDataSouce:(NSArray *)souce{
    if (souce.count) {
        [self.lists addObjectsFromArray:souce];
    }
    [self.collectionView reloadData];
}

- (void)setCurrentIndex:(NSInteger )row{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    [self.collectionView reloadData];
}


- (void)collectioViewScrollToIndex:(NSInteger)index{
    
    NSLog(@"%ld",index);
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.lists.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ELMyofascialMenuCollectionViewCell *cell = [ELMyofascialMenuCollectionViewCell cellWithCollectionView:collectionView indexpath:indexPath];
    if (indexPath.row ==0 ||indexPath.row ==self.lists.count-1) {
        cell.titleLabel.text = @"";
    }else{
        cell.titleLabel.text = self.lists[indexPath.row];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.collectionView.collectionViewLayout isKindOfClass:[ELCollectionViewFlowLayout class]]) {
        CGPoint pInUnderView = [self convertPoint:collectionView.center toView:collectionView];
        NSIndexPath *indexpathNew = [collectionView indexPathForItemAtPoint:pInUnderView];
        if (indexPath.row == indexpathNew.row){
            return;
        }else{
            [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        }
    }
}

-(NSMutableArray *)lists{
    if (!_lists) {
        _lists = [NSMutableArray arrayWithCapacity:0];
    }
    return _lists;
}

@end
