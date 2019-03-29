//
//  ELTextField.m
//  Eleenoe
//
//  Created by FaceBook on 2019/3/28.
//  Copyright © 2019 FaceBook. All rights reserved.
//

#import "ELTextField.h"

@implementation ELTextField
{
    CGFloat _padding;
}

- (instancetype)initWithImage:(UIImage *)image padding:(CGFloat)padding
{
    self = [super init];
    if (self) {
        _padding = padding;
        if(image){
            UIImageView *leftView = [[UIImageView alloc] initWithImage:image];
            leftView.frame = CGRectMake(0, 0, 30, 20);
            leftView.contentMode = UIViewContentModeLeft;
            self.leftView = leftView;
        }else{
            UIImageView *leftView = [[UIImageView alloc] init];
            leftView.frame = CGRectMake(0, 0, 0,0);
            leftView.contentMode = UIViewContentModeLeft;
            self.leftView = leftView;
        }
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    return self;
}

- (CGRect)leftViewRectForBounds:(CGRect)bounds
{
    CGRect frame = [super leftViewRectForBounds:bounds];
    frame.origin.x += _padding;
    return frame;
}

- (CGRect)rightViewRectForBounds:(CGRect)bounds
{
    CGRect frame = [super rightViewRectForBounds:bounds];
    frame.origin.x -= _padding;
    return frame;
}

@end
