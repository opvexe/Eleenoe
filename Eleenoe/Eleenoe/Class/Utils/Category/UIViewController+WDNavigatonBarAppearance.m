//
//  UIViewController+WDNavigatonBarAppearance.m
//  AcneTreatment
//
//  Created by Facebook on 2018/8/3.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "UIViewController+WDNavigatonBarAppearance.h"
#import <Masonry.h>
@implementation UIViewController (WDNavigatonBarAppearance)

-(void)popBack{
    if(self.navigationController!=nil){
        if (self.navigationController.childViewControllers.count ==1) {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else{
            [self.navigationController popViewControllerAnimated:YES];
        }
        return;
    }
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

- (void)addPopBackBarButtonItem{
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = -7;
    UIButton* leftBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"navigBarHidden_back"] forState:UIControlStateNormal];
    leftBtn.frame = CGRectMake(0, 5, 20, 30);
    [leftBtn addTarget:self action:@selector(popBack) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    UIBarButtonItem* leftBtnItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItems = @[negativeSpacer, leftBtnItem];
}

- (UILabel *)navTitleLabelWithTitle:(NSString *)title{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.font = [UIFont ELPingFangSCRegularFontOfSize:kSaFont(16)];
    label.text = title;
    label.textColor = UIColorFromRGB(0x333333);
    [label sizeToFit];
    self.navigationItem.titleView = label;
    return label;
}

- (void)pushViewControllerWithViewControllerClass:(Class)viewControllerClass{
    UIViewController *bvc = [[viewControllerClass alloc] init];
    if (bvc) {
        [self.navigationController pushViewController:bvc animated:YES
         ];
    }
}

- (UIBarButtonItem *)lefButtonWithView:(UIView *)view{
    UIBarButtonItem *barButtonItem =[[UIBarButtonItem alloc] initWithCustomView:view];
    UIBarButtonItem *flexibleSpaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    flexibleSpaceItem.width = -5;
    self.navigationItem.leftBarButtonItems = @[flexibleSpaceItem, barButtonItem];
    return barButtonItem;
}

- (UIBarButtonItem *)backBarButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action {
    UIButton *colorView = [UIButton buttonWithType:UIButtonTypeCustom];
    [colorView setFrame:CGRectMake(0, 0, 64, 44)];
    UIImageView *image_view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navigBarHidden_back"]];
    [colorView addSubview:image_view];
    [image_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(colorView);
        make.centerY.equalTo(colorView);
        make.size.mas_equalTo(CGSizeMake(15, 25));
    }];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.text = title;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:14.0];
    [label sizeToFit];
    [colorView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(image_view.mas_right);
        make.centerY.equalTo(colorView);
    }];
    [colorView addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btn_left =[[UIBarButtonItem alloc] initWithCustomView:colorView];
    return btn_left;
}

- (UIBarButtonItem *)leftBarButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat width = [self getWidthWithContent:title height:44 UIFont:[UIFont systemFontOfSize:14.0]];
    [button setFrame:CGRectMake(0, 0, width, 44)];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButtonItem =[[UIBarButtonItem alloc] initWithCustomView:button];
    
    UIBarButtonItem *fixedButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedButton.width = -5;
    self.navigationItem.leftBarButtonItems = @[fixedButton, barButtonItem];
    return barButtonItem;
}

- (UIBarButtonItem *)leftBarButtonWithImage:(UIImage *)image target:(id)target action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, 44, 44)];
    button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 44 - image.size.width);
    [button setImage:image forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButtonItem =[[UIBarButtonItem alloc] initWithCustomView:button];
    UIBarButtonItem *fixedButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedButton.width = -5;
    self.navigationItem.leftBarButtonItems = @[fixedButton, barButtonItem];
    
    return barButtonItem;
}

- (UIBarButtonItem *)leftBarButtonWithImage:(UIImage *)image  selected:(UIImage *)selectedImage target:(id)target action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, 44, 44)];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:selectedImage forState:UIControlStateSelected];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButtonItem =[[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = barButtonItem;
    UIBarButtonItem *flexibleSpaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    flexibleSpaceItem.width = -5;
    self.navigationItem.leftBarButtonItems = @[flexibleSpaceItem, barButtonItem];
    return barButtonItem;
}

- (UIBarButtonItem *)rightBarButtonWithView:(UIView *)view{
    UIBarButtonItem *barButtonItem =[[UIBarButtonItem alloc] initWithCustomView:view];
    UIBarButtonItem *flexibleSpaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    flexibleSpaceItem.width = -5;
    self.navigationItem.rightBarButtonItems = @[flexibleSpaceItem, barButtonItem];
    return barButtonItem;
}

- (UIBarButtonItem *)rightBarButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor target:(id)target action:(SEL)action {
    return [self rightBarButtonWithTitle:title titleColor:titleColor font:[UIFont systemFontOfSize:14.0] target:target action:action];
}

- (UIBarButtonItem *)rightBarButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font target:(id)target action:(SEL)action{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat width = [self getWidthWithContent:title height:44 UIFont:font];
    [button setFrame:CGRectMake(0, 0, width + 4, 44)];
    if (titleColor) {
        [button setTitleColor:titleColor forState:UIControlStateNormal];
    } else {
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = font;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButtonItem =[[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = barButtonItem;
    
    UIBarButtonItem *flexibleSpaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    flexibleSpaceItem.width = -5;
    self.navigationItem.rightBarButtonItems = @[flexibleSpaceItem, barButtonItem];
    
    return barButtonItem;
}

- (UIBarButtonItem *)rightBarButtonWithImage:(UIImage *)image target:(id)target action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, 44, 44)];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:image forState:UIControlStateDisabled];
    [button setImage:image forState:UIControlStateHighlighted];
    [button setImage:image forState:UIControlStateSelected];
    button.showsTouchWhenHighlighted =NO;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButtonItem =[[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = barButtonItem;
    UIBarButtonItem *flexibleSpaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    flexibleSpaceItem.width = -5;
    self.navigationItem.rightBarButtonItems = @[flexibleSpaceItem, barButtonItem];
    return barButtonItem;
}

- (UIBarButtonItem *)rightBarButtonWithImage:(UIImage *)image  selected:(UIImage *)selectedImage target:(id)target action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, 44, 44)];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:selectedImage forState:UIControlStateSelected];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButtonItem =[[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = barButtonItem;
    UIBarButtonItem *flexibleSpaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    flexibleSpaceItem.width = -5;
    self.navigationItem.rightBarButtonItems = @[flexibleSpaceItem, barButtonItem];
    return barButtonItem;
}

//根据高度度求宽度  content 计算的内容  Height 计算的高度 font字体
- (CGFloat)getWidthWithContent:(NSString *)content height:(CGFloat)height UIFont:(UIFont *)font {
    CGRect rect = [content boundingRectWithSize:CGSizeMake(MAXFLOAT, height)
                                        options:NSStringDrawingUsesLineFragmentOrigin
                                     attributes:@{NSFontAttributeName:font}
                                        context:nil];
    return rect.size.width;
    
}
@end
