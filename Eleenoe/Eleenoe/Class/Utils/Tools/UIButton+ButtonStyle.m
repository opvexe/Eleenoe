//
//  UIButton+ButtonStyle.m
//  XMButtonStyle
//
//  Created by Facebook on 2018/4/19.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "UIButton+ButtonStyle.h"

@implementation UIButton (ButtonStyle)

- (void)layoutTextWithImageButtonStyle:(layoutTextWithImageButtonStyle)style withSpace:(CGFloat)space{
    
    switch (style) {
        case LayoutTextUnderImageButton:{  ///图片在上 
            
            if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {

                self.titleEdgeInsets = (UIEdgeInsets){
                    .top    = 0,
                    .left   = -self.currentImage.size.width,
                    .bottom = -self.currentImage.size.height - space,
                    .right  = 0,
                };
                
                self.imageEdgeInsets = (UIEdgeInsets){
                    .top    = -self.titleLabel.intrinsicContentSize.height - space,
                    .left   = 0,
                    .bottom = 0,
                    .right  = -self.titleLabel.intrinsicContentSize.width,
                };

            } else {
                
                self.titleEdgeInsets = (UIEdgeInsets){
                    .top    = 0,
                    .left   = -self.currentImage.size.width,
                    .bottom = -self.currentImage.size.height - space,
                    .right  = 0,
                };
                
                self.imageEdgeInsets = (UIEdgeInsets){
                    .top    = -self.titleLabel.frame.size.height - space,
                    .left   = 0,
                    .bottom = 0,
                    .right  = -self.titleLabel.frame.size.width,
                };
            }
            
         
        }
            break;
        case layoutTextLeftImageButton:{  ///图片在右
            
                if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
                    
                    self.titleEdgeInsets = (UIEdgeInsets){
                        .top    = 0,
                        .left   = -self.currentImage.size.width - space,
                        .bottom = 0,
                        .right  = self.currentImage.size.width + space,
                    };
                    
                    self.imageEdgeInsets = (UIEdgeInsets){
                        .top    = 0,
                        .left   = self.titleLabel.intrinsicContentSize.width + space,
                        .bottom = 0,
                        .right  = -self.titleLabel.intrinsicContentSize.width - space,
                    };
                    
                }else{
                    
                    self.titleEdgeInsets = (UIEdgeInsets){
                        .top    = 0,
                        .left   = -self.currentImage.size.width,
                        .bottom = 0,
                        .right  = self.currentImage.size.width,
                    };
                    
                    self.imageEdgeInsets = (UIEdgeInsets){
                        .top    = 0,
                        .left   = self.titleLabel.frame.size.width + space,
                        .bottom = 0,
                        .right  = -self.titleLabel.frame.size.width - space,
                    };
                }
        }
            break;
            
        case layoutTextRightImageButton:{ ///图片在左
            
            self.titleEdgeInsets = (UIEdgeInsets){
                .top    = 0,
                .left   = space,
                .bottom = 0,
                .right  = -space,
            };
            
            self.imageEdgeInsets = (UIEdgeInsets){
                .top    = 0,
                .left   = -space,
                .bottom = 0,
                .right  = space,
            };
        }
            break;
            
        case layoutTextUpImageButton:{  ///图片在下
            
             if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
                 
                 self.titleEdgeInsets = (UIEdgeInsets){
                     .top    = -self.currentImage.size.height - space,
                     .left   = -self.currentImage.size.width,
                     .bottom = 0,
                     .right  = 0,
                 };
                 
                 self.imageEdgeInsets = (UIEdgeInsets){
                     .top    = 0,
                     .left   = 0,
                     .bottom = -self.titleLabel.intrinsicContentSize.height -space,
                     .right  = -self.titleLabel.intrinsicContentSize.width,
                 };

             }else{
                 
                 self.titleEdgeInsets = (UIEdgeInsets){
                     .top    = -self.currentImage.size.height - space,
                     .left   = -self.currentImage.size.width,
                     .bottom = 0,
                     .right  = 0,
                 };
                 
                 self.imageEdgeInsets = (UIEdgeInsets){
                     .top    = 0,
                     .left   = 0,
                     .bottom = -self.titleLabel.frame.size.height -space,
                     .right  = -self.titleLabel.frame.size.width,
                 };
             }
        }
            break;
            
        default:
            break;
    }
}

@end

