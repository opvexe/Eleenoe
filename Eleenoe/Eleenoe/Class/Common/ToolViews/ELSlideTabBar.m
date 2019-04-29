//
//  ELSlideTabBar.m
//  Eleenoe
//
//  Created by FaceBook on 2019/4/29.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import "ELSlideTabBar.h"

@interface ELSlideTabBar ()
@property (nonatomic, strong) NSMutableArray<UILabel *> *labels;
@property (nonatomic, strong) NSMutableArray<NSString *>*titles;
@property (nonatomic, assign) NSInteger  tabIndex;
@end
@implementation ELSlideTabBar


-(void)ELSinitConfingViews{
    _labels = [NSMutableArray array];
    _titles = [NSMutableArray array];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    if(_titles.count == 0) {
        return;
    }
    
    [[self subviews] enumerateObjectsUsingBlock:^(UIView *subView, NSUInteger idx, BOOL *stop) {
        [subView removeFromSuperview];
    }];
    [_labels removeAllObjects];
    
    CGFloat itemWidth = self.width/_titles.count;
    [_titles enumerateObjectsUsingBlock:^(NSString * title, NSUInteger idx, BOOL *stop) {
        UILabel *label = [[UILabel alloc]init];
        label.text = title;
        label.textColor = UIColorFromRGB(0x666666);
        label.textAlignment = idx == 0? NSTextAlignmentLeft:idx == 1?NSTextAlignmentCenter:NSTextAlignmentRight;
        label.font = [UIFont ELPingFangSCRegularFontOfSize:kSaFont(14)];
        label.tag = idx;
        [label sizeToFit];
        label.userInteractionEnabled = YES;
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTapAction:)]];
        [self.labels addObject:label];
        [self addSubview:label];
        label.frame = CGRectMake(idx*itemWidth, 0, itemWidth, self.bounds.size.height);
    }];
    _labels[_tabIndex].textColor = MainThemColor;
}

- (void)setLabels:(NSArray<NSString *> *)titles tabIndex:(NSInteger)tabIndex {
    [_titles removeAllObjects];
    [_titles addObjectsFromArray:titles];
    _tabIndex = tabIndex;
}

- (void)onTapAction:(UITapGestureRecognizer *)sender {
    NSInteger index = sender.view.tag;
    if(_delegate) {
        [UIView animateWithDuration:0.10
                              delay:0
             usingSpringWithDamping:0.8
              initialSpringVelocity:0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             [self.labels enumerateObjectsUsingBlock:^(UILabel *label, NSUInteger idx, BOOL *stop) {
                                 label.textColor = index == idx ?  MainThemColor : UIColorFromRGB(0x666666);
                             }];
                         } completion:^(BOOL finished) {
                             [self.delegate onTabTapAction:index];
                         }];
    }
}

@end
