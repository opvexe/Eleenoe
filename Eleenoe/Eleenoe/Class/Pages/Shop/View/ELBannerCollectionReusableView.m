//
//  ELBannerCollectionReusableView.m
//  Eleenoe
//
//  Created by FaceBook on 2019/3/29.
//  Copyright © 2019 FaceBook. All rights reserved.
//

#import "ELBannerCollectionReusableView.h"
#import "ELBannerCollectionViewCell.h"
#import <TYCyclePagerView.h>
#import <TYPageControl.h>

@interface ELBannerCollectionReusableView ()<TYCyclePagerViewDataSource,TYCyclePagerViewDelegate>
@property (nonatomic, strong) TYCyclePagerView *pagerView;
@property (nonatomic, strong) TYPageControl *pageControl;
@property (nonatomic,strong) NSMutableArray *urls;
@property (nonatomic,strong) ELBaseModel *model;
@property (nonatomic,strong) NSArray *imagePathsGroup;
@end

@implementation ELBannerCollectionReusableView

-(void)ELSinitConfingViews{
    
    _pagerView = ({
        TYCyclePagerView *iv = [[TYCyclePagerView alloc]init];
        iv.isInfiniteLoop = YES;
        iv.autoScrollInterval = 5.0;
        iv.dataSource = self;
        iv.delegate = self;
        [iv registerClass:[ELBannerCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([ELBannerCollectionViewCell class])];
        [self addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(self);
            make.height.mas_equalTo(kSAdap_V(150.0));
        }];
        iv;
    });
    
    _pageControl = ({
        TYPageControl *iv = [[TYPageControl alloc]init];
        iv.currentPageIndicatorSize = CGSizeMake(kSAdap(15.0), kSAdap_V(4.0));
        iv.pageIndicatorSize = CGSizeMake(kSAdap(8.0), kSAdap_V(4.0));
        iv.currentPageIndicatorTintColor = UIColorFromRGB(0x90c221);
        iv.pageIndicatorTintColor = UIColorFromRGB(0xd2d2d2);
        iv.pageIndicatorSpaing = kSAdap(8.0);
        [self.pagerView addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.bottom.mas_equalTo(kSAdap_V(15.0));
            make.height.mas_equalTo(kSAdap_V(10.0));
            make.width.mas_equalTo(self.pagerView);
        }];
        iv;
    });
}

-(void)InitDataWithModel:(ELBaseModel *)model{
    _model = model;
    //    NSMutableArray *urls = [NSMutableArray arrayWithCapacity:0];
    //    [model.goods_img enumerateObjectsUsingBlock:^(WDShopDetailBannerModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
    //        [urls addObject:obj.img_url];
    //    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.pageControl.numberOfPages = self.urls.count;
        [self.pagerView reloadData];
    });
}

#pragma mark - TYCyclePagerViewDataSource
- (NSInteger)numberOfItemsInPagerView:(TYCyclePagerView *)pageView {
    return _urls.count;
}

- (UICollectionViewCell *)pagerView:(TYCyclePagerView *)pagerView cellForItemAtIndex:(NSInteger)index {
    ELBannerCollectionViewCell *cell = [pagerView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ELBannerCollectionViewCell class]) forIndex:index];
    NSString *imagePath = self.urls[index];
    if ([imagePath hasPrefix:@"http"]) {
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:imagePath] placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
    } else {
        UIImage *image = [UIImage imageNamed:imagePath];
        if (!image) {
            image = [UIImage imageWithContentsOfFile:imagePath];
        }
        cell.imageView.image = image;
    }
    return cell;
}

- (TYCyclePagerViewLayout *)layoutForPagerView:(TYCyclePagerView *)pageView {
    TYCyclePagerViewLayout *layout = [[TYCyclePagerViewLayout alloc]init];
    layout.itemSize = CGSizeMake(CGRectGetWidth(pageView.frame)*0.9, CGRectGetHeight(pageView.frame)*1.0);
    layout.itemSpacing = kSAdap(10.0);
    return layout;
}

- (void)pagerView:(TYCyclePagerView *)pageView didScrollFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    _pageControl.currentPage = toIndex;
}

- (void)pagerView:(TYCyclePagerView *)pageView didSelectedItemCell:(__kindof UICollectionViewCell *)cell atIndex:(NSInteger)index{
    NSLog(@"%ld",index);
}

@end
