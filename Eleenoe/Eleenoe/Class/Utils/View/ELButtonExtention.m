//
//  ELButtonExtention.m
//  Eleenoe
//
//  Created by zhanglu on 2019/3/29.
//  Copyright © 2019 FaceBook. All rights reserved.
//

#import "ELButtonExtention.h"

@implementation ELButtonExtention
- (void)setHighlighted:(BOOL)highlighted{
    
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    switch (self.type) {
        case ButtonDisplayTypeImageLeftTileRight:{
            self.titleLabel.left = 0;
            self.imageView.left = CGRectGetMaxX(self.titleLabel.frame)+5;
            break;
        }
        case ButtonDisplayTypeImageRightTileleft:{
            self.imageView.left = 2;
            self.imageView.contentMode = UIViewContentModeScaleAspectFit;
            self.titleLabel.left = CGRectGetMaxX(self.imageView.frame)+5;
            [self.titleLabel sizeToFit];
            break;
        }
        case ButtonDisplayTypeImageUpTileDown   :{
            self.imageView.top =1;
            self.imageView.centerX = self.width * 0.5;
            self.titleLabel.top = CGRectGetMaxY(self.imageView.frame)+8;
            [self.titleLabel sizeToFit]; // 文字长度自适应
            self.titleLabel.centerX = self.width * 0.5;
            break;
        }
        case ButtonDisplayTypeImageUpTile:{
            self.imageView.contentMode = UIViewContentModeCenter;
            self.titleLabel.textAlignment = NSTextAlignmentCenter;
            
            self.imageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.width);
            self.titleLabel.frame = CGRectMake(0, self.frame.size.width, self.frame.size.width, self.frame.size.height - self.frame.size.width);
            
            break;
        }
        default:{
            [super layoutSubviews];
        }
            break;
    }
    
}
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if (self.isExpandClick) {
        CGFloat min_x = -40.0;
        CGFloat min_y = -40.0;
        CGFloat max_x = self.frame.size.width + 40;
        CGFloat max_y = self.frame.size.height + 40;
        if (point.x <= max_x && point.x >= min_x && point.y <= max_y && point.y >= min_y) {
            point = CGPointMake(0, 0);
            return [super hitTest:point withEvent:event];
        }else {
            return [super hitTest:point withEvent:event];
        }
    }
    
    return [super hitTest:point withEvent:event];
}
@end
