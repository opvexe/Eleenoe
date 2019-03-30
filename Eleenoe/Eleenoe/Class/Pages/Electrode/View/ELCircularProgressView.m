//
//  ELCircularProgressView.m
//  Eleenoe
//
//  Created by FaceBook on 2019/3/30.
//  Copyright © 2019 FaceBook. All rights reserved.
//

#import "ELCircularProgressView.h"

@interface ELCircularProgressView()
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *contentLabel;
@property (nonatomic,strong) UILabel *timesLabel;
@property (nonatomic,strong) UIImageView *endPoint;
@property (nonatomic,strong) CAShapeLayer* progressLayer;
@end
@implementation ELCircularProgressView
static CGFloat endPointMargin = 1.0f;
-(void)ELSinitConfingViews{
    _lineWidth = 10.0; //默认10.0
    self.backgroundColor = [UIColor clearColor];
    CGFloat centerX = self.bounds.size.width/2.0;
    CGFloat centerY = self.bounds.size.height/2.0;
    CGFloat radius = (self.bounds.size.width-_lineWidth)/2.0;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(centerX, centerY) radius:radius startAngle:(-0.5f*M_PI) endAngle:1.5f*M_PI clockwise:YES];
    
    ///MARK:添加背景圆环
    CAShapeLayer *backLayer = [CAShapeLayer layer];
    backLayer.frame = self.bounds;
    backLayer.fillColor =  [[UIColor clearColor] CGColor];
    backLayer.strokeColor  = [UIColor whiteColor].CGColor;
    backLayer.lineWidth = _lineWidth;
    backLayer.path = [path CGPath];
    backLayer.strokeEnd = 1;
    [self.layer addSublayer:backLayer];
    
    ///创建进度layer
    _progressLayer = [CAShapeLayer layer];
    _progressLayer.frame = self.bounds;
    _progressLayer.fillColor =  [[UIColor clearColor] CGColor];
    _progressLayer.strokeColor  = [[UIColor blackColor] CGColor];
    _progressLayer.lineCap = kCALineCapRound;
    _progressLayer.lineWidth = _lineWidth;
    _progressLayer.path = [path CGPath];
    _progressLayer.strokeEnd = 0;
    
    //设置渐变颜色
    CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
    gradientLayer.frame = self.bounds;
    [gradientLayer setColors:[NSArray arrayWithObjects:(id)[MainThemColor CGColor], nil]];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1);
    [gradientLayer setMask:_progressLayer];
    [self.layer addSublayer:gradientLayer];
    
    //结束位置原点图标
    _endPoint = [[UIImageView alloc] init];
    _endPoint.frame = CGRectMake(0, 0, _lineWidth - endPointMargin*2,_lineWidth - endPointMargin*2);
    _endPoint.hidden = true;
    _endPoint.backgroundColor = [UIColor whiteColor];
    _endPoint.image = [UIImage imageNamed:@"endPoint"];
    _endPoint.layer.masksToBounds = true;
    _endPoint.layer.cornerRadius = _endPoint.bounds.size.width/2;
    [self addSubview:_endPoint];
    
    _titleLabel = ({
        UILabel *iv = [[UILabel alloc]init];
        iv.textColor = MainWhiteTitleColor;
        iv.textAlignment = NSTextAlignmentCenter;
        iv.font = [UIFont ELPingFangSCRegularFontOfSize:kSaFont(12.0)];
        iv.text = @"使用倒计时";
        [self addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(kSAdap_V(60.0));
            make.centerX.mas_equalTo(self);
            make.height.mas_equalTo(kSaFont(20.0));
            make.width.mas_lessThanOrEqualTo(kSAdap(180.0));
        }];
        iv;
    });
    
    _timesLabel = ({
        UILabel *iv = [[UILabel alloc]init];
        iv.textColor = MainWhiteTitleColor;
        iv.textAlignment = NSTextAlignmentCenter;
        iv.font = [UIFont ELPingFangSCMediumFontOfSize:kSaFont(40.0)];
        iv.text = @"00:00";
        [self addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.titleLabel.mas_bottom);
            make.width.mas_lessThanOrEqualTo(kSAdap(200.0));
            make.height.mas_equalTo(kSAdap_V(50.0));
            make.centerX.mas_equalTo(self);
        }];
        iv;
    });
    
    _contentLabel = ({
        UILabel *iv = [[UILabel alloc]init];
        iv.textColor = MainWhiteTitleColor;
        iv.textAlignment = NSTextAlignmentCenter;
        iv.font = [UIFont ELPingFangSCRegularFontOfSize:kSaFont(12.0)];
        iv.text = @"电极片初次使用";
        [self addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.timesLabel.mas_bottom).mas_offset(kSAdap_V(20.0));
            make.height.mas_equalTo(kSAdap_V(20.0));
            make.centerX.mas_equalTo(self);
            make.width.mas_lessThanOrEqualTo(kSAdap(180.0));
        }];
        iv;
    });
}

- (void)setProgress:(float)progress {
    if (progress >= 100.f) {
        _progress = 100.f;
    }
    _progress = progress;
    _progressLayer.strokeEnd = progress;
    [self updateEndPoint];
    [self setNeedsDisplay];
}

-(void)updateEndPoint{
    CGFloat angle = M_PI*2*_progress;
    float radius = (self.bounds.size.width-_lineWidth)/2.0;
    int index = (angle)/M_PI_2;
    float needAngle = angle - index*M_PI_2;
    float x = 0,y = 0;
    switch (index) {
        case 0:
            x = radius + sinf(needAngle)*radius;
            y = radius - cosf(needAngle)*radius;
            break;
        case 1:
            x = radius + cosf(needAngle)*radius;
            y = radius + sinf(needAngle)*radius;
            break;
        case 2:
            x = radius - sinf(needAngle)*radius;
            y = radius + cosf(needAngle)*radius;
            break;
        case 3:
            x = radius - cosf(needAngle)*radius;
            y = radius - sinf(needAngle)*radius;
            break;
        default:
            break;
    }
    
    CGRect rect = _endPoint.frame;
    rect.origin.x = x + endPointMargin;
    rect.origin.y = y + endPointMargin;
    _endPoint.frame = rect;
    
    [self bringSubviewToFront:_endPoint];
    _endPoint.hidden = false;
    if (_progress == 0 || _progress == 1) {
        _endPoint.hidden = true;
    }
}

@end
