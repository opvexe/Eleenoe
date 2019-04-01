//
//  ELMarqueLabel.h
//  Eleenoe
//
//  Created by FaceBook on 2019/3/31.
//  Copyright © 2019 FaceBook. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ELMarqueLabel : UIScrollView

@property (nonatomic, strong) NSString *text; // 设置文字

@property(nonatomic,assign) float rollSpeed; // 滚动速度，默认0.5

-(instancetype)initWithFrame:(CGRect)frame font:(UIFont *)font textColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
