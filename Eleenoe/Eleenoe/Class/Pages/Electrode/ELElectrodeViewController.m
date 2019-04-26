//
//  ELElectrodeViewController.m
//  Eleenoe
//
//  Created by FaceBook on 2019/3/30.
//  Copyright © 2019 FaceBook. All rights reserved.
//

#import "ELElectrodeViewController.h"
#import "ELCircularProgressView.h"

@interface ELElectrodeViewController ()
@property (nonatomic, strong) UIButton *changeButton;
@property (nonatomic, strong) UIButton *resetButton;
@property (nonatomic,strong) ELCircularProgressView *circleView;
@end

@implementation ELElectrodeViewController

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
    self.view.backgroundColor = MainThemColor;
    [self configView];
}


-(void)configView{
    
    _circleView = ({
        ELCircularProgressView *iv = [[ELCircularProgressView alloc] initWithFrame:CGRectMake(kSAdap(80.0), kSAdap_V(80.0), SCREEN_WIDTH-kSAdap(160.0), kSAdap_V(210.0)) lineWidth:kSAdap(10.0)];
        iv.backgroundColor = [UIColor clearColor];
        iv.text = @"250:00";
        [self.view addSubview:iv];
        iv;
    });
    
    self.circleView.progress = 0.7;
    
    
    _resetButton = ({
        UIButton *iv = [UIButton buttonWithType:UIButtonTypeCustom];
        [iv setImage:[UIImage imageNamed:@"reset_tie"] forState:UIControlStateNormal];
        [iv setImage:[UIImage imageNamed:@"reset_tie"] forState:UIControlStateHighlighted];
        iv.adjustsImageWhenHighlighted =NO;
        iv.showsTouchWhenHighlighted =NO;
        iv.tag = ELElectrodeTypeReset;
        [iv addTarget:self action:@selector(Cick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.view.mas_centerX).mas_offset(8);
            make.bottom.mas_equalTo(-kSAdap_V(80));
            make.size.mas_equalTo(CGSizeMake(160, 65));
        }];
        iv;
    });
    
    _changeButton = ({
        UIButton *iv = [UIButton buttonWithType:UIButtonTypeCustom];
        [iv setImage:[UIImage imageNamed:@"change_tie"] forState:UIControlStateNormal];
        [iv setImage:[UIImage imageNamed:@"change_tie"] forState:UIControlStateHighlighted];
        iv.adjustsImageWhenHighlighted =NO;
        iv.showsTouchWhenHighlighted =NO;
        iv.tag = ELElectrodeTypeChange;
        [iv addTarget:self action:@selector(Cick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.view.mas_centerX).mas_offset(-8);
            make.bottom.mas_equalTo(-kSAdap_V(80.0));
            make.size.mas_equalTo(CGSizeMake(160,65));
        }];
        iv;
    });
}

-(void)Cick:(UIButton *)sender{
    switch (sender.tag) {
        case ELElectrodeTypeReset:{
            NSLog(@"重置时间");
        }
            break;
        case ELElectrodeTypeChange:{
            NSLog(@"更换贴片");
        }
            break;
        default:
            break;
    }
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
