//
//  ELTextView.h
//  Eleenoe
//
//  Created by FaceBook on 2019/3/13.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ELTextView : UITextView

@property (nonatomic,strong) NSString *placeholder;

@property (nonatomic,strong) UIColor *placeholderColor;

@property (nonatomic,strong) UIFont * placeholderFont;


@end

NS_ASSUME_NONNULL_END
