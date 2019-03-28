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
    
    _container = ({
        UIView *iv = [[UIView alloc]init];
        iv.backgroundColor = [UIColor blackColor];
        iv.frame = CGRectMake(0.0f, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height*3/4);
        [self addSubview:iv];
        iv;
    });
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0.0f, 0.0f, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height*3/4) byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(15.0f, 15.0f)];
    CAShapeLayer *layer =[[CAShapeLayer alloc] init];
    [layer setPath:path.CGPath];
    self.container.layer.mask = layer;
}


#pragma mark - Tap
-(void)Tap:(UITapGestureRecognizer *)sender{
    
}

@end
