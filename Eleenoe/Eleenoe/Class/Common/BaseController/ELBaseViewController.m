//
//  ELBaseViewController.m
//  Eleenoe
//
//  Created by FaceBook on 2019/3/12.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import "ELBaseViewController.h"
#import "ELTabBarControllerConfig.h"
#import "AppDelegate.h"

@interface ELBaseViewController ()<UIGestureRecognizerDelegate>
@property(nonatomic,strong)UIView *placeholderView;
@end

@implementation ELBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}


#pragma mark 关闭键盘
- (void)dismissKeyBoard{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeTextField)];
    [self.view addGestureRecognizer:tap];
    self.view.userInteractionEnabled  =YES;
    tap.delegate  = self;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if (![touch.view isEqual:self.view]) {
        return NO;
    }
    return YES;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self closeTextField];
}

- (void)closeTextField{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

- (void)setNavigationRightView:(UIView *)navigationRightView{
    _navigationRightView = navigationRightView;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:navigationRightView];
}

-(void)setNavigationleftView:(UIView *)navigationleftView{
    _navigationleftView = navigationleftView;
    self.navigationItem.leftBarButtonItem =  [[UIBarButtonItem alloc] initWithCustomView:navigationleftView];
}

#pragma mark 提示图
- (void)makeToast:(NSString *)message{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.view makeToast:message duration:1.0f position:CSToastPositionCenter];
    });
}

- (void)makeToast:(NSString *)message duration:(NSTimeInterval)duration position:(ToastPositionType)position{
    NSString *positionType =@"CSToastPositionTop";
    switch (position) {
        case ToastPositionTypeTop:
            positionType =@"CSToastPositionTop";
            break;
        case ToastPositionTypeBottom:
            positionType =@"CSToastPositionBottom";
            break;
        case ToastPositionTypeCenter:
            positionType =@"CSToastPositionCenter";
            break;
        default:
            break;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.view makeToast:message duration:duration position:positionType];
    });
}

-(void)makeToast:(NSString *)message backImageView:(NSString *)image {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.view makeToast:message duration:1.0f position:CSToastPositionCenter title:nil image:[UIImage imageNamed:image] style:nil completion:nil];
    });
}

#pragma mark 占位图
-(void)networkErrorWithView:(UIView*)view {
    [self createPlaceholderView:nil message:@"你的网络好像被人蹭走了" image:[UIImage imageNamed:@"network"] withView:view action:@selector(reloadDataSoucre)];
}

- (void)createPlaceholderView:(nullable NSString *) title
                      message:(nullable NSString *)message
                        image:(nullable UIImage *)image
                     withView:(nullable UIView *)superView
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self createPlaceholderView:title message:message image:image withView:superView action:nil];
    });
    
}

///MARK:  展位图
- (void)createPlaceholderView:(nullable NSString *) title
                      message:(nullable NSString *)message
                        image:(nullable UIImage *)image
                     withView:(nullable UIView *)superView action:(nullable SEL)reloadAction{
    
    if (_placeholderView) {
        [_placeholderView removeFromSuperview];
        _placeholderView = nil;
    }
    if(superView==nil){
        superView=self.view;
    }
    
    _placeholderView = [[UIView alloc]initWithFrame:superView.bounds];
    [_placeholderView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin];
    [_placeholderView setAutoresizesSubviews:YES];
    [_placeholderView setBackgroundColor:[UIColor clearColor]];
    [superView addSubview:_placeholderView];
    
    CGRect pf = CGRectMake(0, 0, superView.bounds.size.width, 0);
    UIImageView *icon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"avatar_default"]];
    if(image){
        [icon setImage:image];
    }
    
    
    [icon setContentMode:UIViewContentModeScaleAspectFit];
    [icon setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    icon.frame = CGRectMake(0,0, pf.size.width, image.size.height);
    [_placeholderView addSubview:icon];
    
    CGFloat y= icon.frame.size.height+kSAdap(20);
    if(title){
        CGFloat height=[ELTools getHeightContain:title font:[UIFont ELPingFangSCLightFontOfSize:15.0] Width:pf.size.width];
        
        UILabel *lblTitle=[[UILabel alloc] initWithFrame:CGRectMake(0, y, pf.size.width, height)];
        [lblTitle setText:title];
        [lblTitle setFont:[UIFont ELPingFangSCLightFontOfSize:kSAdap(16.0)]];
        [lblTitle setTextColor:MainLightGrayTitleColor];
        [lblTitle setTextAlignment:NSTextAlignmentCenter];
        [lblTitle setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
        [lblTitle setNumberOfLines:0];
        [lblTitle setBackgroundColor:[UIColor clearColor]];
        [_placeholderView addSubview:lblTitle];
        y=y+height+5;
    }
    
    if(message){
        UILabel *lblTitle=[[UILabel alloc] initWithFrame:CGRectMake(0, y, pf.size.width, kSAdap_V(20))];
        [lblTitle setText:message];
        [lblTitle setFont:[UIFont ELPingFangSCLightFontOfSize:kSaFont(16.0)]];
        [lblTitle setTextColor:MainLightGrayTitleColor];
        [lblTitle setTextAlignment:NSTextAlignmentCenter];
        [lblTitle setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
        [lblTitle setAutoresizesSubviews:YES];
        [lblTitle setBackgroundColor:[UIColor clearColor]];
        [_placeholderView addSubview:lblTitle];
        y=y+kSAdap_V(25);
    }
    //
    //    // 如果有重新加载方法，就显示重新加载按钮
    if(reloadAction){
        UIButton *reButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [reButton setFrame:CGRectMake(pf.size.width/2-kSAdap(114)/2, y+5, kSAdap(114), kSAdap_V(30))];
        
        [reButton setBackgroundImage:[UIImage imageWithColor:MainBackgroundColor] forState:UIControlStateNormal];
        [reButton setBackgroundImage:[UIImage imageWithColor:MainBackgroundColor] forState:UIControlStateDisabled];
        [reButton setBackgroundImage:[UIImage imageWithColor:MainBackgroundColor] forState:UIControlStateHighlighted];
        [reButton setTitle:@"重新加载" forState:UIControlStateNormal];
        [reButton setTitle:@"      加载中..." forState:UIControlStateDisabled];
        [reButton setTitleColor:MainTitleColor forState:UIControlStateNormal];
        [reButton setTitleColor:MainTitleColor forState:UIControlStateDisabled];
        [reButton.titleLabel setFont:[UIFont ELPingFangSCLightFontOfSize:12.0]];
        [reButton addTarget:self action:reloadAction forControlEvents:UIControlEventTouchUpInside];
        [reButton setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin];
        reButton.layer.cornerRadius  = kSAdap(15);
        reButton.layer.masksToBounds = YES;
        reButton.layer.borderColor =MainTitleColor.CGColor;
        reButton.layer.borderWidth = kSAdap(0.5);
        [_placeholderView addSubview:reButton];
        UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        activityIndicator.tag=10;
        [activityIndicator setFrame:CGRectMake(kSAdap(192)/2-kSAdap(45), kSAdap_V(15), kSAdap(20), kSAdap_V(20))];
        [reButton addSubview:activityIndicator];
        y=y+kSAdap_V(60);
    }
    pf.size.height=y;
    
    [_placeholderView setFrame:pf];
    [_placeholderView setCenter:CGPointMake(superView.width *0.5,superView.height*0.5)];
}

- (void)createPlaceholderView:(nullable NSString *) title
                      message:(nullable NSString *)message
                        image:(nullable UIImage *)image
                     withView:(nullable UIView *)superView refTitle:(NSString *)reftitle  action:(nullable SEL)reloadAction{
    if (_placeholderView) {
        [_placeholderView removeFromSuperview];
        _placeholderView = nil;
    }
    if(superView==nil){
        superView=self.view;
    }
    
    _placeholderView = [[UIView alloc]initWithFrame:superView.bounds];
    [_placeholderView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin];
    [_placeholderView setAutoresizesSubviews:YES];
    [_placeholderView setBackgroundColor:[UIColor clearColor]];
    [superView addSubview:_placeholderView];
    
    
    CGRect pf = CGRectMake(0, 0, superView.bounds.size.width, 0);
    UIImageView *icon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"avatar_default"]];
    if(image){
        [icon setImage:image];
    }
    icon.userInteractionEnabled =YES;
    [icon setContentMode:UIViewContentModeScaleAspectFit];
    [icon setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    icon.frame = CGRectMake(0,0, pf.size.width, image.size.height);
    [_placeholderView addSubview:icon];
    CGFloat y= icon.frame.size.height+kSAdap_V(20);
    if(title){
        CGFloat height=[ELTools getHeightContain:title font:[UIFont ELPingFangSCLightFontOfSize:15.0] Width:pf.size.width];
        
        UILabel *lblTitle=[[UILabel alloc] initWithFrame:CGRectMake(0, y, pf.size.width, height)];
        [lblTitle setText:title];
        [lblTitle setFont:[UIFont ELPingFangSCLightFontOfSize:kSaFont(16.0)]];
        [lblTitle setTextColor:MainLightGrayTitleColor];
        [lblTitle setTextAlignment:NSTextAlignmentCenter];
        [lblTitle setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
        [lblTitle setNumberOfLines:0];
        [lblTitle setBackgroundColor:[UIColor clearColor]];
        [_placeholderView addSubview:lblTitle];
        y=y+height+5;
    }
    
    if(message){
        UILabel *lblTitle=[[UILabel alloc] initWithFrame:CGRectMake(0, y, pf.size.width, kSAdap_V(20))];
        [lblTitle setText:message];
        [lblTitle setFont:[UIFont ELPingFangSCLightFontOfSize:kSaFont(16.0)]];
        [lblTitle setTextColor:MainLightGrayTitleColor];
        [lblTitle setTextAlignment:NSTextAlignmentCenter];
        [lblTitle setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
        [lblTitle setAutoresizesSubviews:YES];
        [lblTitle setBackgroundColor:[UIColor clearColor]];
        [_placeholderView addSubview:lblTitle];
        y=y+kSAdap_V(25);
    }
    
    // 如果有重新加载方法，就显示重新加载按钮
    if(reloadAction){
        UIButton *reButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [reButton setFrame:CGRectMake(pf.size.width/2-kSAdap(114)/2, y+5, kSAdap(114), kSAdap_V(30))];
        [reButton setBackgroundImage:[UIImage imageWithColor:MainBackgroundColor] forState:UIControlStateNormal];
        [reButton setBackgroundImage:[UIImage imageWithColor:MainBackgroundColor] forState:UIControlStateDisabled];
        [reButton setBackgroundImage:[UIImage imageWithColor:MainBackgroundColor] forState:UIControlStateHighlighted];
        [reButton setTitle:reftitle forState:UIControlStateNormal];
        [reButton setTitle:reftitle forState:UIControlStateDisabled];
        [reButton setTitleColor:MainTitleColor forState:UIControlStateNormal];
        [reButton setTitleColor:MainTitleColor forState:UIControlStateDisabled];
        [reButton.titleLabel setFont:[UIFont ELPingFangSCLightFontOfSize:12.0]];
        [reButton addTarget:self action:reloadAction forControlEvents:UIControlEventTouchUpInside];
        [reButton setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin];
        reButton.layer.cornerRadius  = kSAdap(15);
        reButton.layer.masksToBounds = YES;
        reButton.layer.borderColor =MainTitleColor.CGColor;
        reButton.layer.borderWidth = kSAdap(0.5);
        [_placeholderView addSubview:reButton];
        UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        activityIndicator.tag=10;
        [activityIndicator setFrame:CGRectMake(kSAdap(192)/2-kSAdap(45), kSAdap_V(15), kSAdap(20), kSAdap_V(20))];
        [reButton addSubview:activityIndicator];
        
        y=y+kSAdap_V(60);
    }
    pf.size.height=y;
    
    [_placeholderView setFrame:pf];
    [_placeholderView setCenter:CGPointMake(superView.width *0.5,superView.height*0.5)];
}

#pragma mark 移除占位图
- (void)removePlaceholderView{
    @weakify(self);
    dispatch_async(dispatch_get_main_queue(), ^{
        @strongify(self);
        if (self.placeholderView && self.placeholderView!=nil) {
            [self.placeholderView removeFromSuperview];
            self.placeholderView = nil;
        }
    });
}


-(void)reloadDataSoucre{}

-(void)switchRootController{
    ELTabBarControllerConfig  *tabBarControllerConfig = [ELTabBarControllerConfig new];
    AppDelegate  *delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    delegate.window.rootViewController = tabBarControllerConfig.tabBarController;
}

-(void)dealloc{
    [ELNotificationCenter removeObserver:self];
    NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
