//
//  ELGuideView.m
//  Eleenoe
//
//  Created by FaceBook on 2019/3/13.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import "ELGuideView.h"

typedef void(^EnterBlock)(void);
@interface ELGuideView()<UIScrollViewDelegate>
@property(nonatomic,strong)UIPageControl* pageControl;
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,copy)EnterBlock enterBlock;
@property(nonatomic,assign)CGSize size;
@end

@implementation ELGuideView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _size = frame.size;
        _scrollView = ({
            UIScrollView *iv = [[UIScrollView alloc]initWithFrame:frame];
            iv.bounces                        = NO;
            iv.delegate                       = self;
            iv.pagingEnabled                  = YES;
            iv.showsVerticalScrollIndicator   = NO;
            iv.showsHorizontalScrollIndicator = NO;
            [self addSubview:iv];
            iv;
        });
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeSelf)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

-(void)removeSelf{
    if (_pageControl.currentPage == _guideImages.count - 1) {
        [self removeFromSuperview];
        if (self.enterBlock) {
            self.enterBlock();
        }
    }
}

-(UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(_size.width * 0.5, _size.height - 60, 0, 40)];
        _pageControl.currentPageIndicatorTintColor =PageCurrentColor;
        _pageControl.pageIndicatorTintColor =UIColorFromRGB(0xbcbcbc);
    }
    return _pageControl;
}

-(void)setGuideImages:(NSArray *)guideImages{
    _guideImages = guideImages;
    if (guideImages.count>0) {
        _pageControl.numberOfPages = guideImages.count;
        _scrollView.contentSize = CGSizeMake(guideImages.count * _size.width, _size.height);
        for (int i = 0 ; i < guideImages.count; i++) {
            UIImageView* imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i * _size.width, 0, _size.width, _size.height)];
            [imageView setImage:[UIImage imageNamed:guideImages[i]]];
            [self.scrollView addSubview:imageView];
            if (i==guideImages.count - 1) {
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                [button setTitle:@"立即体验" forState:UIControlStateNormal];
                [button setTitle:@"立即体验" forState:UIControlStateHighlighted];
                button.layer.cornerRadius = 10;
                button.backgroundColor =PageCurrentColor;
                button.layer.masksToBounds = YES;
                [imageView addSubview:button];
                button.frame  = CGRectMake(0.3*SCREEN_WIDTH, 0.845*SCREEN_HEIGHT, 150, 40);
            }
        }
    }
}

#pragma mark UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint offset = scrollView.contentOffset;
    _pageControl.currentPage = round(offset.x /SCREEN_WIDTH );
}


-(void)didEnterCompletetedBlock:(void(^)(void))completetBlock{
    self.enterBlock  = completetBlock;
}

@end
