//
//  ELLoginViewController.m
//  Eleenoe
//
//  Created by FaceBook on 2019/3/12.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import "ELLoginViewController.h"
#import "ELMessageEventButton.h"
@interface ELLoginViewController ()<ELMessageEventButtonDelegate,UITextFieldDelegate>
@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, strong) UITextField *iphoneTextField;
@property (nonatomic, strong) UITextField *authCodeTextField;
@property (nonatomic, strong) UIImageView *logoImageView;
@property (nonatomic, strong) ELMessageEventButton *messageEventButton;
@property (nonatomic, strong) UIButton *weixinButton;
@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic,strong) UIView *iphoneView;
@property (nonatomic,strong) UIView *authCodeView;
@end

@implementation ELLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configViews];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

-(void)configViews{
    
    _authCodeView = ({
        UIView *iv = [[UIView alloc]init];
        iv.backgroundColor = [UIColor whiteColor];
        iv.clipsToBounds = YES;
        iv.layer.borderColor = [UIColor lightGrayColor].CGColor;
        iv.layer.borderWidth = 0.5;
        iv.layer.cornerRadius = kSAdap_V(15.0);
        [self.view addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(kSAdap(15.0));
            make.right.mas_equalTo(kSAdap(-15.0));
            make.centerY.mas_equalTo(self.view).mas_offset(kSAdap_V(-40.0));
            make.height.mas_equalTo(kSAdap_V(35.0));
        }];
        iv;
    });
    
    _messageEventButton = ({
        ELMessageEventButton *iv = [ELMessageEventButton buttonWithType:UIButtonTypeCustom];
        [iv setTitle:@"获取验证码" forState:UIControlStateNormal];
        [iv setTitle:@"获取验证码" forState:UIControlStateHighlighted];
        [iv setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        [iv setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateHighlighted];
        [iv.titleLabel  setFont:[UIFont ELHelveticaFontOfSize:kSaFont(13.0)]];
        [iv setTitleColor:UIColorFromRGB(0xff758c) forState:UIControlStateNormal];
        [iv setTitleColor:UIColorFromRGB(0xff758c) forState:UIControlStateHighlighted];
        [iv setTitleColor:UIColorFromRGB(0x909090) forState:UIControlStateSelected];
        iv.showsTouchWhenHighlighted=NO;
        iv.countdownBeginNumber                      = 60;
        iv.delegate                                  = self;
        iv.clipsToBounds =YES;
        [self.authCodeView addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.view).mas_offset(kSAdap_V(-40.0));
            make.width.mas_equalTo(kSAdap(80.0));
            make.right.mas_equalTo(kSAdap(-15.0));
            make.height.mas_equalTo(self.authCodeView);
        }];
        iv;
    });
    
    _authCodeTextField = ({
        UITextField *iv = [[UITextField alloc]init];
        iv.font  = [UIFont ELHelveticaFontOfSize:kSaFont(16.0)];
        iv.clearButtonMode = UITextFieldViewModeWhileEditing;
        iv.textColor =UIColorFromRGB(0x323232);
        iv.placeholder =@"请输入验证码";
        [iv setValue:UIColorFromRGB(0x777777) forKeyPath:@"_placeholderLabel.textColor"];
        iv.keyboardType = UIKeyboardTypeNumberPad;
        iv.borderStyle =UITextBorderStyleNone;
        [self.authCodeView addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.messageEventButton);
            make.left.mas_equalTo(kSAdap(15.0));
            make.height.mas_equalTo(self.authCodeView);
            make.right.mas_equalTo(self.messageEventButton.mas_left);
        }];
        iv;
    });
    
    
    _iphoneView = ({
        UIView *iv = [[UIView alloc]init];
        iv.backgroundColor = [UIColor whiteColor];
        iv.clipsToBounds = YES;
        iv.layer.borderColor = [UIColor lightGrayColor].CGColor;
        iv.layer.borderWidth = 0.5;
        iv.layer.cornerRadius = kSAdap_V(15.0);
        [self.view addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(kSAdap(15.0));
            make.right.mas_equalTo(kSAdap(-15.0));
            make.bottom.mas_equalTo(self.authCodeTextField.mas_top).mas_offset(kSAdap_V(-20.0));
            make.height.mas_equalTo(kSAdap_V(35.0));
        }];
        iv;
    });
    
    _iphoneTextField = ({
        UITextField *iv = [[UITextField alloc]init];
        iv.font  = [UIFont ELHelveticaFontOfSize:kSaFont(16.0)];
        iv.clearButtonMode = UITextFieldViewModeWhileEditing;
        iv.textColor =UIColorFromRGB(0x323232);
        iv.placeholder =@"请输入手机号";
        [iv setValue:UIColorFromRGB(0x777777) forKeyPath:@"_placeholderLabel.textColor"];
        iv.keyboardType = UIKeyboardTypeNumberPad;
        iv.borderStyle =UITextBorderStyleNone;
        [iv becomeFirstResponder];
        iv.delegate =  self;
        [iv addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [self.iphoneView addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(kSAdap(15.0));
            make.right.mas_equalTo(kSAdap(-10.0));
            make.height.mas_equalTo(self.iphoneView);
            make.centerY.mas_equalTo(self.iphoneView);
        }];
        iv;
    });
    
    _logoImageView = ({
        UIImageView *iv = [[UIImageView alloc]init];
        iv.image = [UIImage imageNamed:@""];
        [self.view addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.iphoneView.mas_top).mas_offset(kSAdap_V(30.0));
            make.size.mas_equalTo(CGSizeMake(kSAdap(120.0), kSAdap_V(40.0)));
        }];
        iv;
    });
    
    _loginButton = ({
        UIButton *iv = [UIButton buttonWithType:UIButtonTypeCustom];
        [iv setBackgroundImage:[UIImage imageWithColor:[UIColor redColor]] forState:UIControlStateNormal];
        [iv setBackgroundImage:[UIImage imageWithColor:[UIColor redColor]] forState:UIControlStateHighlighted];
        [iv .titleLabel setFont:[UIFont ELHelveticaFontOfSize:kSaFont(16.0)]];
        [iv setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [iv setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [iv setTitle:@"登录" forState:UIControlStateNormal];
        [iv setTitle:@"登录" forState:UIControlStateHighlighted];
        iv.showsTouchWhenHighlighted=NO;
        iv.layer.masksToBounds = YES;
        iv.layer.cornerRadius = kSAdap_V(20.0);
        [iv addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(kSAdap(15.0));
            make.right.mas_equalTo(kSAdap(-15.0));
            make.height.mas_equalTo(kSAdap_V(40.0));
            make.centerY.mas_equalTo(self.view).mas_offset(kSAdap_V(40.0));
        }];
        iv;
    });
    
    _tipLabel = ({
        UILabel *iv = [[UILabel alloc]init];
        iv.text =@"其他登录方式";
        iv.font =[UIFont ELHelveticaFontOfSize:kSaFont(13.0)];
        iv.textColor = [UIColor lightGrayColor];
        iv.textAlignment = NSTextAlignmentCenter;
        iv.numberOfLines = 1;
        [self.view addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self.loginButton);
            make.top.mas_equalTo(self.loginButton.mas_bottom).mas_offset(kSAdap_V(40.0));
            make.height.mas_equalTo(kSAdap_V(20.0));
        }];
        iv;
    });
    
    _weixinButton = ({
        UIButton *iv = [UIButton buttonWithType:UIButtonTypeCustom];
        [iv setBackgroundImage:[UIImage imageNamed:@"weixin"] forState:UIControlStateNormal];
        [iv setBackgroundImage:[UIImage imageNamed:@"weixin"] forState:UIControlStateHighlighted];
        [iv setBackgroundImage:[UIImage imageNamed:@"weixin"] forState:UIControlStateDisabled];
        [iv setBackgroundImage:[UIImage imageNamed:@"weixin"] forState:UIControlStateSelected];
        [iv addTarget:self action:@selector(weixinAction:) forControlEvents:UIControlEventTouchUpInside];
        iv.showsTouchWhenHighlighted = NO;
        [self.view addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.view);
            make.top.mas_equalTo(self.tipLabel.mas_bottom).mas_offset(kSAdap_V(15.0));
            make.size.mas_equalTo(CGSizeMake(kSAdap(25.0), kSAdap_V(20.0)));
        }];
        iv;
    });
    
}

#pragma mark - ELMessageEventButtonDelegate
-(void)ClickedWithMessageButton:(ELMessageEventButton*)messageButton{
    if (![NSString phoneNumberValidity:self.iphoneTextField.text]) {
        [self makeToast:@"请输入正确的手机号"];
        return;
    }
    
}

#pragma mark - TextFieldDelegate
-(void)textFieldDidChange:(UITextField *)textField{
    if ([textField isEqual:self.iphoneTextField]) {
        if (textField.text.length >11) {
            self.iphoneTextField.text = [textField.text substringToIndex:11];
        }else{
            self.iphoneTextField.text = textField.text;
        }
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Weixin
-(void)weixinAction:(UIButton *)sender{
    
}

#pragma mark - loginActoion
-(void)loginAction:(UIButton *)sender{
    
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
