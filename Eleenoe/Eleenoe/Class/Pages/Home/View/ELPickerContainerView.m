//
//  ELPickerContainerView.m
//  Eleenoe
//
//  Created by FaceBook on 2019/4/3.
//  Copyright © 2019 FaceBook. All rights reserved.
//

#import "ELPickerContainerView.h"
#import "ELMyofascialMenuCollectionViewCell.h"
@interface ELPickerContainerView()<
UICollectionViewDataSource,
UICollectionViewDelegate,
UICollectionViewDelegateFlowLayout
>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic,assign) CGSize itemsSize;
@property (nonatomic,strong) NSMutableArray *lists;
@property (nonatomic, assign) NSInteger currentRow;
@end
@implementation ELPickerContainerView

- (instancetype)initWithFrame:(CGRect)frame itemsSize:(CGSize)itemsSize
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.itemsSize = itemsSize;
        self.flowLayout = [[UICollectionViewFlowLayout alloc] init];
        self.flowLayout.minimumLineSpacing = 0;
        self.flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        self.flowLayout.itemSize = CGSizeMake(self.frame.size.width, self.itemsSize.height);
        
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
        
        self.collectionView.showsHorizontalScrollIndicator = NO;
        self.collectionView.showsVerticalScrollIndicator   = NO;
        self.collectionView.pagingEnabled                  = NO;
        self.collectionView.backgroundColor                = [UIColor clearColor];
        self.collectionView.dataSource = self;
        self.collectionView.delegate = self;
        [self.collectionView registerClass:[ELMyofascialMenuCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([ELMyofascialMenuCollectionViewCell class])];
        
        CGFloat inset = (self.frame.size.height - self.itemsSize.height) / 2;
        self.collectionView.contentInset = UIEdgeInsetsMake(inset, 0, inset, 0);
        
        self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:self.collectionView];
        
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self);
        }];
        for (NSInteger i = 1; i<10; i++) {
            [self.lists addObject:[NSString stringWithFormat:@"肩部%ld",(long)i]];
        }
        
    }
    return self;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.lists.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ELMyofascialMenuCollectionViewCell *cell = [ELMyofascialMenuCollectionViewCell cellWithCollectionView:collectionView indexpath:indexPath];
    cell.titleLabel.textColor = [UIColor whiteColor];
    cell.titleLabel.text = self.lists[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self selectRow:indexPath.row animated:YES];
}

- (void)selectRow:(NSInteger)row animated:(BOOL)animated
{
    self.currentRow = row;
    if (self.currentRow>self.lists.count-1) {
        self.currentRow = self.lists.count-1;
    }
    if (self.currentRow<0) {
        self.currentRow = 0;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        NSIndexPath *currentIndex = [NSIndexPath indexPathForRow:row inSection:0];
        UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:currentIndex];
        CGFloat contentOffsetY = cell.center.y - (self.frame.size.height / 2);
        [self.collectionView setContentOffset:CGPointMake(0, contentOffsetY) animated:animated];
    });
}

-(NSMutableArray *)lists{
    if (!_lists) {
        _lists = [NSMutableArray array];
    }
    return _lists;
}
@end
