//
//  ELHorseRaceLamp.h
//  Eleenoe
//
//  Created by FaceBook on 2019/4/25.
//  Copyright © 2019 FaceBook. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
//2个lab的间隔
static CGFloat const distanceInterval = 0;

@interface ELHorseRaceLamp : UIView

@property (nonatomic,copy) NSString * text;
@property (nonatomic,copy) NSAttributedString * attributedString;
@property (nonatomic,strong) UIColor * textColor;
@property (nonatomic,strong) UIFont * textFont;
@property (nonatomic,assign) BOOL isScorll;

- (void)updateTextAlignmentLeft;

- (void)updateTextAlignmentCenter;

/**
 * method 2个title
 */
@property (nonatomic,strong) UILabel * titleLab;

/**
 * method 控制2个title的origin.x
 */
@property (nonatomic,assign,readonly) CGFloat currentTitleX;

@end

NS_ASSUME_NONNULL_END
