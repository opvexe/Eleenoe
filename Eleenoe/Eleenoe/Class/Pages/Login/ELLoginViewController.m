//
//  ELLoginViewController.m
//  Eleenoe
//
//  Created by FaceBook on 2019/3/12.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import "ELLoginViewController.h"
#import "ELMessageEventButton.h"
#import "ELHomeViewController.h"
#import "UITextField+ELFormatNumber.h"
@interface ELLoginViewController ()<ELMessageEventButtonDelegate,UITextFieldDelegate>
@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, strong) UITextField *iphoneTextField;
@property (nonatomic, strong) UITextField *authCodeTextField;
@property (nonatomic, strong) FLAnimatedImageView *logoImageView;
@property (nonatomic, strong) ELMessageEventButton *messageEventButton;
@property (nonatomic, strong) UIButton *weixinButton;
@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UIView *iphoneView;
@property (nonatomic, strong) UIView *authCodeView;
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
        iv.layer.borderColor = MainGrayBorderColor.CGColor;
        iv.layer.borderWidth = 0.5;
        iv.layer.cornerRadius = kSAdap_V(20.0);
        [self.view addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(kSAdap(15.0));
            make.right.mas_equalTo(kSAdap(-15.0));
            make.centerY.mas_equalTo(self.view).mas_offset(kSAdap_V(-45.0));
            make.height.mas_equalTo(kSAdap_V(40.0));
        }];
        iv;
    });
    
    _messageEventButton = ({
        ELMessageEventButton *iv = [ELMessageEventButton buttonWithType:UIButtonTypeCustom];
        [iv setTitle:@"获取验证码" forState:UIControlStateNormal];
        [iv setTitle:@"获取验证码" forState:UIControlStateHighlighted];
        [iv setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        [iv setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateHighlighted];
        [iv.titleLabel  setFont:[UIFont ELPingFangSCRegularFontOfSize:kSaFont(12.0)]];
        [iv setTitleColor:MainBlackTitleColor forState:UIControlStateNormal];
        [iv setTitleColor:MainBlackTitleColor forState:UIControlStateHighlighted];
        [iv setTitleColor:MainLightGrayTitleColor forState:UIControlStateSelected];
        iv.showsTouchWhenHighlighted=NO;
        iv.countdownBeginNumber                      = 60;
        iv.delegate                                  = self;
        iv.clipsToBounds =YES;
        [self.authCodeView addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.authCodeView);
            make.width.mas_equalTo(kSAdap(80.0));
            make.right.mas_equalTo(kSAdap(-15.0));
            make.height.mas_equalTo(self.authCodeView);
        }];
        iv;
    });
    
    UIView *spliteLine = [[UIView alloc] init];
    spliteLine.backgroundColor = MainGrayBorderColor;
    spliteLine.layer.zPosition = 10;
    [self.view addSubview:spliteLine];
    [spliteLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.messageEventButton.mas_left);
        make.centerY.mas_equalTo(self.messageEventButton);
        make.width.mas_equalTo(0.5);
        make.height.mas_equalTo(kSAdap(15.0));
    }];
    
    _authCodeTextField = ({
        UITextField *iv = [[UITextField alloc]init];
        iv.font  = [UIFont ELPingFangSCRegularFontOfSize:kSaFont(14.0)];
        iv.clearButtonMode = UITextFieldViewModeWhileEditing;
        iv.textColor = MainBlackTitleColor;
        iv.placeholder =@"请输入验证码";
        [iv setValue:MainLightGrayTitleColor forKeyPath:@"_placeholderLabel.textColor"];
        [iv setValue:[UIFont ELPingFangSCRegularFontOfSize:kSaFont(12.0)] forKeyPath:@"_placeholderLabel.font"];
        iv.keyboardType = UIKeyboardTypeNumberPad;
        iv.borderStyle =UITextBorderStyleNone;
        iv.delegate =  self;
        [iv addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
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
        iv.layer.borderColor = MainGrayBorderColor.CGColor;
        iv.layer.borderWidth = 0.5;
        iv.layer.cornerRadius = kSAdap_V(20.0);
        [self.view addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(kSAdap(15.0));
            make.right.mas_equalTo(kSAdap(-15.0));
            make.bottom.mas_equalTo(self.authCodeTextField.mas_top).mas_offset(kSAdap_V(-20.0));
            make.height.mas_equalTo(kSAdap_V(40.0));
        }];
        iv;
    });
    
    _iphoneTextField = ({
        UITextField *iv = [[UITextField alloc]init];
        iv.font  = [UIFont ELPingFangSCRegularFontOfSize:kSaFont(14.0)];
        iv.clearButtonMode = UITextFieldViewModeWhileEditing;
        iv.textColor = MainBlackTitleColor;
        iv.placeholder =@"请输入手机号";
        [iv setValue:MainLightGrayTitleColor forKeyPath:@"_placeholderLabel.textColor"];
        [iv setValue:[UIFont ELPingFangSCRegularFontOfSize:kSaFont(12.0)] forKeyPath:@"_placeholderLabel.font"];
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
        FLAnimatedImageView *iv = [[FLAnimatedImageView alloc]init];
        iv.image = [UIImage imageNamed:@"login_logo"];
        [self.view addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.iphoneView.mas_top).mas_offset(-kSAdap_V(45));
            make.size.mas_equalTo(CGSizeMake(kSAdap(105), kSAdap_V(56)));
            make.centerX.mas_equalTo(self.view);
        }];
        iv;
    });
    
    _loginButton = ({
        UIButton *iv = [UIButton buttonWithType:UIButtonTypeCustom];
        [iv setBackgroundImage:[UIImage imageWithColor:MainThemColor] forState:UIControlStateNormal];
        [iv setBackgroundImage:[UIImage imageWithColor:MainThemColor] forState:UIControlStateHighlighted];
        [iv .titleLabel setFont:[UIFont ELPingFangSCRegularFontOfSize:kSaFont(12.0)]];
        [iv setTitleColor:MainWhiteTitleColor forState:UIControlStateNormal];
        [iv setTitleColor:MainWhiteTitleColor forState:UIControlStateHighlighted];
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
        iv.font =[UIFont ELPingFangSCRegularFontOfSize:kSaFont(12.0)];
        iv.textColor = MainLightGrayTitleColor;
        iv.textAlignment = NSTextAlignmentCenter;
        iv.numberOfLines = 1;
        [self.view addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.view);
            make.width.mas_lessThanOrEqualTo(kSAdap(120.0));
            make.top.mas_equalTo(self.loginButton.mas_bottom).mas_offset(kSAdap_V(45.0));
            make.height.mas_equalTo(kSAdap_V(20.0));
        }];
        iv;
    });
    
    UIView *leftSpliteLine = [[UIView alloc] init];
    leftSpliteLine.backgroundColor = MainGrayBorderColor;
    [self.view addSubview:leftSpliteLine];
    [leftSpliteLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.tipLabel.mas_left).mas_offset(-kSAdap(20.0));
        make.centerY.mas_equalTo(self.tipLabel);
        make.height.mas_equalTo(0.5);
        make.width.mas_equalTo(kSAdap(60.0));
    }];
    
    UIView *rightSpliteLine = [[UIView alloc] init];
    rightSpliteLine.backgroundColor = MainGrayBorderColor;
    [self.view addSubview:rightSpliteLine];
    [rightSpliteLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.tipLabel.mas_right).mas_offset(kSAdap(20.0));
        make.centerY.mas_equalTo(self.tipLabel);
        make.height.mas_equalTo(0.5);
        make.width.mas_equalTo(kSAdap(60.0));
    }];
    
    _weixinButton = ({
        UIButton *iv = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *icon  = [UIImage imageNamed:@"weixin"];
        [iv setBackgroundImage:icon forState:UIControlStateNormal];
        [iv setBackgroundImage:icon forState:UIControlStateHighlighted];
        [iv setBackgroundImage:icon forState:UIControlStateDisabled];
        [iv setBackgroundImage:icon forState:UIControlStateSelected];
        [iv addTarget:self action:@selector(weiXinAction:) forControlEvents:UIControlEventTouchUpInside];
        iv.showsTouchWhenHighlighted = NO;
        [self.view addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.view);
            make.top.mas_equalTo(self.tipLabel.mas_bottom).mas_offset(kSAdap_V(15.0));
            make.size.mas_equalTo(icon.size);
        }];
        iv;
    });
    
}
-(void)weiXinAction:(UIButton *)sender{
    @weakify(self);
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_WechatSession currentViewController:self completion:^(UMSocialUserInfoResponse * result, NSError *error) {
        @strongify(self);
        if (error) {
         
            return ;
        }
        UMSocialUserInfoResponse *resp = result;
        NSLog(@"%@",resp);
    }];
    
}
#pragma mark - ELMessageEventButtonDelegate
-(void)ClickedWithMessageButton:(ELMessageEventButton*)messageButton{
    if (![NSString phoneNumberValidity:self.iphoneTextField.text]) {
        [self makeToast:@"请输入正确的手机号"];
        return;
    }
    
    NSLog(@"发送验证码");
}

#pragma mark - TextFieldDelegate
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if([textField isEqual:self.iphoneTextField]) {
        return [UITextField numberFormatTextField:self.iphoneTextField shouldChangeCharactersInRange:range replacementString:string textFieldType:kPhoneNumberTextFieldType];
    }
    return YES;
}

-(void)textFieldDidChange:(UITextField *)textField{
    if ([textField isEqual:self.authCodeTextField]){
        if (textField.text.length >6) {
            self.authCodeTextField.text = [textField.text substringToIndex:6];
        }else{
            self.authCodeTextField.text = textField.text;
        }
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


#pragma mark - loginActoion
-(void)loginAction:(UIButton *)sender{
    [self switchRootController];
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
