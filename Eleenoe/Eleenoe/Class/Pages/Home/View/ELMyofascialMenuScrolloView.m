//
//  ELMyofascialMenuScrolloView.m
//  Eleenoe
//
//  Created by FaceBook on 2019/3/30.
//  Copyright © 2019 FaceBook. All rights reserved.
//

#import "ELMyofascialMenuScrolloView.h"
#import "ELMyofascialMenuCollectionViewCell.h"

@interface ELMyofascialMenuScrolloView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong) UICollectionView *listCollectionView;
@property (nonatomic,strong) UICollectionViewFlowLayout *layout;
@property (nonatomic,strong) NSMutableArray *lists;
@end
@implementation ELMyofascialMenuScrolloView

-(void)ELSinitConfingViews{
    
    _listCollectionView = ({
        _layout =[[UICollectionViewFlowLayout alloc]init];
        _layout.minimumInteritemSpacing = 0.f;
        _layout.minimumLineSpacing = kSAdap_V(15.0);
        _layout.itemSize = CGSizeMake(kSAdap(80.0), kSAdap_V(15.0));
        _layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        UICollectionView *iv =[[UICollectionView alloc] initWithFrame:CGRectZero
                                                 collectionViewLayout:_layout];
        iv.backgroundColor = [UIColor clearColor];
        iv.showsHorizontalScrollIndicator = NO;
        iv.showsVerticalScrollIndicator =NO;
        iv.dataSource = self;
        iv.delegate = self;
        [iv registerClass:[ELMyofascialMenuCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([ELMyofascialMenuCollectionViewCell class])];
        [self addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self);
        }];
        iv;
    });
}

-(void)setType:(MyofascialMenuType)type{
    _type = type;
    switch (type) {
        case MyofascialMenuTypeVertical:{
            _layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        }
            break;
        case MyofascialMenuTypeHorizontal:{
            _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        }
            break;
        default:
            break;
    }
}

-(void)initWithSouce:(NSArray *)lists{
    if (lists.count) {
        [self.lists addObjectsFromArray:lists];
        [self.listCollectionView reloadData];
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ELMyofascialMenuCollectionViewCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ELMyofascialMenuCollectionViewCell class]) forIndexPath:indexPath];
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
