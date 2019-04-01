//
//  ELBatteryView.m
//  Eleenoe
//
//  Created by FaceBook on 2019/4/1.
//  Copyright © 2019 FaceBook. All rights reserved.
//

#import "ELBatteryView.h"

@implementation ELBatteryView

-(void)setProgress:(float)progress{
    _progress = progress;
    NSInteger currentIndex = 5;
    if (0<=progress<0.2) {
        currentIndex = 1;
    }else if (0.2<=progress<=0.4){
        currentIndex = 2;
    }else if (0.4<=progress<=0.6){
        currentIndex = 3;
    }else if (0.6<=progress<=0.8){
        currentIndex = 4;
    }else if (0.8<=progress<=1.0){
        currentIndex = 5;
    }
    
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    
    for (NSInteger index = 1; index<currentIndex+1; index++) {
        UIView *iv = [[UIView alloc]initWithFrame:CGRectMake(2*index+1, 3, 1, self.frame.size.height-6)];
        iv.backgroundColor = UIColorFromRGB(0xC3E282);
        [self addSubview:iv];
    }
}


-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    CGFloat w = rect.size.width;
    // 电池的高度
    CGFloat h = rect.size.height;
    // 电池的x的坐标
    CGFloat x = rect.origin.x;
    // 电池的y的坐标
    CGFloat y = rect.origin.y;
    
    UIBezierPath *path1 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(x, y, w, h) cornerRadius:2];
    CAShapeLayer *batteryLayer = [CAShapeLayer layer];
    batteryLayer.lineWidth = 1;
    batteryLayer.strokeColor = UIColorFromRGB(0xC3E282).CGColor;
    batteryLayer.fillColor = [UIColor clearColor].CGColor;
    batteryLayer.path = [path1 CGPath];
    [self.layer addSublayer:batteryLayer];
    
    UIBezierPath *path2 = [UIBezierPath bezierPath];
    [path2 moveToPoint:CGPointMake(x+w, y+h/3+1)];
    [path2 addLineToPoint:CGPointMake(x+w+2, y+h/3)];
    [path2 addLineToPoint:CGPointMake(x+w+2, y+h*2/3)];
    [path2 addLineToPoint:CGPointMake(x+w, y+h*2/3-1)];
    CAShapeLayer *layer2 = [CAShapeLayer layer];
    layer2.lineWidth = 1;
    layer2.strokeColor = UIColorFromRGB(0xC3E282).CGColor;
    layer2.fillColor = [UIColor clearColor].CGColor;
    layer2.path = [path2 CGPath];
    [self.layer addSublayer:layer2];
}

@end
