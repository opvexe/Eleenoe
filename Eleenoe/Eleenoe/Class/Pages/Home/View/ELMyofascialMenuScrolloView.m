//
//  ELMyofascialMenuScrolloView.m
//  Eleenoe
//
//  Created by FaceBook on 2019/3/30.
//  Copyright © 2019 FaceBook. All rights reserved.
//

#import "ELMyofascialMenuScrolloView.h"
#import "ELMyofascialMenuCollectionViewCell.h"
@interface ELMyofascialMenuScrolloView()
@property (nonatomic,strong) NSMutableArray *lists;
@property(nonatomic, assign) CGSize cellSize;
@property (nonatomic,strong) NSIndexPath *currentIndex;
@end
@implementation ELMyofascialMenuScrolloView

-(instancetype)initWithFrame:(CGRect)frame  collectionViewLayout:(nonnull UICollectionViewFlowLayout *)layout{
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.dataSource = self;
        self.delegate = self;
        _cellSize = layout.itemSize;
        self.backgroundColor = [UIColor clearColor];
        [self registerClass:[ELMyofascialMenuCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([ELMyofascialMenuCollectionViewCell class])];
        self.decelerationRate = UIScrollViewDecelerationRateFast;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGestureRecognizer:)];
        [self addGestureRecognizer:tapGesture];
    }
    return self;
}

-(void)initWithSouce:(NSArray *)lists{
    if (lists.count) {
        [self.lists addObjectsFromArray:lists];
        [self reloadData];
    }
}

#pragma mark - handleTapGestureRecognizer
- (void)handleTapGestureRecognizer:(UITapGestureRecognizer *)tapGesture {
    if (tapGesture.state == UIGestureRecognizerStateEnded) {
        CGPoint     location = [tapGesture locationInView:tapGesture.view];
        NSIndexPath *indexPath = [self indexPathForItemAtPoint:location];
        if (indexPath.row != self.currentIndex.row) {
            [self setCurrentIndex:indexPath];
        }
    }
}

- (void)setCurrentIndex:(NSIndexPath *)currentIndex {
    _currentIndex = currentIndex;
    UICollectionViewCell *cell = [self cellForItemAtIndexPath:currentIndex];
    CGFloat contentOffset = cell.center.y - (self.frame.size.width / 2);
    [self setContentOffset:CGPointMake(self.contentOffset.x, contentOffset) animated:YES];
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ELMyofascialMenuCollectionViewCell *cell = [ELMyofascialMenuCollectionViewCell cellWithCollectionView:collectionView indexpath:indexPath];
    [cell setUserInteractionEnabled:NO];
    if (indexPath.row == _currentIndex.row) {
        cell.titleLabel.font = [UIFont ELPingFangSCMediumFontOfSize:kSaFont(16.0)];
    }else{
        cell.titleLabel.font =  [UIFont ELPingFangSCMediumFontOfSize:kSaFont(16.0)];
    }
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView*)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.lists.count;
}

#pragma mark - UIScrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self scrollViewDidFinishScrolling:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        [self scrollViewDidFinishScrolling:scrollView];
    }
}

- (void)scrollViewDidFinishScrolling:(UIScrollView *)scrollView {
    CGPoint point = [self convertPoint:CGPointMake(self.frame.size.width / 2.0, self.cellSize.height / 2.0) toView:self];
    NSIndexPath *centerIndexPath = [self indexPathForItemAtPoint:CGPointMake(0, point.y)];
    if (centerIndexPath.row != self.currentIndex.row) {
        self.currentIndex = centerIndexPath;
    }else{
        UICollectionViewCell *cell = [self cellForItemAtIndexPath:_currentIndex];
        CGFloat contentOffset = cell.center.y - (self.frame.size.width / 2);
        [self setContentOffset:CGPointMake(self.contentOffset.x, contentOffset) animated:YES];
    }
}

-(NSMutableArray *)lists{
    if (!_lists) {
        _lists = [NSMutableArray arrayWithCapacity:0];
    }
    return _lists;
}

@end
