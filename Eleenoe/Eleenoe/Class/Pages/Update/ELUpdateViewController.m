//
//  ELUpdateViewController.m
//  Eleenoe
//
//  Created by FaceBook on 2019/3/30.
//  Copyright © 2019 FaceBook. All rights reserved.
//

#import "ELUpdateViewController.h"
@interface ELUpdateViewController ()
@property (nonatomic,strong) UIButton *checkButton;
@property (nonatomic,strong) UIView *topView;
@property (nonatomic,strong) UIImageView *updateImageView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *veseionLabel;
@end

@implementation ELUpdateViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:MainThemColor] forBarMetrics:UIBarMetricsDefault];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:UIColorFromRGB(0xffffff)] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configView];
}

-(void)configView{

    _topView = ({
        UIView *iv = [[UIView alloc]init];
        iv.backgroundColor = MainThemColor;
        [self.view addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_equalTo(self.view);
            make.height.mas_equalTo(kSAdap_V(260.0));
        }];
        iv;
    });

    _updateImageView = ({
        UIImageView *iv = [[UIImageView alloc]initWithFrame:CGRectZero];
        UIImage *icon  = [UIImage imageNamed:@"update_white"];
        iv.image = icon;
        [self.topView addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.view);
            make.top.mas_equalTo(kSAdap_V(48.0));
            make.size.mas_equalTo(icon.size);
        }];
        iv;
    });

    _titleLabel = ({
        UILabel *iv = [[UILabel alloc]init];
        iv.textColor = MainWhiteTitleColor;
        iv.textAlignment = NSTextAlignmentCenter;
        iv.font = [UIFont ELPingFangSCMediumFontOfSize:kSaFont(16.0)];
        iv.text = @"已经是最新版本";
        [self.topView addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.updateImageView.mas_bottom).mas_offset(kSAdap_V(25.0));
            make.centerX.mas_equalTo(self.topView);
            make.height.mas_equalTo(kSaFont(20.0));
        }];
        iv;
    });

    _veseionLabel = ({
        UILabel *iv = [[UILabel alloc]init];
        iv.textColor = MainLightThemColor;
        iv.textAlignment = NSTextAlignmentCenter;
        iv.font = [UIFont ELPingFangSCRegularFontOfSize:kSaFont(12.0)];
        iv.text = @"V1.2.0 稳定版";
        [self.topView addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.titleLabel.mas_bottom);
            make.centerX.mas_equalTo(self.topView);
            make.height.mas_equalTo(kSaFont(20.0));
        }];
        iv;
    });

    _checkButton = ({
        UIButton *iv = [UIButton buttonWithType:UIButtonTypeCustom];
        [iv setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        [iv setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateHighlighted];
        [iv .titleLabel setFont:[UIFont ELPingFangSCRegularFontOfSize:kSaFont(12.0)]];
        [iv setTitleColor:UIColorFromRGB(0x3B3B3B) forState:UIControlStateNormal];
        [iv setTitleColor:UIColorFromRGB(0x3B3B3B) forState:UIControlStateHighlighted];
        [iv setTitle:@"检查更新" forState:UIControlStateNormal];
        [iv setTitle:@"检查更新" forState:UIControlStateHighlighted];
        iv.showsTouchWhenHighlighted=NO;
        iv.layer.masksToBounds = YES;
        iv.layer.borderColor = MainTableViewColor.CGColor;
        iv.layer.borderWidth = 1.0f;
        iv.layer.cornerRadius = kSAdap_V(22.0);
        [iv addTarget:self action:@selector(Click:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-kSAdap_V(50.0));
            make.left.mas_equalTo(kSAdap(15.0));
            make.right.mas_equalTo(-kSAdap(15.0));
            make.height.mas_equalTo(kSAdap_V(44.0));
        }];
        iv;
    });
}

-(void)Click:(UIButton *)sender{
    
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
