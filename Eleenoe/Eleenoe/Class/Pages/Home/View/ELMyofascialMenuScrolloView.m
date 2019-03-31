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
@end
@implementation ELMyofascialMenuScrolloView

-(instancetype)initWithFrame:(CGRect)frame  collectionViewLayout:(nonnull UICollectionViewLayout *)layout{
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.dataSource = self;
        self.delegate = self;
        self.backgroundColor = [UIColor clearColor];
        [self registerClass:[ELMyofascialMenuCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([ELMyofascialMenuCollectionViewCell class])];
    }
    return self;
}

-(void)initWithSouce:(NSArray *)lists{
    if (lists.count) {
        [self.lists addObjectsFromArray:lists];
        [self reloadData];
    }

    
}

- (void)setPageContentCollectionViewCurrentIndex:(NSInteger)currentIndex{
    

//    [self setContentOffset:CGPointMake(self.contentOffset.x, contentOffset) animated:YES];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ELMyofascialMenuCollectionViewCell *cell = [ELMyofascialMenuCollectionViewCell cellWithCollectionView:collectionView indexpath:indexPath];
    [cell InitDataWithModel:self.lists[indexPath.row]];
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView*)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.lists.count;
}

-(NSMutableArray *)lists{
    if (!_lists) {
        _lists = [NSMutableArray arrayWithCapacity:0];
    }
    return _lists;
}

@end
