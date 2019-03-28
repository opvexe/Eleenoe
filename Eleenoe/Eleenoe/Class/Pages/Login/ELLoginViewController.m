//
//  ELLoginViewController.m
//  Eleenoe
//
//  Created by FaceBook on 2019/3/12.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import "ELLoginViewController.h"
#import "ELMessageEventButton.h"
@interface ELLoginViewController ()
@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, strong) UITextField *iphoneTextField;
@property (nonatomic, strong) UITextField *authCodeTextField;
@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) ELMessageEventButton *messageEventButton;
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
