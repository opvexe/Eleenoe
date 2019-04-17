//
//  ELHomeListView.m
//  Eleenoe
//
//  Created by HuiLu on 2019/3/30.
//  Copyright © 2019 FaceBook. All rights reserved.
//

#import "ELHomeListView.h"
#import "ELMyofascialContentModel.h"
#import "ELHomeCollectionViewCell.h"
@interface ELHomeListView()
@property(nonatomic,strong)NSMutableArray *homeLists;
@property (nonatomic, assign) NSInteger startOffsetX;
@property (nonatomic, assign) NSInteger previousCVCIndex;
@property (nonatomic, assign) BOOL isScroll;
@end
@implementation ELHomeListView
-(instancetype)initWithFrame:(CGRect)frame  collectionViewLayout:(nonnull UICollectionViewLayout *)layout{
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.dataSource = self;
        self.delegate = self;
        self.pagingEnabled = YES;
        self.backgroundColor = MainThemColor;
        [self registerClass:[ELHomeCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([ELHomeCollectionViewCell class])];
        _startOffsetX = 0;
        _previousCVCIndex = -1;
        [self loadDataSoucre];
    }
    return self;
}

-(void)loadDataSoucre{
    
    NSArray *lists =  @[
                        //肌肉放松
                        @{@"datas":@[
                                  @{@"title":@"肩部",@"selectedImageName":@"relax_shoulders",@"choose":@(NO)},
                                  @{@"title":@"背部",@"selectedImageName":@"relax_back",@"choose":@(NO)},
                                  @{@"title":@"臀部",@"selectedImageName":@"relax_thigh",@"choose":@(YES)},
                                  @{@"title":@"大腿",@"selectedImageName":@"relax_haunch",@"choose":@(NO)},
                                  @{@"title":@"小腿",@"selectedImageName":@"relax_shank",@"choose":@(NO)},
                                  @{@"title":@"手臂",@"selectedImageName":@"relax_arm",@"choose":@(NO)}],
                          @"isShow":@(NO)},
                        //筋膜松懈
                        @{@"datas":@[
                                  @{@"title":@"头前倾",@"selectedImageName":@""},
                                  @{@"title":@"腰肌劳损",@"selectedImageName":@""},
                                  @{@"title":@"背部松懈",@"selectedImageName":@""},
                                  @{@"title":@"颈椎劳损",@"selectedImageName":@""},
                                  @{@"title":@"驼背",@"selectedImageName":@""},
                                  @{@"title":@"O型腿",@"selectedImageName":@""},
                                  @{@"title":@"X型腿",@"selectedImageName":@""},
                                  @{@"title":@"盆骨前倾",@"selectedImageName":@""}],
                          @"isShow":@(NO)},
                        //疼痛
                        @{@"datas":@[
                                  @{@"title":@"痛经",@"selectedImageName":@""},
                                  @{@"title":@"肩痛",@"selectedImageName":@""},
                                  @{@"title":@"背痛",@"selectedImageName":@""},
                                  @{@"title":@"肘痛",@"selectedImageName":@""},
                                  @{@"title":@"脖子痛",@"selectedImageName":@""},
                                  @{@"title":@"腰痛",@"selectedImageName":@""},
                                  @{@"title":@"脚踝痛",@"selectedImageName":@""},
                                  @{@"title":@"足底痛",@"selectedImageName":@""},
                                  @{@"title":@"手术后疼痛",@"selectedImageName":@""},
                                  @{@"title":@"烧伤疼痛",@"selectedImageName":@""}],
                          @"pains":@[
                                  @{@"title":@"1"},
                                  @{@"title":@"2"},
                                  @{@"title":@"3"},
                                  @{@"title":@"4"},
                                  @{@"title":@"5"},
                                  @{@"title":@"6"},
                                  @{@"title":@"7"},
                                  @{@"title":@"8"},
                                  @{@"title":@"9"},
                                  @{@"title":@"10"}],
                          @"isShow":@(YES)},
                        //损伤康复
                        @{@"datas":@[
                                  @{@"title":@"鼠标手",@"selectedImageName":@""},
                                  @{@"title":@"足底筋膜炎",@"selectedImageName":@""},
                                  @{@"title":@"跟腱炎",@"selectedImageName":@""},
                                  @{@"title":@"胫骨骨膜炎",@"selectedImageName":@""},
                                  @{@"title":@"膝关节炎",@"selectedImageName":@""},
                                  @{@"title":@"客胫综合征",@"selectedImageName":@""},
                                  @{@"title":@"梨状肌综合性",@"selectedImageName":@""},
                                  @{@"title":@"网球肘",@"selectedImageName":@""},
                                  @{@"title":@"肩周炎",@"selectedImageName":@""}],
                          @"isShow":@(NO)},
                        ];
    self.homeLists = [ELMyofascialContentModel mj_objectArrayWithKeyValuesArray:lists];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    _startOffsetX = scrollView.contentOffset.x;
    _isScroll = YES;
    if (self.delegatePageContentCollectionView && [self.delegatePageContentCollectionView respondsToSelector:@selector(pageContentCollectionViewWillBeginDragging)]) {
        [self.delegatePageContentCollectionView pageContentCollectionViewWillBeginDragging];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    _isScroll = NO;
    CGFloat offsetX = scrollView.contentOffset.x;
    // 1、记录上个子控制器下标
    _previousCVCIndex = offsetX / scrollView.frame.size.width;
    
    if (self.delegatePageContentCollectionView && [self.delegatePageContentCollectionView respondsToSelector:@selector(pageContentCollectionView:index:)]) {
        [self.delegatePageContentCollectionView pageContentCollectionView:self index:_previousCVCIndex];
    }
    // 3、pageContentCollectionViewDidEndDecelerating
    if (self.delegatePageContentCollectionView && [self.delegatePageContentCollectionView respondsToSelector:@selector(pageContentCollectionViewDidEndDecelerating)]) {
        [self.delegatePageContentCollectionView pageContentCollectionViewDidEndDecelerating];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ( _isScroll == NO) {
        return;
    }
    // 1、定义获取需要的数据
    CGFloat progress = 0;
    NSInteger originalIndex = 0;
    NSInteger targetIndex = 0;
    // 2、判断是左滑还是右滑
    CGFloat currentOffsetX = scrollView.contentOffset.x;
    CGFloat scrollViewW = scrollView.bounds.size.width;
    if (currentOffsetX > _startOffsetX) { // 左滑
        // 1、计算 progress
        progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW);
        // 2、计算 originalIndex
        originalIndex = currentOffsetX / scrollViewW;
        // 3、计算 targetIndex
        targetIndex = originalIndex + 1;
        if (targetIndex >= self.homeLists.count) {
            progress = 1;
            targetIndex = originalIndex;
        }
        // 4、如果完全划过去
        if (currentOffsetX - _startOffsetX == scrollViewW) {
            progress = 1;
            targetIndex = originalIndex;
        }
    } else { // 右滑
        // 1、计算 progress
        progress = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW));
        // 2、计算 targetIndex
        targetIndex = currentOffsetX / scrollViewW;
        // 3、计算 originalIndex
        originalIndex = targetIndex + 1;
        if (originalIndex >= self.homeLists.count) {
            originalIndex = self.homeLists.count - 1;
        }
    }
    if (self.delegatePageContentCollectionView && [self.delegatePageContentCollectionView respondsToSelector:@selector(pageContentCollectionView:progress:originalIndex:targetIndex:)]) {
        [self.delegatePageContentCollectionView pageContentCollectionView:self progress:progress originalIndex:originalIndex targetIndex:targetIndex];
    }
}
#pragma mark - - - 给外界提供的方法，获取 SGPageTitleView 选中按钮的下标
- (void)setPageContentCollectionViewCurrentIndex:(NSInteger)currentIndex {
    CGFloat offsetX = currentIndex * self.width;
    _startOffsetX = offsetX;
    // 1、处理内容偏移
    if (_previousCVCIndex != currentIndex) {
        [self setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    }
    // 2、记录上个子控制器下标
    _previousCVCIndex = currentIndex;
    if (self.delegatePageContentCollectionView && [self.delegatePageContentCollectionView respondsToSelector:@selector(pageContentCollectionView:index:)]) {
        [self.delegatePageContentCollectionView pageContentCollectionView:self index:currentIndex];
    }
}

//设置分区
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView*)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.homeLists.count;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(SCREEN_WIDTH,self.height);
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ELHomeCollectionViewCell *cell =  [ELHomeCollectionViewCell cellWithCollectionView:collectionView indexpath:indexPath];
    [cell InitDataWithModel:self.homeLists[indexPath.row]];
    return cell;
}
#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
}
@end
