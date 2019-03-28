//
//  ELCauseShowView.m
//  Eleenoe
//
//  Created by FaceBook on 2019/3/28.
//  Copyright © 2019 FaceBook. All rights reserved.
//

#import "ELCauseShowView.h"

@interface ELCauseShowView()<UIGestureRecognizerDelegate>
@property(nonatomic,strong)UIView *container;
@end
@implementation ELCauseShowView

- (instancetype)initWithCauseModel:(id)model{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.frame = [UIScreen mainScreen].bounds;
        [self configView];
    }
    return self;
}

-(void)configView{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Tap:)];
    tap.delegate = self;
    [self addGestureRecognizer:tap];
    
    
}

#pragma mark - 懒加载
-(UIView *)container{
    if (!_container) {
        _container = [[UIView alloc]init];
    }
    return _container;
}

#pragma mark - Tap
-(void)Tap:(UITapGestureRecognizer *)sender{
    
}

@end
