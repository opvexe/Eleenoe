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
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"电极片";
    self.view.backgroundColor = MainThemColor;
    [self configView];
}


-(void)configView{
    
    _circleView = ({
        ELCircularProgressView *iv = [[ELCircularProgressView alloc] init];
        iv.frame = CGRectMake(kSAdap(80.0), kSAdap_V(80.0), SCREEN_WIDTH-kSAdap(160.0), kSAdap_V(210.0));
        [self.view addSubview:iv];
        iv;
    });
    
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
            make.right.mas_equalTo(self.view.mas_centerX).mas_offset(kSAdap(12.0));
            make.bottom.mas_equalTo(-kSAdap_V(80.0));
            make.size.mas_equalTo(CGSizeMake(kSAdap(160.0), kSAdap_V(65.0)));
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
            make.left.mas_equalTo(self.view.mas_centerX).mas_offset(-kSAdap(12.0));
            make.bottom.mas_equalTo(-kSAdap_V(80.0));
            make.size.mas_equalTo(CGSizeMake(kSAdap(160.0), kSAdap_V(65.0)));
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
