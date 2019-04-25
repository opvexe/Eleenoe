//
//  ELHorseRaceLamp.m
//  Eleenoe
//
//  Created by FaceBook on 2019/4/25.
//  Copyright © 2019 FaceBook. All rights reserved.
//

#import "ELHorseRaceLamp.h"
@interface ELHorseRaceLamp ()

/**
 * method 定时器
 */
@property (nonatomic, strong) dispatch_source_t timer;


@end

@implementation ELHorseRaceLamp

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.clipsToBounds = YES;
        self.isScorll = YES;
        [self addSubview:self.titleLab];
    }
    return self;
}

- (void)updateTextAlignmentLeft {
    self.titleLab.textAlignment = NSTextAlignmentLeft;
}

- (void)updateTextAlignmentCenter {
    self.titleLab.textAlignment = NSTextAlignmentCenter;
}

- (void)setText:(NSString *)text {
    _text = text;
    [self updateWithText:text];
}

- (void)setAttributedString:(NSAttributedString *)attributedString {
    _attributedString = attributedString;
    [self updateWithText:attributedString];
}

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    self.titleLab.textColor = textColor;
}

- (void)setTextFont:(UIFont *)textFont {
    _textFont = textFont;
    self.titleLab.font = textFont;
}

- (void)updateWithText:(id)title {
    _currentTitleX = 0;
    
    if (self.timer) {
        dispatch_cancel(self.timer);
        self.timer = nil;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if ([title isKindOfClass:[NSString class]]) {
            self.titleLab.text = title;
        }else if ([title isKindOfClass:[NSAttributedString class]]){
            self.titleLab.attributedText = title;
        }
        //计算textLb大小
//        CGSize size = [title boundingRectWithSize:(CGSizeMake(CGFLOAT_MAX, 30)) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading  context:nil].size;
        CGSize sizeOfText = [self.titleLab sizeThatFits:CGSizeZero];
        self.titleLab.frame = CGRectMake((self.frame.size.width - sizeOfText.width)/2, (self.frame.size.height - sizeOfText.height)/2, sizeOfText.width, sizeOfText.height);
        //判断是否需要 滚动
        BOOL useReserve = (sizeOfText.width > self.frame.size.width) && self.isScorll ? YES : NO;
        if (useReserve) {
            
            self.titleLab.frame = CGRectMake(0, self.titleLab.frame.origin.y, self.titleLab.frame.size.width, self.titleLab.frame.size.height);
            
            __weak __typeof(self)weakSelf = self;
            dispatch_queue_t queue = dispatch_get_main_queue();
            self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
            dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC));
            uint64_t interval = (uint64_t)(0.03 * NSEC_PER_SEC);
            dispatch_source_set_timer(self.timer, start, interval, 0);
            dispatch_source_set_event_handler(self.timer, ^{
                [weakSelf startAnimate];
            });
            dispatch_resume(self.timer);
        }
        else {
            self.titleLab.frame = self.bounds;
        }
    });
}



- (void)startAnimate {
    
    _currentTitleX = _currentTitleX - 1;
    
    self.titleLab.frame = CGRectMake(_currentTitleX, self.titleLab.frame.origin.y, self.titleLab.frame.size.width, self.titleLab.frame.size.height);
    if (fabs(self.titleLab.frame.origin.x) >= self.titleLab.frame.size.width + distanceInterval && _currentTitleX < 0) {
        _currentTitleX = self.right;
    }
}


#pragma mark - getter

- (UILabel *)titleLab {
    if (_titleLab == nil) {
        _titleLab = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.backgroundColor = [UIColor clearColor];
        _titleLab.textColor = [UIColor whiteColor];
        _titleLab.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
        _titleLab.opaque = YES;
    }
    return _titleLab;
}


- (void)dealloc {
    if (self.timer) {
        dispatch_cancel(self.timer);
        self.timer = nil;
    }
}

@end
