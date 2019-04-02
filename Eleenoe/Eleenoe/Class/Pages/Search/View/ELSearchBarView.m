//
//  ELSearchBarView.m
//  Eleenoe
//
//  Created by zhanglu on 2019/4/2.
//  Copyright © 2019 FaceBook. All rights reserved.
//

#import "ELSearchBarView.h"
#import "ELButtonExtention.h"
@interface ELSearchBarView ()<UITextFieldDelegate>
@property(nonatomic,strong)UITextField *textField;
@property(nonatomic,strong)ELButtonExtention *clearButton;
@end
@implementation ELSearchBarView

-(void)ELSinitConfingViews{
    self.layer.masksToBounds = YES;
    
    _maxLength = CGFLOAT_MAX;
    
    _clearButton = ({
        ELButtonExtention *btn = [ELButtonExtention buttonWithType:UIButtonTypeCustom];
        btn.size = CGSizeMake(18, 18);
        btn.isExpandClick = YES;
        [btn setBackgroundImage:[UIImage imageNamed:@"Clear"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"Clear"] forState:UIControlStateSelected];
        [btn setBackgroundImage:[UIImage imageNamed:@"Clear"]  forState:UIControlStateDisabled];
        [btn setBackgroundImage:[UIImage imageNamed:@"Clear"]  forState:UIControlStateHighlighted];
        btn.adjustsImageWhenHighlighted = NO;
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        btn.showsTouchWhenHighlighted = NO;
        btn.titleLabel.font = [UIFont ELPingFangSCRegularFontOfSize:13];
        [btn addTarget:self action:@selector(clearActiion:) forControlEvents:UIControlEventTouchUpInside];
        btn;
    });
    
    _textField  = ({
        UITextField *iv = [[UITextField alloc] init];
        iv.placeholder = @"搜索....";
        iv.textColor = UIColorFromRGB(0X333333);
        iv.font = [UIFont ELPingFangSCRegularFontOfSize:13];
        iv.rightViewMode = UITextFieldViewModeWhileEditing;
        iv.rightView =  self.clearButton;
        iv.delegate = self;
        iv.returnKeyType = UIReturnKeySearch;
        [iv addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [iv setValue:UIColorFromRGB(0Xbfbfbf) forKeyPath:@"_placeholderLabel.textColor"];
        [self addSubview:iv];
        iv;
    });
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.and.bottom.mas_equalTo(0);
        make.right.mas_equalTo(-15);
    }];
}

-(void)setSearchText:(NSString *)searchText{
    _searchText = searchText;
    self.textField.text = searchText;
}
-(void)clearActiion:(UIButton *)sender{
    self.textField.text = @"";
    self.clearButton.hidden =!self.textField.hasText;
    if (self.delegate &&[self.delegate respondsToSelector:@selector(clearSearchBarView:)]) {
        [self.delegate clearSearchBarView:self];
    }
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    self.clearButton.hidden  = !textField.hasText;
    if (self.delegate &&[self.delegate respondsToSelector:@selector(searchBarView:ShouldBeginEditing:)]) {
        [self.delegate searchBarView:self ShouldBeginEditing:textField.text];
    }
    
    return YES;
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    if (self.delegate &&[self.delegate respondsToSelector:@selector(searchBarView:textFieldShouldReturn:)]) {
        [self.delegate searchBarView:self textFieldShouldReturn:textField.text];
    }
    return YES;
}
- (CGSize)intrinsicContentSize
{
    return UILayoutFittingExpandedSize;
    
}
-(void)searchbecomeFirstResponder{
    [self.textField becomeFirstResponder];
}
-(void)resignFirstResponder{
    [self.textField resignFirstResponder];
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (self.delegate &&[self.delegate respondsToSelector:@selector(searchBarView:textFieldDidEndEditing:)]) {
        [self.delegate searchBarView:self textFieldDidEndEditing:textField.text];
    }
}
- (void)textFieldDidChange:(UITextField *)textField
{
    self.clearButton.hidden  = !textField.hasText;
    ELTitleInfo info = [NSString ELgetInfoWithText:textField.text maxLength:self.maxLength];
    if (info.length > self.maxLength) {
        textField.text = [textField.text substringWithRange:NSMakeRange(0, info.number)];
    }
    if (self.delegate &&[self.delegate respondsToSelector:@selector(searchBarView:textDidChange:)]) {
        
        [self.delegate searchBarView:self textDidChange:textField.text];
    }
}
-(NSString *)text{
    return self.textField.text;
}
@end
