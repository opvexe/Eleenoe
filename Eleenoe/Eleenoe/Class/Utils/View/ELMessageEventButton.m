//
//  ELMessageEventButton.m
//  Eleenoe
//
//  Created by FaceBook on 2019/3/13.
//  Copyright © 2019 FaceBook. All rights reserved.
//

#import "ELMessageEventButton.h"
@interface ELMessageEventButton (){
    NSUInteger _countdown;
    NSTimer * _countdownTimer;
}
@end
@implementation ELMessageEventButton
@synthesize normalStateImageName = _normalStateImageName;
@synthesize highlightedStateImageName;
@synthesize selectedStateImageName;
@synthesize normalStateBgImageName;
@synthesize highlightedStateBgImageName;
@synthesize selectedStateBgImageName;

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupBackgroundNotification];
    }
    return self;
}

- (id)initWithCoder: (NSCoder *)aDecoder {
    self = [super initWithCoder: aDecoder];
    if (self) {
        
        [self setupBackgroundNotification];
    }
    return self;
}

- (void)setupBackgroundNotification {
    
    [self setupSendSNSCodeButton];
    //页面将要进入前台，开启定时器
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(distantPastTimer)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];
    
    //页面消失，进入后台不显示该页面，关闭定时器
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(distantFutureTimer)
                                                 name:UIApplicationDidEnterBackgroundNotification
                                               object:nil];
    
}

- (void)setupSendSNSCodeButton {
    [self setBackgroundImage:[UIImage imageNamed:self.normalStateBgImageName]?:[UIImage imageWithColor:[UIColor redColor]] forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageNamed:self.selectedStateBgImageName]?:[UIImage imageWithColor:[UIColor redColor]] forState:UIControlStateHighlighted];
    [self setBackgroundImage:[UIImage imageWithColor:UIColorFromRGB(0x7b7b7b)] forState:UIControlStateDisabled];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [self addTarget:self action:@selector(receiveCode) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)receiveCode{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(ClickedWithMessageButton:)]) {
        [self.delegate ClickedWithMessageButton:self];
    }
    
}

-(void)startBeginNumber{
    self.userInteractionEnabled = NO;
    _countdown = self.countdownBeginNumber - 1;
    self.selected =YES;
    [self setTitle:[NSString stringWithFormat:@"重新获取(%zd)",self.countdownBeginNumber - 1] forState:UIControlStateSelected];
    _countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(closeGetVerifyButtonUser) userInfo:nil repeats:YES];
    
}

-(void)closeGetVerifyButtonUser{
    _countdown = _countdown-1;
    self.userInteractionEnabled = NO;
    self.selected =YES;
    [self setTitle:[NSString stringWithFormat:@"重新获取(%zd)",_countdown] forState:UIControlStateSelected];
    if(_countdown == 0){
        self.userInteractionEnabled = YES;
        self.selected=NO;
        [self setTitle:@"重新获取" forState:UIControlStateNormal];
        _countdown = self.countdownBeginNumber - 1;
        //注意此处不是暂停计时器,而是彻底注销,使_countdownTimer.valid == NO;
        [_countdownTimer invalidate];
    }
}
//页面将要进入前台，开启定时器
-(void)distantPastTimer
{
    if([_countdownTimer isValid]&&(_countdown >0))
        //开启定时器
        [_countdownTimer setFireDate:[NSDate distantPast]];
}

//页面消失，进入后台不显示该页面，关闭定时器
-(void)distantFutureTimer{
    if([_countdownTimer isValid]&&(_countdown >0))
        //关闭定时器
        [_countdownTimer setFireDate:[NSDate distantFuture]];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:Nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidEnterBackgroundNotification object:Nil];
}

@end
