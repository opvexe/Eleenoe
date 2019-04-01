//
//  ELMarqueLabel.m
//  Eleenoe
//
//  Created by FaceBook on 2019/3/31.
//  Copyright © 2019 FaceBook. All rights reserved.
//

#import "ELMarqueLabel.h"
#define labelMargin  20
@interface ELMarqueLabel ()
@property (nonatomic,strong) UILabel *animationLabel;
@property (strong, nonatomic) UIView * containerView;
@end
@implementation ELMarqueLabel

-(void)ELSinitConfingViews{
    
    _speed = 20.0;
    
    _containerView = ({
        UIView *iv = [[UIView alloc]initWithFrame:self.bounds];
        iv.backgroundColor = [UIColor clearColor];
        [self addSubview:iv];
        iv;
    });
    
    _animationLabel = ({
        UILabel *iv = [[UILabel alloc]init];
        iv.textAlignment = NSTextAlignmentLeft;
        iv.textColor =  UIColorFromRGB(0x8EC31F);
        iv.font = [UIFont ELPingFangSCRegularFontOfSize:12];
        [self.containerView addSubview:iv];
        iv;
    });
}

-(void)setText:(NSString *)text{
    _text = text;
    self.animationLabel.text = text;
}

-(void)setSpeed:(CGFloat)speed{
    _speed = speed;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self beReadyToAnimateFrame:CGRectMake(0, 0, self.width, self.height)];
}

- (void)beReadyToAnimateFrame:(CGRect)frame {
    
    CGRect rect = [self.animationLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont ELPingFangSCRegularFontOfSize:12]} context:nil];
    if (rect.size.width <= frame.size.width) {
        _animationLabel.frame = frame;
        [_containerView.layer removeAnimationForKey:@"containerView animation"];
        
    } else {
        _animationLabel.frame = CGRectMake(0, 0, frame.size.width, self.frame.size.height);
        [self startToAnimate];
    }
}

- (void)startToAnimate{
    CABasicAnimation * animate = [CABasicAnimation animation];
    animate.fromValue = @(0);
    animate.toValue=@( - _animationLabel.frame.size.width - labelMargin);
    animate.keyPath = @"transform.translation.x";
    animate.duration = (_animationLabel.frame.size.width + labelMargin) / _speed;
    animate.removedOnCompletion = YES;
    animate.repeatCount = MAXFLOAT;
    [_containerView.layer addAnimation:animate forKey:@"containerView animation"];
}

@end
